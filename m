Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F9DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4A720685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTW9i5Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392211AbfDXRzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:55:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43030 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389157AbfDXRzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:55:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so9642462plp.10;
        Wed, 24 Apr 2019 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7X/TpVUy9MOoo+OOx4gvhRbEBFHOPzvaja1yF/wQgs=;
        b=WTW9i5VgWtI2OfLYQkSS9UPt9XqxYG6P1DhQTWbRz7blDTUUvxHgQdoaYlPCbMLC5d
         ivEtgQcm9F1lDlhxmHAaBeDTmKNlc7IU4FiEsuZdjaducRwm86e3hk0S3E7dpWAOjwFn
         +S7UV+y3eM3d30yYMi3ADrOAG979aRU7MfbVuw3FKMDMv2n/kE9g4fdiSv8Y0Nbz32ja
         OsKuQg3U090U80ZtZZABbb3bqq8WXAvA8Wc4XQgHrI4rRtIz7c9LPiv12+k+8K7ieZAw
         Pzcgra8BLK7NvxYxr3do9lrVKfR+vO8ZRcbk2MMi2QMLCv4vQRKz0nI6ZKY5rWr2/4v+
         TE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7X/TpVUy9MOoo+OOx4gvhRbEBFHOPzvaja1yF/wQgs=;
        b=kDkkVb3oV2RtxFHA/wudDTlycxrffmCllzBAViwbMEqtnL5+Ru05eRs6HSK7V94PGN
         YP1D4s5uymPr0YBCsXWA4FoaCRc/dybSGUTquV6PNyPSiZy8YvWu2ESkOPWgnUn87YEd
         VVb+toFHZRQHXkR4ZFg//37n7ZVg5RNGYNK9YAikgJQpVSlkKcTWmLipBqwsRz22727O
         kYgtfuX1MZ2ounllEi3bBFlowdyZ2OnMC2WIGExqXUPIMiUkB5xwaXwOhk9k2FmMOepq
         fBzbu/ple7XbuLHCJ0/m5hGVo5937BL+F1yxBHF0iuZ+/Qp1t0AZYIH7UcpVQre+NYfb
         ORag==
X-Gm-Message-State: APjAAAV6sa7tSqvIGEXwhN1vxCRaCindzokMuvKh6Ro/t89Xidi5DF5K
        x3SHTtkUVOIVXDCMty0zRWU=
X-Google-Smtp-Source: APXvYqzTEEjOuY3iZlYpBg/MSO92IWFem0Ato+mbCxPNrERh9adJIkWgrus6M64aBoyf321dn54YUw==
X-Received: by 2002:a17:902:4481:: with SMTP id l1mr14850672pld.75.1556128541686;
        Wed, 24 Apr 2019 10:55:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:55:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 13/23] Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:52:56 +0800
Message-Id: <20190424175306.25880-14-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
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
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../acpi/dsd/graph.rst}                       | 157 +++++++++---------
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 2 files changed, 81 insertions(+), 77 deletions(-)
 rename Documentation/{acpi/dsd/graph.txt => firmware-guide/acpi/dsd/graph.rst} (56%)

diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/firmware-guide/acpi/dsd/graph.rst
similarity index 56%
rename from Documentation/acpi/dsd/graph.txt
rename to Documentation/firmware-guide/acpi/dsd/graph.rst
index b9ce910781dc..e0baed35b037 100644
--- a/Documentation/acpi/dsd/graph.txt
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
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
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index bedcb0b242a2..f81cfbcb6878 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -8,6 +8,7 @@ ACPI Support
    :maxdepth: 1
 
    namespace
+   dsd/graph
    enumeration
    osi
    method-customizing
-- 
2.20.1

