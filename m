Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F52CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 01:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD9821D7C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 01:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VREnqwrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfJTBZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 21:25:45 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35243 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfJTBZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 21:25:45 -0400
Received: by mail-vk1-f195.google.com with SMTP id d66so2042262vka.2;
        Sat, 19 Oct 2019 18:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUQmpU57mDzIzJ7kVuY9aLBqmE4vAg2xVScwQnfYVek=;
        b=VREnqwrGuOTZgcYTrRLcK6YrDIs4afZyP4PixPARCe+B6Z9AIjH/HtE7EtjZH5Qtvp
         NpOh1BNeYXUZYR6EPBB0XBGE5ZhdnSJaWj1+GbM39Oi0jSLgTCt10IpVnOcz6yriUDcV
         u0atdmQg2Bxfy9VAatCMlpfavbckcDj547LK8C/jNy66BuzqlTZy4CnmhLXwfLCixLAt
         n9wWcSPjeX2Z4kyuzh41VeV+vdtVoGYVu+c3TZQK+QHy8/oVIrZrfpMcYTF9DC60Piuj
         EogJNEwaETfIKre1CrJilnOPZW+e/TFTDEZVpbp1/o3hQKMQ7DoQhxnk0Px1HEJ588Kf
         1SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUQmpU57mDzIzJ7kVuY9aLBqmE4vAg2xVScwQnfYVek=;
        b=dSJqbyzlc1BMn3p+tSFbYDFtz3LRGGuUB1OGr2syVrJLM4Xas7bLl5i483BKpxBRC1
         ZfYX0lQmrUG+r4YAn4Ui6Cq3HqNUIdAF6kQsfNK9gPlUf6BNWUGlA7UPevNfxd1yKptS
         Rr47gc915Z6LfeZvnbRZBi3JYGObmCWUNaOX1vPXDWzXCijsNoT4cVXkmkF4nc9HjAHa
         FYtkPQAwTjYw9PP+kBc88a0jpq5XEO7hnifysSlF+FOlpcjwaTuQeJNcXvN15411ptHP
         VjVLvYKBbENzwgLunC94eq0RBMWXJDgRvYFChMZYZzxIPxxkKYRbsox32D/S2zDn1r9K
         gQ2Q==
X-Gm-Message-State: APjAAAV9AkYBI+gGj3vFWJBM3Mf8k1eZQp08C6xP2z5IFrctStc8Swid
        2lw0gPaORvNtonc/t0xOhxQrAtgflipR
X-Google-Smtp-Source: APXvYqxMP+Fd9epgUAKdmVQhgIXHkSaxyH+Zy7aA0KHxHcQam9rSH5sm/Wy4Rt1CkpMX1+kgCZSrcQ==
X-Received: by 2002:a1f:9712:: with SMTP id z18mr9416651vkd.22.1571534743688;
        Sat, 19 Oct 2019 18:25:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id r27sm2282148uae.7.2019.10.19.18.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 18:25:43 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Mattias Jacobsson <2pi@mok.nu>, Takashi Iwai <tiwai@suse.de>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: huawei-wmi: Remove unnecessary battery mutex
Date:   Sat, 19 Oct 2019 21:24:58 -0400
Message-Id: <20191020012504.17919-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

battery_lock mutex is never used and not needed.

Fixes: 355a070b09ab ("platform/x86: huawei-wmi: Add battery charging thresholds")
Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 7373a65a61d3..a2d846c4a7ee 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -67,7 +67,6 @@ struct huawei_wmi {
 	struct led_classdev cdev;
 	struct device *dev;
 
-	struct mutex battery_lock;
 	struct mutex wmi_lock;
 };
 
@@ -807,7 +806,6 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		mutex_init(&huawei_wmi->wmi_lock);
-		mutex_init(&huawei_wmi->battery_lock);
 
 		huawei_wmi_leds_setup(&pdev->dev);
 		huawei_wmi_fn_lock_setup(&pdev->dev);

base-commit: fd13c8622a5ad4f7317b64de4f6aa2de1962220e
prerequisite-patch-id: 7639f479e344d2a1be074f93dc5e5530611928f9
prerequisite-patch-id: ad5932635d0c0d531a99e15e239f81ecc69b47d6
-- 
2.21.0

