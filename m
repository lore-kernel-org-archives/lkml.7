Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A735C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D213120828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dSSoTAA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfCSKWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:22:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39594 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCSKWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NHMVokAbopqD3ioWtD6psiOfyLHSEY0KmVwYMefuWfw=; b=dSSoTAA+GniyLc/AlKlWeADL0
        vix1SUkrJySTkhkyAGhB/R88dmvddp46rQo/tdMasq7h8v5763fYXos5h9CiLPwAJ6AzYbiHotrrE
        CaZg47y6JwVFkEx3Ys7sCRBkWnFl6SxCbowmFd3KCCeE2NQmqh0TbTQopvfmBNW5HcBAwCB8m5W9s
        PUid0y72zQtEB6wTqrfWj/2JctLtpzq/wb6dhQsQhS2EfG+KKafO5vlylcK3WSgmtvOaWooh9pl6a
        v+P8AY9CxVkUPL5D4Y9ADByNnz6FDJSNC9iCSmWYt4K7SZFtSvOmmNiUUAAjDuZSnCno2UVneIkem
        O+2VTFWWg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37450)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h6Bt2-0005gQ-3w; Tue, 19 Mar 2019 10:22:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h6Bsu-0006T0-T8; Tue, 19 Mar 2019 10:22:16 +0000
Date:   Tue, 19 Mar 2019 10:22:16 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     l.stach@pengutronix.de, christian.gmeiner@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yuzibode@126.com
Subject: Re: [PATCH] drm: etnaviv: fix strncpy sizeof argument
Message-ID: <20190319102216.ylrkd6vxm77pq553@shell.armlinux.org.uk>
References: <20190319025755.15394-1-tsu.yubo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319025755.15394-1-tsu.yubo@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:57:55PM -0400, Bo YU wrote:
> Calling strncpy with a maximum size argument of 64 bytes on destination
> array "domain->name" of size 64 bytes might leave the destination string
> unterminated.
> 
> Detected by CoverityScan, CID# 1443992:  Memory - illegal accesses
> (BUFFER_SIZE_WARNING)
> 
> Fixes: 9e2c2e2730126 (drm/etnaviv: add infrastructure to query perf counter)
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> index 4227a4006c34..08ca3c44be48 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> @@ -414,7 +414,7 @@ int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
>  
>  	domain->id = domain->iter;
>  	domain->nr_signals = dom->nr_signals;
> -	strncpy(domain->name, dom->name, sizeof(domain->name));
> +	strncpy(domain->name, dom->name, sizeof(dom->name));

This introduces an overflow bug if sizeof(dom->name) >
sizeof(domain->name).  If both sizes are the same, then there is no
effect.

strlcpy() would be a better replacement, it guarantees that the
destination will be correctly terminated.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
