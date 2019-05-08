Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAC3C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAC620644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srUvp3Lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfEHPYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:24:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44249 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfEHPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:24:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so10253524pgv.11;
        Wed, 08 May 2019 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCYB/f33HOqS1mtaKEbHbUDuAOKpC4D6CXfqGMUJYqU=;
        b=srUvp3LtgKq85JMDYD6pr+dwCS6e7Y9Ml962vYuWOHRk7wyjmlhomUK2MaD6vwoJda
         TdoocmEV7pxCGLwjLdJtg4XmpvdjDt86aZIG6q426CzBj5J7nMxGaXJ+hqMT5llftWAf
         YAf17FKytvmiYikqojFB4amjKd1RsB0Gh5AYL3yROsLekkUm9gmVcARLE0TY0lxvdTpa
         5xRWW4NkBDUB62Hy5BY92kRloVcWYNFnclsce1zrjdD1k06k8CIuhDxFA6hWqcwFy8n6
         XGe9Ry0xOWYGo1qAgV1dhmZPsu8mSqBIkv8iDboTD+ysPaVtnV71MbUh/xjG8Tl4ddqj
         KvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCYB/f33HOqS1mtaKEbHbUDuAOKpC4D6CXfqGMUJYqU=;
        b=aVOvWgZy2z9+Yl8QWcJlmseiBrqTGM9c3KFJATBae40vrV111pKHbO98UUhpmybjJk
         4HHyyYfmEXXJYnoZg3KU8rNOKTbezrQOrcE0IS4Pa+fCZPJXOHAmQiM/h2FFjlga8KK0
         dhqcg1iaHb3OG3bguDRXcjGVOwkY6W0pL8xZBJr7fxRKeAXnbGpfKKR4vV72OXhmeLMq
         Mf2y0tf7hWTsnPkVCfBFitpBXChIBEHM/ZZeRM49canlJ6Gpc1OHfJ2sFHYSv08mYAEi
         I+MBPI2OhSslT8xI+sLqviuXTufKa4lLpuHpdh9eV1S0hUVzJGI4K4OJLqjmAi4Ss0f5
         kAkA==
X-Gm-Message-State: APjAAAX9pouIbYV3iqe+X3L2rMowVOyBCgadcjeAak8iwJKUETD9g8aV
        dzSytNwMC92hlCOfeMLhDbg=
X-Google-Smtp-Source: APXvYqwt9zwGY4ExXFtvmzx0GcX6FCi1ny7cNlPZ2P+4HC+fFSJcvXb2ztnkWLKBCOodlrRVY71eVg==
X-Received: by 2002:a63:9dc8:: with SMTP id i191mr46537137pgd.91.1557329047990;
        Wed, 08 May 2019 08:24:07 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.24.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:24:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 20/27] Documentation: x86: convert i386/IO-APIC.txt to reST
Date:   Wed,  8 May 2019 23:21:34 +0800
Message-Id: <20190508152141.8740-21-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
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
 .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     | 28 +++++++++++--------
 Documentation/x86/i386/index.rst              | 10 +++++++
 Documentation/x86/index.rst                   |  1 +
 3 files changed, 27 insertions(+), 12 deletions(-)
 rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
 create mode 100644 Documentation/x86/i386/index.rst

diff --git a/Documentation/x86/i386/IO-APIC.txt b/Documentation/x86/i386/IO-APIC.rst
similarity index 93%
rename from Documentation/x86/i386/IO-APIC.txt
rename to Documentation/x86/i386/IO-APIC.rst
index 15f5baf7e1b6..ce4d8df15e7c 100644
--- a/Documentation/x86/i386/IO-APIC.txt
+++ b/Documentation/x86/i386/IO-APIC.rst
@@ -1,3 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+IO-APIC
+=======
+
+:Author: Ingo Molnar <mingo@kernel.org>
+
 Most (all) Intel-MP compliant SMP boards have the so-called 'IO-APIC',
 which is an enhanced interrupt controller. It enables us to route
 hardware interrupts to multiple CPUs, or to CPU groups. Without an
