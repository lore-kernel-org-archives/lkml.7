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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3314CC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0638A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okn4LyXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE2By4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:54:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32917 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfE2By4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:54:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so524263pfk.0;
        Tue, 28 May 2019 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5W/lLWMNb17QpP+6k38wb7j7ve1dD6nwPuptvVHvnkI=;
        b=Okn4LyXVLPFBoL8Xw/FdxASDxhTVtFYuBqrr/QTfowX9+5PNaH0UG7GfAXRemV1YV8
         A1X+dzdUsnusz34CjjDCd7kqOz508/UNfxbpIRxh7Te27qEpsMUh4cnud2zVIoPp2Jcl
         lsKIMmxnFe6qeXIDv52+u/1sD74KdQYLdB+VguGUKd41wjxGkhCY7x+2sMvUjs6YQt2y
         EkVPwpQmwFQ6gdFct3/SeZ4nAW78vvEawzBbjHXNr53tACUqO7HBG3US/SxQeEjQvhbA
         8q16KKpOqkchaSIo3P5DqL4DasWyVKQ4rFke0uTJWMIy3wiIW2FGWLLmsCr/faUU73Dg
         qEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5W/lLWMNb17QpP+6k38wb7j7ve1dD6nwPuptvVHvnkI=;
        b=Exz3ytn8WxsH/TV5KBrawE4dfmUE32OxEVFJFq13CcqAaLxC3QjnaqewX+zEQ3bDFJ
         U0uukj4a8DAvtbpmqxQXMLEnJX6+J09t2utvNffb0YLieZsoj3etYMRwhtfjW6+Chru/
         AIzhJJgG0yB21hAEj/nZHohd206ELgiBu+riWtExHIOa/wP3X2AyTFdebA/jW7QLHB72
         VdcwtsppLNZlmHUFIFzGppx/w/IuwM/LhOOQOT2ODHofbdr0JsaJu56e0xAr/xM4VBoR
         NboEFikMYn9AYmIKqOThsE6zWoC5DNKqkuTQa5yjPyShUPCxsFQBufpjVgTmfbP7Z1O3
         V7YA==
X-Gm-Message-State: APjAAAXUFxbhMSK1qWTtN8mwPVkU2+vEw0mLcqy3Lzh9DLhjoMWJzuZI
        ++AHEQ1oB1hwGwZiHWFGqww=
X-Google-Smtp-Source: APXvYqyiMm2o6ewEBpTuiiSueFvWgwtgc7oCo6TLMNbRr8Xyn4wQp45ZT+cDrNoZ8J7SeT8uf9LM3w==
X-Received: by 2002:a17:90a:77c4:: with SMTP id e4mr9440966pjs.86.1559094895333;
        Tue, 28 May 2019 18:54:55 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id s24sm15800610pfe.57.2019.05.28.18.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 18:54:54 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     sujith.thomas@intel.com, dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] intel_menlow: avoid null pointer deference error
Date:   Wed, 29 May 2019 09:55:51 +0800
Message-Id: <1559094951-25391-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a null pointer deference by acpi_driver_data() if device is
null (dereference before check). We should only set cdev and check
this is OK after we are sure device is not null.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/platform/x86/intel_menlow.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index 77eb870..28feb5c 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -180,9 +180,13 @@ static int intel_menlow_memory_add(struct acpi_device *device)
 
 static int intel_menlow_memory_remove(struct acpi_device *device)
 {
-	struct thermal_cooling_device *cdev = acpi_driver_data(device);
+	struct thermal_cooling_device *cdev;
+
+	if (!device)
+		return -EINVAL;
 
-	if (!device || !cdev)
+	cdev = acpi_driver_data(device);
+	if (!cdev)
 		return -EINVAL;
 
 	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-- 
2.7.4

