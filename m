Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E341AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2015C20891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUL3wLbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfDYPcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:32:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39810 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbfDYPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:32:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so9486535plb.6;
        Thu, 25 Apr 2019 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydaAtanhe5luQq8qrhQiH95JS2NmsbhYg1m6ekwdf5o=;
        b=KUL3wLbTWkZ/awIyUBXXP9ac/jSSDNu3AYL9u+nQRWFMeHakhphPZ1wxSCkmAqOR8F
         5+Zu5d/LjV9ur73c0TTstD9iFQfbPRxljSjbx/ljhkL/Idm8ucEuEhk4I60ugxbpMI+3
         wGZ5Q/hvtHYcFLIBBPPrS7aD6xXffzHc2QSgdtU8D8MGLTPVX51s1F+aaHJ/j1Bb1SSw
         jsrcnbQYcZ6ByyQdwQPNc8crfWBKu/Bk8vvI8scVR6T3Tw0PP7mS2Jb1NjMHIKGXWL70
         Feoz6FjMeBFHgwqatHYMHvBkhs/KxDvgD/szIbBUVQ2FfhcM/fMQ0vdVWjyncKzg6SwP
         D90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydaAtanhe5luQq8qrhQiH95JS2NmsbhYg1m6ekwdf5o=;
        b=Hb+4/FcTI73p7AJLxCvaIRTNY3ivA3q0jSsAD6bh0DK44GlUMuuBskXNkoUd94z3vQ
         2OLHB3CwgJu55bDX022431Mt9TKybs9wg1L8xNyKaqH8fv5T15fgJVwshQi0gFQVQpwE
         KBYI53GK4PJaME3QVyLjMLik7ybvd5jtYRu241vz29GwhCgcDYxAcg2fEWyHO7LTy+OQ
         /lqOFO7ZELgTJr/VyH1CT+yG2pt8MMw64oBJWHxfXZ/yNXOVvzFD7LC2YqyLTOrzOMB2
         +Z1e6dYdM3H03vWEf3rQkUa57c2yWTYoXF83jBeDWPIRyLIP9gxHOLYxfImVv0Ik44/2
         9IVg==
X-Gm-Message-State: APjAAAVfGGz15vD9aaHtYH6q6qpzkKfG/DY6oDPWQMAR5IzSCN4GdXf2
        20K1BVXUFCUXTqOuIdVquus=
X-Google-Smtp-Source: APXvYqwm0yZSg35X3LIazXcrJL8hxnm+1neXBMlhHHKv6ctFLzmozDzwjXR32bGKzWRmKzMGEQlCUg==
X-Received: by 2002:a17:902:2c01:: with SMTP id m1mr41198162plb.22.1556206329043;
        Thu, 25 Apr 2019 08:32:09 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:32:08 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 06/24] Documentation: ACPI: move scan_handlers.txt to driver-api/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:30:59 +0800
Message-Id: <20190425153117.16057-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/acpi/index.rst       |  1 +
 .../acpi/scan_handlers.rst}                   | 24 ++++++++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)
 rename Documentation/{acpi/scan_handlers.txt => driver-api/acpi/scan_handlers.rst} (90%)

diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
index 12649947b19b..ace0008e54c2 100644
--- a/Documentation/driver-api/acpi/index.rst
+++ b/Documentation/driver-api/acpi/index.rst
@@ -6,3 +6,4 @@ ACPI Support
    :maxdepth: 2
 
    linuxized-acpica
+   scan_handlers
diff --git a/Documentation/acpi/scan_handlers.txt b/Documentation/driver-api/acpi/scan_handlers.rst
similarity index 90%
rename from Documentation/acpi/scan_handlers.txt
rename to Documentation/driver-api/acpi/scan_handlers.rst
index 3246ccf15992..7a197b3a33fc 100644
--- a/Documentation/acpi/scan_handlers.txt
+++ b/Documentation/driver-api/acpi/scan_handlers.rst
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

