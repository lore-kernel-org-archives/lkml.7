Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145F3206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Yj5NDgeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKMVBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:01:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34964 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:01:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so1589707plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwCJeTWsXIkuZf7U24JozLi4iI7y8pjl8SC2dEj8VQM=;
        b=Yj5NDgeVRspTtypcFWEprPu587HokocCy6qd8YgXKmjeQY3h+vdwa7OiYHirzIrd79
         oPkaorZS9KYlO7HVJUJIz/MKwEUlBQVuK0Itu5nPbQ8b5uGkicYyOOrW9NoY38kBK1de
         gic4nQ2DBjOyIfkqDfF5uIVOkzT+weXHWHA0Qem7GeuJsBmVquvUW8Z7Wh+7IosRmJK/
         knztOP1ktcOAUwG05+cn7AU4ZN23pVcbuKPKYBwz114FFDCMAx1w2MBxKFLrHlFlROs+
         fnddAT+yqOiLF7a54b1TsAicAwkGXuZKB1j+AFhWxTROGOeuI2t5cHNgm+MSntXj954L
         uTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwCJeTWsXIkuZf7U24JozLi4iI7y8pjl8SC2dEj8VQM=;
        b=RCp3aZQP6jXa1NIR52ajOJz7lytFP3K4B2BM+1JaEzFgjr2TTxx9+B9+HLR+tzUw9y
         q3nvzPygp5KVXBpNrMd0Saiax2NabtZKbzZXPGB26/T9kA9UC/7PaVgfnTxqxrggyid2
         Yd0jSzQ7tTpZgBn5qKNha/9ZzO8ISFyeAmneqoEGiwGss2dXYhug6G8Ma85fBBiJ459g
         Mge8ccgQvdk/ZUEIOLsTPpRAxXCZf8J63J/viTjrA8dlyfHdPgnn5NZsysJEBnr0aS4M
         n0EkUMxCt3erNNGrb8BSyWn3juhaaqeDqpRL7wNifgQ9uv/JkeAACwDjHiYAEgFYQIMU
         S5MQ==
X-Gm-Message-State: APjAAAWgvonilvlWBUzamYWxzGnet2R2f1WgQMRG6NhqNCm627uttoJS
        qovzjLrai6CDJycTzUz5KcdeNRyTr9KYcw==
X-Google-Smtp-Source: APXvYqxx5ospNT4MLpFUNLCJQSlkzXvM/qUblwjMbUGxg/kMFFA3Jfyz0dk809P0MgjSoAGCObPtfQ==
X-Received: by 2002:a17:902:9882:: with SMTP id s2mr5912132plp.101.1573678896219;
        Wed, 13 Nov 2019 13:01:36 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id s24sm3854935pfh.108.2019.11.13.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:01:35 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Tim Murray <timmurray@google.com>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] firmware_class: make firmware caching configurable
Date:   Wed, 13 Nov 2019 13:01:13 -0800
Message-Id: <20191113210124.59909-1-salyzyn@android.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
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
---
 drivers/base/Kconfig                | 13 +++++++++++++
 drivers/base/firmware_loader/main.c |  6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 28b92e3cc570..36351c3a62b0 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -89,6 +89,19 @@ config PREVENT_FIRMWARE_BUILD
 
 source "drivers/base/firmware_loader/Kconfig"
 
+config FW_CACHE
+	bool "Enable firmware caching during suspend"
+	depends on PM_SLEEP
+	default y
+	help
+	  Because firmware caching generates uevent messages that are sent
+	  over a netlink socket, it can prevent suspend on many platforms.
+	  It is also not always useful, so on such platforms we have the
+	  option.
+
+	  If unsure, say Y.
+
+
 config WANT_DEV_COREDUMP
 	bool
 	help
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

