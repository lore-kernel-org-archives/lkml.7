Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA61C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A156E205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDd2MK1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfDYPdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:33:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34073 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbfDYPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:33:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so44525pgq.1;
        Thu, 25 Apr 2019 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpX7F8/8x7KQ3d4aSKya8qsEnETmNBHRHBKInuxFpFI=;
        b=lDd2MK1R/m44/mCy0kf4pa9RHEkAkCFgtZKUrxtGrUQ4GJ8biiMz5gS4OZuMPiqP2Y
         NzoU3UAC4Bg4orD/u/NWaaNkkzL2l9YlNrssUXSFifbE7teCAH51QjLSgsfmyDsHT3EI
         9eeKOma3WwXrQMKcdnm2wqwiL3Rcb44YLDfCD5usZJlgesfvaVVjoyXhvVRNFeCuocL0
         vbJtvUKCuSTnhJ2vQCG5waZUghcOJDuZKdHHgxN1+DCFYqpCJjWrD229rPVr1XdEKWRO
         rL5i422f2/TiBbHRYKotSfRhKibg2f/MautBidGV7FliYobIkFk1XnbxGu2W/Uggthn6
         NoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpX7F8/8x7KQ3d4aSKya8qsEnETmNBHRHBKInuxFpFI=;
        b=R5q2MjVbqBT3mGxaVQLNcdPozx/tKxC0p3xzx2GmEdPexqcvZxxZCifILyXCtC9+d1
         W+GfVFQNuGvrKBaHdBIJzwfaXdIFQRlEIMjPoMXf9bibc58kX8WdA9ruiv/A66TRgDH+
         FTQn4BBeCUDRQhrOGQOLIVjVKxruaxuLcRLPjgmF1fOyd4/Wc8ugqeOnX3m06cI4dXA3
         Qh7FKki16f9x4su5ScrWW4wHJFEUF4YJs0+/CjGN4nIyOlbF1KTlOdpEx/KBHnia95Tj
         scQ8a7b3f16JZX0kAp+w+qXu9x4Hka9AVnY7aH88o7KcfGB9V0I9LdfUi75n4N43lQZw
         LdWg==
X-Gm-Message-State: APjAAAXTkPsfhrUn6pL8oYP7Iryk5wNX4MER4o4k+cWlQaU33+cHbWTE
        eH+NUJ7sWitCVZP3NQUpOLk=
X-Google-Smtp-Source: APXvYqwTaGWYpz3+bQAqBffJVPAR6u0jiBtaVeD1ln1YqX5J8SEMNVaEQrfyyGfBjnr8JY4nJBOhIg==
X-Received: by 2002:a63:6581:: with SMTP id z123mr38512069pgb.243.1556206382322;
        Thu, 25 Apr 2019 08:33:02 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:33:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 15/24] Documentation: ACPI: move dsd/data-node-references.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:08 +0800
Message-Id: <20190425153117.16057-16-changbin.du@gmail.com>
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
 .../acpi/dsd/data-node-references.rst}        | 36 ++++++++++---------
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 21 insertions(+), 16 deletions(-)
 rename Documentation/{acpi/dsd/data-node-references.txt => firmware-guide/acpi/dsd/data-node-references.rst} (71%)

diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
similarity index 71%
rename from Documentation/acpi/dsd/data-node-references.txt
rename to Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index c3871565c8cf..1351984e767c 100644
--- a/Documentation/acpi/dsd/data-node-references.txt
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -1,9 +1,12 @@
-Copyright (C) 2018 Intel Corporation
-Author: Sakari Ailus <sakari.ailus@linux.intel.com>
-
+.. SPDX-License-Identifier: GPL-2.0
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
@@ -28,13 +31,14 @@ extension key.
 
 
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
@@ -75,15 +79,15 @@ Example
 	    })
 	}
 
-Please also see a graph example in graph.txt .
+Please also see a graph example in :doc:`graph`.
 
 References
-----------
+==========
 
 [1] Hierarchical Data Extension UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
-    referenced 2018-07-17.
+<http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
+referenced 2018-07-17.
 
 [2] Device Properties UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
-    referenced 2016-10-04.
+<http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+referenced 2016-10-04.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index f81cfbcb6878..6d4e0df4f063 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -9,6 +9,7 @@ ACPI Support
 
    namespace
    dsd/graph
+   dsd/data-node-references
    enumeration
    osi
    method-customizing
-- 
2.20.1

