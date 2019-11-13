Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48545C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265B8206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="tSDAklaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfKMWyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:54:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43397 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMWym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:54:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so2298322pgh.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 14:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YzThP7vqWAF2JKLOm94GCZOblrnMR8+6q3/EyLUdnt0=;
        b=tSDAklaSoQvipGE27ua1O3lzpOd4kK5GoM9WC9l+9BqEgxiVPneK7Dqnxf/glB1p26
         geJO7MDJ4zdV3iK3WmZsouncLPqY2Rf03BRL99x6kl4H6wlwqKYXJdKkXC/uzfs8tI2a
         tU+BzUeZNVJTDgf4ivkYrtP6JeNfXjnIoe8yLWcgRcYCMMMRH3f0wjwF1zbGDm4nRG5C
         Qgz8PxAeaQZf1xPoa8B9rTo+1yJYhamQ3l1NGfOeNXb84ZDRaYcS+1fZcT/e2gHU0/AQ
         5A0lB7G7eGevTcarm5sQAZ5XFNvwmK6yUtoDcyD8lusEYl6kebRdprgHaq99MBcn5ul9
         Tlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzThP7vqWAF2JKLOm94GCZOblrnMR8+6q3/EyLUdnt0=;
        b=kMpgyRFVTyDt2GLtHCe5XfXBAw1oFnoTC6Rxeoi4z2xSmo/d5Grz5/TY+5IawqIqE/
         9E3Tl6P0A8/2NIx1LhUCuKcNyfGOhhxk+UjeXtnwW4quDaXiEDxhHdYfFwulJ3JAOz76
         e9e9HkSYtxLP6m6zGpvVxuEym9d8RErEFqn2kq0MXyukheMVOddR3Xi74X28IiPwhV7N
         uPWDtK5fDL70rBBICQzhQW+BRmRmJCoCetMVQcEZ7FWy1tutpqGTGyExhd0PnUKSvDTD
         2e+PIDT5mya6utZtD8KKgAmJOsU0ep8+5jeghE7ME2TtPMhTY99Gj1UWvB67PX5CdnD4
         e13A==
X-Gm-Message-State: APjAAAUPZ8rPCFpFIudrLBTow+H91mVxFDCv8FVybQfYvnOHN03545m9
        +FVAMj0p64ULJOCVTcodYY417SJAuLRV3Q==
X-Google-Smtp-Source: APXvYqwueIJ4re/fD86sVeb5x152yqjDqaH+pkQk8TNwHRHEoNwzt5z5yAcy2w25lsp6UQrocV+tUQ==
X-Received: by 2002:a65:68d7:: with SMTP id k23mr6395729pgt.157.1573685680314;
        Wed, 13 Nov 2019 14:54:40 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id l21sm3250622pjt.28.2019.11.13.14.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 14:54:39 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Tim Murray <timmurray@google.com>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] firmware_class: make firmware caching configurable
Date:   Wed, 13 Nov 2019 14:54:26 -0800
Message-Id: <20191113225429.118495-1-salyzyn@android.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191113210124.59909-1-salyzyn@android.com>
References: <20191113210124.59909-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because firmware caching generates uevent messages that are sent over
a netlink socket, it can prevent suspend on many platforms.  It's
also not always useful, so make it a configurable option.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Tim Murray <timmurray@google.com>
Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
---
v2
- move config from drivers/base/Kconfig to
  drivers/base/firmware_loader/Kconfig
- drop blank line
- default yes conditional on PM_SLEEP
---
 drivers/base/firmware_loader/Kconfig | 12 ++++++++++++
 drivers/base/firmware_loader/main.c  |  6 +++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 3f9e274e2ed3..33e6552ddbb6 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -169,5 +169,17 @@ config FW_LOADER_COMPRESS
 	  be compressed with either none or crc32 integrity check type (pass
 	  "-C crc32" option to xz command).
 
+config FW_CACHE
+	bool "Enable firmware caching during suspend"
+	depends on PM_SLEEP
+	default y if PM_SLEEP
+	help
+	  Because firmware caching generates uevent messages that are sent
+	  over a netlink socket, it can prevent suspend on many platforms.
+	  It is also not always useful, so on such platforms we have the
+	  option.
+
+	  If unsure, say Y.
+
 endif # FW_LOADER
 endmenu
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index bf44c79beae9..1c9f03514a47 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -51,7 +51,7 @@ struct firmware_cache {
 	struct list_head head;
 	int state;
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_FW_CACHE
 	/*
 	 * Names of firmware images which have been cached successfully
 	 * will be added into the below list so that device uncache
@@ -556,7 +556,7 @@ static void fw_set_page_data(struct fw_priv *fw_priv, struct firmware *fw)
 		 (unsigned int)fw_priv->size);
 }
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_FW_CACHE
 static void fw_name_devm_release(struct device *dev, void *res)
 {
 	struct fw_name_devm *fwn = res;
@@ -1046,7 +1046,7 @@ request_firmware_nowait(
 }
 EXPORT_SYMBOL(request_firmware_nowait);
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_FW_CACHE
 static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
 
 /**
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

