Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6AAC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E58206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXBpAtwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfDYPcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:32:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46547 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbfDYPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:32:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id j11so72875pff.13;
        Thu, 25 Apr 2019 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyEwlX82c6Bq2y5y3PF+BOLHdI7/R7pprHZNYOVIDmE=;
        b=ZXBpAtwbbbojc7JxUhsbCf3bMqrAJug3Vl1FxI+U8Lidue3J9RNX+CCaDfjaxmJK5M
         Sg0WMoLR2AvBx/ZlqsNZ7DQrNTyAl+OBrBh+Vz4CtsJjdvlZi92cOBo98OXq78nzxGaw
         tDsT0yEPyQcOP2Uy6Fy1aMGc9vuVKTbGEIa47KW18cdJ0oYAseRpMg6POweWofg3Fqtu
         YeGPwRflm2kL4c2wIfrr9IB1/s7IK4tyUSdkK0HUV7F2nw6Uu48BdJLJfeuOTTt4cYjm
         36bnYMTxIrqdeVDMnR+UKzSbJNttXwoyn8PqIa/Ntv5rHTNyTzyqx1JjMxHdD8DnoICs
         Izhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyEwlX82c6Bq2y5y3PF+BOLHdI7/R7pprHZNYOVIDmE=;
        b=MCoquvJwidv8Df/rjQfAzamyPnKO3Ek6C+6/sCNb3jBV5ul/nNhdvhlJjB3s/EUi7H
         3+CBVSv+p/f9DAcmkF6amQ2p4Z95O/3O2Y1UwB2PRKU0KNUeP48BwURXFn+WEDWAcbMv
         71D6EYCaaovsy+ZjkVFwpFEOX8xmhNDv5yJArgxJZUv0t6DdG+8sHan9+quG/TYr2AIK
         oOeMU6fAcA2mkC8NWEcgld62Kx4jey+f9p+qZDcDsrxZaZwSpilJycWhB70nPPPobM/F
         ejEmzwR97LwXk0HDF3jjIFYx+X5i6t2cKiGXwowsyGMaKS6TwDAM90Bz+WOcEQalPo7z
         oIGA==
X-Gm-Message-State: APjAAAUgpCPvGWjNR5jooCk/+i7hB4+E398YECtE1swWd+y6nxyoxgD8
        F4T/Na53XfFXubBfn7Lrxfw=
X-Google-Smtp-Source: APXvYqzBwVFTuK1bQGBeqX5wlDE1yU17f/KuEgz4bEwbfPgIlaGhp+8dXp0z/5brq6RQhcdg5i+xpg==
X-Received: by 2002:a63:6e09:: with SMTP id j9mr38174965pgc.416.1556206365276;
        Thu, 25 Apr 2019 08:32:45 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:32:44 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 12/24] Documentation: ACPI: move i2c-muxes.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:05 +0800
Message-Id: <20190425153117.16057-13-changbin.du@gmail.com>
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
 Documentation/acpi/i2c-muxes.txt              | 58 ------------------
 .../firmware-guide/acpi/i2c-muxes.rst         | 61 +++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |  3 +-
 3 files changed, 63 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst

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
diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
new file mode 100644
index 000000000000..3a8997ccd7c4
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
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
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index d1d069b26bbc..1c89888f6ee8 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -12,4 +12,5 @@ ACPI Support
    osi
    method-customizing
    DSD-properties-rules
-   gpio-properties
\ No newline at end of file
+   gpio-properties
+   i2c-muxes
-- 
2.20.1

