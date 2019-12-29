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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD71C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 10:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420B7207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 10:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDo1FQhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfL2Kn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 05:43:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46339 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfL2Kn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 05:43:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so9105622pff.13;
        Sun, 29 Dec 2019 02:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/LBWm4l954ZJKYAq92ROSgs+ZenxsvmleMIDLun91dw=;
        b=JDo1FQhJmYfRsBhu2Wu5bzNCLN4BfQFrKawakq4ZNnqh7F8Bsr6MgKwGPrM0pAR747
         m3u4NwVzc3JNdNqCzhc7xlR6vgxKUQJm3RGytfYs+GVN5q4jrvIwJtr98v5hHyWOv6kJ
         tH72oN8HVcqC83u+yzUDQbtjG3qxrSaUUOo+52bMet/bCSHR2s5cjWaZ3hJLfQEoVOuz
         9/uo5azGXWZAJr1m6IyShiTy5DZYmpkjKV7hVcfZcjpJadbuNNacjdrTEEVgWC1ybfSc
         6YDzfy1ftuBRFyb1IqkIfmx+2KpyM9aQ2WL9QqGjuf2raJbFb4lcxJbt4hJrNOersus1
         N0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/LBWm4l954ZJKYAq92ROSgs+ZenxsvmleMIDLun91dw=;
        b=emNUP0AyHfVIuzK4kaWi7LHuRUr0B57SIuLdZP20GGOX2QRllAiFBbOUirGtp3WsqZ
         1Z12EjPaTJBrPnW9xrT2JvaQ/gGCgBC8VoEI5+z2zKMWoiAKeqMmhvoYVoqOf7SRE6UW
         tnc21/S0bTBjUSr9KlWz2lhvNjKzDIMH5x7rx/Con7pTYfLO0q/5GAPehowgL+FAB+W6
         JA7GPMKYChDllUce6lHsFskBlp/11hGskqRntxfETEH6xjAMQU+PyG34QEPfhbDoUI2N
         lKTja/fOsnXuz9H1vd/A9Rs6mlKiPDZFm/1EqG5/837Gq1soGQZx8ia0z9bgFGPdcUuY
         5ejA==
X-Gm-Message-State: APjAAAUYgPDH+eJuuUa6PeoD4cCgbGoOB0JxBKkD1w3qPxI8UB6rXOOu
        t3TcgIbVCgX+oXNVyNRbmBA=
X-Google-Smtp-Source: APXvYqwmLa+NDFvL01yeV8iEdrmHYiAHIwhIXMGs0MMC5H0Tu9B6S4fgYf9kUCPaPVzVAPi3Q4M2Rg==
X-Received: by 2002:a62:d407:: with SMTP id a7mr62077586pfh.242.1577616208086;
        Sun, 29 Dec 2019 02:43:28 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id b22sm20643677pjb.4.2019.12.29.02.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 02:43:27 -0800 (PST)
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
Subject: [PATCH 1/2] lib: devres: provide devm_ioremap_resource_nocache()
Date:   Sun, 29 Dec 2019 10:43:23 +0000
Message-Id: <20191229104325.10132-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a variant of devm_ioremap_resource() for nocache ioremap.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/driver-api/driver-model/devres.rst |  1 +
 include/linux/device.h                           |  2 ++
 lib/devres.c                                     | 15 +++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 13046fcf0a5d..af1b1b9e3a17 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -317,6 +317,7 @@ IOMAP
   devm_ioremap_uc()
   devm_ioremap_wc()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
+  devm_ioremap_resource_nocache()
   devm_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
   devm_platform_ioremap_resource_wc()
diff --git a/include/linux/device.h b/include/linux/device.h
index 96ff76731e93..3aa353aa52e2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -962,6 +962,8 @@ extern void devm_free_pages(struct device *dev, unsigned long addr);
 
 void __iomem *devm_ioremap_resource(struct device *dev,
 				    const struct resource *res);
+void __iomem *devm_ioremap_resource_nocache(struct device *dev,
+					    const struct resource *res);
 void __iomem *devm_ioremap_resource_wc(struct device *dev,
 				       const struct resource *res);
 
diff --git a/lib/devres.c b/lib/devres.c
index f56070cf970b..a182f8479fbf 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -188,6 +188,21 @@ void __iomem *devm_ioremap_resource(struct device *dev,
 }
 EXPORT_SYMBOL(devm_ioremap_resource);
 
+/**
+ * devm_ioremap_resource_nocache() - nocache variant of
+ *				      devm_ioremap_resource()
+ * @dev: generic device to handle the resource for
+ * @res: resource to be handled
+ *
+ * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure.
+ */
+void __iomem *devm_ioremap_resource_nocache(struct device *dev,
+					    const struct resource *res)
+{
+	return __devm_ioremap_resource(dev, res, DEVM_IOREMAP_NC);
+}
+
 /**
  * devm_ioremap_resource_wc() - write-combined variant of
  *				devm_ioremap_resource()
-- 
2.17.1

