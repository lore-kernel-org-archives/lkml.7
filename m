Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBEBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7346020693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRpGrz2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfC1Q3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44390 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Q3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so11839319pgj.11;
        Thu, 28 Mar 2019 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGgzvXKiiC8UYoKz0m9qdhOaT31jPzGO4hH0Wma5Dvs=;
        b=lRpGrz2qbZOgTsTSjuvv6Du/uNbnb7W47c89Sgu8ChFeDbxnDdLk0yGRUJzUHLfJYB
         lyJQmLURB8y23O5TRyrEVdcDEc9GFm4SFFn5+O/E1jpms//3NtRrNyoWpJJ5Td9drYS5
         iS+i1DeKJpckj0onlehDInJ2x4bJW0mkDbQODUauHPumX8ZJ2J8LVdbWjsvzcwWIw814
         KFJfq9Xzj3LX34NjOJWJrYXV/Zx9EQUL0G5rNFK0yD7Wj08vz9sEloJ6jJIhcwNmGbT2
         Zo0GUFNchsUPnZdFiJLZjwt8MJQT6O8EP3fAbuTJmONep0kMZ73CMSwT0376LBBignKt
         f05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGgzvXKiiC8UYoKz0m9qdhOaT31jPzGO4hH0Wma5Dvs=;
        b=qWQtzhZ6F/NQnbkjuogp5/EyqiaieEqtyN7OfL/U0qdgPNXQuBOS+qP3UvzyEJseFX
         Dc2gco/sMAL2IXzD5Kl4QPPNpbksKbVu0RcyE4asYadJ5bix1TrWXDbpT4IRZ2cYPvPE
         5TfmB6S7/M9eQgPUYD4DzFsMMGSaLXeaAbl+eNVwQGsIPEKPpsb5rNeocoNwwfRmgmMm
         S4SjknRvzSOB+gYxEyAyChIlbIO7r1PTmswYr1QHs2smNC8kadRlOmfOI9U8kqC24eu8
         2WJZ6//O8vXA8zbOfb4bE1HTl0ZLyU8x8LaE1iD4d3na33kyq8H704yNLqsF9x5FYxid
         4a/w==
X-Gm-Message-State: APjAAAUGSh8EtvMJHQ8TKB0TcNd45cl3arlamgiHjVyqCNGPuVoZMyps
        c9tMfMLpQIjhj9BG5eBFleM=
X-Google-Smtp-Source: APXvYqwxyXmuyac8RENQp38kNZTU6GOq3jJdFIp7JyxM3EfBAYxwJcNXj9iKhAYvBCANlrpfR9aDKw==
X-Received: by 2002:a63:5854:: with SMTP id i20mr31434567pgm.171.1553790573105;
        Thu, 28 Mar 2019 09:29:33 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:32 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 12/23] acpi doc: convert acpi/i2c-muxes.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:10 +0800
Message-Id: <20190328162721.26138-13-changbin.du@gmail.com>
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
 Documentation/acpi/i2c-muxes.rst | 59 ++++++++++++++++++++++++++++++++
 Documentation/acpi/i2c-muxes.txt | 58 -------------------------------
 Documentation/acpi/index.rst     |  1 +
 3 files changed, 60 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.rst
 delete mode 100644 Documentation/acpi/i2c-muxes.txt

diff --git a/Documentation/acpi/i2c-muxes.rst b/Documentation/acpi/i2c-muxes.rst
new file mode 100644
index 000000000000..656db288d69a
--- /dev/null
+++ b/Documentation/acpi/i2c-muxes.rst
@@ -0,0 +1,59 @@
+==============
+ACPI I2C Muxes
+==============
+
+Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
+Device () scope per mux channel.
+
+Consider this topology::
+
+    +------+   +------+
+    | SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
+    |      |   | 0x70 |--CH01--> i2c client B (0x50)
+    +------+   +------+
+
+which corresponds to the following ASL::
+
+    Device (SMB1)
+    {
+        Name (_HID, ...)
+        Device (MUX0)
+        {
+            Name (_HID, ...)
+            Name (_CRS, ResourceTemplate () {
+                I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
+                            AddressingMode7Bit, "^SMB1", 0x00,
+                            ResourceConsumer,,)
+            }
+
+            Device (CH00)
+            {
+                Name (_ADR, 0)
+
+                Device (CLIA)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH00", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+
+            Device (CH01)
+            {
+                Name (_ADR, 1)
+
+                Device (CLIB)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH01", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+        }
+    }
diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
deleted file mode 100644
index 9fcc4f0b885e..000000000000
--- a/Documentation/acpi/i2c-muxes.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-ACPI I2C Muxes
---------------
-
-Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
-Device () scope per mux channel.
-
-Consider this topology:
-
-+------+   +------+
-| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
-|      |   | 0x70 |--CH01--> i2c client B (0x50)
-+------+   +------+
-
-which corresponds to the following ASL:
-
-Device (SMB1)
-{
-    Name (_HID, ...)
-    Device (MUX0)
-    {
-        Name (_HID, ...)
-        Name (_CRS, ResourceTemplate () {
-            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
-                          AddressingMode7Bit, "^SMB1", 0x00,
-                          ResourceConsumer,,)
-        }
-
-        Device (CH00)
-        {
-            Name (_ADR, 0)
-
-            Device (CLIA)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH00", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-
-        Device (CH01)
-        {
-            Name (_ADR, 1)
-
-            Device (CLIB)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH01", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-    }
-}
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 7701d4df614e..9bf84570c91b 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -11,6 +11,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
    osi
    DSD-properties-rules
    gpio-properties
+   i2c-muxes
    scan_handlers
    method-customizing
    initrd_table_override
-- 
2.20.1

