Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BB3C06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B7F208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwX/eN1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGADYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 23:24:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44541 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfGADYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 23:24:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so621014pgl.11;
        Sun, 30 Jun 2019 20:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VhkgpflQSTglp1xxSrutR/deUdtT15AWmO5q6HS2EJw=;
        b=QwX/eN1NP+s31qkaBXHsA/4uNdz33T8GNlJUJHI4GrgssHadPqV388mV20DOlquTdy
         zj2kwtYw4vvArOv83bPWOe9P3KAZKVHPAKYUhzy8MZBBZTWJg1DoHy/IsN0u+8VEXBkf
         rB5HZf/8f0BtUeJoPLliBvjZMCmJOBEn0C1mH6gL0Whp365455b0gEXuFPSMBkwdeYyU
         lDxgFjM2GExlBcZqjqBnKn6IjggO8Fr/4tc1Vnqk4Z88sHwfkcjhiOnTCrFMGWTzDOa6
         CMuKN9QNWpZ5rjpcAakotv1oLnvuJ+BVmyOhd+sf/TghXe8wzsPWKE37m31VPuUx89Zr
         NxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VhkgpflQSTglp1xxSrutR/deUdtT15AWmO5q6HS2EJw=;
        b=PP6dyZpeSauy0eS5NzaoleQGpaft/nvjOXzhryEMwiOOy1wyIGGQ53UMFu9fW+lEH3
         tG3Q3nE+0BmdKpeEIyeahJALaM1y8xPskdO070wd+H8p7dBalrxTh1pKmB1dD7eqVyDm
         5CNmhncc2iDlVGa79T8lJct/jfxw49aJqX1uHEE01k6d7w6knrg5s8rF2hN3Mk2OfjVd
         FMP7PCwky6lPqknpw1FaX4JvLr/96BlmWJcrXm9HIpoZU8D7bnT0goPUw2u95kNKLsCo
         H8Tw26KNcfk7jYq1F4ATGPHk1SsUEugEB/QvOSIN2IsBKuWW45zAVxWNkcR8YGxLXAwA
         Jd9A==
X-Gm-Message-State: APjAAAUM2QPkDdnMS9La9LNYXKtbj9kr5ljShWvQmkXFWOh7bzZpXE0R
        jcDKcY1vaEZyLaDOAz4ulv0w07TRQDE=
X-Google-Smtp-Source: APXvYqypRRvqTRN4Zfwk4sGc5n91o0nELNv9VP+tB4FycyMgVLHbSCyjaJHLmURAxGTCk1dV372k/A==
X-Received: by 2002:a17:90a:d14a:: with SMTP id t10mr28422499pjw.85.1561951476408;
        Sun, 30 Jun 2019 20:24:36 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 137sm9185889pfz.112.2019.06.30.20.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 20:24:36 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform: x86: Use dev_get_drvdata()
Date:   Mon,  1 Jul 2019 11:24:26 +0800
Message-Id: <20190701032426.26127-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_get_drvdata directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9b18a184e0aa..49049b02a015 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1353,8 +1353,7 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 					  struct attribute *attr, int idx)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct asus_wmi *asus = platform_get_drvdata(pdev);
+	struct asus_wmi *asus = dev_get_drvdata(dev->parent);
 	int dev_id = -1;
 	int fan_attr = -1;
 	u32 value = ASUS_WMI_UNSUPPORTED_METHOD;
-- 
2.11.0

