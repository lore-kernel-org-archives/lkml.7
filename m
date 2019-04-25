Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13AAC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A0A206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3lROnbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfDYPcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:32:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43080 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbfDYPcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:32:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so11268203plp.10;
        Thu, 25 Apr 2019 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7iW4MbVd77MEAccCwSku/MkHI3UfK1BuasUTDy15CeE=;
        b=u3lROnbm0VN76si2ABD4XoHYOXl2xIcsMsmytLpSxXYVKKCC+htJeY8bTEPD/S3Phe
         UNoWAEeO8B8FO969vE0Hl8R+qas+OT0BcPFzY2kEuAIQ4ZkY3ydS7Jr5lSuB1jD3DEE6
         OUBy5sU/S3rSxjGDBD7JSbfl9pfde3FToAjtmDjcjfcQeElSRUOdCK5iJDnuM9aoRPRW
         9iO+wcAuC7s9EKBsnLX65eAdj7/y6z9xaAerkUY8BVylQeGubiIw6/8Ebg+1yGyCigYB
         8BctT4BfoeHJt8Ab04al19rVcTfxHYwrfzz9wWNlJjN+SN5ut9DYi782wGk3EzYcV1E/
         x9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7iW4MbVd77MEAccCwSku/MkHI3UfK1BuasUTDy15CeE=;
        b=h/aNhATwDwhk6H0zs6a/nX//Gw4KcTFUTz59ZvhiKB/g5QN3ymqvmafaFR9itBdsi3
         WR3KPJb7UHvX/WduGWzdvE4iJ0Tl+Vv8Jm9+lsSv4NvmrmlKBsuQuoF/VAA2L3yp78f+
         h5lJjyh8elMypzcy6cvKUJGoH2IZOteagYTfiq/AAfEx3gTHl1jg8Ac/PaYu+oV0EyZw
         XwxFkmZxH+J6tAieMkzOYArAsXl2wLzwcKgMhTy4tuIc6yL4gjJ39AoB6ZiYuyb6+dBs
         pTzWVPt//Yl3d+8n0b0OuFsSBynPTLKsqQxushdJ6ZbQuQlWCFwicQAk3/TZ4Mh3qN6k
         Igrw==
X-Gm-Message-State: APjAAAXWMLBvXqFaOB7BBe+EtK3EawWpc9SkaytZENfs25OqcGpAgqet
        h5+M8sXacipXGGldV4yZF5w=
X-Google-Smtp-Source: APXvYqwatzTfNnv6S1Wgdobw7qtMufyuTFu57h2iiajodT0TTyLGILlwrVsoBD8jHQDyecaxVxCO0Q==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr39637747plp.118.1556206370992;
        Thu, 25 Apr 2019 08:32:50 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:32:50 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 13/24] Documentation: ACPI: move acpi-lid.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:06 +0800
Message-Id: <20190425153117.16057-14-changbin.du@gmail.com>
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
 .../acpi/acpi-lid.rst}                        | 40 ++++++++++++++-----
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 30 insertions(+), 11 deletions(-)
 rename Documentation/{acpi/acpi-lid.txt => firmware-guide/acpi/acpi-lid.rst} (86%)

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/firmware-guide/acpi/acpi-lid.rst
similarity index 86%
rename from Documentation/acpi/acpi-lid.txt
rename to Documentation/firmware-guide/acpi/acpi-lid.rst
index effe7af3a5af..874ce0ed340d 100644
--- a/Documentation/acpi/acpi-lid.txt
+++ b/Documentation/firmware-guide/acpi/acpi-lid.rst
@@ -1,13 +1,18 @@
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
+Abstract
+========
+Platforms containing lids convey lid state (open/close) to OSPMs
+using a control method lid device. To implement this, the AML tables issue
 Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
 changed. The _LID control method for the lid device must be implemented to
 report the "current" state of the lid as either "opened" or "closed".
@@ -19,7 +24,8 @@ taken into account. This document describes the restrictions and the
 expections of the Linux ACPI lid device driver.
 
 
-1. Restrictions of the returning value of the _LID control method
+Restrictions of the returning value of the _LID control method
+==============================================================
 
 The _LID control method is described to return the "current" lid state.
 However the word of "current" has ambiguity, some buggy AML tables return
@@ -30,7 +36,8 @@ initial returning value. When the AML tables implement this control method
 with cached value, the initial returning value is likely not reliable.
 There are platforms always retun "closed" as initial lid state.
 
-2. Restrictions of the lid state change notifications
+Restrictions of the lid state change notifications
+==================================================
 
 There are buggy AML tables never notifying when the lid device state is
 changed to "opened". Thus the "opened" notification is not guaranteed. But
@@ -39,18 +46,22 @@ state is changed to "closed". The "closed" notification is normally used to
 trigger some system power saving operations on Windows. Since it is fully
 tested, it is reliable from all AML tables.
 
-3. Expections for the userspace users of the ACPI lid device driver
+Expections for the userspace users of the ACPI lid device driver
+================================================================
 
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
@@ -59,20 +70,25 @@ button driver uses the following 3 modes in order not to trigger issues.
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
@@ -80,6 +96,7 @@ B. button.lid_init_state=open:
 If the userspace has been prepared to ignore the unreliable "opened" events
 and the unreliable initial state notification, Linux users should always
 use the following kernel parameter:
+
 C. button.lid_init_state=ignore:
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
@@ -89,6 +106,7 @@ C. button.lid_init_state=ignore:
    notifications can be delivered to the userspace when the lid is actually
    opens given that some AML tables do not send "opened" notifications
    reliably.
+
    In this mode, if everything is correctly implemented by the platform
    firmware, the old userspace programs should still work. Otherwise, the
    new userspace programs are required to work with the ACPI button driver.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 1c89888f6ee8..bedcb0b242a2 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -14,3 +14,4 @@ ACPI Support
    DSD-properties-rules
    gpio-properties
    i2c-muxes
+   acpi-lid
\ No newline at end of file
-- 
2.20.1

