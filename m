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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142A0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9B7218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kum0bIHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfC2ANM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40725 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfC2ANK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so147185pfc.7;
        Thu, 28 Mar 2019 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrDVUndfihY6pqz8GMUucTeB47faJTZBQXvDJQqs0IY=;
        b=Kum0bIHIbaxWEm6HVEfUT8LWuBZfyh/WFmZRppP28ErMHdUbtq/r111g+3V96kB2tg
         exb0dMkFlxWEr4iMLmt5Gn+PwtDIrAUYhOP9HTFYaN+I0A9QV89GRjk81dne6Z7z8BlI
         ssE9bRJ45dQfn9aZzZAF7KOU0m94Gd8pMbEmP3HZWVOFVL2HDaFg3xxcGlyIY7w4YJsL
         iHvQLDATtK6rGCUfEoG3rC6dkufWioMerTASeaYKBf4fNY54sVaoOmwN58JfOBfT4DOp
         +bN37jnf5muKc+h+w1eWkMU1SZ6IDMS+PBruGmfr1A+uFn8qyZbeDzeDiJh4nJfnu7Yf
         5AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrDVUndfihY6pqz8GMUucTeB47faJTZBQXvDJQqs0IY=;
        b=e7G6JIzD3dm0fXcE/xHvoRN3dnaxc87jMs5M4+rbRKsVi87CJVjZHL5E3taCp1Wv5Y
         C18mNZ/mI9YPWvQPS2oBYr9/W6oH0Xld6gOnV0C/ClmnpQcXz9Y1GajpuygJJWvn3E8B
         ium3wZYo+fFIJvVkg6wgDbTHRd7tVv93F1PmPKsu7Uj4AYQlDYoQiJTRQ1xOLSLWohaa
         brLNsgSM/JTdcU4k87fJTL6axQ9Zm8HVgmHHdRQzsY6VkYcAcQyHZxX32TkhL9cihmK+
         rnxjRWARCA83f0k99+r3iWFWEdM311suaPcKakXAX2bbhzfWWKWDnWEBQL5zkGTQ8sPz
         wVmw==
X-Gm-Message-State: APjAAAXo9sbboBIItbno3lFyV1iQU6am0N4dS2K5Cl747DA7Su1W2Qi1
        JZ1aXlRbvbT4ki4pKne+ibk=
X-Google-Smtp-Source: APXvYqxVCILvjGlZNixtY9ERq/Mg2A0qVLoDDOtMhzuRejzZBhSNGySOXKzCxad445FuddLgNj7rMQ==
X-Received: by 2002:aa7:9296:: with SMTP id j22mr16228702pfa.140.1553818389173;
        Thu, 28 Mar 2019 17:13:09 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:08 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 13/24] acpi doc: convert acpi/acpi-lid.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:24 +0800
Message-Id: <20190329001135.15847-14-changbin.du@gmail.com>
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
 .../acpi/{acpi-lid.txt => acpi-lid.rst}       | 48 ++++++++++++-------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 33 insertions(+), 16 deletions(-)
 rename Documentation/acpi/{acpi-lid.txt => acpi-lid.rst} (77%)

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.rst
similarity index 77%
rename from Documentation/acpi/acpi-lid.txt
rename to Documentation/acpi/acpi-lid.rst
index effe7af3a5af..1d19e15a6945 100644
--- a/Documentation/acpi/acpi-lid.txt
+++ b/Documentation/acpi/acpi-lid.rst
@@ -1,25 +1,29 @@
-Special Usage Model of the ACPI Control Method Lid Device
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-Copyright (C) 2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
+=========================================================
+Special Usage Model of the ACPI Control Method Lid Device
+=========================================================
 
+:Copyright: |copy| 2016, Intel Corporation
 
-Abstract:
+:Author: Lv Zheng <lv.zheng@intel.com>
 
-Platforms containing lids convey lid state (open/close) to OSPMs using a
-control method lid device. To implement this, the AML tables issue
-Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
-changed. The _LID control method for the lid device must be implemented to
-report the "current" state of the lid as either "opened" or "closed".
+:Abstract: Platforms containing lids convey lid state (open/close) to OSPMs
+  using a control method lid device. To implement this, the AML tables issue
+  Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
+  changed. The _LID control method for the lid device must be implemented to
+  report the "current" state of the lid as either "opened" or "closed".
 
