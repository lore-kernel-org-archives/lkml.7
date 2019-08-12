Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2191DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 00:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF9520820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 00:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="JPVkijIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfHLAIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 20:08:07 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.43]:12255 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbfHLAIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 20:08:06 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 7F55A400C95E7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 19:08:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wxsbhWUWV3Qi0wxsbhEoB4; Sun, 11 Aug 2019 19:08:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HkwYskj4hcqhar/pMnuy1yYlf+y7tZmG56Gg3PFUL0k=; b=JPVkijILtRkj9igWsLFjuJmYKS
        F6CinifQtxXBv7RW3u4IN8In493M+5I2neJuiW7XfzXSqrDNg/Zr02XVfXlm/PwP29tt5KP4mMRie
        HPxbIABPA0ukRCfyr9UdHNomWKpYkYicF+0dCsZn/gkzvCeVt2j8HbbCg9w8D6iQjRj8Ew6RXazHW
        yAe8khiwLlq2fxLIVW8syIYNZSwcvOmeg+Xz+gOBqamAUuK0+UFrI/hDSZ9FPcnnYz6qMTqkgssXX
        6rKg1UaFiclhTCHAEO6rh5z+ZOPDg96QQQiWcAB9Eaa/iyoXblSQaa+nx5lWPw9qm3CCbjjESAFIS
        KM8pQ5uQ==;
Received: from [187.192.11.120] (port=52004 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hwxsa-002WKs-7p; Sun, 11 Aug 2019 19:08:04 -0500
Date:   Sun, 11 Aug 2019 19:08:01 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/komeda: Fix potential integer overflow in
 komeda_crtc_update_clock_ratio
Message-ID: <20190812000801.GA29204@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hwxsa-002WKs-7p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:52004
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix ULL to constant 1000 in order to avoid a potential integer
overflow and give the compiler complete information about the proper
arithmetic to use. Notice that this constant is being used in a context
that expects an expression of type u64, but it's currently evaluated
using 32-bit arithmetic.

Addresses-Coverity-ID: 1485796 ("Unintentional integer overflow")
Fixes: ed22c6d9304d ("drm/komeda: Use drm_display_mode "crtc_" prefixed hardware timings")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index fa9a4593bb37..624d257da20f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -27,7 +27,7 @@ static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcrtc_st)
 		return;
 	}
 
-	pxlclk = kcrtc_st->base.adjusted_mode.crtc_clock * 1000;
+	pxlclk = kcrtc_st->base.adjusted_mode.crtc_clock * 1000ULL;
 	aclk = komeda_crtc_get_aclk(kcrtc_st);
 
 	kcrtc_st->clock_ratio = div64_u64(aclk << 32, pxlclk);
-- 
2.22.0

