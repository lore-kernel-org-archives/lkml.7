Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5288CC2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4082075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAFKIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:08:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56559 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFKIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:08:44 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ioPJS-0001hz-R9; Mon, 06 Jan 2020 11:08:42 +0100
Message-ID: <15ed7b85a13e220a533a800b9c04f13b1c747c1c.camel@pengutronix.de>
Subject: Re: [PATCH 3/6] drm/etnaviv: show identity information in debugfs
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Mon, 06 Jan 2020 11:08:42 +0100
In-Reply-To: <20200102100230.420009-4-christian.gmeiner@gmail.com>
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
         <20200102100230.420009-4-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2020-01-02 at 11:02 +0100, Christian Gmeiner wrote:
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 253301be9e95..cecef5034db1 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -868,6 +868,18 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu,
> struct seq_file *m)
>  
>  	verify_dma(gpu, &debug);
>  
> +	seq_puts(m, "\tidentity\n");
> +	seq_printf(m, "\t model: 0x%x\n",
> +		   gpu->identity.model);
> +	seq_printf(m, "\t revision: 0x%x\n",
> +		   gpu->identity.revision);
> +	seq_printf(m, "\t product_id: 0x%x\n",
> +		   gpu->identity.product_id);
> +	seq_printf(m, "\t customer_id: 0x%x\n",
> +		   gpu->identity.customer_id);
> +	seq_printf(m, "\t eco_id: 0x%x\n",
> +		   gpu->identity.eco_id);

I like having this info in debugfs. Most of those seq_printf don't need
a line break though, as they fit well within the 80 char limit.

Regards,
Lucas

