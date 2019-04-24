Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE66C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B56B218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOPC6WeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391317AbfDXRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:54:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41633 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732760AbfDXRym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:54:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so9732173pgs.8;
        Wed, 24 Apr 2019 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydaAtanhe5luQq8qrhQiH95JS2NmsbhYg1m6ekwdf5o=;
        b=DOPC6WePyDfiQFha+zKO5o+FOeMD/TCz2ilkgaszT9QxFxzHkPXqU+ysuZjF2DzKKz
         bXfUJNG2cv9F9aypKjHJYYI2mcE++es2+WYHYmsinNbBqLREuaMomJTjwYYBEbDnFQHm
         ZSDq/o/tDKj1uqPksrKkSczmfCVhEzMlO+9td038rnQqnvoou6uM0XLs1f737LDUgthQ
         +UvUq3U7xDnvVblEuJB23/MJd3aJ5b4CJbX2mQuPyNbu//IeU5O/06aQ2P1M7/94XRKc
         Lp9Pxk045FYnsKdkOuVjXdznmu/c7Woa11Nvr4V1Ae1+F+xy3FvaQP3cO1RZIpa2Gvvt
         6/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydaAtanhe5luQq8qrhQiH95JS2NmsbhYg1m6ekwdf5o=;
        b=uBJIFjj9LYoqYGPMUGLclHLk8nK9kn8HC+Ip4wZF2zrM5uzFjY3c6pGxDsyq9sYamf
         PlLefxHmiWoBK41l5PUgVVYz7pKMadyaRqPAsc/RSqd+4erKeTIhqp4l0qE+5SbHraXe
         6wZVvw4jo2JjTV6F/Iy1GO3cFEjgT3HPXQ75jwIRGEx6RIFSujmC9at1N+874RWXT89M
         Xlw0WnMrUkPw5R0cYFNE+2IFuZ0l3QbtT/TxB1XaSsb6zU4g1v6ikYh3naOVQQMqvd+j
         GEQ8Zn4Af1mbL72/5wT9LBkawZEt1+8SDwQbngnkX785z9meu73cZI3KtyHPsPommgbJ
         yKhQ==
X-Gm-Message-State: APjAAAV4zKJCa54YXRnZBpobj32bLFLMkzEPRp6POPdEilw9ZEbrNlas
        E0q2sWz/MfkuukvrPeP+pms=
X-Google-Smtp-Source: APXvYqz1g+tX9rFRlxdxbz24XMsVj1JfXx/pOiSA507bfSWCdAYAkVJlqMKo98zT/xWRme7+45UtGQ==
X-Received: by 2002:a63:c944:: with SMTP id y4mr32499788pgg.257.1556128481720;
        Wed, 24 Apr 2019 10:54:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:54:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 05/23] Documentation: ACPI: move scan_handlers.txt to driver-api/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:52:48 +0800
Message-Id: <20190424175306.25880-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
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

