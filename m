Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AB3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBB02081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB/ZAgwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfE2NPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:15:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42523 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2NPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:15:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id 33so1352748pgv.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN5neQLEPuy8rf1hiSBhjEvuwhf5Or8I1z3QH2reqRo=;
        b=KB/ZAgwVtpsscHpxRL2WxEnZSjd07Gwyz2fitS1PZiXG05ZDobhExv0V3qnjvyd5u1
         IQ9J9BTglpmDw0bu8hG5dkRuNsrk8peU3jiDOnhitl1YfMgq1x1OG9zwddO7K8QCiQcL
         yYbEaDkBlTyxSKY5Az8//PsZMu9hRaHjjylWtv8Mm93hliHX8wl/rQmOu0UpzUa5z2Ni
         syP6arMk6/g+h0pRaE6Z+/OuQQeogHLblUZyFQ7mxjFdi1JCizncxqQ0NBZB8438Fz7l
         4XmvoJJsbeEcOSlCIZsRYFNiKQqi74X096iz9lgxtysgSLcsgL3/+sac2FmVr1HTYWFh
         CvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN5neQLEPuy8rf1hiSBhjEvuwhf5Or8I1z3QH2reqRo=;
        b=irihqoydtV5wgXYCtenlU6E6DFQJKGET4EB3myWnklLBLcxjdrmp30NtWnNUulsA/j
         Exyo3LljcNmNmPHp9sAjhZNdTsjmH5CJ/oaiunxsDQwzu1VVDPZc7pinKwbU214iPeMW
         0kaTZt6RlL0mnkKSxY0tM1PoTD9Zh6HbWxvCv7/HWtUV2wcTysFmSZwUGajvCbKFrjXc
         jXMSyfgjZBAnGwDgpD0OdhnpYSYEhGq/C93S1Ov0N3+mS5CB+s1mLXZEnQVaedtj3zrr
         2gC1syd9SX8/yRZcxYwQxPtlL/E2nHw82rwNa0BUmrF2RQoLTzPdIY+Ig6E7Uy/yns2G
         +KEw==
X-Gm-Message-State: APjAAAWOnxO7AEXLefpB1oBfszKG5yr8nJeLfgT54FkPKvPqyDbvl/+8
        PI+1qFI4O6QWKjkpHU0MRRI=
X-Google-Smtp-Source: APXvYqxqk6JDonQnV/wxu8JWsy8K0bS3rk427TwK4U+WoZy6ABfTmVuXj+UIawze5M0YKtA8Sa13ig==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr152436226pfb.2.1559135747593;
        Wed, 29 May 2019 06:15:47 -0700 (PDT)
Received: from localhost.localdomain ([122.163.67.155])
        by smtp.gmail.com with ESMTPSA id o6sm17900752pfo.164.2019.05.29.06.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:15:46 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, qader.aymen@gmail.com,
        kim.jamie.bradley@gmail.com, keescook@chromium.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rts5208: Remove negations
Date:   Wed, 29 May 2019 18:45:31 +0530
Message-Id: <20190529131531.6368-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously return variable fake_para was being negated before return.
For simplification, fake_para can be changed to valid_para, which is
returned without negation (corresponding values swapped accordingly).
Further, the function names check_sd_current_prior and check_sd_speed_prior
can be changed to valid_sd_current_prior and valid_sd_speed_prior
respectively for greater clarity on the purpose of the functions.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rts5208/rtsx_chip.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_chip.c b/drivers/staging/rts5208/rtsx_chip.c
index 76c35f3c0208..17c4131f5f62 100644
--- a/drivers/staging/rts5208/rtsx_chip.c
+++ b/drivers/staging/rts5208/rtsx_chip.c
@@ -598,38 +598,38 @@ int rtsx_reset_chip(struct rtsx_chip *chip)
 	return STATUS_SUCCESS;
 }
 
-static inline int check_sd_speed_prior(u32 sd_speed_prior)
+static inline int valid_sd_speed_prior(u32 sd_speed_prior)
 {
-	bool fake_para = false;
+	bool valid_para = true;
 	int i;
 
 	for (i = 0; i < 4; i++) {
 		u8 tmp = (u8)(sd_speed_prior >> (i * 8));
 
 		if ((tmp < 0x01) || (tmp > 0x04)) {
-			fake_para = true;
+			valid_para = false;
 			break;
 		}
 	}
 
-	return !fake_para;
+	return valid_para;
 }
 
-static inline int check_sd_current_prior(u32 sd_current_prior)
+static inline int valid_sd_current_prior(u32 sd_current_prior)
 {
-	bool fake_para = false;
+	bool valid_para = true;
 	int i;
 
 	for (i = 0; i < 4; i++) {
 		u8 tmp = (u8)(sd_current_prior >> (i * 8));
 
 		if (tmp > 0x03) {
-			fake_para = true;
+			valid_para = false;
 			break;
 		}
 	}
 
-	return !fake_para;
+	return valid_para;
 }
 
 static int rts5208_init(struct rtsx_chip *chip)
@@ -796,13 +796,13 @@ int rtsx_init_chip(struct rtsx_chip *chip)
 		chip->rw_fail_cnt[i] = 0;
 	}
 
-	if (!check_sd_speed_prior(chip->sd_speed_prior))
+	if (!valid_sd_speed_prior(chip->sd_speed_prior))
 		chip->sd_speed_prior = 0x01040203;
 
 	dev_dbg(rtsx_dev(chip), "sd_speed_prior = 0x%08x\n",
 		chip->sd_speed_prior);
 
-	if (!check_sd_current_prior(chip->sd_current_prior))
+	if (!valid_sd_current_prior(chip->sd_current_prior))
 		chip->sd_current_prior = 0x00010203;
 
 	dev_dbg(rtsx_dev(chip), "sd_current_prior = 0x%08x\n",
-- 
2.19.1

