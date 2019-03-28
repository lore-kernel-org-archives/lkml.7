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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE94C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5012184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIMkJlVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfC1Q3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43902 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Q3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id m10so5199582plt.10;
        Thu, 28 Mar 2019 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4YM6Vq3hQ0YOx+8XyLtYUK8xAgeK38BRqFsDIvpzruM=;
        b=TIMkJlVGsEST9knTJjR1MAghu9PgxAOALs5J337gXg/kGdM5586H8DrZ+CgJFFrVXe
         2b2mhH5Nt+i+oTwiMyX7m2lCLk3i+Sa6zMj7Q//QptShA4x0SU49LWRoNnO5b0rdMzJR
         owOCZG7X+K0IGk0C5USdFcyNf2hnrzy24ZG0xyCiTdGjkCXVCCbeqznyl7CxWmXlzVU0
         mFzkKfHpflkqfLNG7mikZUwtlHLXS6w/ZdU0Lu5oV0sUptSvJGY0sPDBOHrv7eWPC+/z
         VnLs5z+T3khN9nn2LT5UAtJRMfxWOJm6yy5uNPT2F52ZesSY5cbaP9q64I/+HPLGP+Qc
         ZKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4YM6Vq3hQ0YOx+8XyLtYUK8xAgeK38BRqFsDIvpzruM=;
        b=KaALZ5XXzJuJcg0Qri9bqgSt6gqV7RvaWePJ+rJ0M5QZwn057PkDJqqeSQB10P4CX0
         enC5Ejnf8G6Sy8HBFWBpBIBZhJFGpBfTstP54Axmh6gxN7MLzha5T62iHJXC8KDno5Cy
         jtPq6iRiFjqw0ljtqlalL2thuvFodq21u8ZfsfXEU22DgWFrhlraIY1oS0bcvPKuB8Ji
         fOzxi1XsATZWZW6C7gzgscjl/wJkKUjnIKWb9RjuA5oTGSWc0R3Nr0ZkiXg9wypdFZ/m
         vWt1gbDdt4SoffzP2+neIU+MM3YvycN6Izkfncke35H7FwUoWScNxTLXXx86pbYKGdPG
         rhSA==
X-Gm-Message-State: APjAAAUs2XI5UO/rGYOuFxgx5UUF5PNIE1aLHZ5ig1dOAFB/imOm5q9c
        xV4nzuNcv+lw03BchetkLGsFyo3YdI0=
X-Google-Smtp-Source: APXvYqzxfk3+FmPB4HKfmINz/Apk8daOmvQR+G3arIg3RzNMNEKVwcWVCBa3NEyFpu4UWLiEKHgJ3A==
X-Received: by 2002:a17:902:5c5:: with SMTP id f63mr40532241plf.64.1553790587712;
        Thu, 28 Mar 2019 09:29:47 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 15/23] acpi doc: convert acpi/debug.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:13 +0800
Message-Id: <20190328162721.26138-16-changbin.du@gmail.com>
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
 Documentation/acpi/{debug.txt => debug.rst}   | 31 ++++++++++---------
 ...eferences.txt => data-node-references.rst} | 27 +++++++++-------
 Documentation/acpi/index.rst                  |  2 ++
 3 files changed, 33 insertions(+), 27 deletions(-)
 rename Documentation/acpi/{debug.txt => debug.rst} (91%)
 rename Documentation/acpi/dsd/{data-node-references.txt => data-node-references.rst} (80%)

diff --git a/Documentation/acpi/debug.txt b/Documentation/acpi/debug.rst
similarity index 91%
rename from Documentation/acpi/debug.txt
rename to Documentation/acpi/debug.rst
index 65bf47c46b6d..c9aa32b3a80b 100644
--- a/Documentation/acpi/debug.txt
+++ b/Documentation/acpi/debug.rst
@@ -1,18 +1,19 @@
-			ACPI Debug Output
-
+=================
+ACPI Debug Output
+=================
 
 The ACPI CA, the Linux ACPI core, and some ACPI drivers can generate debug
 output.  This document describes how to use this facility.
 
 Compile-time configuration
---------------------------
+==========================
 
 ACPI debug output is globally enabled by CONFIG_ACPI_DEBUG.  If this config
 option is turned off, the debug messages are not even built into the
 kernel.
 
 Boot- and run-time configuration
---------------------------------
+================================
 
 When CONFIG_ACPI_DEBUG=y, you can select the component and level of messages
 you're interested in.  At boot-time, use the acpi.debug_layer and
@@ -21,7 +22,7 @@ debug_layer and debug_level files in /sys/module/acpi/parameters/ to control
 the debug messages.
 
 debug_layer (component)
------------------------
+=======================
 
 The "debug_layer" is a mask that selects components of interest, e.g., a
 specific driver or part of the ACPI interpreter.  To build the debug_layer
