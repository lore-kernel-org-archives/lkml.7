Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D28C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B646F2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odq+wJNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfC1Q27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:28:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42844 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC1Q26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:28:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so11569679pfn.9;
        Thu, 28 Mar 2019 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7I6CyKKsm330aBih/4WGk5QcMYpSPVX/DKlL93W6Bw0=;
        b=Odq+wJNC07qNUIyzVvDYRxqzARb80aFhb03RIH/iYgyaWyYYhPRCJfOL2ovR5Q+rdh
         k3Q8JvvnzEJ0bCU2OKPdfRZxpFoifQhZc5wwycprA2kcZT6hfh7pzkGgz99F7N6WeQ7D
         k8G8+Lg+olY5qvX6Spg+SZelY9WLKlXxOa5izh+fGxZ9aj00KmZ59h/n+KH1K5RUYlgj
         AM1cvWFHm/3ETRnNotp0aDbaGQn+4QVK+Pde1rSRgGqNoVwQ5G2VSCOHTg8LH72Dlmqe
         9M8FpIpbICeoxl2f+TLcbwed/wjtHYmPbsAp8Np3VJbrHZbxSxZBUfnhCiUe72crnWxX
         UoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7I6CyKKsm330aBih/4WGk5QcMYpSPVX/DKlL93W6Bw0=;
        b=Prg8fDOVjk1/HwGddT2aEyehl5EAzW2WWl6wnyp96bzlkEXoPPB+0Jzfyr9kZEdDDI
         9YVFUDAXeWGys+mmT8iCYAVdSXcQGFNJdAu19Mv841BwORHjaSz8DzzgradepMF2ry6c
         +TEVnwYW+Ajnncl5SkOtfkUZJot5FTnozSgUFywCxW8D9LAM84XuDDSHfsfo+9oqvV+0
         OQIOcnL6XYSwKFpAccsv+SOmLu630Jei7IL/LCYdRpzSN4qwVoWOPciVhxxw+a6STJi5
         shOjnPfBeHZQqdXNqmZlGE6IzTW5vAWQUrqfQEh/mZhY6qafswxIwMn/WKyv2ZZlRoyY
         bJ4A==
X-Gm-Message-State: APjAAAVeLa2brscJUgvkDlNog69YS6gFYwbEAjmnqkhFta3xYt4NhfWL
        VKcCwN/4K8zmVb/WYEmBr/g=
X-Google-Smtp-Source: APXvYqyfDjwhI5itvcTgoqj046YzR0kr7+2a33Wr8WO6nqB24apchehHsMAKsX+c3F1kHN9Rac/cZQ==
X-Received: by 2002:aa7:938b:: with SMTP id t11mr34862671pfe.67.1553790536897;
        Thu, 28 Mar 2019 09:28:56 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:28:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 05/23] acpi doc: convert acpi/linuxized-acpica.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:03 +0800
Message-Id: <20190328162721.26138-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
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
 ...uxized-acpica.txt => linuxized-acpica.rst} | 114 ++++++++++--------
 2 files changed, 65 insertions(+), 50 deletions(-)
 rename Documentation/acpi/{linuxized-acpica.txt => linuxized-acpica.rst} (78%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 1b5459e46533..0ba63d0ec9c7 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -5,6 +5,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
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
index 3ad7b0dfb083..febafdbc5246 100644
--- a/Documentation/acpi/linuxized-acpica.txt
+++ b/Documentation/acpi/linuxized-acpica.rst
@@ -1,31 +1,34 @@
-Linuxized ACPICA - Introduction to ACPICA Release Automation
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
@@ -71,21 +74,27 @@ upstream.
 
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
@@ -95,24 +104,27 @@ upstream.
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
@@ -153,7 +165,7 @@ upstream.
 
                 Figure 2. ACPICA -> Linux Upstream Process
 
-   NOTE:
+.. note::
     A. Linuxize Utilities - Provided by the ACPICA repository, including a
        utility located in source/tools/acpisrc folder and a number of
        scripts located in generate/linux folder.
@@ -170,19 +182,20 @@ upstream.
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
@@ -213,11 +226,12 @@ upstream.
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
 
@@ -225,7 +239,7 @@ upstream.
    you want to cherry pick must be committed into the local repository.
 
    Then the gen-patch.sh command can help to cherry-pick an ACPICA commit
-   from the ACPICA local repository:
+   from the ACPICA local repository::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -240,7 +254,7 @@ upstream.
    changes that haven't been applied to Linux yet.
 
    You can generate the ACPICA release series yourself and rebase your code on
-   top of the generated ACPICA release patches:
+   top of the generated ACPICA release patches::
 
    $ git clone https://github.com/acpica/acpica
    $ cd acpica
@@ -254,7 +268,7 @@ upstream.
    3. Inspect the current divergences
 
    If you have local copies of both Linux and upstream ACPICA, you can generate
-   a diff file indicating the state of the current divergences:
+   a diff file indicating the state of the current divergences::
 
    # git clone https://github.com/acpica/acpica
    # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-- 
2.20.1

