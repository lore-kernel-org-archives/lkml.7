Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA3C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFB7208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbfIMIx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:53:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43945 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbfIMIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:53:29 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1i8hKa-0006rN-C8; Fri, 13 Sep 2019 10:53:28 +0200
Message-ID: <a4f36fed24c8c2a1e9228ee178fe16f2957b3ffb.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] drm/etnaviv: print MMU exception cause
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Date:   Fri, 13 Sep 2019 10:53:25 +0200
In-Reply-To: <20190913055052.25599-2-christian.gmeiner@gmail.com>
References: <20190913055052.25599-1-christian.gmeiner@gmail.com>
         <20190913055052.25599-2-christian.gmeiner@gmail.com>
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

On Fr, 2019-09-13 at 07:50 +0200, Christian Gmeiner wrote:
> Might be useful when debugging MMU exceptions.
> 
> Changes in V2:
>  - Use a static array of string for error message as suggested
>    by Lucas Stach.

Please move those changelogs below the 3 dashes, so they don't end up
in the commit message. They don't really add any value to the
persistent kernel history.

> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index d47d1a8e0219..b8cd85153fe0 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1351,6 +1351,15 @@ static void sync_point_worker(struct work_struct *work)
>  
>  static void dump_mmu_fault(struct etnaviv_gpu *gpu)
>  {
> +	static const char *errors[] = {
> +		"slave not present",
> +		"page not present",
> +		"write violation",
> +		"out of bound",
> +		"read security violation",
> +		"write security violation",
> +	};
> +
>  	u32 status_reg, status;
>  	int i;
>  
> @@ -1364,10 +1373,16 @@ static void dump_mmu_fault(struct etnaviv_gpu *gpu)
>  
>  	for (i = 0; i < 4; i++) {
>  		u32 address_reg;
> +		const char *error = "unknown state";
>  
>  		if (!(status & (VIVS_MMUv2_STATUS_EXCEPTION0__MASK << (i * 4))))
>  			continue;
>  
> +		if (status < ARRAY_SIZE(errors))
> +			error = errors[status];

Huh? This won't work. The status register is a bitfield, not an integer
so you need to map the bit position to the array index via ffs() or
something like that.

Regards,
Lucas

> +
> +		dev_err_ratelimited(gpu->dev, "MMU %d %s\n", i, error);
> +
>  		if (gpu->sec_mode == ETNA_SEC_NONE)
>  			address_reg = VIVS_MMUv2_EXCEPTION_ADDR(i);
>  		else

