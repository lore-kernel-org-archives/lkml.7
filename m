Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D6FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDAC208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtWIjLTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfDZPdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:33:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34249 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfDZPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:33:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so1918592pfd.1;
        Fri, 26 Apr 2019 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J17i3s9/yS9ONA7YnOqXaIB+lUc5Ou1Pz41sdMQ4ptI=;
        b=YtWIjLTRFfqdmTOgFT0U0M4v+Q919hYYvtAMDj2xnnboKNsUWCaCyvQq9qS09mj8lv
         Dww3vIhhEXTksxFXp3wcaHk8Rv6Krt4D6PHuu87CCF6VNOrgi/pS9czJDaSx+sHS2g2y
         NtiENKmDlNRBShnesFBX0y63yTIxsUEF+xX8/wsypOGsIx550XKxh33UMAL1hRS7rP5D
         7boNrl9axAaFK6NqQJ6WqbQZm+phsQkY4hn2HGV9s10x3yyrQXMdbfa51CF1ZW0xTuv+
         KXXqfdUloOvB8/v8I8n9ayo0aeWJU8UkAPpMd2cf88BMJ5PP/iNiJHA1pkrhImr59mWT
         lJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J17i3s9/yS9ONA7YnOqXaIB+lUc5Ou1Pz41sdMQ4ptI=;
        b=b0LbXrozsXAzCZZPsASZmNnBSbOKPCQmDk8lCk3SD4aEGkAwR2GsRoxShBWQPJtcc6
         dnL5OUzaxqBO411j1tyUAkYTSGwDfEj1+wQMbD+0bj+HRTjMQkXaV9WjpOeGhZU9pLlZ
         rqwcS1TZ8YOI0Ek2oyJGFYWX5366sPl1o0xgqEXVJkV0szBuqNq4uRS1k4EgZ9mkw0zW
         dXnXeZgv4LY00buVNGu4xnpakqtpSOjOXjiY1lQiN49IMLfAhvBiwvbO3d3oepdDTFKv
         bkU7CNQA126fRWfETAjrE/LckcOA33lBABLaDITEkw8LLCJ7xFfPSm1eWWJkCuOUbXaQ
         NwVw==
X-Gm-Message-State: APjAAAUYzWOe17zw90lDEfC8zFNJIDWFAkzpWPUEqPc2swsOVPNW++2G
        QIIYskYXqugBblWt2duat8U=
X-Google-Smtp-Source: APXvYqyxu5Vqu4eXXXs1J7UiGRwzjH+SYdAIFT/IqcutJ9lf7MSUCVyIrqX+oQ7PG1OrUKXc+8xumg==
X-Received: by 2002:a65:43c3:: with SMTP id n3mr44148743pgp.375.1556292786598;
        Fri, 26 Apr 2019 08:33:06 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:33:05 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 10/27] Documentation: x86: convert mtrr.txt to reST
Date:   Fri, 26 Apr 2019 23:31:33 +0800
Message-Id: <20190426153150.21228-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
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
 Documentation/x86/index.rst |   1 +
 Documentation/x86/mtrr.rst  | 350 ++++++++++++++++++++++++++++++++++++
 Documentation/x86/mtrr.txt  | 329 ---------------------------------
 3 files changed, 351 insertions(+), 329 deletions(-)
 create mode 100644 Documentation/x86/mtrr.rst
 delete mode 100644 Documentation/x86/mtrr.txt

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index fd54b859db9b..d805962a7238 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -16,3 +16,4 @@ Linux x86 Support
    earlyprintk
    zero-page
    tlb
