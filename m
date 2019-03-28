Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7FD20693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTPSFmrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfC1Q3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42102 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Q3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so5213673plb.9;
        Thu, 28 Mar 2019 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/WU7k/aJWgwoXYp66T9noVQ1MhB2daWNprUl9GsYJc=;
        b=MTPSFmrWXg+EusLlPYuWk1PUImZb+tmGxZgHUlHq/mXV1ZjLA7V+kHLnMachNgSdmx
         xABPZXqUApcPxGExXIHTbm7KVcgQfn0bA9e+4rRJVidbPtgw7Fen+uADJRLIJ4W+6Yf7
         G56tIOyVUWhUd5SLvxvmaTMKrONLPrf36PLggtnNlCGrLeGpfNVA5aL9jdq8iOEVAgcE
         Uc63vGlvh7K6yS5aLSd44FksxOFaemMzjFGY5QbLtBzUIWLp4kY4qgsFxSAmNcT4/W+W
         8UFc6ctfDSBI3p606tOeZxqHZi8VPEPC2APvIW4YCCv6Bj00NKxMR0SZUliQbNTJ1wNa
         CWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/WU7k/aJWgwoXYp66T9noVQ1MhB2daWNprUl9GsYJc=;
        b=Npr3audp5+l4oNTpRsYw+N8MkGYqld8x8Tta/ZcIwJJGTY8skmQYtvQ2TCMCZ2QgK/
         nPt534qXtgEalesYThNsSA8zFaxChTOT6bzwWevHLqT1BsfbReHx+hRGTmjJ2QK/OsT/
         PxFh4VjKJIuHAb+ZL8z3qJ/ygawugOzEbzUJ82wQjkWrWFWU7LObu04xdF8Egs5LXmyU
         w5Gawqa6NnbIeIJneCBRMeFdq8eV6uBAGkvvVPWyDlX5XCxexWY/BRpGD37TC4wVkC53
         tFrz7slb9SmB0LzoEmiF2YHpzKSK8gzPQTS1zDFmnTGrNRTgKWY5lwIhqd9ZRnlUztp4
         kWjw==
X-Gm-Message-State: APjAAAXJFJOkQfQkbaJiIS7fDT86+PoYqGi70oqbUAw1y9DBhwiqdCvU
        OkLoDJxh1DmcBgut7kuudv4=
X-Google-Smtp-Source: APXvYqypCimPzvrt4NVNqYgN0L87rVxJJaEBPzczzas/Ph93BW6VX7g6r7kvPc8iqDR8iMeo8MNY+g==
X-Received: by 2002:a17:902:b484:: with SMTP id y4mr36520337plr.88.1553790583053;
        Thu, 28 Mar 2019 09:29:43 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:42 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 14/23] acpi doc: convert acpi/dsd/graph.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:12 +0800
Message-Id: <20190328162721.26138-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
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
 .../acpi/dsd/{graph.txt => graph.rst}         | 155 +++++++++---------
 Documentation/acpi/index.rst                  |   1 +
 2 files changed, 79 insertions(+), 77 deletions(-)
 rename Documentation/acpi/dsd/{graph.txt => graph.rst} (56%)

diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/acpi/dsd/graph.rst
similarity index 56%
rename from Documentation/acpi/dsd/graph.txt
rename to Documentation/acpi/dsd/graph.rst
index b9ce910781dc..98a7a0cdf43e 100644
--- a/Documentation/acpi/dsd/graph.txt
+++ b/Documentation/acpi/dsd/graph.rst
@@ -1,8 +1,9 @@
+======
 Graphs
-
+======
 
 _DSD
-----
+====
 
 _DSD (Device Specific Data) [7] is a predefined ACPI device
 configuration object that can be used to convey information on
@@ -30,7 +31,7 @@ hierarchical data extension array on each depth.
 
 
 Ports and endpoints
--------------------
+===================
 
 The port and endpoint concepts are very similar to those in Devicetree
 [3]. A port represents an interface in a device, and an endpoint
@@ -38,9 +39,9 @@ represents a connection to that interface.
 
 All port nodes are located under the device's "_DSD" node in the hierarchical
 data extension tree. The data extension related to each port node must begin
-with "port" and must be followed by the "@" character and the number of the port
-as its key. The target object it refers to should be called "PRTX", where "X" is
-the number of the port. An example of such a package would be:
+with "port" and must be followed by the "@" character and the number of the
+port as its key. The target object it refers to should be called "PRTX", where
+"X" is the number of the port. An example of such a package would be::
 
     Package() { "port@4", PRT4 }
 
@@ -49,7 +50,7 @@ data extension key of the endpoint nodes must begin with
 "endpoint" and must be followed by the "@" character and the number of the
 endpoint. The object it refers to should be called "EPXY", where "X" is the
 number of the port and "Y" is the number of the endpoint. An example of such a
-package would be:
+package would be::
 
     Package() { "endpoint@0", EP40 }
 
@@ -62,85 +63,85 @@ of that port shall be zero. Similarly, if a port may only have a single
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
@@ -148,27 +149,27 @@ the "ISP" device and vice versa.
 
 
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
index a5251782e781..e10ce874269c 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -7,6 +7,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
 
    linuxized-acpica
    namespace
+   dsd/graph
    enumeration
    osi
    DSD-properties-rules
-- 
2.20.1

