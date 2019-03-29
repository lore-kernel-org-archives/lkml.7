Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C287C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB38B218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3Yq2t6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfC2ANR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37667 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfC2ANP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so302579pgq.4;
        Thu, 28 Mar 2019 17:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqFe0dSNshc67H87gxKMpnP9YE8KUP85ZOunbUXIUlE=;
        b=s3Yq2t6qwg2v8SM/CBIguWagibZew0zY0UWRVJMyGvKkJDJGITPdT8YbsATytx7inD
         bpQwOowHNeWAisNedf0tLN1LgJT9kbW0Qk989zcHjnqF3yI20uUQDhHBaimpcH5CiSDU
         TtxBnA0hgPjUjDxA3ZSVBqpXmZ8mru0fgj8XzGzlACsCioSB+dKWyrpeqUazgqXCxOi8
         YoJKpG/dV8J918Shkc+yELostYqMmpbzUu74d6Mue2pZLzCCAnY7Wsuxld8VqFXx3RRF
         d96Udz4iOIkcSNwTlnAeNSNfM4PGNpNGU3xWdICQOhf8wzxQ2fh4cdOHhKBi+JWUHfgF
         nOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqFe0dSNshc67H87gxKMpnP9YE8KUP85ZOunbUXIUlE=;
        b=OCFm47vdLeW1C29EKVWn9Fwbm70uNusqji3Ldoh3TfdKljaF1bDNrI85ykDp702KbR
         vOYqvgWHHBebtEBw8qm1bmr9Ay9xKVdkzdS/mu8shHjw4bcNcHoVDm1addoqDNieyC7R
         3gHtmkfLr3/bZRMRuJtYG5lu+6ZsiLaS7R48AKpqMYxJztriKD6OLPob8mXmblO61GD+
         qkQvq/s31l5JCKnEFlVc2CNcfXqlw/4a8a70Sf3qEoqgCTuXM9apLkUDKKtcOchfOhv4
         Ujj2c6NPwJzrN76tWSCTzRFdKbHb0r3gGHNFrSYemH6ZqvX3zI4K45vzJU7d4g1QtWZ6
         ZgEw==
X-Gm-Message-State: APjAAAX9roa++d5ShTLaz6doSBer+W5g1Rb3OA3gHS98gjbHmBQ2mgV+
        tBxVpqzTLgC98dKCsNelhA8=
X-Google-Smtp-Source: APXvYqwlgBjVOXn5mpt9LYH2dwq42QjLELSyDpTGcr6wdQiTZX2jLbtcCsbtHSSW6v0TItWDd7qitg==
X-Received: by 2002:a63:360e:: with SMTP id d14mr29620926pga.188.1553818393931;
        Thu, 28 Mar 2019 17:13:13 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:12 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 14/24] acpi doc: convert acpi/dsd/graph.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:25 +0800
Message-Id: <20190329001135.15847-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 .../acpi/dsd/{graph.txt => graph.rst}         | 157 +++++++++---------
 Documentation/acpi/index.rst                  |   1 +
 2 files changed, 81 insertions(+), 77 deletions(-)
 rename Documentation/acpi/dsd/{graph.txt => graph.rst} (56%)

diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/acpi/dsd/graph.rst
similarity index 56%
rename from Documentation/acpi/dsd/graph.txt
rename to Documentation/acpi/dsd/graph.rst
index b9ce910781dc..e0baed35b037 100644
--- a/Documentation/acpi/dsd/graph.txt
+++ b/Documentation/acpi/dsd/graph.rst
@@ -1,8 +1,11 @@
-Graphs
+.. SPDX-License-Identifier: GPL-2.0
 
+======
+Graphs
+======
 
 _DSD
-----
+====
 
 _DSD (Device Specific Data) [7] is a predefined ACPI device
 configuration object that can be used to convey information on
@@ -30,7 +33,7 @@ hierarchical data extension array on each depth.
 
 
 Ports and endpoints
--------------------
+===================
 
 The port and endpoint concepts are very similar to those in Devicetree
 [3]. A port represents an interface in a device, and an endpoint
@@ -38,9 +41,9 @@ represents a connection to that interface.
 
 All port nodes are located under the device's "_DSD" node in the hierarchical
 data extension tree. The data extension related to each port node must begin
-with "port" and must be followed by the "@" character and the number of the port
-as its key. The target object it refers to should be called "PRTX", where "X" is
-the number of the port. An example of such a package would be:
+with "port" and must be followed by the "@" character and the number of the
+port as its key. The target object it refers to should be called "PRTX", where
+"X" is the number of the port. An example of such a package would be::
 
     Package() { "port@4", PRT4 }
 
