Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E7EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE47A20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkULjwak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392228AbfDXRzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:55:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36263 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733104AbfDXRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:55:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so9697650pfn.3;
        Wed, 24 Apr 2019 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TfJooqezv1rjwCTdoZktCgHcEmSUPQlbQtDFtcyrPBY=;
        b=ZkULjwakFLZu7Q83lPrcRpucMTBh1hXwCGWgCM1OcqawLZyp2XKl3F7wNuxiRFpfH5
         eaZk/Kr9tQvQXOMX/PN+NTQMquRM3EgunPbxRqGpzAZoH4Gpwx3nH5ehm0TaN3lHY/C/
         JZ1QppIKrqz3fByrsLYTgY2PEwCRk8hsBPle9KA4Rr9YIB8TOU2YV9f5o/swverjtAzJ
         BfvpSwDgDdVYCxbsDwxDXAxBieJ5J22tYA0+71R08BPvx8S1AoPDI2EC20IAwzNtJmmW
         EkwbfWstB+PmNqQLiM2aONdCM6lXztUiNmKYIKslyjOPOAF4qD5VlPg4azLPaTIau3Gi
         k0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfJooqezv1rjwCTdoZktCgHcEmSUPQlbQtDFtcyrPBY=;
        b=clHYQ2LBlMDuy4UKE+srmM9SLH1GyMMPu60tQQ/jOjY+6tC/d3lKZezPv4jk0O9uxi
         nXlWaY3dqX9lMI313nkm7sSzre+LfS3+eqMLcg0+efR/iMk+ehUqgg9uEUj6f7wRtxpp
         UoNxG2u5LqvVpC/zR/HeuMpJQWOoIRPZPB3g4gFSDyx1A2PQ9jJJuF/L3m7w4gOckP99
         k/+DL7SI4gqiuTLY0NE1FDtlYZ2cWu3/XEJeRcJ3kRa5Gp2ImVCvyZLqQ25ZTqDS452w
         l5yjkj2maK953PyaXg5n4Eh3Kqb1UPogQxOWeo6OSFNd2CwmbTJuCjsqKVdDlHT5HxXt
         8YSQ==
X-Gm-Message-State: APjAAAXe2zOGDLXvBhQQ0LEWSKG8fQo/ZmXJgNG1NAV09SyeDG0HjQUL
        Q3imfnjEe69fPtGP9M6BdQ4P4mqF
X-Google-Smtp-Source: APXvYqwlVIEJ5rlkHBPo6UDTHNmo10/KYY75sgYKU7XsSljRAyGz+bcPZwlk7n+/g1ZrBbYXlzsliQ==
X-Received: by 2002:aa7:8c56:: with SMTP id e22mr34491156pfd.155.1556128550519;
        Wed, 24 Apr 2019 10:55:50 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:55:49 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 14/23] Documentation: ACPI: move dsd/data-node-references.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:52:57 +0800
Message-Id: <20190424175306.25880-15-changbin.du@gmail.com>
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

