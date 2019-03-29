Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5032DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139992075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaV+ra9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfC2AMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:12:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33528 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfC2AMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:12:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id bg8so141155plb.0;
        Thu, 28 Mar 2019 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Onrx8SsvrVUlrW6RCR3riY1EmoSENYz7JjjA3u0DU7Y=;
        b=YaV+ra9Y6QoEdEWe4ROMZHzArL8Dv6SXdG43XutrumayBT8htFNH703GdtaPTGpz0u
         XWjIpBrjiXvDMh5fnFA6JrVd6Y92VLwnZ70mJGfzpMBij6I9EL55LVQbMXxRJ8l+mrhv
         DSZTrcgMHIb47EifgyiDzEDSerkF9D7b/1oU6dWgA/6TVnzZ5/RNam8TgSS63k0wOV1r
         k5tRXxdbZ1Uas4WlQMMGSMNYaQLu1d9pdxcvVC0wjNBlfxUw7N2YLhmIfSFGgIIkieRm
         eUI0zb2UiMZL42QXoR7OI1x9phDTVh+GhIaJ3TPS0jIp44bMYQ0/iWDXR3c1XocXdqnJ
         KX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Onrx8SsvrVUlrW6RCR3riY1EmoSENYz7JjjA3u0DU7Y=;
        b=HisnXhzq/p5hngHkwpi79z5RtGgVkNzv0ji1iZaFBK/5HSHCJFgd0BeUeHpq6Zv+ho
         DANSSEnsAwauwQrqy9AeR63S4yrMEqrCgpYMSQV+A1TF4yUlxAmNx7q0hUTD0JizEuWx
         JiEzxnX3QHyMjGcl8pXl09PtpJMwdLiV8j5VSe87M6/Ls9BEyMRfEK0viZTKEnd9d20Z
         wiLn+Q7wv9WdQOR4/EEBXB8iLstcGydTRKtoEx2zC21zFIAtwTjTeO2O6NAbCto35HWC
         M8oEnoASoMoHgHkVLd7uT5OFbdfMnuqvJAxr0Y6fe7yqSML6vhOxmsTwJDN7dg2nBkk/
         VQjA==
X-Gm-Message-State: APjAAAUC5TiskY1bTdq6jtLZ+10tMN94ChyMbJ0dE2+YRKv4+h4T2WE/
        JEQz58jk8RcKgXMx7oiS5thw9cSBn6U=
X-Google-Smtp-Source: APXvYqyZH6QMjdlUvOB9Fj5jZfyh6NtCXbz3T7ef4bHIpFK5QtUcUqDoIRGqTDe+Nb1ZmZ5WJY3A1A==
X-Received: by 2002:a17:902:b788:: with SMTP id e8mr35523690pls.339.1553818360933;
        Thu, 28 Mar 2019 17:12:40 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:12:39 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 07/24] acpi doc: convert acpi/DSD-properties-rules.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:18 +0800
Message-Id: <20190329001135.15847-8-changbin.du@gmail.com>
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
 ...ies-rules.txt => DSD-properties-rules.rst} | 21 +++++++++++--------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 13 insertions(+), 9 deletions(-)
 rename Documentation/acpi/{DSD-properties-rules.txt => DSD-properties-rules.rst} (88%)

diff --git a/Documentation/acpi/DSD-properties-rules.txt b/Documentation/acpi/DSD-properties-rules.rst
similarity index 88%
rename from Documentation/acpi/DSD-properties-rules.txt
rename to Documentation/acpi/DSD-properties-rules.rst
index 3e4862bdad98..4306f29b6103 100644
--- a/Documentation/acpi/DSD-properties-rules.txt
+++ b/Documentation/acpi/DSD-properties-rules.rst
@@ -1,8 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
 _DSD Device Properties Usage Rules
-----------------------------------
+==================================
 
 Properties, Property Sets and Property Subsets
-----------------------------------------------
+==============================================
 
 The _DSD (Device Specific Data) configuration object, introduced in ACPI 5.1,
 allows any type of device configuration data to be provided via the ACPI
@@ -18,7 +21,7 @@ specific type) associated with it.
 
 In the ACPI _DSD context it is an element of the sub-package following the
 generic Device Properties UUID in the _DSD return package as specified in the
-Device Properties UUID definition document [1].
+Device Properties UUID definition document [1]_.
 
 It also may be regarded as the definition of a key and the associated data type
 that can be returned by _DSD in the Device Properties UUID sub-package for a
@@ -33,14 +36,14 @@ Property subsets are nested collections of properties.  Each of them is
 associated with an additional key (name) allowing the subset to be referred
 to as a whole (and to be treated as a separate entity).  The canonical
 representation of property subsets is via the mechanism specified in the
-Hierarchical Properties Extension UUID definition document [2].
+Hierarchical Properties Extension UUID definition document [2]_.
 
 Property sets may be hierarchical.  That is, a property set may contain
 multiple property subsets that each may contain property subsets of its
 own and so on.
 
 General Validity Rule for Property Sets
----------------------------------------
+=======================================
 
 Valid property sets must follow the guidance given by the Device Properties UUID
 definition document [1].
@@ -73,7 +76,7 @@ suitable for the ACPI environment and consequently they cannot belong to a valid
 property set.
 
 Property Sets and Device Tree Bindings
---------------------------------------
+======================================
 
 It often is useful to make _DSD return property sets that follow Device Tree
 bindings.
@@ -91,7 +94,7 @@ expected to automatically work in the ACPI environment regardless of their
 contents.
 
 References
-----------
+==========
 
-[1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
-[2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
+.. [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
+.. [2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 741fcae251b4..d10170942e13 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -11,4 +11,5 @@ Linux ACPI (Advanced Configuration and Power Interface)
    namespace
    enumeration
    osi
+   DSD-properties-rules
    scan_handlers
-- 
2.20.1

