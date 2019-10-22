Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD23CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C7D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfJVJAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:00:20 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54027 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbfJVJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:00:19 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMq1a-0004OA-Fn; Tue, 22 Oct 2019 11:00:18 +0200
Message-ID: <0a8e4249ae1e75906e4ab36460c2ffcb7ccf963d.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Fix memory leak in reset_control_array_put()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 22 Oct 2019 11:00:18 +0200
In-Reply-To: <20191022083623.29697-1-kishon@ti.com>
References: <20191022083623.29697-1-kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Tue, 2019-10-22 at 14:06 +0530, Kishon Vijay Abraham I wrote:
> Memory allocated for 'struct reset_control_array' in
> of_reset_control_array_get() is never freed in
> reset_control_array_put() resulting in kmemleak showing
> the following backtrace.
> 
>   backtrace:
>     [<00000000c5f17595>] __kmalloc+0x1b0/0x2b0
>     [<00000000bd499e13>] of_reset_control_array_get+0xa4/0x180
>     [<000000004cc02754>] 0xffff800008c669e4
>     [<0000000050a83b24>] platform_drv_probe+0x50/0xa0
>     [<00000000d3a0b0bc>] really_probe+0x108/0x348
>     [<000000005aa458ac>] driver_probe_device+0x58/0x100
>     [<000000008853626c>] device_driver_attach+0x6c/0x90
>     [<0000000085308d19>] __driver_attach+0x84/0xc8
>     [<00000000080d35f2>] bus_for_each_dev+0x74/0xc8
>     [<00000000dd7f015b>] driver_attach+0x20/0x28
>     [<00000000923ba6e6>] bus_add_driver+0x148/0x1f0
>     [<0000000061473b66>] driver_register+0x60/0x110
>     [<00000000c5bec167>] __platform_driver_register+0x40/0x48
>     [<000000007c764b4f>] 0xffff800008c6c020
>     [<0000000047ec2e8c>] do_one_initcall+0x5c/0x1b0
>     [<0000000093d4b50d>] do_init_module+0x54/0x1d0
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/reset/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 213ff40dda11..36b1ff69b1e2 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -748,6 +748,7 @@ static void reset_control_array_put(struct reset_control_array *resets)
>  	for (i = 0; i < resets->num_rstcs; i++)
>  		__reset_control_put_internal(resets->rstc[i]);
>  	mutex_unlock(&reset_list_mutex);
> +	kfree(resets);
>  }
>  
>  /**

Thank you for the patch! I've added a

Fixes: 17c82e206d2a ("reset: Add APIs to manage array of resets")

tag and applied it to my reset/fixes branch.

regards
Philipp

