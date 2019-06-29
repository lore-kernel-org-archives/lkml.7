Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026CBC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34262086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IglXVzc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfF2KZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:25:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35826 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2KZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:25:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so3723947pgl.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CxypI43ytN5Ipwu2eJZ9WP6oEc0mtS7rDBKUGQ2NaIQ=;
        b=IglXVzc9+65oiSs+QIqDDdQJA4wtPHj4OWUpcEffOBeVIQExouQzLhoPfNW0Rtpp3J
         PmhRSZyEsp1Jd2//XWqZDRbf2TZxZNlCQZc3vRnmlzTkM+RsH2RhJWDaw+rdoY///qk1
         L6OslWHFZN3G08Hs+8KieXGxS9s3QT97W/Luq5WS9MMO4q5QeG2GPNXCAGFnm9u/FJ+1
         qC7aFDr9bAgbX9TCmS6NcYTn5HkKbMs2kTmXH8VnUa5PmjE3ISysbUWSdyu+WtjwzDKW
         eXgCmdIjBu8me25aQrPSS/dGWT4FeztP+hoHQq8OJconr6neNa+hoHWSPQzDEunhOC5j
         t7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CxypI43ytN5Ipwu2eJZ9WP6oEc0mtS7rDBKUGQ2NaIQ=;
        b=fNvdxWt7s1VCZNFmqE4JjWsER8EMlb44yRO7FvHB9jK4BNy7cWvnZ+s1uAPVJbVB2T
         zjCJFhCeUR9yY4j1BGnam2n5U+RQDIb5/H8Y+DEyWB+5bxMG4N2iRRwumXBsaAb33ye2
         CmFRanlIj4ZIjssBO+YW98dzLz3QQ1j0NwovBmyz0wVI32NU3C0sRJnUJm0zx4sjtKwF
         htdCEqWn+6bWLmQPUGQQXQoiZer5FKgC5h28zkLpKbZmi2F3TXmb7g5Yh8VOCaS3zbLS
         w2QZoIyrLBQCME1O4+Qp2mo1DHxD9A8tTWfkkUKZmaAp1QKRENSyzkuTSkJZdP1IXPXr
         H5vQ==
X-Gm-Message-State: APjAAAX4F2hv7/O/ZMdb7Pl0g7WNqeMJXtqOtGWBYgwEdfgFbZyCEsU+
        iKVQLHTTFtM9Y8Q30X5dRyVQUgEH
X-Google-Smtp-Source: APXvYqzsO6ZZ4yrDO5RiEb7WhYzA6reScVpUYT/VG+itFRvT/f5pne9ZmAj+dob2oajhm6V/9GeFrA==
X-Received: by 2002:a17:90a:9905:: with SMTP id b5mr19086055pjp.70.1561803918651;
        Sat, 29 Jun 2019 03:25:18 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id x5sm9859134pjp.21.2019.06.29.03.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:25:18 -0700 (PDT)
Date:   Sat, 29 Jun 2019 15:55:14 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629102514.GA15194@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index 6578147..e6ddce3 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -152,14 +152,14 @@ void rtl8723b_HalDmWatchDog(struct adapter *Adapter)
 
 	hw_init_completed = Adapter->hw_init_completed;
 
-	if (hw_init_completed == false)
+	if (!hw_init_completed)
 		goto skip_dm;
 
 	bFwCurrentInPSMode = adapter_to_pwrctl(Adapter)->bFwCurrentInPSMode;
 	rtw_hal_get_hwreg(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&bFwPSAwake));
 
 	if (
-		(hw_init_completed == true) &&
+		(hw_init_completed) &&
 		((!bFwCurrentInPSMode) && bFwPSAwake)
 	) {
 		/*  */
@@ -170,7 +170,7 @@ void rtl8723b_HalDmWatchDog(struct adapter *Adapter)
 	}
 
 	/* ODM */
-	if (hw_init_completed == true) {
+	if (hw_init_completed) {
 		u8 bLinked = false;
 		u8 bsta_state = false;
 		u8 bBtDisabled = true;
@@ -233,7 +233,7 @@ void rtl8723b_HalDmWatchDog_in_LPS(struct adapter *Adapter)
 	struct sta_priv *pstapriv = &Adapter->stapriv;
 	struct sta_info *psta = NULL;
 
-	if (Adapter->hw_init_completed == false)
+	if (!Adapter->hw_init_completed)
 		goto skip_lps_dm;
 
 
@@ -242,7 +242,7 @@ void rtl8723b_HalDmWatchDog_in_LPS(struct adapter *Adapter)
 
 	ODM_CmnInfoUpdate(&pHalData->odmpriv, ODM_CMNINFO_LINK, bLinked);
 
-	if (bLinked == false)
+	if (!bLinked)
 		goto skip_lps_dm;
 
 	if (!(pDM_Odm->SupportAbility & ODM_BB_RSSI_MONITOR))
-- 
2.7.4

