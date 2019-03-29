Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC622075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRboTA5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfC2AMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:12:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38640 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfC2AMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:12:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id g37so130280plb.5;
        Thu, 28 Mar 2019 17:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yrrz4X0b3iO0ef+Eqem0gn+OxiKJfuWgju1XckNuM24=;
        b=vRboTA5PuxwhyTHvbeUNa5SJr/66tUf4EHG79EFMr8HiGZyV0yZqi1qDd5jHE/1KPE
         fO/YycXP2KTOwu+cQDi2hLDyMif+LI3gQQ/c9tlPmqFKO3I0TnGmz6WzMxXoDbbslgS+
         sMnmfqWi+C16/0ZwEOGDxD1oHDywXz/G8a1PoHiLEuMSnKT6cPEArI8i5CxqMx5Plib7
         BpjWJ1uQNtOIUvGA075PRr4ZL/lpRFc/MPAht5gEhN9A9pXocp2DBtw5WLY5/69LQq/9
         pcD+bZL5+WtmNsPpmPHpypr7ZZjkuypgXeeWUns0fd3p3a2F9xXSMxB+g/5Ph0S3LZYU
         xpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrrz4X0b3iO0ef+Eqem0gn+OxiKJfuWgju1XckNuM24=;
        b=Wq7gjA3a5CagnVB08O7yN3HLv/+Hm+aTMT0djGOp4MiNaJyzjm0SBzHZr8wXOehAsY
         MjnyAU8Q/fQwUoCwApRclobWMgpYKSqh0acAthH3rFky9r5vjwihhYrqOYKfg2LSNevN
         RkPlv6VKWVZer5qk7Cgfh/B2yPq1hdVzLdQLbSj/HQbp2CGFQ1HcYtCK9yI4rI2oqq8F
         XFTF2AhbO8S3ukKKnmWk1A0u7UkAbBtZWOKSjn32RC1Not5xS93kmEHgaAARs4OomlLH
         glTWLKWv9OqgZbNOFUZH0rolqee5Al+6LbftXHc3fpV4pTEGHJzDOHETPvrjqjinM619
         NZuA==
X-Gm-Message-State: APjAAAUq0HXm7FLXYsT1RzCbVHt5JnGK6dtO3A97IKj+aYbmt/90IVEo
        PvCSqXrbttpgavjVRZM2Aq8=
X-Google-Smtp-Source: APXvYqy+TkXTSMwdl7dfXWJip6KPXhM4FXZLpJbUP8GoNmMwck4whhYDGZFCfGH/4wQ1JKS/VaFspQ==
X-Received: by 2002:a17:902:8606:: with SMTP id f6mr47350207plo.151.1553818351314;
        Thu, 28 Mar 2019 17:12:31 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:12:30 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 05/24] acpi doc: convert acpi/linuxized-acpica.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:16 +0800
