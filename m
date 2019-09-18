Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18CAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E6921E6F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P76x95oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbfIRSgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:36:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39352 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388846AbfIRSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:36:01 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so1561683ioc.6;
        Wed, 18 Sep 2019 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nZl0MfkTG3X3EXhRDaK05nz2gr2DUoRYaVX3YpE3rKk=;
        b=P76x95oA4I/9RZG8/nGE+NLWOBJkz6OajRxBKLlUSogHtFCbaOen6x5zvLYCAkc6fX
         dnXbVWILFTNeVeu103eowUSbgGSxoNRQFYN+tTkrTOKpBp+A61PwWK5r+QaawHz1gk5S
         uAavkXo3gt9BKPb/ZWXJr/MwsdeZ6UWxHGIwC0cJPfRJWnVdY6rIVtQeul1HHViSY5Fh
         t0NjLElUKL+upqPO/795G9BXskknaxg7RC2BpA9Wx1yTD6oe0asYZtunZ1QihAuM5zVo
         94JcHxsrnlOM9iMPR1TeTt1cs2urFirzuLmbyLmGoUhDyavNPv1mt7D8Z0WuA3UYHTpL
         blHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nZl0MfkTG3X3EXhRDaK05nz2gr2DUoRYaVX3YpE3rKk=;
        b=IGWbhw0zN1eMEb1Au/Tzh8YNKteePKJaGCn8O3q2ttpZPWkOPNVsUhlwiAGKiq3Q0H
         05oO0t3I0vZ6op2jMNcd4wyyIEz9oBqDU9y3IYLn+yWhTM3f9d2YPeN4t53Xp28MeSTC
         6wydDAp+iJKm4COwxPmSSywH9MoGUq6WHZoF8O+Ax1WTpHjN/TYzoskTudr4HPLo9RB0
         sXOe5ThTAxuGr7xKmUoouFfpLWKSam4+vbwVqAGunWW88v1TMNnt9cgkhyyzmskJuvf7
         4zBpmgB0wAjwpP8UbaSeOQgmfAHKMJaRCxKpWFnzZR7KSwwP3KOq8zs6QdeQkzg+lmpa
         ZCNg==
X-Gm-Message-State: APjAAAVfPtPkCyagSM7/823oSen/zIuZOKGBCdclLiqrQCVetT+yzw2x
        m7Qu+1RrsjWbooNGi1g4r+c=
X-Google-Smtp-Source: APXvYqyW/V+IS0EdkluNl1QzO2MJYnQ49J8HzARg1IPCkZSP4jgjkBu1LJpJe2H6FetEP8lNmRwwFQ==
X-Received: by 2002:a6b:7615:: with SMTP id g21mr6478202iom.67.1568831760754;
        Wed, 18 Sep 2019 11:36:00 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id s201sm8348190ios.83.2019.09.18.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 11:36:00 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Enrico Weigelt <lkml@metux.net>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        jan.kiszka@siemens.com, Frank Iwanitz <friw@hms-networks.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 4/5] staging: fieldbus core: add support for FL-NET devices
Date:   Wed, 18 Sep 2019 14:35:51 -0400
Message-Id: <20190918183552.28959-5-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918183552.28959-1-TheSven73@gmail.com>
References: <20190918183552.28959-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the FL-NET device type to the fieldbus core.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 .../fieldbus/Documentation/ABI/sysfs-class-fieldbus-dev        | 1 +
 drivers/staging/fieldbus/dev_core.c                            | 3 +++
 drivers/staging/fieldbus/fieldbus_dev.h                        | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/staging/fieldbus/Documentation/ABI/sysfs-class-fieldbus-dev b/drivers/staging/fieldbus/Documentation/ABI/sysfs-class-fieldbus-dev
index 439f14d33c3b..233c418016aa 100644
--- a/drivers/staging/fieldbus/Documentation/ABI/sysfs-class-fieldbus-dev
+++ b/drivers/staging/fieldbus/Documentation/ABI/sysfs-class-fieldbus-dev
@@ -12,6 +12,7 @@ Description:
 		Possible values:
 			'unknown'
 			'profinet'
+			'flnet'
 
 What:		/sys/class/fieldbus_dev/fieldbus_devX/fieldbus_id
 KernelVersion:	5.1 (staging)
diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 9903c4f3cba9..7e9405e52f19 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -113,6 +113,9 @@ static ssize_t fieldbus_type_show(struct device *dev,
 	case FIELDBUS_DEV_TYPE_PROFINET:
 		t = "profinet";
 		break;
+	case FIELDBUS_DEV_TYPE_FLNET:
+		t = "flnet";
+		break;
 	default:
 		t = "unknown";
 		break;
diff --git a/drivers/staging/fieldbus/fieldbus_dev.h b/drivers/staging/fieldbus/fieldbus_dev.h
index 3b00315600e5..f775546b3404 100644
--- a/drivers/staging/fieldbus/fieldbus_dev.h
+++ b/drivers/staging/fieldbus/fieldbus_dev.h
@@ -15,6 +15,7 @@ struct fieldbus_dev_config;
 enum fieldbus_dev_type {
 	FIELDBUS_DEV_TYPE_UNKNOWN = 0,
 	FIELDBUS_DEV_TYPE_PROFINET,
+	FIELDBUS_DEV_TYPE_FLNET
 };
 
 enum fieldbus_dev_offl_mode {
-- 
2.17.1

