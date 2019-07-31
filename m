Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AD1C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D557206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyb32Or3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfGaSYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:24:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35983 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGaSYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:24:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so32458216pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LMprJ1umUnvu1dTPiCF12+IEy2mbH3QvbE/6RTXXxRo=;
        b=tyb32Or3VmREdlP9nkj0OyFFjS3LBsRt3zMvjFavg+65HKxCSVSUX11NDfj9UdNawF
         uJucIx3kBcwVjXfBMquMuh8KX5sGLWuiSzbLb4LalwNSazcPBIToTHKC9kmYw77n3+k2
         vQHaOL33IeMXPDSdi8d3uAzbbpb1ubyu+ea665xYHd790jDaIlfNkU5K7YAZWVSHojyw
         ikHYozd4OIUoxJX5ACxmRhI9b+XLvilnCY0eH8wE6Jg7wp/oyEmyRSWtAimSgViMTsKx
         hqGGSP4wiz/fWHacE6h5txA+aBGJjcu79nfWS2ywvAaU1uUhfGornX4HPZhvPVkGuuY+
         RCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LMprJ1umUnvu1dTPiCF12+IEy2mbH3QvbE/6RTXXxRo=;
        b=Zej93PmDC0L0Jfn05XzedxYHSlPVlnDagT+eqGguQvwMEHoVYjmONFCfqCJurIWH7a
         NJpv1CNqL8zPy7tYZEZfqOKS8LcEq41s1B1A+KObJU2BRPb6t2hZqofjloRL2gd/3ai5
         zIWyYgCI7A1b2BfiPtRaunAE0jad2jRi1R0yjNRnz8kyhKCpHWX1FwSraalgKPssYwWD
         4w7UNuSi9Ct3oOcbdJRCuvZdD4L+wCBRZxwXK4wRN9m6lCokASGHXgl1Ivl3mIYNt3uL
         6aGi/o3jybUr45rNi+wPLgRFkirJuZsIxXRZObb7Y6EcBkqwbPeasBwvOobc1cYAALpR
         5mHw==
X-Gm-Message-State: APjAAAUkLguSSpWVhU6jtOx1Ggx463mllMCeRO5NYrOOYVnyGYDmu+7l
        P7Ig2tusYQMgKj/8RndUkcU=
X-Google-Smtp-Source: APXvYqzhzw2BA7flXoBf5Mp5rPLsLG16tG/QklwIadDX0PbQT9u1Cq4Ak1UsMdb6apJ3lcoK9x+HWA==
X-Received: by 2002:a62:7990:: with SMTP id u138mr46840329pfc.191.1564597446519;
        Wed, 31 Jul 2019 11:24:06 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id u23sm71863700pfn.140.2019.07.31.11.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:24:06 -0700 (PDT)
Date:   Wed, 31 Jul 2019 23:54:00 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net
Subject: [Patch v2 09/10] staging: rtl8723bs: core: Remove unneeded variables
 sgi_20m,sgi_40m and sgi_80m
Message-ID: <20190731182400.GA9792@hari-Inspiron-1545>
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
v2 - Add patch number

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