Message-Id: <20190329001135.15847-6-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst                  |   1 +
 ...uxized-acpica.txt => linuxized-acpica.rst} | 115 ++++++++++--------
 2 files changed, 66 insertions(+), 50 deletions(-)
 rename Documentation/acpi/{linuxized-acpica.txt => linuxized-acpica.rst} (78%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index d69c2a416909..3747a0286442 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -7,6 +7,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
 .. toctree::
    :maxdepth: 2
 
+   linuxized-acpica
    namespace
    enumeration
    osi
diff --git a/Documentation/acpi/linuxized-acpica.txt b/Documentation/acpi/linuxized-acpica.rst
similarity index 78%
rename from Documentation/acpi/linuxized-acpica.txt
rename to Documentation/acpi/linuxized-acpica.rst
index 3ad7b0dfb083..f8aaea668e41 100644
--- a/Documentation/acpi/linuxized-acpica.txt
+++ b/Documentation/acpi/linuxized-acpica.rst
@@ -1,31 +1,35 @@
-Linuxized ACPICA - Introduction to ACPICA Release Automation
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-Copyright (C) 2013-2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
+============================================================
+Linuxized ACPICA - Introduction to ACPICA Release Automation
+============================================================
 
+:Copyright: |copy| 2013-2016, Intel Corporation
 
-Abstract:
+:Author: Lv Zheng <lv.zheng@intel.com>
 
-This document describes the ACPICA project and the relationship between
-ACPICA and Linux.  It also describes how ACPICA code in drivers/acpi/acpica,
-include/acpi and tools/power/acpi is automatically updated to follow the
-upstream.
+:Abstract: This document describes the ACPICA project and the relationship
+           between ACPICA and Linux.  It also describes how ACPICA code in
+           drivers/acpi/acpica, include/acpi and tools/power/acpi is
+           automatically updated to follow the upstream.
 
 
-1. ACPICA Project
+ACPICA Project
+==============
 
-   The ACPI Component Architecture (ACPICA) project provides an operating
-   system (OS)-independent reference implementation of the Advanced
-   Configuration and Power Interface Specification (ACPI).  It has been
-   adapted by various host OSes.  By directly integrating ACPICA, Linux can
-   also benefit from the application experiences of ACPICA from other host
-   OSes.
+The ACPI Component Architecture (ACPICA) project provides an operating
+system (OS)-independent reference implementation of the Advanced
+Configuration and Power Interface Specification (ACPI).  It has been
+adapted by various host OSes.  By directly integrating ACPICA, Linux can
+also benefit from the application experiences of ACPICA from other host
+OSes.
 
-   The homepage of ACPICA project is: www.acpica.org, it is maintained and
-   supported by Intel Corporation.
+The homepage of ACPICA project is: www.acpica.org, it is maintained and
+supported by Intel Corporation.
 
-   The following figure depicts the Linux ACPI subsystem where the ACPICA
-   adaptation is included:
+The following figure depicts the Linux ACPI subsystem where the ACPICA
+adaptation is included::
 
       +---------------------------------------------------------+
       |                                                         |
@@ -71,21 +75,27 @@ upstream.
 
                  Figure 1. Linux ACPI Software Components
 
-   NOTE:
+.. note::
     A. OS Service Layer - Provided by Linux to offer OS dependent
        implementation of the predefined ACPICA interfaces (acpi_os_*).
+       ::
+
          include/acpi/acpiosxf.h
          drivers/acpi/osl.c
          include/acpi/platform
          include/asm/acenv.h
     B. ACPICA Functionality - Released from ACPICA code base to offer
        OS independent implementation of the ACPICA interfaces (acpi_*).
+       ::
+
          drivers/acpi/acpica
          include/acpi/ac*.h
          tools/power/acpi
     C. Linux/ACPI Functionality - Providing Linux specific ACPI
        functionality to the other Linux kernel subsystems and user space
        programs.
+       ::
+
          drivers/acpi
          include/linux/acpi.h
          include/linux/acpi*.h
@@ -95,24 +105,27 @@ upstream.
        ACPI subsystem to offer architecture specific implementation of the
        ACPI interfaces.  They are Linux specific components and are out of
        the scope of this document.
+       ::
+
          include/asm/acpi.h
          include/asm/acpi*.h
          arch/*/acpi
 
-2. ACPICA Release
+ACPICA Release
+==============
 
-   The ACPICA project maintains its code base at the following repository URL:
-   https://github.com/acpica/acpica.git. As a rule, a release is made every
-   month.
+The ACPICA project maintains its code base at the following repository URL:
+https://github.com/acpica/acpica.git. As a rule, a release is made every
+month.
 
-   As the coding style adopted by the ACPICA project is not acceptable by
-   Linux, there is a release process to convert the ACPICA git commits into
-   Linux patches.  The patches generated by this process are referred to as
-   "linuxized ACPICA patches".  The release process is carried out on a local
-   copy the ACPICA git repository.  Each commit in the monthly release is
-   converted into a linuxized ACPICA patch.  Together, they form the monthly
-   ACPICA release patchset for the Linux ACPI community.  This process is
-   illustrated in the following figure:
+As the coding style adopted by the ACPICA project is not acceptable by
+Linux, there is a release process to convert the ACPICA git commits into
+Linux patches.  The patches generated by this process are referred to as
+"linuxized ACPICA patches".  The release process is carried out on a local
+copy the ACPICA git repository.  Each commit in the monthly release is
+converted into a linuxized ACPICA patch.  Together, they form the monthly
+ACPICA release patchset for the Linux ACPI community.  This process is
+illustrated in the following figure::
 
     +-----------------------------+
     | acpica / master (-) commits |
@@ -153,7 +166,7 @@ upstream.
 
                 Figure 2. ACPICA -> Linux Upstream Process
 
-   NOTE:
+.. note::
     A. Linuxize Utilities - Provided by the ACPICA repository, including a
        utility located in source/tools/acpisrc folder and a number of
        scripts located in generate/linux folder.
@@ -170,19 +183,20 @@ upstream.
    following kernel configuration options:
    CONFIG_ACPI/CONFIG_ACPI_DEBUG/CONFIG_ACPI_DEBUGGER
 
-3. ACPICA Divergences
+ACPICA Divergences
+==================
 
-   Ideally, all of the ACPICA commits should be converted into Linux patches
-   automatically without manual modifications, the "linux / master" tree should
-   contain the ACPICA code that exactly corresponds to the ACPICA code
-   contained in "new linuxized acpica" tree and it should be possible to run
-   the release process fully automatically.
+Ideally, all of the ACPICA commits should be converted into Linux patches
+automatically without manual modifications, the "linux / master" tree should
+contain the ACPICA code that exactly corresponds to the ACPICA code
+contained in "new linuxized acpica" tree and it should be possible to run
+the release process fully automatically.
 
-   As a matter of fact, however, there are source code differences between
-   the ACPICA code in Linux and the upstream ACPICA code, referred to as
-   "ACPICA Divergences".
+As a matter of fact, however, there are source code differences between
+the ACPICA code in Linux and the upstream ACPICA code, referred to as
+"ACPICA Divergences".
 
-   The various sources of ACPICA divergences include:
+The various sources of ACPICA divergences include:
    1. Legacy divergences - Before the current ACPICA release process was
       established, there already had been divergences between Linux and
       ACPICA. Over the past several years those divergences have been greatly
@@ -213,11 +227,12 @@ upstream.
       rebased on the ACPICA side in order to offer better solutions, new ACPICA
       divergences are generated.
 
-4. ACPICA Development
+ACPICA Development
+==================
 
-   This paragraph guides Linux developers to use the ACPICA upstream release
-   utilities to obtain Linux patches corresponding to upstream ACPICA commits
-   before they become available from the ACPICA release process.
+This paragraph guides Linux developers to use the ACPICA upstream release
+utilities to obtain Linux patches corresponding to upstream ACPICA commits
+before they become available from the ACPICA release process.
 
    1. Cherry-pick an ACPICA commit
 
@@ -225,7 +240,7 @@ upstream.
    you want to cherry pick must be committed into the local repository.
 
    Then the gen-patch.sh command can help to cherry-pick an ACPICA commit
-   from the ACPICA local repository:
+   from the ACPICA local repository::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -240,7 +255,7 @@ upstream.
    changes that haven't been applied to Linux yet.
 
    You can generate the ACPICA release series yourself and rebase your code on
-   top of the generated ACPICA release patches:
+   top of the generated ACPICA release patches::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -254,7 +269,7 @@ upstream.
    3. Inspect the current divergences
 
    If you have local copies of both Linux and upstream ACPICA, you can generate
-   a diff file indicating the state of the current divergences:
+   a diff file indicating the state of the current divergences::
 
    # git clone https://github.com/acpica/acpica
    # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1

