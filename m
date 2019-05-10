Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C05C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FED217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EcJ7jK4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfEJSCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:02:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34539 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfEJSB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:01:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so3384483pgt.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYP5cJo7Rn+KgfhTSNkJ3NUy5pK1OjrMkapnaBKgukw=;
        b=EcJ7jK4VMbyV7NP4gX8Bvna+PAEJWRAxSPwoB/jrK5v/GqmjncDXcZeduQGfwnqYIK
         apGfm//m48c9Sqp/lRfhygYEdUmjcWG8svKrze8Lh0TrR+aA/WM/W/xqh3QTKDLVPGb9
         cgrQt/HUitHjOthg5RggwGPMr2ti4+8q2icX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYP5cJo7Rn+KgfhTSNkJ3NUy5pK1OjrMkapnaBKgukw=;
        b=FmN5htYpvIIsFGU1Ba7q1czvtakYGugBlz6QwhMYHXtwLtRFfpQoybuX+hMZCTHvAS
         vP4UColKygVmPoOF4I9d1xTx/jxTtvJnPq/wMUndZgVVbxJf/Th7MYlpbXwdIKgNlneW
         U8UUxdPsFzZyyPXwGb9xSncxUjbuK1mQnf6Mpoo0pkxB8zEsytOFv7lnimHqZEkf/fQq
         gUjGH0e7763tXgP/mSeH4mtDc5PRAF2OIuUgCCqQci4cNJmvyEsgqCr8nHHQjJRskW1h
         FzY8ZHkbX7moExA0Oxct0c+Q2tM4WsDw7P7/DGfgWDqQh+eyi3kjzbCSqBNOehFBqLK7
         QSaQ==
X-Gm-Message-State: APjAAAUNjRx2zGhxzczNNrdfkOhheW+HwxL3wH6vljDlyK/PnruWFr/t
        N6hl9TXw7bDCEnhediHgIgcd9w==
X-Google-Smtp-Source: APXvYqxHk8ImfMgeuCz4qZdecuDvrD1atRcG0wEn6Vmawjaxw05mIuV7g7Vq1J/k9hqyJlfnIDcRgw==
X-Received: by 2002:a62:5994:: with SMTP id k20mr16219177pfj.150.1557511318021;
        Fri, 10 May 2019 11:01:58 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s19sm7556740pfe.74.2019.05.10.11.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:01:57 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 5/5] firmware: google: coreboot: Drop unnecessary headers
Date:   Fri, 10 May 2019 11:01:51 -0700
Message-Id: <20190510180151.115254-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510180151.115254-1-swboyd@chromium.org>
References: <20190510180151.115254-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These headers aren't used by the files they're included in, so drop
them. The memconsole file uses memremap() though, so include io.h there
so that the include is explicit.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.h      | 1 -
 drivers/firmware/google/memconsole-coreboot.c | 1 +
 drivers/firmware/google/memconsole.c          | 1 -
 drivers/firmware/google/vpd_decode.c          | 2 --
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 054fa9374c59..d33c139447f6 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -21,7 +21,6 @@
 #define __COREBOOT_TABLE_H
 
 #include <linux/device.h>
-#include <linux/io.h>
 
 /* Coreboot table header structure */
 struct coreboot_table_header {
diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
index ab0fe93b88ad..f8a66354e5a4 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
index 968135025e4f..c8156db0e3a0 100644
--- a/drivers/firmware/google/memconsole.c
+++ b/drivers/firmware/google/memconsole.c
@@ -15,7 +15,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/init.h>
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
 #include <linux/module.h>
diff --git a/drivers/firmware/google/vpd_decode.c b/drivers/firmware/google/vpd_decode.c
index 943acaa8aa76..f8c9143472df 100644
--- a/drivers/firmware/google/vpd_decode.c
+++ b/drivers/firmware/google/vpd_decode.c
@@ -15,8 +15,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/export.h>
-
 #include "vpd_decode.h"
 
 static int vpd_decode_len(const s32 max_len, const u8 *in,
-- 
Sent by a computer through tubes

