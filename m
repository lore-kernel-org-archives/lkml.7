Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D534AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF292053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C24o8CPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfEFRLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:11:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38815 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfEFRLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:11:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so7107217pfo.5;
        Mon, 06 May 2019 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCYB/f33HOqS1mtaKEbHbUDuAOKpC4D6CXfqGMUJYqU=;
        b=C24o8CPRbC18JMUk0st8JZZM+Oo9ZmZzxB2zf3YEy8eGHyBykBfjlnRdMn/ZEm9FDW
         LWKxK4QFLnGTAc2suox9sTZmggoT3F2dJIfZ5Lzbd5ROc2ClnUxCHXbwhg6736G8KCHy
         YFCSlXrgXt7Yca6SN8X8nBhXNBJuxitVf/cBDQ4oYLRxCD+Z4/1u0y/XMF7e4YufOnu5
         oo1Abdn7MHxSl1f5v+kVCqb8BO2bJotwWWCyMPBQkQS+ZCaXh3+UttNX4C4MD7etU54j
         hJttQnhQqgR//W7X1I8EfPE1Qcl0cRGsnf8Eer2HAS6oa07EYls0Jb7lpLxGRX8BdNtp
         V2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCYB/f33HOqS1mtaKEbHbUDuAOKpC4D6CXfqGMUJYqU=;
        b=DQBrO1/ZJoXyiLcvtfRjQh4zgYz6ZlgYxAK6nV954WSNvfAj1ZFhsDI63LHMcwKDNN
         1ZhZb0RExcw0qW2mKnjcXd67o+i1cZNnvRAmw1z3j4xIPnk8BmnZNhxlFp7QCmuR89bj
         2McafLpL+srs9BhAgbQkQ2I7WjmexNe+XnxE/ll32KX7+EKi0DI2JqisjmnK/bFkUgQO
         LRvjbKWBJkOFVzW7IpSWkYO6kPWoRtL572sZItJuYuYQzqFv7O5ZL+aDT17T+043K/Uh
         9L6aXBWfnyQ2AZjdEVZAp/KIPUKp+/Ikq1bLADETyOUBGKOW5pEA5/Ur0WFRIX5/xy0i
         SppA==
X-Gm-Message-State: APjAAAVytemd9p045JXYLfLAQ0WyWi/Y+J2KlCtxTUgYgdtXZ1U/SiV/
        FSJccUMWM3NYwb6uEtCJuQQ=
X-Google-Smtp-Source: APXvYqyct+hgj0Chh90lABNCeTIeH5fjiyqYTSmD7stm4zR56ao3JfKD0WuHqHxe2M0ZPzOcxdGcew==
X-Received: by 2002:a63:610f:: with SMTP id v15mr33689825pgb.128.1557162693701;
        Mon, 06 May 2019 10:11:33 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.11.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:11:33 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 20/27] Documentation: x86: convert i386/IO-APIC.txt to reST
Date:   Tue,  7 May 2019 01:09:16 +0800
Message-Id: <20190506170923.7117-21-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506170923.7117-1-changbin.du@gmail.com>
References: <20190506170923.7117-1-changbin.du@gmail.com>
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