-For most platforms, both the _LID method and the lid notifications are
-reliable. However, there are exceptions. In order to work with these
-exceptional buggy platforms, special restrictions and expections should be
-taken into account. This document describes the restrictions and the
-expections of the Linux ACPI lid device driver.
+  For most platforms, both the _LID method and the lid notifications are
+  reliable. However, there are exceptions. In order to work with these
+  exceptional buggy platforms, special restrictions and expections should be
+  taken into account. This document describes the restrictions and the
+  expections of the Linux ACPI lid device driver.
 
 
 1. Restrictions of the returning value of the _LID control method
+=================================================================
 
 The _LID control method is described to return the "current" lid state.
 However the word of "current" has ambiguity, some buggy AML tables return
@@ -31,6 +35,7 @@ with cached value, the initial returning value is likely not reliable.
 There are platforms always retun "closed" as initial lid state.
 
 2. Restrictions of the lid state change notifications
+=====================================================
 
 There are buggy AML tables never notifying when the lid device state is
 changed to "opened". Thus the "opened" notification is not guaranteed. But
@@ -40,17 +45,21 @@ trigger some system power saving operations on Windows. Since it is fully
 tested, it is reliable from all AML tables.
 
 3. Expections for the userspace users of the ACPI lid device driver
+===================================================================
 
 The ACPI button driver exports the lid state to the userspace via the
-following file:
+following file::
+
   /proc/acpi/button/lid/LID0/state
+
 This file actually calls the _LID control method described above. And given
 the previous explanation, it is not reliable enough on some platforms. So
 it is advised for the userspace program to not to solely rely on this file
 to determine the actual lid state.
 
 The ACPI button driver emits the following input event to the userspace:
-  SW_LID
+  * SW_LID
+
 The ACPI lid device driver is implemented to try to deliver the platform
 triggered events to the userspace. However, given the fact that the buggy
 firmware cannot make sure "opened"/"closed" events are paired, the ACPI
@@ -59,20 +68,25 @@ button driver uses the following 3 modes in order not to trigger issues.
 If the userspace hasn't been prepared to ignore the unreliable "opened"
 events and the unreliable initial state notification, Linux users can use
 the following kernel parameters to handle the possible issues:
+
 A. button.lid_init_state=method:
    When this option is specified, the ACPI button driver reports the
    initial lid state using the returning value of the _LID control method
    and whether the "opened"/"closed" events are paired fully relies on the
    firmware implementation.
+
    This option can be used to fix some platforms where the returning value
    of the _LID control method is reliable but the initial lid state
    notification is missing.
+
    This option is the default behavior during the period the userspace
    isn't ready to handle the buggy AML tables.
+
 B. button.lid_init_state=open:
    When this option is specified, the ACPI button driver always reports the
    initial lid state as "opened" and whether the "opened"/"closed" events
    are paired fully relies on the firmware implementation.
+
    This may fix some platforms where the returning value of the _LID
    control method is not reliable and the initial lid state notification is
    missing.
@@ -80,6 +94,7 @@ B. button.lid_init_state=open:
 If the userspace has been prepared to ignore the unreliable "opened" events
 and the unreliable initial state notification, Linux users should always
 use the following kernel parameter:
+
 C. button.lid_init_state=ignore:
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
@@ -89,6 +104,7 @@ C. button.lid_init_state=ignore:
    notifications can be delivered to the userspace when the lid is actually
    opens given that some AML tables do not send "opened" notifications
    reliably.
+
    In this mode, if everything is correctly implemented by the platform
    firmware, the old userspace programs should still work. Otherwise, the
    new userspace programs are required to work with the ACPI button driver.
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 78f72a525a3f..909f12833692 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -14,6 +14,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
    DSD-properties-rules
    gpio-properties
    i2c-muxes
+   acpi-lid
    scan_handlers
    method-customizing
    initrd_table_override
-- 
2.20.1

