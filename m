Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C812C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AB521D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbfISLmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:42:35 -0400
Received: from mx1.emlix.com ([188.40.240.192]:57994 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388688AbfISLmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:42:35 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 5A998603CA;
        Thu, 19 Sep 2019 13:42:33 +0200 (CEST)
Subject: Re: [PATCH v3 1/3] dmaengine: imx-sdma: fix buffer ownership
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.or,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190919102319.23368-1-philipp.puschmann@emlix.com>
 <20190919104526.29851-1-philipp.puschmann@emlix.com>
 <20190919104526.29851-2-philipp.puschmann@emlix.com>
 <CAOMZO5BNvejzMxhZiaJ36E5XES=uVNn_G-+fXQfStzy5W+YbsA@mail.gmail.com>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <b108b840-b8f9-2104-25c3-369bf1683e02@emlix.com>
Date:   Thu, 19 Sep 2019 13:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BNvejzMxhZiaJ36E5XES=uVNn_G-+fXQfStzy5W+YbsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,


Am 19.09.19 um 13:37 schrieb Fabio Estevam:
> Hi Philipp,
> 
> On Thu, Sep 19, 2019 at 7:45 AM Philipp Puschmann
> <philipp.puschmann@emlix.com> wrote:
>>
>> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the
>> buffer, when 0 ARM owns it. When processing the buffers in
>> sdma_update_channel_loop the ownership of the currently processed
>> buffer was set to SDMA again before running the callback function of
>> the buffer and while the sdma script may be running in parallel. So
>> there was the possibility to get the buffer overwritten by SDMA before
>> it has been processed by kernel leading to kind of random errors in the
>> upper layers, e.g. bluetooth.
>>
>> Fixes: broken since start
> 
> The Fixes tag requires a commit ID like this:
> 
> Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
> 
> Same applies to the other patch.
> 
oh okay, thanks. I will fix this with v4.

Regards,
Philipp
