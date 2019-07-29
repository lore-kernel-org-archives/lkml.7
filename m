Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5B020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ikgY1QHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfG2KmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:42:11 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.93]:37820 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387444AbfG2KmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:42:10 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 27539BD53
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 05:42:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id s36Xh3m40YTGMs36Xhrs4B; Mon, 29 Jul 2019 05:42:09 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tI1InY25XuRFb2ybHZ7jkvgFNykX+oW2psCL79T0A2M=; b=ikgY1QHyCWfCTl2KPmi0t2j1a3
        BS0xFue+R6gJGVdgydv8EMYCH8S+Y4Fg4EkBBJmW5ccRgMxHrIXAuOMc4CDlv0K4V5TPwtZ1i+m8o
        7QpuPa1qSaZyyg/R8nfYUlPq26XbMuxJ6bb8G41g2oeTdjbWZgnVyUDQITBUQFDBZKq4HfnvnzTys
        KDQwh/0WfKgugXS3CQMBnH33QN7F4ncNdAfNEW6akk+A1KlTjFfmMWGVAZYV4o4p/h4TC1JB+AfpX
        q11mLf4APGwoLvoQ2gF27A9Q5gynPX7pxxmaWUQZGm9nUUa17wfWNS2HvFP/CO+NsOgqw3havmJex
        tnSOu0vQ==;
Received: from [187.192.11.120] (port=41804 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hs36W-004JYV-NW; Mon, 29 Jul 2019 05:42:08 -0500
To:     Anders Roxell <anders.roxell@linaro.org>, b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190726112835.19928-1-anders.roxell@linaro.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH] video: fbdev: Mark expected switch fall-through
Message-ID: <6689420e-2383-b7d1-fccc-5d0a149975be@embeddedor.com>
Date:   Mon, 29 Jul 2019 05:42:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726112835.19928-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hs36W-004JYV-NW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [187.192.11.120]:41804
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On 7/26/19 6:28 AM, Anders Roxell wrote:
> When fall-through warnings was enabled by default the following warnings
> was starting to show up:
> 
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_channel_fb_init’:
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:2086:22: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>    info->fix.ypanstep = 2;
>    ~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:2087:2: note: here
>   case V4L2_PIX_FMT_NV16:
>   ^~~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_overlay_fb_init’:
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:1596:22: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>    info->fix.ypanstep = 2;
>    ~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:1597:2: note: here
>   case V4L2_PIX_FMT_NV16:
>   ^~~~
> 
> Rework so that the compiler doesn't warn about fall-through.
> 
> Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")

This is a misuse of the 'Fixes' tag. You are not fixing that commit. You are
addressing a warning due to the enablement of -Wimplicit-fallthrough in
that commit.

I think that saying that you are addressing a warning due to the enablement
of -Wimplicit-fallthrough is the right way to justify this change.

Thanks
--
Gustavo

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index ac0bcac9a865..c249763dbf0b 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -1594,6 +1594,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
>  	case V4L2_PIX_FMT_NV12:
>  	case V4L2_PIX_FMT_NV21:
>  		info->fix.ypanstep = 2;
> +		/* Fall through */
>  	case V4L2_PIX_FMT_NV16:
>  	case V4L2_PIX_FMT_NV61:
>  		info->fix.xpanstep = 2;
> @@ -2084,6 +2085,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
>  	case V4L2_PIX_FMT_NV12:
>  	case V4L2_PIX_FMT_NV21:
>  		info->fix.ypanstep = 2;
> +		/* Fall through */
>  	case V4L2_PIX_FMT_NV16:
>  	case V4L2_PIX_FMT_NV61:
>  		info->fix.xpanstep = 2;
> 