@@ -33,7 +34,7 @@ to /sys/module/acpi/parameters/debug_layer.
 
 The possible components are defined in include/acpi/acoutput.h and
 include/acpi/acpi_drivers.h.  Reading /sys/module/acpi/parameters/debug_layer
-shows the supported mask values, currently these:
+shows the supported mask values, currently these::
 
     ACPI_UTILITIES                  0x00000001
     ACPI_HARDWARE                   0x00000002
@@ -65,7 +66,7 @@ shows the supported mask values, currently these:
     ACPI_PROCESSOR_COMPONENT        0x20000000
 
 debug_level
------------
+===========
 
 The "debug_level" is a mask that selects different types of messages, e.g.,
 those related to initialization, method execution, informational messages, etc.
@@ -81,7 +82,7 @@ to /sys/module/acpi/parameters/debug_level.
 
 The possible levels are defined in include/acpi/acoutput.h.  Reading
 /sys/module/acpi/parameters/debug_level shows the supported mask values,
-currently these:
+currently these::
 
     ACPI_LV_INIT                    0x00000001
     ACPI_LV_DEBUG_OBJECT            0x00000002
@@ -113,9 +114,9 @@ currently these:
     ACPI_LV_EVENTS                  0x80000000
 
 Examples
---------
+========
 
-For example, drivers/acpi/bus.c contains this:
+For example, drivers/acpi/bus.c contains this::
 
     #define _COMPONENT              ACPI_BUS_COMPONENT
     ...
@@ -127,22 +128,22 @@ statement uses ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO
 definition.)
 
 Enable all AML "Debug" output (stores to the Debug object while interpreting
-AML) during boot:
+AML) during boot::
 
     acpi.debug_layer=0xffffffff acpi.debug_level=0x2
 
-Enable PCI and PCI interrupt routing debug messages:
+Enable PCI and PCI interrupt routing debug messages::
 
     acpi.debug_layer=0x400000 acpi.debug_level=0x4
 
-Enable all ACPI hardware-related messages:
+Enable all ACPI hardware-related messages::
 
     acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
 
-Enable all ACPI_DB_INFO messages after boot:
+Enable all ACPI_DB_INFO messages after boot::
 
     # echo 0x4 > /sys/module/acpi/parameters/debug_level
 
-Show all valid component values:
+Show all valid component values::
 
     # cat /sys/module/acpi/parameters/debug_layer
diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/acpi/dsd/data-node-references.rst
similarity index 80%
rename from Documentation/acpi/dsd/data-node-references.txt
rename to Documentation/acpi/dsd/data-node-references.rst
index c3871565c8cf..83a368d9d208 100644
--- a/Documentation/acpi/dsd/data-node-references.txt
+++ b/Documentation/acpi/dsd/data-node-references.rst
@@ -1,9 +1,11 @@
-Copyright (C) 2018 Intel Corporation
-Author: Sakari Ailus <sakari.ailus@linux.intel.com>
-
+.. include:: <isonum.txt>
 
+===================================
 Referencing hierarchical data nodes
------------------------------------
+===================================
+
+:Copyright: |copy| 2018 Intel Corporation
+:Author: Sakari Ailus <sakari.ailus@linux.intel.com>
 
 ACPI in general allows referring to device objects in the tree only.
 Hierarchical data extension nodes may not be referred to directly, hence this
@@ -28,13 +30,14 @@ extension key.
 
 
 Example
--------
+=======
 
-	In the ASL snippet below, the "reference" _DSD property [2] contains a
-	device object reference to DEV0 and under that device object, a
-	hierarchical data extension key "node@1" referring to the NOD1 object
-	and lastly, a hierarchical data extension key "anothernode" referring to
-	the ANOD object which is also the final target node of the reference.
+In the ASL snippet below, the "reference" _DSD property [2] contains a
+device object reference to DEV0 and under that device object, a
+hierarchical data extension key "node@1" referring to the NOD1 object
+and lastly, a hierarchical data extension key "anothernode" referring to
+the ANOD object which is also the final target node of the reference.
+::
 
 	Device (DEV0)
 	{
@@ -75,10 +78,10 @@ Example
 	    })
 	}
 
-Please also see a graph example in graph.txt .
+Please also see a graph example in :doc:`graph`.
 
 References
-----------
+==========
 
 [1] Hierarchical Data Extension UUID For _DSD.
     <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index e10ce874269c..3bd1d9996ffc 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -8,6 +8,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
    linuxized-acpica
    namespace
    dsd/graph
+   dsd/data-node-references
    enumeration
    osi
    DSD-properties-rules
@@ -18,3 +19,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    method-customizing
    initrd_table_override
    dsdt-override
+   debug
-- 
2.20.1