+   mtrr
diff --git a/Documentation/x86/mtrr.rst b/Documentation/x86/mtrr.rst
new file mode 100644
index 000000000000..72da61022861
--- /dev/null
+++ b/Documentation/x86/mtrr.rst
@@ -0,0 +1,350 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+MTRR (Memory Type Range Register) control
+=========================================
+
+:Ahthors: - Richard Gooch <rgooch@atnf.csiro.au> - 3 Jun 1999
+          - Luis R. Rodriguez <mcgrof@do-not-panic.com> - April 9, 2015
+
+
+Phasing out MTRR use
+====================
+
+MTRR use is replaced on modern x86 hardware with PAT. Direct MTRR use by
+drivers on Linux is now completely phased out, device drivers should use
+arch_phys_wc_add() in combination with ioremap_wc() to make MTRR effective on
+non-PAT systems while a no-op but equally effective on PAT enabled systems.
+
+Even if Linux does not use MTRRs directly, some x86 platform firmware may still
+set up MTRRs early before booting the OS. They do this as some platform
+firmware may still have implemented access to MTRRs which would be controlled
+and handled by the platform firmware directly. An example of platform use of
+MTRRs is through the use of SMI handlers, one case could be for fan control,
+the platform code would need uncachable access to some of its fan control
+registers. Such platform access does not need any Operating System MTRR code in
+place other than mtrr_type_lookup() to ensure any OS specific mapping requests
+are aligned with platform MTRR setup. If MTRRs are only set up by the platform
+firmware code though and the OS does not make any specific MTRR mapping
+requests mtrr_type_lookup() should always return MTRR_TYPE_INVALID.
+
+For details refer to :doc:`x86/pat`.
+
+On Intel P6 family processors (Pentium Pro, Pentium II and later)
+the Memory Type Range Registers (MTRRs) may be used to control
+processor access to memory ranges. This is most useful when you have
+a video (VGA) card on a PCI or AGP bus. Enabling write-combining
+allows bus write transfers to be combined into a larger transfer
+before bursting over the PCI/AGP bus. This can increase performance
+of image write operations 2.5 times or more.
+
+The Cyrix 6x86, 6x86MX and M II processors have Address Range
+Registers (ARRs) which provide a similar functionality to MTRRs. For
+these, the ARRs are used to emulate the MTRRs.
+
+The AMD K6-2 (stepping 8 and above) and K6-3 processors have two
+MTRRs. These are supported.  The AMD Athlon family provide 8 Intel
+style MTRRs.
+
+The Centaur C6 (WinChip) has 8 MCRs, allowing write-combining. These
+are supported.
+
+The VIA Cyrix III and VIA C3 CPUs offer 8 Intel style MTRRs.
+
+The CONFIG_MTRR option creates a /proc/mtrr file which may be used
+to manipulate your MTRRs. Typically the X server should use
+this. This should have a reasonably generic interface so that
+similar control registers on other processors can be easily
+supported.
+
+There are two interfaces to /proc/mtrr: one is an ASCII interface
+which allows you to read and write. The other is an ioctl()
+interface. The ASCII interface is meant for administration. The
+ioctl() interface is meant for C programs (i.e. the X server). The
+interfaces are described below, with sample commands and C code.
+
+Reading MTRRs from the shell::
+
+  % cat /proc/mtrr
+  reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
+  reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
+
+Creating MTRRs from the C-shell::
+
+  # echo "base=0xf8000000 size=0x400000 type=write-combining" >! /proc/mtrr
+
+or if you use bash::
+
+  # echo "base=0xf8000000 size=0x400000 type=write-combining" >| /proc/mtrr
+
+And the result thereof::
+
+  % cat /proc/mtrr
+  reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
+  reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
+  reg02: base=0xf8000000 (3968MB), size=   4MB: write-combining, count=1
+
+This is for video RAM at base address 0xf8000000 and size 4 megabytes. To
+find out your base address, you need to look at the output of your X
+server, which tells you where the linear framebuffer address is. A
+typical line that you may get is:
+
+(--) S3: PCI: 968 rev 0, Linear FB @ 0xf8000000
+
+Note that you should only use the value from the X server, as it may
+move the framebuffer base address, so the only value you can trust is
+that reported by the X server.
+
+To find out the size of your framebuffer (what, you don't actually
+know?), the following line will tell you:
+
+(--) S3: videoram:  4096k
+
+That's 4 megabytes, which is 0x400000 bytes (in hexadecimal).
+A patch is being written for XFree86 which will make this automatic:
+in other words the X server will manipulate /proc/mtrr using the
+ioctl() interface, so users won't have to do anything. If you use a
+commercial X server, lobby your vendor to add support for MTRRs.
+
+
+Creating overlapping MTRRs
+==========================
+::
+
+  %echo "base=0xfb000000 size=0x1000000 type=write-combining" >/proc/mtrr
+  %echo "base=0xfb000000 size=0x1000 type=uncachable" >/proc/mtrr
+
+And the results::
+
+  % cat /proc/mtrr
+  reg00: base=0x00000000 (   0MB), size=  64MB: write-back, count=1
+  reg01: base=0xfb000000 (4016MB), size=  16MB: write-combining, count=1
+  reg02: base=0xfb000000 (4016MB), size=   4kB: uncachable, count=1
+
+Some cards (especially Voodoo Graphics boards) need this 4 kB area
+excluded from the beginning of the region because it is used for
+registers.
+
+NOTE: You can only create type=uncachable region, if the first
+region that you created is type=write-combining.
+
+
+Removing MTRRs from the C-shel
+==============================
+::
+
+  % echo "disable=2" >! /proc/mtrr
+
+or using bash::
+
+  % echo "disable=2" >| /proc/mtrr
+
+
+Reading MTRRs from a C program using ioctl()'s
+==============================================
+::
+
+  /*  mtrr-show.c
+
+      Source file for mtrr-show (example program to show MTRRs using ioctl()'s)
+
+      Copyright (C) 1997-1998  Richard Gooch
+
+      This program is free software; you can redistribute it and/or modify
+      it under the terms of the GNU General Public License as published by
+      the Free Software Foundation; either version 2 of the License, or
+      (at your option) any later version.
+
+      This program is distributed in the hope that it will be useful,
+      but WITHOUT ANY WARRANTY; without even the implied warranty of
+      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+      GNU General Public License for more details.
+
+      You should have received a copy of the GNU General Public License
+      along with this program; if not, write to the Free Software
+      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+      Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
+      The postal address is:
+        Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
+  */
+
+  /*
+      This program will use an ioctl() on /proc/mtrr to show the current MTRR
+      settings. This is an alternative to reading /proc/mtrr.
+
+
+      Written by      Richard Gooch   17-DEC-1997
+
+      Last updated by Richard Gooch   2-MAY-1998
+
+
+  */
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <string.h>
+  #include <sys/types.h>
+  #include <sys/stat.h>
+  #include <fcntl.h>
+  #include <sys/ioctl.h>
+  #include <errno.h>
+  #include <asm/mtrr.h>
+
+  #define TRUE 1
+  #define FALSE 0
+  #define ERRSTRING strerror (errno)
+
+  static char *mtrr_strings[MTRR_NUM_TYPES] =
+  {
+      "uncachable",               /* 0 */
+      "write-combining",          /* 1 */
+      "?",                        /* 2 */
+      "?",                        /* 3 */
+      "write-through",            /* 4 */
+      "write-protect",            /* 5 */
+      "write-back",               /* 6 */
+  };
+
+  int main ()
+  {
+      int fd;
+      struct mtrr_gentry gentry;
+
+      if ( ( fd = open ("/proc/mtrr", O_RDONLY, 0) ) == -1 )
+      {
+    if (errno == ENOENT)
+    {
+        fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
+        stderr);
+        exit (1);
+    }
+    fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
+    exit (2);
+      }
+      for (gentry.regnum = 0; ioctl (fd, MTRRIOC_GET_ENTRY, &gentry) == 0;
+    ++gentry.regnum)
+      {
+    if (gentry.size < 1)
+    {
+        fprintf (stderr, "Register: %u disabled\n", gentry.regnum);
+        continue;
+    }
+    fprintf (stderr, "Register: %u base: 0x%lx size: 0x%lx type: %s\n",
+      gentry.regnum, gentry.base, gentry.size,
+      mtrr_strings[gentry.type]);
+      }
+      if (errno == EINVAL) exit (0);
+      fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
+      exit (3);
+  }   /*  End Function main  */
+
+
+Creating MTRRs from a C programme using ioctl()'s
+=================================================
+::
+
+  /*  mtrr-add.c
+
+      Source file for mtrr-add (example programme to add an MTRRs using ioctl())
+
+      Copyright (C) 1997-1998  Richard Gooch
+
+      This program is free software; you can redistribute it and/or modify
+      it under the terms of the GNU General Public License as published by
+      the Free Software Foundation; either version 2 of the License, or
+      (at your option) any later version.
+
+      This program is distributed in the hope that it will be useful,
+      but WITHOUT ANY WARRANTY; without even the implied warranty of
+      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+      GNU General Public License for more details.
+
+      You should have received a copy of the GNU General Public License
+      along with this program; if not, write to the Free Software
+      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+      Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
+      The postal address is:
+        Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
+  */
+
+  /*
+      This programme will use an ioctl() on /proc/mtrr to add an entry. The first
+      available mtrr is used. This is an alternative to writing /proc/mtrr.
+
+
+      Written by      Richard Gooch   17-DEC-1997
+
+      Last updated by Richard Gooch   2-MAY-1998
+
+
+  */
+  #include <stdio.h>
+  #include <string.h>
+  #include <stdlib.h>
+  #include <unistd.h>
+  #include <sys/types.h>
+  #include <sys/stat.h>
+  #include <fcntl.h>
+  #include <sys/ioctl.h>
+  #include <errno.h>
+  #include <asm/mtrr.h>
+
+  #define TRUE 1
+  #define FALSE 0
+  #define ERRSTRING strerror (errno)
+
+  static char *mtrr_strings[MTRR_NUM_TYPES] =
+  {
+      "uncachable",               /* 0 */
+      "write-combining",          /* 1 */
+      "?",                        /* 2 */
+      "?",                        /* 3 */
+      "write-through",            /* 4 */
+      "write-protect",            /* 5 */
+      "write-back",               /* 6 */
+  };
+
+  int main (int argc, char **argv)
+  {
+      int fd;
+      struct mtrr_sentry sentry;
+
+      if (argc != 4)
+      {
+    fprintf (stderr, "Usage:\tmtrr-add base size type\n");
+    exit (1);
+      }
+      sentry.base = strtoul (argv[1], NULL, 0);
+      sentry.size = strtoul (argv[2], NULL, 0);
+      for (sentry.type = 0; sentry.type < MTRR_NUM_TYPES; ++sentry.type)
+      {
+    if (strcmp (argv[3], mtrr_strings[sentry.type]) == 0) break;
+      }
+      if (sentry.type >= MTRR_NUM_TYPES)
+      {
+    fprintf (stderr, "Illegal type: \"%s\"\n", argv[3]);
+    exit (2);
+      }
+      if ( ( fd = open ("/proc/mtrr", O_WRONLY, 0) ) == -1 )
+      {
+    if (errno == ENOENT)
+    {
+        fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
+        stderr);
+        exit (3);
+    }
+    fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
+    exit (4);
+      }
+      if (ioctl (fd, MTRRIOC_ADD_ENTRY, &sentry) == -1)
+      {
+    fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
+    exit (5);
+      }
+      fprintf (stderr, "Sleeping for 5 seconds so you can see the new entry\n");
+      sleep (5);
+      close (fd);
+      fputs ("I've just closed /proc/mtrr so now the new entry should be gone\n",
+      stderr);
+  }   /*  End Function main  */
diff --git a/Documentation/x86/mtrr.txt b/Documentation/x86/mtrr.txt
deleted file mode 100644
index dc3e703913ac..000000000000
--- a/Documentation/x86/mtrr.txt
+++ /dev/null
@@ -1,329 +0,0 @@
-MTRR (Memory Type Range Register) control
-
-Richard Gooch <rgooch@atnf.csiro.au> - 3 Jun 1999
-Luis R. Rodriguez <mcgrof@do-not-panic.com> - April 9, 2015
-
-===============================================================================
-Phasing out MTRR use
-
-MTRR use is replaced on modern x86 hardware with PAT. Direct MTRR use by
-drivers on Linux is now completely phased out, device drivers should use
-arch_phys_wc_add() in combination with ioremap_wc() to make MTRR effective on
-non-PAT systems while a no-op but equally effective on PAT enabled systems.
-
-Even if Linux does not use MTRRs directly, some x86 platform firmware may still
-set up MTRRs early before booting the OS. They do this as some platform
-firmware may still have implemented access to MTRRs which would be controlled
-and handled by the platform firmware directly. An example of platform use of
-MTRRs is through the use of SMI handlers, one case could be for fan control,
-the platform code would need uncachable access to some of its fan control
-registers. Such platform access does not need any Operating System MTRR code in
-place other than mtrr_type_lookup() to ensure any OS specific mapping requests
-are aligned with platform MTRR setup. If MTRRs are only set up by the platform
-firmware code though and the OS does not make any specific MTRR mapping
-requests mtrr_type_lookup() should always return MTRR_TYPE_INVALID.
-
-For details refer to Documentation/x86/pat.txt.
-
-===============================================================================
-
-  On Intel P6 family processors (Pentium Pro, Pentium II and later)
-  the Memory Type Range Registers (MTRRs) may be used to control
-  processor access to memory ranges. This is most useful when you have
-  a video (VGA) card on a PCI or AGP bus. Enabling write-combining
-  allows bus write transfers to be combined into a larger transfer
-  before bursting over the PCI/AGP bus. This can increase performance
-  of image write operations 2.5 times or more.
-
-  The Cyrix 6x86, 6x86MX and M II processors have Address Range
-  Registers (ARRs) which provide a similar functionality to MTRRs. For
-  these, the ARRs are used to emulate the MTRRs.
-
-  The AMD K6-2 (stepping 8 and above) and K6-3 processors have two
-  MTRRs. These are supported.  The AMD Athlon family provide 8 Intel
-  style MTRRs.
-
-  The Centaur C6 (WinChip) has 8 MCRs, allowing write-combining. These
-  are supported.
-
-  The VIA Cyrix III and VIA C3 CPUs offer 8 Intel style MTRRs.
-
-  The CONFIG_MTRR option creates a /proc/mtrr file which may be used
-  to manipulate your MTRRs. Typically the X server should use
-  this. This should have a reasonably generic interface so that
-  similar control registers on other processors can be easily
-  supported.
-
-
-There are two interfaces to /proc/mtrr: one is an ASCII interface
-which allows you to read and write. The other is an ioctl()
-interface. The ASCII interface is meant for administration. The
-ioctl() interface is meant for C programs (i.e. the X server). The
-interfaces are described below, with sample commands and C code.
-
-===============================================================================
-Reading MTRRs from the shell:
-
-% cat /proc/mtrr
-reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
-reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
-===============================================================================
-Creating MTRRs from the C-shell:
-# echo "base=0xf8000000 size=0x400000 type=write-combining" >! /proc/mtrr
-or if you use bash:
-# echo "base=0xf8000000 size=0x400000 type=write-combining" >| /proc/mtrr
-
-And the result thereof:
-% cat /proc/mtrr
-reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
-reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
-reg02: base=0xf8000000 (3968MB), size=   4MB: write-combining, count=1
-
-This is for video RAM at base address 0xf8000000 and size 4 megabytes. To
-find out your base address, you need to look at the output of your X
-server, which tells you where the linear framebuffer address is. A
-typical line that you may get is:
-
-(--) S3: PCI: 968 rev 0, Linear FB @ 0xf8000000
-
-Note that you should only use the value from the X server, as it may
-move the framebuffer base address, so the only value you can trust is
-that reported by the X server.
-
-To find out the size of your framebuffer (what, you don't actually
-know?), the following line will tell you:
-
-(--) S3: videoram:  4096k
-
-That's 4 megabytes, which is 0x400000 bytes (in hexadecimal).
-A patch is being written for XFree86 which will make this automatic:
-in other words the X server will manipulate /proc/mtrr using the
-ioctl() interface, so users won't have to do anything. If you use a
-commercial X server, lobby your vendor to add support for MTRRs.
-===============================================================================
-Creating overlapping MTRRs:
-
-%echo "base=0xfb000000 size=0x1000000 type=write-combining" >/proc/mtrr
-%echo "base=0xfb000000 size=0x1000 type=uncachable" >/proc/mtrr
-
-And the results: cat /proc/mtrr
-reg00: base=0x00000000 (   0MB), size=  64MB: write-back, count=1
-reg01: base=0xfb000000 (4016MB), size=  16MB: write-combining, count=1
-reg02: base=0xfb000000 (4016MB), size=   4kB: uncachable, count=1
-
-Some cards (especially Voodoo Graphics boards) need this 4 kB area
-excluded from the beginning of the region because it is used for
-registers.
-
-NOTE: You can only create type=uncachable region, if the first
-region that you created is type=write-combining.
-===============================================================================
-Removing MTRRs from the C-shell:
-% echo "disable=2" >! /proc/mtrr
-or using bash:
-% echo "disable=2" >| /proc/mtrr
-===============================================================================
-Reading MTRRs from a C program using ioctl()'s:
-
-/*  mtrr-show.c
-
-    Source file for mtrr-show (example program to show MTRRs using ioctl()'s)
-
-    Copyright (C) 1997-1998  Richard Gooch
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
-    The postal address is:
-      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
-*/
-
-/*
-    This program will use an ioctl() on /proc/mtrr to show the current MTRR
-    settings. This is an alternative to reading /proc/mtrr.
-
-
-    Written by      Richard Gooch   17-DEC-1997
-
-    Last updated by Richard Gooch   2-MAY-1998
-
-
-*/
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <errno.h>
-#include <asm/mtrr.h>
-
-#define TRUE 1
-#define FALSE 0
-#define ERRSTRING strerror (errno)
-
-static char *mtrr_strings[MTRR_NUM_TYPES] =
-{
-    "uncachable",               /* 0 */
-    "write-combining",          /* 1 */
-    "?",                        /* 2 */
-    "?",                        /* 3 */
-    "write-through",            /* 4 */
-    "write-protect",            /* 5 */
-    "write-back",               /* 6 */
-};
-
-int main ()
-{
-    int fd;
-    struct mtrr_gentry gentry;
-
-    if ( ( fd = open ("/proc/mtrr", O_RDONLY, 0) ) == -1 )
-    {
-	if (errno == ENOENT)
-	{
-	    fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
-		   stderr);
-	    exit (1);
-	}
-	fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
-	exit (2);
-    }
-    for (gentry.regnum = 0; ioctl (fd, MTRRIOC_GET_ENTRY, &gentry) == 0;
-	 ++gentry.regnum)
-    {
-	if (gentry.size < 1)
-	{
-	    fprintf (stderr, "Register: %u disabled\n", gentry.regnum);
-	    continue;
-	}
-	fprintf (stderr, "Register: %u base: 0x%lx size: 0x%lx type: %s\n",
-		 gentry.regnum, gentry.base, gentry.size,
-		 mtrr_strings[gentry.type]);
-    }
-    if (errno == EINVAL) exit (0);
-    fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
-    exit (3);
-}   /*  End Function main  */
-===============================================================================
-Creating MTRRs from a C programme using ioctl()'s:
-
-/*  mtrr-add.c
-
-    Source file for mtrr-add (example programme to add an MTRRs using ioctl())
-
-    Copyright (C) 1997-1998  Richard Gooch
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
-    The postal address is:
-      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
-*/
-
-/*
-    This programme will use an ioctl() on /proc/mtrr to add an entry. The first
-    available mtrr is used. This is an alternative to writing /proc/mtrr.
-
-
-    Written by      Richard Gooch   17-DEC-1997
-
-    Last updated by Richard Gooch   2-MAY-1998
-
-
-*/
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <errno.h>
-#include <asm/mtrr.h>
-
-#define TRUE 1
-#define FALSE 0
-#define ERRSTRING strerror (errno)
-
-static char *mtrr_strings[MTRR_NUM_TYPES] =
-{
-    "uncachable",               /* 0 */
-    "write-combining",          /* 1 */
-    "?",                        /* 2 */
-    "?",                        /* 3 */
-    "write-through",            /* 4 */
-    "write-protect",            /* 5 */
-    "write-back",               /* 6 */
-};
-
-int main (int argc, char **argv)
-{
-    int fd;
-    struct mtrr_sentry sentry;
-
-    if (argc != 4)
-    {
-	fprintf (stderr, "Usage:\tmtrr-add base size type\n");
-	exit (1);
-    }
-    sentry.base = strtoul (argv[1], NULL, 0);
-    sentry.size = strtoul (argv[2], NULL, 0);
-    for (sentry.type = 0; sentry.type < MTRR_NUM_TYPES; ++sentry.type)
-    {
-	if (strcmp (argv[3], mtrr_strings[sentry.type]) == 0) break;
-    }
-    if (sentry.type >= MTRR_NUM_TYPES)
-    {
-	fprintf (stderr, "Illegal type: \"%s\"\n", argv[3]);
-	exit (2);
-    }
-    if ( ( fd = open ("/proc/mtrr", O_WRONLY, 0) ) == -1 )
-    {
-	if (errno == ENOENT)
-	{
-	    fputs ("/proc/mtrr not found: not supported or you don't have a PPro?\n",
-		   stderr);
-	    exit (3);
-	}
-	fprintf (stderr, "Error opening /proc/mtrr\t%s\n", ERRSTRING);
-	exit (4);
-    }
-    if (ioctl (fd, MTRRIOC_ADD_ENTRY, &sentry) == -1)
-    {
-	fprintf (stderr, "Error doing ioctl(2) on /dev/mtrr\t%s\n", ERRSTRING);
-	exit (5);
-    }
-    fprintf (stderr, "Sleeping for 5 seconds so you can see the new entry\n");
-    sleep (5);
-    close (fd);
-    fputs ("I've just closed /proc/mtrr so now the new entry should be gone\n",
-	   stderr);
-}   /*  End Function main  */
-===============================================================================
-- 
2.20.1

