Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A00AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CC92077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfLJRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:33:38 -0500
Received: from foss.arm.com ([217.140.110.172]:51864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfLJRdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:33:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 310D91FB;
        Tue, 10 Dec 2019 09:33:37 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA6E93F6CF;
        Tue, 10 Dec 2019 09:33:36 -0800 (PST)
Subject: Re: [PATCH 02/15] firmware: arm_scmi: Skip scmi mbox channel setup
 for addtional devices
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-3-sudeep.holla@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <23168005-1326-e535-4dd7-fdab481b08ac@arm.com>
Date:   Tue, 10 Dec 2019 17:33:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210145345.11616-3-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 14:53, Sudeep Holla wrote:
> Now that the scmi bus supports adding multiple devices per protocol,
> and since scmi_create_protocol_device calls scmi_mbox_chan_setup,
> we must avoid allocating and initialising the mbox channel if it is
> already initialised.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index dee7ce3bd815..2952fcd8dd8a 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -735,6 +735,11 @@ static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev,
>  	idx = tx ? 0 : 1;
>  	idr = tx ? &info->tx_idr : &info->rx_idr;
> 
> +	/* check if already allocated, used for multiple device per protocol */
> +	cinfo = idr_find(idr, prot_id);
> +	if (cinfo)
> +		return 0;
> +
>  	if (scmi_mailbox_check(np, idx)) {
>  		cinfo = idr_find(idr, SCMI_PROTOCOL_BASE);
>  		if (unlikely(!cinfo)) /* Possible only if platform has no Rx */
> --
> 2.17.1
> 

Fine for me.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>


Cristian

