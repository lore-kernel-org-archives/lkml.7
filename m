Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2CCC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 10:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8287C207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 10:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sszXrU01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfL2Knd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 05:43:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44191 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfL2Knc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 05:43:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so16703420pgl.11;
        Sun, 29 Dec 2019 02:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7DhzWBS5UwZiGHnoV8xDhDhB0j8GNMpnSRjHD30dKiE=;
        b=sszXrU01FkjSQNPJF1nqy/MQQXF7rxTjkbovF2bmOpxYKb8r7VpoBgjRlQmd1364L7
         jb5j1mDM9sUPOlU4ypGG5BrARsRWlzjo2QT2F8sjeS08tNLeSi/p/4FV4ALcdE4ink8F
         O8FyWnbW7XxO9v0qNNu3V2BvEQSeZ9LcQKR2TmpTVRk7BkVHnV634WHLIr3qnVeYGV4M
         ZQfonQdiI6JxjEQi1uweWguvdiZoyj0mcoCU+eVLkoP/3nMrB6OtpEqNDgqmarv/PEVL
         0fnZaQ4mCIwzHtxVLnpXiSFyJ7vjvsN3flzXqPteO+2dccj9ZjqMiQGyl6UXamLzIzWM
         DHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7DhzWBS5UwZiGHnoV8xDhDhB0j8GNMpnSRjHD30dKiE=;
        b=FoV5tcCLqCp8FET8XhbHxvyY+j3tI+HKisIiKQqsOOINQ6Rr1NcwonB/E4dd0uDgxr
         GJaJupgFqdF8eY5HMG+M0InMUwzLgVsDkbRjKtd32OM3/clcHoi1l4ZtbFPOYJiZhfuH
         7yKvodLUqB7TnX0mzIW4JTxSfLOdm/Zn6AjnoN0xsp1PSF25hNfcuBBLN1pWbJdUnJ6a
         3foBlAx1doipZFFumvN8ObWdM8NlRoS8xcunmK8OmWLQkwD/w8J0QrO68mVWoGQuCago
         fYZ1lPzLvfmXGam1en3ptQBZgwHGxTlBh/qaWcQ7M3NxsRmoUIDofw7S5khGMhDifjaT
         GWqQ==
X-Gm-Message-State: APjAAAVaUb2IHkFaEJ1CQ0IrBww3fj8VFs+ZcR8QbHqbQPuOmFsFlcNm
        4u9pb3+hb1bQIGh5B/ym/hw=
X-Google-Smtp-Source: APXvYqwAlJZJaiwBc9a6GtVubhR2kSJS1Maicf+HrNznlTStIN0Ikguaq/p2qIJsB8HuldCFd0+fjA==
X-Received: by 2002:a65:4344:: with SMTP id k4mr64812391pgq.193.1577616211982;
        Sun, 29 Dec 2019 02:43:31 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id p16sm43147484pgi.50.2019.12.29.02.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 02:43:31 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org,
        bgolaszewski@baylibre.com, arnd@arndb.de, sboyd@kernel.org,
        mchehab+samsung@kernel.org, matti.vaittinen@fi.rohmeurope.com,
        phil.edworthy@renesas.com, suzuki.poulose@arm.com,
        saravanak@google.com, heikki.krogerus@linux.intel.com,
        dan.j.williams@intel.com, joe@perches.com,
        jeffrey.t.kirsher@intel.com, mans@mansr.com, tglx@linutronix.de,
        hdegoede@redhat.com, akpm@linux-foundation.org,
        ulf.hansson@linaro.org, ztuowen@gmail.com,
        sergei.shtylyov@cogentembedded.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] drivers: platform: provide devm_platform_ioremap_resource_nocache()
Date:   Sun, 29 Dec 2019 10:43:25 +0000
Message-Id: <20191229104325.10132-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229104325.10132-1-tiny.windzz@gmail.com>
References: <20191229104325.10132-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a nocache variant of devm_platform_ioremap_resource().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/platform.c                       | 19 +++++++++++++++++++
 include/linux/platform_device.h               |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index af1b1b9e3a17..3b79a3207490 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -320,6 +320,7 @@ IOMAP
   devm_ioremap_resource_nocache()
   devm_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
+  devm_platform_ioremap_resource_nocache()
   devm_platform_ioremap_resource_wc()
   devm_platform_ioremap_resource_byname()
   devm_iounmap()
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index cf6b6b722e5c..80f420b9b4d7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -79,6 +79,25 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
 
+/**
+ * devm_platform_ioremap_resource_nocache - nocache variant of
+ *					    devm_platform_ioremap_resource()
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @index: resource index
+ */
+void __iomem *
+devm_platform_ioremap_resource_nocache(struct platform_device *pdev,
+				       unsigned int index)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	return devm_ioremap_resource_nocache(&pdev->dev, res);
+}
+EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_nocache);
+
 /**
  * devm_platform_ioremap_resource_wc - write-combined variant of
  *                                     devm_platform_ioremap_resource()
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 276a03c24691..b803e670b1c5 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -58,6 +58,9 @@ extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
 extern void __iomem *
+devm_platform_ioremap_resource_nocache(struct platform_device *pdev,
+				       unsigned int index);
+extern void __iomem *
 devm_platform_ioremap_resource_wc(struct platform_device *pdev,
 				  unsigned int index);
 extern void __iomem *
-- 
2.17.1

