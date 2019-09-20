Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABC0C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592462086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408374AbfITIxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:53:48 -0400
Received: from mx1.emlix.com ([188.40.240.192]:60966 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405574AbfITIxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:53:48 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id B8BB2602BA;
        Fri, 20 Sep 2019 10:53:44 +0200 (CEST)
Subject: Re: [PATCH v4 2/3] dmaengine: imx-sdma: fix dma freezes
To:     =?UTF-8?Q?Jan_L=c3=bcbbe?= <jlu@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     fugang.duan@nxp.com, festevam@gmail.com, s.hauer@pengutronix.de,
        vkoul@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        dan.j.williams@intel.com, yibin.gong@nxp.com, shawnguo@kernel.org,
        dmaengine@vger.kernel.or, linux-arm-kernel@lists.infradead.org,
        l.stach@pengutronix.de
References: <20190919142942.12469-1-philipp.puschmann@emlix.com>
 <20190919142942.12469-3-philipp.puschmann@emlix.com>
 <ad87f175496358adb825240f1de609318ed8204c.camel@pengutronix.de>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <9305e5ff-f555-3c6e-9e99-36d88edcae0a@emlix.com>
Date:   Fri, 20 Sep 2019 10:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ad87f175496358adb825240f1de609318ed8204c.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

Am 19.09.19 um 17:19 schrieb Jan Lübbe:
> Hi Philipp,
> 
> see below...
> 
> On Thu, 2019-09-19 at 16:29 +0200, Philipp Puschmann wrote:
>> For some years and since many kernel versions there are reports that the
>> RX UART SDMA channel stops working at some point. The workaround was to
>> disable DMA for RX. This commit tries to fix the problem itself.
>>
>> Due to its license i wasn't able to debug the sdma script itself but it
>> somehow leads to blocking the scheduling of the channel script when a
>> running sdma script does not find any free descriptor in the ring to put
>> its data into.
>>
>> If we detect such a potential case we manually restart the channel.
>>
>> As sdmac->desc is constant we can move desc out of the loop.
>>
>> Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
>> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
>> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
>> ---
>>
>> Changelog v4:
>>  - fixed the fixes tag
>>  
>> Changelog v3:
>>  - use correct dma_wmb() instead of dma_wb()
>>  - add fixes tag
>>  
>> Changelog v2:
>>  - clarify comment and commit description
>>
>>  drivers/dma/imx-sdma.c | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
>> index e029a2443cfc..a32b5962630e 100644
>> --- a/drivers/dma/imx-sdma.c
>> +++ b/drivers/dma/imx-sdma.c
>> @@ -775,21 +775,23 @@ static void sdma_start_desc(struct sdma_channel *sdmac)
>>  static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>>  {
>>  	struct sdma_buffer_descriptor *bd;
>> -	int error = 0;
>> -	enum dma_status	old_status = sdmac->status;
>> +	struct sdma_desc *desc = sdmac->desc;
>> +	int error = 0, cnt = 0;
>> +	enum dma_status old_status = sdmac->status;
>>  
>>  	/*
>>  	 * loop mode. Iterate over descriptors, re-setup them and
>>  	 * call callback function.
>>  	 */
>> -	while (sdmac->desc) {
>> -		struct sdma_desc *desc = sdmac->desc;
>> +	while (desc) {
>>  
>>  		bd = &desc->bd[desc->buf_tail];
>>  
>>  		if (bd->mode.status & BD_DONE)
>>  			break;
>>  
>> +		cnt++;
>> +
>>  		if (bd->mode.status & BD_RROR) {
>>  			bd->mode.status &= ~BD_RROR;
>>  			sdmac->status = DMA_ERROR;
>> @@ -822,6 +824,17 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>>  		if (error)
>>  			sdmac->status = old_status;
>>  	}
>> +
>> +	/* In some situations it may happen that the sdma does not found any
>                                                           ^ hasn't
>> +	 * usable descriptor in the ring to put data into. The channel is
>> +	 * stopped then. While there is no specific error condition we can
>> +	 * check for, a necessary condition is that all available buffers for
>> +	 * the current channel have been written to by the sdma script. In
>> +	 * this case and after we have made the buffers available again,
>> +	 * we restart the channel.
>> +	 */
> 
> Are you sure we can't miss cases where we only had to make some buffers
> available again, but the SDMA already ran out of buffers before?
Think so, yes.
> 
> A while ago, I was debugging a similar issue triggered by receiving
> data with a wrong baud rate, which leads to all descriptors being
> marked with the error flag very quickly (and the SDMA stalling).
> I noticed that you can check if the channel is still running by
> checking the SDMA_H_STATSTOP register & BIT(sdmac->channel).

I think checking for this register is the better approach. Then i could drop the
cnt variable. And by droppting cnt i would propose to move the check and reenabling
to the end of the while loop to reenable the channel after freeing first buffer.

> 
> I also added a flag for the sdmac->flags field to allow stopping the
> channel from the callback (otherwise it would enable the channel
> again).

Could memory and compiler ordering a problem here?
I'm not that into these kind of problems, but is this
	sdmac->flags &= ~IMX_DMA_ACTIVE;
  	writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
guaranteed to be free of race conditions?

Regards,
Philipp

> 
> Attached is my current version of that patch for reference.
> 
>> +	if (cnt >= desc->num_bd)
>> +		sdma_enable_channel(sdmac->sdma, sdmac->channel);
>>  }
>>  
>>  static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
