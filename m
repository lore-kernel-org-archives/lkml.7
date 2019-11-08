Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AE1FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D692178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2fNiNh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKHQr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:47:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34384 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:47:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id 139so6925876ljf.1;
        Fri, 08 Nov 2019 08:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruDzCFGTnibQWfw6eGTcqpKQB6fF0oRUt7fDkDjSl4k=;
        b=A2fNiNh6wFIBLG0Gy4E9lTn2QQkhbfkInruQoJ19Tn4MVDI7qdmLPX2BHfNHkheAR2
         SazZrHu9lZFI3abwISz3kGuvCbCvM9GZ3BuV7lZOktkDoUjHU2H2FLlX40POzn+RXsW0
         u37WEN9wQ4y4MtjvDA/kGOUiYWs1kvw5JFmuX4T6JPPs3NbObv7sVI3v9+Yh7qupLzxi
         pC/a3RWnKTp3+0ZQ/vIK7E1EnM3iB0gZzb0OWPgyIkTSPW9odEHd8ZZUikZHFvwGDm06
         i2eEJsDxFmrkaQfQVnptmXX0AGIS17PeCI4AasSwEykk7bXRkCK/SwEzBRrbG9q/OBYk
         HAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruDzCFGTnibQWfw6eGTcqpKQB6fF0oRUt7fDkDjSl4k=;
        b=tmyE09vvo2RcZxphil8V1fcBMeWF6WDL6QyKMejuGTaHSEZgBuSYxYa6anglt5L3Oj
         W7xaP+A2MJwGV1kZXeR9jy3iTjcoq/InPiMssinSRoiu6Q/VfZkct5Sa08BpQelzucgi
         fdipiptptpzAmhpffOrpoQiCPWMFxkD6Ern6gsFZiAKnzBn+xtWwHmHNl1HlVlFT2cUG
         FDcWF6g4FIxMl9T5sWfx6fZLSL4vFsLtwkZkerLp6ACniOblSo3jbvtcYGhTWoh7APxc
         B4dE4oRM4cCIwYPVVlzLpw2crLmVY32q7n3fe5KzNUUQ89QnG+OaR4Scz0YqMxMmvY7v
         72fA==
X-Gm-Message-State: APjAAAWBDIWOBbQLP2l7+Wn3g3gvQQy0Jmlby1nkwv1WZVKo/D2fHso8
        f+SIlxaUpxlY2ncw03fGFj2mlNT+9hM=
X-Google-Smtp-Source: APXvYqx/g1MVap0Pkj3DOsKO7eHBIvo4hWDmGcLEXx335XgFY9+ODFw4MbZgkqh7sXcGBGUXU2VSXQ==
X-Received: by 2002:a2e:9d8d:: with SMTP id c13mr1219810ljj.71.1573231643626;
        Fri, 08 Nov 2019 08:47:23 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id i30sm3162236lfp.39.2019.11.08.08.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 08:47:23 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v4 3/3] asus_wmi: Set default fan boost mode to normal
Date:   Fri,  8 Nov 2019 18:46:52 +0200
Message-Id: <20191108164652.3223-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108164317.2874-1-leonmaxx@gmail.com>
References: <20191108164317.2874-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set default fan boost mode to normal for multiple reasons:

1) existing code assumes that laptop started in normal mode and that is
   not always correct.
2) FX705DY/FX505DY starts in silent mode and under heavy CPU load it
   overheats and drops CPU frequency to 399MHz [1]. Setting fan mode to
   normal avoids overheating.

[1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=203733

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 4f9c0b99f352..e6565b4e7ed7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1675,6 +1675,15 @@ static int fan_boost_mode_write(struct asus_wmi *asus)
 	return 0;
 }
 
+static int fan_boost_mode_set_default(struct asus_wmi *asus)
+{
+	if (!asus->fan_boost_mode_available)
+		return 0;
+
+	asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_NORMAL;
+	return fan_boost_mode_write(asus);
+}
+
 static int fan_boost_mode_switch_next(struct asus_wmi *asus)
 {
 	u8 mask = asus->fan_boost_mode_mask;
@@ -2451,6 +2460,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
+	fan_boost_mode_set_default(asus);
 
 	err = asus_wmi_sysfs_init(asus->platform_device);
 	if (err)
-- 
2.23.0

