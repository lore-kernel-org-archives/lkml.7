Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5066C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7C42075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGtoZICR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfC2AM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:12:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36597 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfC2AM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:12:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so303620pgc.3;
        Thu, 28 Mar 2019 17:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbyA327uXl3MzoEnDWdUyXfVZmPBTAd9tTRgFSPW16Q=;
        b=SGtoZICReT/HvG2SonJYU6/7WXiudBHPtXegETGqHArActRFZLYeexXTO13OMjXZ9V
         7XFA3iiL7Tw2KO4D7wP3qEfNWQda6lfEODUKyfkI49vqxW+jfxghMEYxtemB6AZkQq5t
         zakaoZzKIuh0jm3gUgOk97+uTFf/ep7Z9cgBlxwTlJ+0UN6cdcSMoT6BC7nbbo7kKs2c
         NAO4a8+dkZQZCdeTnTT/XcXyTe4vzg3pAlKSMQTpMoYlNwdFfw5twdyG6EMcgqTCzo5b
         Ljr4GDlZL9MOQGG1VLmVbGDn1K8dnFq1nkxww61vwWKtRGfuuTejVus4rO5R3ceQ5sqF
         b4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbyA327uXl3MzoEnDWdUyXfVZmPBTAd9tTRgFSPW16Q=;
        b=CxncHhCcAOQrDxlG3ecOJP9hw1Of+qXHZXI/6TG/iMuv0uI9rBQqnkVmCTwiEczjqj
         Oav/80KR9f2cAE797w6N3HGb6TotpDidv4okc8khpEvOI4dNPCVHAG5D8zQGIkF0sjXq
         4tlUI7iV3G8iycHVgQ8DrOH3YCmELRb1sso2yboWhpWH6j/8P6G9f7utNBlCALRspzfB
         fjrX5KApFkGS5OsB99Y+UzdkSDHTZnLv2Q3jbKPKI8EB3Nmr8ZhGss/UCqGggkkTQt8w
         xgc8rD0811uzFcOgw3HO+mB3OVVo6Ci41NmeUxRkWrmuurj/VBGtMgceTcmgUjS9Yg7h
         +L4Q==
X-Gm-Message-State: APjAAAVDpfM9xd5VlMZIjv4fgZLFl4gdLEkENuSKOXjky3fEFnHx70bp
        YQyfWTztXJzOqfzBJXBFqng=
X-Google-Smtp-Source: APXvYqyXgIQr0FcjRxd6uzs39ZFVO50fdP3EMer9ARQTVEiKS3RFMGsOzPhUQ+4HM/Jeix2NK7pdvA==
X-Received: by 2002:aa7:8243:: with SMTP id e3mr44734017pfn.40.1553818345688;
        Thu, 28 Mar 2019 17:12:25 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:12:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 04/24] acpi doc: convert acpi/osi.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:15 +0800
Message-Id: <20190329001135.15847-5-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst            |  1 +
 Documentation/acpi/{osi.txt => osi.rst} | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)
 rename Documentation/acpi/{osi.txt => osi.rst} (97%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 52ff8d0a9ed6..d69c2a416909 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -9,3 +9,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
 
    namespace
    enumeration
+   osi
diff --git a/Documentation/acpi/osi.txt b/Documentation/acpi/osi.rst
similarity index 97%
rename from Documentation/acpi/osi.txt
rename to Documentation/acpi/osi.rst
index 50cde0ceb9b0..29e9ef79ebc0 100644
--- a/Documentation/acpi/osi.txt
+++ b/Documentation/acpi/osi.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
 ACPI _OSI and _REV methods
---------------------------
+==========================
 
 An ACPI BIOS can use the "Operating System Interfaces" method (_OSI)
 to find out what the operating system supports. Eg. If BIOS
@@ -14,7 +17,7 @@ This document explains how and why the BIOS and Linux should use these methods.
 It also explains how and why they are widely misused.
 
 How to use _OSI
----------------
+===============
 
 Linux runs on two groups of machines -- those that are tested by the OEM
 to be compatible with Linux, and those that were never tested with Linux,
@@ -62,7 +65,7 @@ the string when that support is added to the kernel.
 That was easy.  Read on, to find out how to do it wrong.
 
 Before _OSI, there was _OS
---------------------------
+==========================
 
 ACPI 1.0 specified "_OS" as an
 "object that evaluates to a string that identifies the operating system."
@@ -96,7 +99,7 @@ That is the *only* viable strategy, as that is what modern Windows does,
 and so doing otherwise could steer the BIOS down an untested path.
 
 _OSI is born, and immediately misused
---------------------------------------
+=====================================
 
 With _OSI, the *BIOS* provides the string describing an interface,
 and asks the OS: "YES/NO, are you compatible with this interface?"
@@ -144,7 +147,7 @@ catastrophic failure resulting from the BIOS taking paths that
 were never validated under *any* OS.
 
 Do not use _REV
----------------
+===============
 
 Since _OSI("Linux") went away, some BIOS writers used _REV
 to support Linux and Windows differences in the same BIOS.
@@ -164,7 +167,7 @@ from mid-2015 onward.  The ACPI specification will also be updated
 to reflect that _REV is deprecated, and always returns 2.
 
 Apple Mac and _OSI("Darwin")
-----------------------------
+============================
 
 On Apple's Mac platforms, the ACPI BIOS invokes _OSI("Darwin")
 to determine if the machine is running Apple OSX.
-- 
2.20.1

