Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6752075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irSqipFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfC2AMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:12:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35871 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfC2AMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:12:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id p10so153344pff.3;
        Thu, 28 Mar 2019 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kr8m+1yEmfW/Tftm4Dz5M/23l76k0vsOwLCsbSKiNHk=;
        b=irSqipFN4/81K2Vj6aAaGoJ2+f0J9uIKMyxJ1GtpsBVSsxRysdNOGEEP8gCtXfka1T
         XTpMK2T4jh0s8zsNYeNDrpIGlkzFaCrFMVxsbbA0DxOcttvM7sBdgxuAzqPY+yodfQoN
         5hV39uqxQT+HCnFSBVmRfrV9pDO024U8QRvsjFGXM/Vr/ueu4hnoeM9YV+CkFx6Djtsq
         vS5VfwzGznAY1wTXqnhwLm1cMko5HIxwHAviMyF85G7n5iOBdnoS/KBoL83BlHej5UYZ
         D7pSGvoWiMuceyv0SHGoq85He8lCYuSR56R25YEYeIW2UkR/FA7J6d943A/eHuboe7ZC
         epdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kr8m+1yEmfW/Tftm4Dz5M/23l76k0vsOwLCsbSKiNHk=;
        b=GT8LEjUzGrCnmafouxb5zCCmxcpyhscW3ZOmYFMWkb7eSWXNafvgjl1/1106R8osiM
         /7McP01u8O9gLytE9DIHQhMZ0Rg4Tj9ltRRThhc+Dtwwv4TpV9+DKq62wbKgQTpGV8Wy
         eFGGX4BECm2mb0YbRjDJLIctjy5foxoG87uKyRKXBRt5SW3iq7gCkGAm3rXd40b01jTH
         wRStFOylOsBgr1ElOYzsa++o+WPrkApdKZfSbrzp/F45f49a7khyBt+8UMtP53DEDRYX
         tcnTaoCODIye2VUzEdQzlLT0XLXEGk7Bi0YA8LBknERyk3iUtnM78IiGUVg4Hn5I3FJd
         aO4A==
X-Gm-Message-State: APjAAAX/2qMDJOk7BhD2OlNvmfQSVs4VZ7PtYtx6R25YKgI3vQpVFxfX
        UiFEFLi/1chgqeeKijV1GpU=
X-Google-Smtp-Source: APXvYqyrJhwU63Hvi0eppqX96JbIOdQaP3OTsHbu+5paTSM+N8sPWUljAuIfaOKUg3P5vwTLa4eyLw==
X-Received: by 2002:a63:fd12:: with SMTP id d18mr41945698pgh.88.1553818356059;
        Thu, 28 Mar 2019 17:12:36 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:12:35 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 06/24] acpi doc: convert acpi/scan_handlers.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:17 +0800
Message-Id: <20190329001135.15847-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/index.rst                  |  1 +
 .../{scan_handlers.txt => scan_handlers.rst}  | 24 ++++++++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)
 rename Documentation/acpi/{scan_handlers.txt => scan_handlers.rst} (90%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 3747a0286442..741fcae251b4 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -11,3 +11,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    namespace
    enumeration
    osi
+   scan_handlers
diff --git a/Documentation/acpi/scan_handlers.txt b/Documentation/acpi/scan_handlers.rst
similarity index 90%
rename from Documentation/acpi/scan_handlers.txt
rename to Documentation/acpi/scan_handlers.rst
index 3246ccf15992..7a197b3a33fc 100644
--- a/Documentation/acpi/scan_handlers.txt
+++ b/Documentation/acpi/scan_handlers.rst
@@ -1,7 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+==================
 ACPI Scan Handlers
+==================
+
+:Copyright: |copy| 2012, Intel Corporation
 
-Copyright (C) 2012, Intel Corporation
-Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 During system initialization and ACPI-based device hot-add, the ACPI namespace
 is scanned in search of device objects that generally represent various pieces
@@ -30,14 +36,14 @@ to configure that link so that the kernel can use it.
 Those additional configuration tasks usually depend on the type of the hardware
 component represented by the given device node which can be determined on the
 basis of the device node's hardware ID (HID).  They are performed by objects
-called ACPI scan handlers represented by the following structure:
+called ACPI scan handlers represented by the following structure::
 
-struct acpi_scan_handler {
-	const struct acpi_device_id *ids;
-	struct list_head list_node;
-	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
-	void (*detach)(struct acpi_device *dev);
-};
+	struct acpi_scan_handler {
+		const struct acpi_device_id *ids;
+		struct list_head list_node;
+		int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
+		void (*detach)(struct acpi_device *dev);
+	};
 
 where ids is the list of IDs of device nodes the given handler is supposed to
 take care of, list_node is the hook to the global list of ACPI scan handlers
-- 
2.20.1

