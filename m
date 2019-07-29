Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB82C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAF0206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui5138LA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfG2Bjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 21:39:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43224 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2Bjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 21:39:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so27132053pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=c1uHsnX/WnSI8+586zLkoV7QQKmUDl0aRnKS/YZ6qok=;
        b=Ui5138LAx1zch27e5gPKEmiSWQ+NzklokjKVFqbDa6+NKrrizvMsmt9IMLEyjY6IlU
         NcTAeyYC/T7fHKXBVkquD46FoM0XbyvxFbY4/gluvDrn1vx3Y21WKT8SUleD0m+4tRuu
         OWKUbWAWHvOgy6KgX6bNc+FnZIq9ttf+kyZwk/ksE2Cf5ut/iO5tJMo/ANyu/mGoxWKk
         j6dWgdxUs3GpXKMCuSzB05gKBF/jpJVwX11RsfG/LMwuxmd0aDmqxGmTyjChKnkqCvJp
         8z1CYkh2nIarGkUjjnnXGs+tTiKY7T1wRQV1wnlNUyVY3ayhIRIe6jR4iNLECPBqk6jn
         VJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=c1uHsnX/WnSI8+586zLkoV7QQKmUDl0aRnKS/YZ6qok=;
        b=DQ53fDZaEAb3YxqWWoADi7lguRblqXsSCqv8cJNxmmJQzYmWW9lMndx578Fdu5WFh+
         Y3Eqwha0MV86TU6AfiWEpi5jFxpTUDnxIePN1fw40UJNateYkDoXcQ0fZdvYBNuDK0yy
         wbRO6jEV1qTVpxm5rfsjl3/0hjuh0jTyb5LlhSFmOqnC8gxJoSj5EA6D2sBie58Vd5Yb
         cJpTXKkdNXs5W3uvkTzbNV/jREdxQHU1t/rCiqzM+S/hLg3DV9vnymQXziEXT+PO3spm
         spsC1jjj4g9YTJUtCMZxTQjXJYUtjSwW0/v6PkisqN1RbFyIjwZGJcyMZOoI1Wp3LfYh
         vTjA==
X-Gm-Message-State: APjAAAV05BBCZv5IIjYNrqlzTKpd+R8e/IOz7fwu2c5elcqq2sNnuOoM
        5PCDBGT3Ba3nvR8t5F+EjWM=
X-Google-Smtp-Source: APXvYqycYQSy4zkpEsmQu71+26qyTxUjbC0/UDcbpxafuc8TBJr+JD80Sx7p9BHNQ1ct8aFBsLHaTw==
X-Received: by 2002:a17:90a:26e4:: with SMTP id m91mr109783963pje.93.1564364370481;
        Sun, 28 Jul 2019 18:39:30 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id w197sm74139684pfd.41.2019.07.28.18.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 18:39:29 -0700 (PDT)
Date:   Mon, 29 Jul 2019 07:09:22 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8723bs: core: Remove unneeded variables
 sgi_20m,sgi_40m and sgi_80m
Message-ID: <20190729013922.GA5379@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

htpriv.sgi_* variables are of type u8 ,instead of storing them in local
variables ,its better to read value directly from structure.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index b5dcb78..0690d5e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -346,21 +346,18 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 
 u8 query_ra_short_GI(struct sta_info *psta)
 {
-	u8 sgi = false, sgi_20m = false, sgi_40m = false, sgi_80m = false;
-
-	sgi_20m = psta->htpriv.sgi_20m;
-	sgi_40m = psta->htpriv.sgi_40m;
+	u8 sgi = false;
 
 	switch (psta->bw_mode) {
 	case CHANNEL_WIDTH_80:
-		sgi = sgi_80m;
+		sgi = false;
 		break;
 	case CHANNEL_WIDTH_40:
-		sgi = sgi_40m;
+		sgi = psta->htpriv.sgi_40m;
 		break;
 	case CHANNEL_WIDTH_20:
 	default:
-		sgi = sgi_20m;
+		sgi = psta->htpriv.sgi_20m;
 		break;
 	}
 
-- 
2.7.4

