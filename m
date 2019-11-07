Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2876C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEA62084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6eQY235"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfKGXFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:05:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36840 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfKGXFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:05:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id m6so2927187lfl.3;
        Thu, 07 Nov 2019 15:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qh1AeCz8eA6zmulN69qbNwKR1BsfwhZTioKSRTvkL3s=;
        b=H6eQY235ZUufhirzG/FMY+QW+MMkR5AeVIQ9atA8pC4O8NbNFpudtjJyx2M37BmKma
         tSfz05UC/lmDgOleSzcySKRZpG34WxYGzPOTKf6Rp8FUs2v8lVkyZvLW1+CXDQC/9p1X
         3C7QdQzGjfraJonx6a9RpCwF1gW+lp1ctVql+GUplVKBGlNQ0QthPg5iTdTBgur3DwqJ
         zzrgdF5Zqc+pfZS7/QAX6sHVEBcLaIiEQtRIooLbetmTIlcWE6koIdK+v/xPLfn1T3J0
         0rQZi7/TQDVROGVzGskBOVXzZxUAAYYztglFEHRn2Y4c0DrYhWgMf1APcigRIpjI0fUp
         RJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qh1AeCz8eA6zmulN69qbNwKR1BsfwhZTioKSRTvkL3s=;
        b=ITZrVC/Uwfl/J56hzBDrVmXrHo9XdY2Yt4M+p7e8qRerZbuNUdvJIpyZWeZtISyMLh
         KgwpA5wjLcIdOXvUB43AnPRXu7t/YTeh1C59W4wpLKLUWLk0HRfERNiK9l+RoK6isqiM
         VGM0+dWVWWqpTvXrcO9rODHsvGu4mzNSnzknOUYq7vl/7iMmBjG78LMJiWFDbkly+rXO
         V0yk6l7egfcKdCtPDDxhFxK4BHvVkslY4u38djga6J6EfBtNX/K7XwpKwYtRQK/k/mwX
         d0NhnvpFQEC3gsjPxC72CS86BasCyF44GVRTdY3xS7SiN54LNQFsO5Ig3/XF7RgufIud
         HUOA==
X-Gm-Message-State: APjAAAWt8UNNVwwXVqTD/gSllT1dAhKJRGs39JxYqZ2hwRe4oOJRcgD7
        AFpnN/nXFnmu8/+RQzsCN+1Ib8yosAw=
X-Google-Smtp-Source: APXvYqyVGAOaeBedDtYlz53PFyZjB3gajDQWaZrwBhwlLsvYOIeFI9ug2eQ0Z+w+xPMJGWX88ewLnw==
X-Received: by 2002:ac2:5453:: with SMTP id d19mr4331022lfn.181.1573167909899;
        Thu, 07 Nov 2019 15:05:09 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id y5sm1556113lfg.5.2019.11.07.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 15:05:09 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v3 3/3] asus_wmi: Set default fan boost mode to normal
Date:   Fri,  8 Nov 2019 01:04:58 +0200
Message-Id: <20191107230458.30922-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107230105.30574-1-leonmaxx@gmail.com>
References: <20191107230105.30574-1-leonmaxx@gmail.com>
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
index 311658807dfe..435e1420fb40 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1678,6 +1678,15 @@ static int fan_boost_mode_write(struct asus_wmi *asus)
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
@@ -2454,6 +2463,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
+	fan_boost_mode_set_default(asus);
 
 	err = asus_wmi_sysfs_init(asus->platform_device);
 	if (err)
-- 
2.23.0