@@ -49,7 +52,7 @@ data extension key of the endpoint nodes must begin with
 "endpoint" and must be followed by the "@" character and the number of the
 endpoint. The object it refers to should be called "EPXY", where "X" is the
 number of the port and "Y" is the number of the endpoint. An example of such a
-package would be:
+package would be::
 
     Package() { "endpoint@0", EP40 }
 
@@ -62,85 +65,85 @@ of that port shall be zero. Similarly, if a port may only have a single
 endpoint, the number of that endpoint shall be zero.
 
 The endpoint reference uses property extension with "remote-endpoint" property
-name followed by a reference in the same package. Such references consist of the
+name followed by a reference in the same package. Such references consist of
 the remote device reference, the first package entry of the port data extension
 reference under the device and finally the first package entry of the endpoint
-data extension reference under the port. Individual references thus appear as:
+data extension reference under the port. Individual references thus appear as::
 
     Package() { device, "port@X", "endpoint@Y" }
 
-In the above example, "X" is the number of the port and "Y" is the number of the
-endpoint.
+In the above example, "X" is the number of the port and "Y" is the number of
+the endpoint.
 
 The references to endpoints must be always done both ways, to the
 remote endpoint and back from the referred remote endpoint node.
 
-A simple example of this is show below:
+A simple example of this is show below::
 
     Scope (\_SB.PCI0.I2C2)
     {
-	Device (CAM0)
-	{
-	    Name (_DSD, Package () {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "compatible", Package () { "nokia,smia" } },
-		},
-		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-		Package () {
-		    Package () { "port@0", PRT0 },
-		}
-	    })
-	    Name (PRT0, Package() {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "reg", 0 },
-		},
-		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-		Package () {
-		    Package () { "endpoint@0", EP00 },
-		}
-	    })
-	    Name (EP00, Package() {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "reg", 0 },
-		    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4", "endpoint@0" } },
-		}
-	    })
-	}
+        Device (CAM0)
+        {
+            Name (_DSD, Package () {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "compatible", Package () { "nokia,smia" } },
+                },
+                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+                Package () {
+                    Package () { "port@0", PRT0 },
+                }
+            })
+            Name (PRT0, Package() {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "reg", 0 },
+                },
+                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+                Package () {
+                    Package () { "endpoint@0", EP00 },
+                }
+            })
+            Name (EP00, Package() {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "reg", 0 },
+                    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4", "endpoint@0" } },
+                }
+            })
+        }
     }
 
     Scope (\_SB.PCI0)
     {
-	Device (ISP)
-	{
-	    Name (_DSD, Package () {
-		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-		Package () {
-		    Package () { "port@4", PRT4 },
-		}
-	    })
-
-	    Name (PRT4, Package() {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "reg", 4 }, /* CSI-2 port number */
-		},
-		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
-		Package () {
-		    Package () { "endpoint@0", EP40 },
-		}
-	    })
-
-	    Name (EP40, Package() {
-		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
-		Package () {
-		    Package () { "reg", 0 },
-		    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, "port@0", "endpoint@0" } },
-		}
-	    })
-	}
+        Device (ISP)
+        {
+            Name (_DSD, Package () {
+                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+                Package () {
+                    Package () { "port@4", PRT4 },
+                }
+            })
+
+            Name (PRT4, Package() {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "reg", 4 }, /* CSI-2 port number */
+                },
+                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+                Package () {
+                    Package () { "endpoint@0", EP40 },
+                }
+            })
+
+            Name (EP40, Package() {
+                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+                Package () {
+                    Package () { "reg", 0 },
+                    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, "port@0", "endpoint@0" } },
+                }
+            })
+        }
     }
 
 Here, the port 0 of the "CAM0" device is connected to the port 4 of
@@ -148,27 +151,27 @@ the "ISP" device and vice versa.
 
 
 References
-----------
+==========
 
 [1] _DSD (Device Specific Data) Implementation Guide.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm,
     referenced 2016-10-03.
 
-[2] Devicetree. <URL:http://www.devicetree.org>, referenced 2016-10-03.
+[2] Devicetree. http://www.devicetree.org, referenced 2016-10-03.
 
 [3] Documentation/devicetree/bindings/graph.txt
 
 [4] Device Properties UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
     referenced 2016-10-04.
 
 [5] Hierarchical Data Extension UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
     referenced 2016-10-04.
 
 [6] Advanced Configuration and Power Interface Specification.
-    <URL:http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf>,
+    http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf,
     referenced 2016-10-04.
 
 [7] _DSD Device Properties Usage Rules.
-    Documentation/acpi/DSD-properties-rules.txt
+    :doc:`../DSD-properties-rules`
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 909f12833692..40a628b2be21 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -9,6 +9,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
 
    linuxized-acpica
    namespace
+   dsd/graph
    enumeration
    osi
    DSD-properties-rules
-- 
2.20.1

