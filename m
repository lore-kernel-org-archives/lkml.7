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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5CEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0CD2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyLOZwRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfC2ANU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37670 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfC2ANT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id q206so302653pgq.4;
        Thu, 28 Mar 2019 17:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUA9/rY9s/hVZgVjRvHMPr6SBCZzgjUta2zOOyBSl+Y=;
        b=fyLOZwRn07fNLc470bcNKqTjA5qU1AowdqStY23r0LvL9VPKxkf7QVGSDJ4MI1yo1t
         QGvDZWH1CKU1PMt7YHN0zm/UI9UsQ89vFKFI1X+QY84u9zqTSOQ91aEbcrN5yKg0Aj3f
         MbJl0LQYOoYfK3+bHJNzNIeUhH8sWzmtpQhZvnlaNrSnY3gzOC2M4L/4ogMeA2G8Y+eR
         iKJ7RunKmhf5Db91HzJimnku87oqdLmcjT5azea0+9GY2MWwjIRlOS9N/HFCazfuaYje
         Dt5tNQzZJRRWR5hO9OvRePSv/V9yYwhXuX4vHPITDPOsbJ/bSztmItFRSHByKDVvuzza
         rYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUA9/rY9s/hVZgVjRvHMPr6SBCZzgjUta2zOOyBSl+Y=;
        b=rWTh2siwMz/+mU9Ye5CBEoaRG4nwQZIZ5df2ynR/eMwfROHy86mICs+tqhi3I4mI19
         SW3OB6QJV5M8m/INdlonwIuqSYgVFavfa87+fZgd7QM9CKAMkrZSXECi1vwonjR8TRcp
         XgWTdpjmO5/72spGkQLQWT9fdwZhm7GsYNd0uY6xge8sGFujNoW4SIPprfSPBj4LtQEK
         e0eCTn0viLWpLO/DRqY2QPQyvHWEJDk4MoOSX3iZX+6AP8sRFr8AigbuPsN7nvALGhkU
         dd/7spRxnOJxc58kObFmGo1uB0XrnaiJ1gUsM2UiuJ9cNJaHMt/0K2T9/CuBh2Leuoz6
         RemA==
X-Gm-Message-State: APjAAAVOBcE7ohh4sM72trOXtAuEZ3gyi1rj1wVMp90AIKnUCy9UnBbp
        Pf+wuDBfeJofGvygx1aN7r4=
X-Google-Smtp-Source: APXvYqzm4bj1t1rb1FxyEhavq9agBoFznMEWMixFD+JSjCYPjJkq0fIuK8zUgz5vppSRnQuppJtDHg==
X-Received: by 2002:a65:6644:: with SMTP id z4mr42894207pgv.198.1553818398722;
        Thu, 28 Mar 2019 17:13:18 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 15/24] acpi doc: convert acpi/dsd/data-node-references.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:26 +0800
Message-Id: <20190329001135.15847-16-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
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
 ...eferences.txt => data-node-references.rst} | 28 +++++++++++--------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 17 insertions(+), 12 deletions(-)
 rename Documentation/acpi/dsd/{data-node-references.txt => data-node-references.rst} (79%)

diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/acpi/dsd/data-node-references.rst
similarity index 79%
rename from Documentation/acpi/dsd/data-node-references.txt
rename to Documentation/acpi/dsd/data-node-references.rst
index c3871565c8cf..79c5368eaecf 100644
--- a/Documentation/acpi/dsd/data-node-references.txt
+++ b/Documentation/acpi/dsd/data-node-references.rst
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
@@ -75,10 +79,10 @@ Example
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
index 40a628b2be21..b680fb13f445 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -10,6 +10,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
    linuxized-acpica
    namespace
    dsd/graph
+   dsd/data-node-references
    enumeration
    osi
    DSD-properties-rules
-- 
2.20.1

