Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D8BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1271A204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7ZgGOiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfC1Q3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46331 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfC1Q3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so5209316pll.13;
        Thu, 28 Mar 2019 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EBfVh4dIqr6krOEwfARE5WciKGBQOpypkYS1V2yQEw=;
        b=V7ZgGOivcQO8L7H2RhOS9AEUnjpq18oSQLre/YjtT1a3hJTwIsyTZLF9Eet5MY1jIF
         goLy7bdXJ6AnJh+F8OIAH7lHa9+bfkAJznpV8ye1WznxzadTw6QJlWU2BoUbIQPnOxLK
         Mc9DkLTu9p6Q/+PhNfGrd75i/U6F84tIF0Rmo95bhFdvXBtE4oZ+wSLwrPoFVC1nIq0g
         2UDnvIqQvLqX4c9C0swmIE39Tj1qmHSvGcbBVVEHcM0J1NK7DEz2bVNcxHuqFgkHKINI
         OpWb3Yby0awlz61CzOYcvrSPY1J5AnVEGhYF20iTtBtkOznp+7pfHYDdPlREwRBpWgq6
         q1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EBfVh4dIqr6krOEwfARE5WciKGBQOpypkYS1V2yQEw=;
        b=sQ31Hj1H04n6o4lZIs1S/T3jXqe3FZgG8rAhQSt6oxLyli7E7UfPaXgGwXp4fNDSyd
         dqh7ociKSWpE79EFhrw2up5I+LT3ElxGLvJIDNXZGioN09nyZRddoTmMK3aeJOMiRlnz
         VHTVZgKjsl2A60spgDTnal6NPfmrVr+ShXgxbqhyysPbQhmvRAXLyiAqxxDUjCx4TFdJ
         57lTHRAwLoaeZQGEIxK8KOuNFVi6fKH1M3RoDXIbQQy6/io6Vzr7X5u3zNzEHKyNAjI3
         qgJkVNzYJZ5r+RchuVpk1y+n8jC1MfvRT/LXBtJQvxg3Q+snjNsFEZYMhEoOuV7cTeZI
         xMwA==
X-Gm-Message-State: APjAAAUZdrTCTiM5s8BDxNXI8p1AjXvcsuPS4AuuuJhfLYhHlYZ7MQb2
        mnQnUrRv0+FHoNK/tI9h918=
X-Google-Smtp-Source: APXvYqzQecqnOSz9QVrS+yqAtGaQ5x3xAwQ+pAgEeUbmbmC+y0uiG0UGbaRCbwdSa6iag3Vbbi6Raw==
X-Received: by 2002:a17:902:bb0d:: with SMTP id l13mr8753165pls.141.1553790541777;
        Thu, 28 Mar 2019 09:29:01 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 06/23] acpi doc: convert acpi/scan_handlers.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:04 +0800
Message-Id: <20190328162721.26138-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
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
 .../{scan_handlers.txt => scan_handlers.rst}  | 23 +++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)
 rename Documentation/acpi/{scan_handlers.txt => scan_handlers.rst} (91%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 0ba63d0ec9c7..dac49d27e841 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -9,3 +9,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    namespace
    enumeration
    osi
+   scan_handlers
diff --git a/Documentation/acpi/scan_handlers.txt b/Documentation/acpi/scan_handlers.rst
similarity index 91%
rename from Documentation/acpi/scan_handlers.txt
rename to Documentation/acpi/scan_handlers.rst
index 3246ccf15992..6036127a9571 100644
--- a/Documentation/acpi/scan_handlers.txt
+++ b/Documentation/acpi/scan_handlers.rst
@@ -1,7 +1,12 @@
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
@@ -30,14 +35,14 @@ to configure that link so that the kernel can use it.
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

