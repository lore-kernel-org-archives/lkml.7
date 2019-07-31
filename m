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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F436C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A11206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/PURujR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfGaSMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:12:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46523 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfGaSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:12:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id c3so9177570pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5NI/Y5dFZFuaNgPcp4QneIfH5xBadepsGHb9N4tpny8=;
        b=c/PURujRSFmt4W56yEkkPJiMiLnSy+I9hHk4F3krR3jiDTeMD3vnK854bzL5miffpD
         QyqEi96wVR/L7sLF1YWZqnH+B3ELUU6mWNiYM1gnNc5qMpVUqrffFNXCH5MD5bVTWeSr
         XtKKissxyuiVW9qPgegvAaUhsSVblAfMRRMS3jCtI1pLuMEgRg/bvKSAc6noAzQfz5Q9
         NBdCOlt2KTeyv1bmHh88T0G4D/uorDXNYkOMqxjlgTGbzdl9xI2oipsRjUjx+Adc5eBA
         idLYGCAlvPUKSIJvvUvyaVl442CByscJX6eRbqMJv1jOoGIbKiAVVzxKzLF6qPi3vqcL
         T8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5NI/Y5dFZFuaNgPcp4QneIfH5xBadepsGHb9N4tpny8=;
        b=DufEZHoxOnsT/KJKv/Za6Alg7sBugzXg5rE3CAVou3qrYbIBxcnfyRPz2LvcPaE1i5
         quZbk1BlSwEgObZgGR6Y4qvEnezd9yAJt5fEZyiW9G8r64GPdzRApQi5qV7RrJF8jjgT
         bUZ2tGHs1QSgWZ8oL4pUw14Kv+bJ8haM3gDarhBX2rY4hCZBYG6D4iuU7vKFDQHq3rXl
         xq4FZ7or5u1jBZwv8OiHliW7H/503gb8VrKW20GQxcUK6prf0MKhFPXHixbsCdZlYE/z
         Nme+1/3hw0Daac4YN7tdU3U4eqIZhUErxrws3J0j5jUCXDylGeVNVOA7mPRb+JXpPED0
         WheQ==
X-Gm-Message-State: APjAAAUkN84WYsRrx+2L+ayMIy+lbzmISbV3piqRt2laVTkZ8sCScIwi
        BuQ/pWZIfNF2SLTX3BXzJcii0Nrd
X-Google-Smtp-Source: APXvYqxz5v1naU0oUETNREfYLZSjsQDGsXJJpUUx3FIVW39CHx8SXGwdAOqAFau1T9wg33t31Nfp7g==
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr4203159pjb.117.1564596725725;
        Wed, 31 Jul 2019 11:12:05 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id n17sm73058821pfq.182.2019.07.31.11.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:12:03 -0700 (PDT)
Date:   Wed, 31 Jul 2019 23:41:58 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [Patch v2 01/10] staging: rtl8723bs: os_dep: Remove function
 _rtw_regdomain_select
Message-ID: <20190731181158.GA9051@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function simply returns &rtw_regdom_rd . So replace this function
with actual code

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v2 - Add patch number

 drivers/staging/rtl8723bs/os_dep/wifi_regd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
index aa2f62a..bbd83b2 100644
--- a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
+++ b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
@@ -115,13 +115,6 @@ static int _rtw_reg_notifier_apply(struct wiphy *wiphy,
 	return 0;
 }
 
-static const struct ieee80211_regdomain *_rtw_regdomain_select(struct
-							       rtw_regulatory
-							       *reg)
-{
-	return &rtw_regdom_rd;
-}
-
 static void _rtw_regd_init_wiphy(struct rtw_regulatory *reg,
 				 struct wiphy *wiphy,
 				 void (*reg_notifier)(struct wiphy *wiphy,
@@ -137,7 +130,7 @@ static void _rtw_regd_init_wiphy(struct rtw_regulatory *reg,
 	wiphy->regulatory_flags &= ~REGULATORY_STRICT_REG;
 	wiphy->regulatory_flags &= ~REGULATORY_DISABLE_BEACON_HINTS;
 
-	regd = _rtw_regdomain_select(reg);
+	regd = &rtw_regdom_rd;
 	wiphy_apply_custom_regulatory(wiphy, regd);
 
 	/* Hard code flags */
-- 
2.7.4

