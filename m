Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A58C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E327821951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq97gd7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfGYRd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:33:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35265 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfGYRd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:33:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so23122876pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hZk0TqDrxTM1KdLxSkV0vH8ZC4HuTZk2jgm5Qa5W38s=;
        b=pq97gd7dW3xHRFqRCYE8GJRT4eFN1Oj1H5if4i+6I+1XvKweGTnzQwHVsEJWNIOEJV
         wFmglC/Y6anBzCmfBMAR2fd/ijMUAKRFXrLeW6T6Kd64u0grkGrKPE0COa2IlTXwgr1h
         2qneSwBzA/J0tRwQyqPkKJYeHgpE0aRlUojIT43YH5zK1rw3QKRi9YbzJxY6ppFIVEj8
         HFfKnXLyGnJ7imdQS0R3CNWcPb+tyE0ct79f1XvvZ2dnxgr9iKaBXiOVYOaZ26fmjo3u
         SH3o6qzzN11S5tbchQDdLuP92OciyhnTVvxnyvfTMn2GYfmXLt56QsixUeBWtKHWfJMQ
         Koqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hZk0TqDrxTM1KdLxSkV0vH8ZC4HuTZk2jgm5Qa5W38s=;
        b=H3K5dw2JR8EKStwyiAqcVELCygEuvK+Jp++AeRmCv3GqqiDsmRD+yDu8bxhkjya3Ya
         a1R5BN9RjXYMXYM/2GoClEp8Yye8fZ4e1HB7+CvlNN/hzvKMJNMlItc87XG2RHQBZKBH
         DgSt42Eb9pZIyn9lO+OsxP92gztLJhNYVvUXamP6sXFrqj3QbxXPap3Phn5mUjtdCoyH
         mpPIlmLs+N9fhY0JEJnw+0/gzvuCDI+YRbsPN4R9BIggGDrQUugpQtCZ7eRStj1mSQP6
         OpD1e1ZTYvUbK+8mX+UpYxZTXKvOT8ftpH9CHkeKGG7c30r8MSccddTXGbk+gxM+7T/v
         UbMg==
X-Gm-Message-State: APjAAAUvfoyLrHNmwYEbF3UTzQnv+3AYMJswEbacvyG77NQAFR2W5fMN
        PtV/MaWYDfZFwba3ZBwiu2A=
X-Google-Smtp-Source: APXvYqw6/wLL6u7WdrtkLm19PLdxm+noBmOPehGs2ypkQbAARYSFQNprz51nqVoNIQ8IT66oWN/mfg==
X-Received: by 2002:a65:49cc:: with SMTP id t12mr81629192pgs.83.1564076035389;
        Thu, 25 Jul 2019 10:33:55 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id t9sm25753094pgj.89.2019.07.25.10.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 10:33:54 -0700 (PDT)
Date:   Thu, 25 Jul 2019 23:03:49 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8723bs: os_dep: Remove function
 _rtw_regdomain_select
Message-ID: <20190725173349.GA9894@hari-Inspiron-1545>
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

