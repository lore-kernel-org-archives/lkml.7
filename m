Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6A7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D238C20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgS5J1CF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbfDXRya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:54:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42600 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390122AbfDXRy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:54:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id w25so9687008pfi.9;
        Wed, 24 Apr 2019 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKtDv1X/aYP4TvJqarXB9+14q+P9ROu4ceFb9isBfF8=;
        b=kgS5J1CFOTKUuQ9Ke3TpJ2dADMCpP+Tj86y7Sbi096rhz+OOZVnC28z/PW+fLL7SON
         O1cr791RYVNVJ6r7jybdjPSFA0HEwfjA4+h7aLx0E6RA0Aq9feMQKFkogOcXpaFuINFg
         0wTKZK/Vd4MOF5zO99gL86RpyqoD47MS6BprgOMsk4oGXmyiVv+1FP49T4G2EI4PcHM0
         F6T9GLT4hU0ak5RMZ4aXbnP+WmiNxpPEs2G8cZKG9qA36A24+gc6pcf6hYiL/Z7YzNvt
         rc0Uorg8WLfbaMOEscGkyQ55fu0fne/X+WPKUj+2rKAsuh6bZosHAy0Z7k6detE1RorD
         E3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKtDv1X/aYP4TvJqarXB9+14q+P9ROu4ceFb9isBfF8=;
        b=sShvzkyy+ftm8OZt/QBmeHr4RK1+6UWEleyjiA5u8f7/4JwDdfiqvezEEHI44LEOdt
         +Wmc+EmopuY7grWBDxeyxjr47ggGHFe/dA7EZj7gjNp2vObu4dRzVK7J7+bYVGmYBtE6
         vY6QodzlVulOUT1ewI3dLytaaFiVQWWxU3PDdPJraGgs9Ue54RCpYZvE5A0SMIx3lGg/
         mYB2Ly8PaNS5JGZhz+5UKeillN2GkXdyaxvHZEPiQeWNfd5k3Ro3YZmSo1TdpB0ltHFD
         N3OeKYjcf19jQYG6R+ppVDRHGxhsVRpRTdAmtUL1vT2SNd4m0IPZAV05WJqJtZ9CdV1e
         MA3A==
X-Gm-Message-State: APjAAAXY2z4hi/t39GwAxvOWtT6cv8DIjIGvVz1ikr4AGTDN/x+VvHtL
        ud6isDVaeccSn+pgFX0yETg=
X-Google-Smtp-Source: APXvYqzZOKb8F3KryDFF0JbCavpwyLZ2eBk0SSZ8/gP3dBrP4ES4l32jm4A7JgqPQCdmwJbPxIVzuw==
X-Received: by 2002:a63:7843:: with SMTP id t64mr31730007pgc.130.1556128466533;
        Wed, 24 Apr 2019 10:54:26 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:54:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 03/23] Documentation: ACPI: move osi.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:52:46 +0800
Message-Id: <20190424175306.25880-4-changbin.du@gmail.com>
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
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/firmware-guide/acpi/index.rst       |  1 +
 .../{acpi/osi.txt => firmware-guide/acpi/osi.rst} | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)
 rename Documentation/{acpi/osi.txt => firmware-guide/acpi/osi.rst} (97%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 99677c73f1fb..868bd25a3398 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -9,3 +9,4 @@ ACPI Support
 
    namespace
    enumeration
+   osi
diff --git a/Documentation/acpi/osi.txt b/Documentation/firmware-guide/acpi/osi.rst
similarity index 97%
rename from Documentation/acpi/osi.txt
rename to Documentation/firmware-guide/acpi/osi.rst
index 50cde0ceb9b0..29e9ef79ebc0 100644
--- a/Documentation/acpi/osi.txt
+++ b/Documentation/firmware-guide/acpi/osi.rst
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

