Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B5C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2521479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5yI2Exz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfDTMmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:42:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53284 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDTMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:42:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so9002068wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z1XXjdP1raYtc6eofdmgmZhdX2Q5XdKzCfskQfcYBLo=;
        b=V5yI2ExzEGPzJK3fF4PXuIC1+Xx/1Thg6ZArDJQEidiQwRW6qzU7JNyrAowiCdCkEY
         j4mJ3OPLJUYUUvVTK3JNq2690ewLKfWHp3w6WObU3JMqjsF7SODCFZ+f/oQKd76RdDlh
         YsqXkxMk/yCJJUznxPMm+2R9EJ2bWmNkxTjKXvhVJGKu3srJ7/LG7lcsvDGC6Xf1jyLX
         ibo+mVUzq/tkSkIujrl2JYUzw8hEwEs3A0hOVt/igJeFElpG5/5h3wGGOrbNWjfi3MOg
         zNsZK1g9xBLidtNyH3SddaKzhWQOAuXcPo7Okb95toB7IlhLJo/OWUleE31oXeRpt2u6
         EOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z1XXjdP1raYtc6eofdmgmZhdX2Q5XdKzCfskQfcYBLo=;
        b=n2g8IDfWrc5fQCsrSWVXEhuTWCKfetgfofK9X+lKQQpJWLV9LZe5LD800oBH5O3G8U
         DtPpaaaB7dAuR+O4t3CtHrzxYizJe2KdLjC2BTkzMfuq/rA5m+Ae+arg/C7+QhJ47Mfp
         qUtf+KOaYH9EtUfC8QAjxe2qcFWBFPZupmAlhDvg0rmGvBHcwnaqpl/1hUGi92qy6HYv
         P+Sjm9fT288Jfgwc1PfaQ/mMDQ1S34Y0QPcTqDAlk7kJE0AK8UZ1q2rB4oDUhJvNTLaA
         KxLWSP3oIZpIA8emUEnxh0LE+aEknnDuvkKVerxYD6TWVO8VXbQ0AtMHqeZs8Kil11wu
         lI6A==
X-Gm-Message-State: APjAAAUJEiulKAIv4yL5ePowz5PHuHF14/xI5PVhGlYMU5w4iVa6A//R
        9gsLsyi9nMFT1YmeqM/6OdSPFaew
X-Google-Smtp-Source: APXvYqwC+sBjLp4Q5DGqysZYI+kM+WeT/OZxn8gy9HKONI2zy0vb+22Ya9i0G0ZLObwTmH9eClC0dw==
X-Received: by 2002:a1c:a184:: with SMTP id k126mr5921788wme.71.1555764168773;
        Sat, 20 Apr 2019 05:42:48 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u6sm8919678wrg.72.2019.04.20.05.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 05:42:48 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Cancel pr_fmt() definition dependency on includes order
Date:   Sat, 20 Apr 2019 15:42:38 +0300
Message-Id: <20190420124238.30666-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

pr_fmt() should be defined before including linux/printk.h, either
directly or indirectly, in order to avoid redefinition of the macro.
Currently the macro definition is in habanalabs.h, which is included in
many files, and that makes the addition/reorder of includes to be prone
to compilation errors.
This patch cancels this dependency by defining the macro only in the few
source files that use it.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c         | 2 ++
 drivers/misc/habanalabs/habanalabs.h     | 2 --
 drivers/misc/habanalabs/habanalabs_drv.c | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 25bfb093ff26..a88f7be23c7f 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -5,6 +5,8 @@
  * All Rights Reserved.
  */
 
+#define pr_fmt(fmt)			"habanalabs: " fmt
+
 #include "habanalabs.h"
 
 #include <linux/pci.h>
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 2f02bb55f66a..86bd5298efd6 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -11,8 +11,6 @@
 #include "include/armcp_if.h"
 #include "include/qman_if.h"
 
-#define pr_fmt(fmt)			"habanalabs: " fmt
-
 #include <linux/cdev.h>
 #include <linux/iopoll.h>
 #include <linux/irqreturn.h>
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 1667df7ca64c..5f4d155be767 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -6,6 +6,8 @@
  *
  */
 
+#define pr_fmt(fmt)		"habanalabs: " fmt
+
 #include "habanalabs.h"
 
 #include <linux/pci.h>
-- 
2.17.1

