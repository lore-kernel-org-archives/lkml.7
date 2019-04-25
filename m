Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C620C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF5B205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdk3XlQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfDYPcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:32:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40055 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbfDYPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:32:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so11284089plr.7;
        Thu, 25 Apr 2019 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaCx91wAcR4ikyNBIoUaFJho1ovTMWA1CQykmERd8P8=;
        b=Hdk3XlQRCv7evnLRIrBqNI6dKOKM/IAtVLukmn4hOfboTFMosGg/1qHBBboME7fsSV
         mgsDQX6YOUt0C+CyWn01xtR/CLYxDQkE815BTUxlY5LDT8bmCi0rWztMl8rKEvgLS0L7
         HfT7yxZLK9PY8kxOLlVDTOfzpBIKYvNh1cJnM+uNyYnW854EQcaSuS443iIyiZ2U6Dnp
         thbuNE2QdB4pFr0CyyZGzY4sv0dTTgCYS/Wyqc4BiX7X7kTPIkrEwFd3FSquz/okgL4k
         An3nopJ2X09KuovKvKoLAPsyju3Z1PmebkjS/ctlAdK/v94yun4Je6bVUtP7qhTfsBYG
         BiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaCx91wAcR4ikyNBIoUaFJho1ovTMWA1CQykmERd8P8=;
        b=NVC1zDzdp24D/y+XbuwLMstc38LhKTBTAkg7wN9hiQW3WtbrUcwtKjlJ0D9GmtG/Go
         1t4UGEmdPVuW4ekesGf+yx7PzIhwMoIX8PfkXz1KheezZGE1y8kNW/EFDQ9MVWPX/tRi
         f2oCj9v7SrIQbvnVFLsHF7HJ4Y41COWLaVn2gGWtBlx9/gLe8rxl/PaXVLaSsn4yuBj8
         T4X3kABzI5FcJKKV0ju6pBx2FUvzMMB/8yw0NacTD9f8fOYhJuLDSNJsa02hzypCdB1d
         WugxvgDjt0Zpbj9PkiIztBHZZWHVU7Msl12rDWMTs2OxYG2Kwg2VSWGppq9sWi9dVS5w
         zkMg==
X-Gm-Message-State: APjAAAUHYnesxlrycXLZzKg1LJjJmZTgXoWFD1cU7sbio2eNTD3xNHq3
        SHEgHtC5Zjr/H0XMep/MEh0=
X-Google-Smtp-Source: APXvYqx68euL3s8ftKjiMXZ0iaWeLPJXtLVsDDr36kkfZtCXIn3smjJr6dZt5olwjZ/tgq7YYFOqfw==
X-Received: by 2002:a17:902:6843:: with SMTP id f3mr14305386pln.218.1556206334772;
        Thu, 25 Apr 2019 08:32:14 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:32:14 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 07/24] Documentation: ACPI: move DSD-properties-rules.txt to firmware-guide/acpi and covert to reST
Date:   Thu, 25 Apr 2019 23:31:00 +0800
Message-Id: <20190425153117.16057-8-changbin.du@gmail.com>
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
 .../acpi/DSD-properties-rules.rst}            | 21 +++++++++++--------
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 13 insertions(+), 9 deletions(-)
 rename Documentation/{acpi/DSD-properties-rules.txt => firmware-guide/acpi/DSD-properties-rules.rst} (88%)

diff --git a/Documentation/acpi/DSD-properties-rules.txt b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
similarity index 88%
rename from Documentation/acpi/DSD-properties-rules.txt
rename to Documentation/firmware-guide/acpi/DSD-properties-rules.rst
index 3e4862bdad98..4306f29b6103 100644
--- a/Documentation/acpi/DSD-properties-rules.txt
+++ b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
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
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 868bd25a3398..0e05b843521c 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -10,3 +10,4 @@ ACPI Support
    namespace
    enumeration
    osi
+   DSD-properties-rules
-- 
2.20.1