@@ -13,9 +21,8 @@ usually worked around by the kernel. If your MP-compliant SMP board does
 not boot Linux, then consult the linux-smp mailing list archives first.
 
 If your box boots fine with enabled IO-APIC IRQs, then your
-/proc/interrupts will look like this one:
+/proc/interrupts will look like this one::
 
-   ---------------------------->
   hell:~> cat /proc/interrupts
              CPU0
     0:    1360293    IO-APIC-edge  timer
@@ -28,7 +35,6 @@ If your box boots fine with enabled IO-APIC IRQs, then your
   NMI:          0
   ERR:          0
   hell:~>
-  <----------------------------
 
 Some interrupts are still listed as 'XT PIC', but this is not a problem;
 none of those IRQ sources is performance-critical.
@@ -37,14 +43,14 @@ none of those IRQ sources is performance-critical.
 In the unlikely case that your board does not create a working mp-table,
 you can use the pirq= boot parameter to 'hand-construct' IRQ entries. This
 is non-trivial though and cannot be automated. One sample /etc/lilo.conf
-entry:
+entry::
 
 	append="pirq=15,11,10"
 
 The actual numbers depend on your system, on your PCI cards and on their
 PCI slot position. Usually PCI slots are 'daisy chained' before they are
 connected to the PCI chipset IRQ routing facility (the incoming PIRQ1-4
-lines):
+lines)::
 
                ,-.        ,-.        ,-.        ,-.        ,-.
      PIRQ4 ----| |-.    ,-| |-.    ,-| |-.    ,-| |--------| |
@@ -56,7 +62,7 @@ lines):
      PIRQ1 ----| |-  `----| |-  `----| |-  `----| |--------| |
                `-'        `-'        `-'        `-'        `-'
 
-Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD:
+Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD::
 
                                ,-.
                          INTD--| |
@@ -78,19 +84,19 @@ to have non shared interrupts). Slot5 should be used for videocards, they
 do not use interrupts normally, thus they are not daisy chained either.
 
 so if you have your SCSI card (IRQ11) in Slot1, Tulip card (IRQ9) in
-Slot2, then you'll have to specify this pirq= line:
+Slot2, then you'll have to specify this pirq= line::
 
 	append="pirq=11,9"
 
 the following script tries to figure out such a default pirq= line from
-your PCI configuration:
+your PCI configuration::
 
 	echo -n pirq=; echo `scanpci | grep T_L | cut -c56-` | sed 's/ /,/g'
 
 note that this script won't work if you have skipped a few slots or if your
 board does not do default daisy-chaining. (or the IO-APIC has the PIRQ pins
 connected in some strange way). E.g. if in the above case you have your SCSI
-card (IRQ11) in Slot3, and have Slot1 empty:
+card (IRQ11) in Slot3, and have Slot1 empty::
 
 	append="pirq=0,9,11"
 
@@ -105,7 +111,7 @@ won't function properly (e.g. if it's inserted as a module).
 If you have 2 PCI buses, then you can use up to 8 pirq values, although such
 boards tend to have a good configuration.
 
-Be prepared that it might happen that you need some strange pirq line:
+Be prepared that it might happen that you need some strange pirq line::
 
 	append="pirq=0,0,0,0,0,0,9,11"
 
@@ -115,5 +121,3 @@ Good luck and mail to linux-smp@vger.kernel.org or
 linux-kernel@vger.kernel.org if you have any problems that are not covered
 by this document.
 
--- mingo
-
diff --git a/Documentation/x86/i386/index.rst b/Documentation/x86/i386/index.rst
new file mode 100644
index 000000000000..8747cf5bbd49
--- /dev/null
+++ b/Documentation/x86/i386/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+i386 Support
+============
+
+.. toctree::
+   :maxdepth: 2
+
+   IO-APIC
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 3eb0334ae2d4..4e15bcc6456c 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -26,3 +26,4 @@ x86-specific Documentation
    microcode
    resctrl_ui
    usb-legacy-support
+   i386/index
-- 
2.20.1

