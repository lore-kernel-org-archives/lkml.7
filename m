Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C5EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25EC2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJstlmFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfDZPeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:34:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41182 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfDZPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so1746961pls.8;
        Fri, 26 Apr 2019 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ao1k2Uh8U/LRDASbEEQCfw1kgyOffPMSmdg/Hjoj9fg=;
        b=YJstlmFf+uppi2wmqwvFurBeGphjmmqjfr2DLcoPB9fKFKxCJdTEGzGVjTlREx7dd+
         OacHdM66u1vlj2lNQvlWuAi33DJiEHRAVw6Bxb/yl0hDKEOKtpbGq1l9/za1JLTHyM39
         B/j+bhfCZ0OOeV9JcS2szAWbXTQwAsr+mG4sr9JP+OAa4K0fmyRDMGmIIZcwzZM/7Yy8
         7/hxHRQ+0EH4hDxRKXROUOPrcz+pOvIMFNtwudYaRBLKTsBYFJKb5ythCIF/ihfjA/O5
         ngh8ltO/u0pOtOirEFuvntZOImsPUdOciTJ4CjF561ilpwG32tUkbYelIaJs6qNVwUvJ
         pYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ao1k2Uh8U/LRDASbEEQCfw1kgyOffPMSmdg/Hjoj9fg=;
        b=Hk7dbO8Lzsl5rOm8zHfl51abK4w/rn7ZvC/biCcKkuCjFQi6t5ugWky0JK48B4eaGp
         U24S5QUvmOGVdEzwo6S1IdQnHQJ7Y7oes99fv3ig+n5yWx19+eSZBQMWTHr5SVhL9dxo
         SBZzDA/UQJKUBfzttMnq5tS8ag/UijOsO1OOgAeXcp+QBw1zPi9QRc+ni/KE5/wp/AaI
         LRnHxQSxvYUdSXpAn1Vl8KkUVLqMq0bPn9eDXOhiQkg1lPtHGaFD9MJ+XPf+aOfS39Tx
         QJfJLTHbRu7hrl3srCg7WAt/TFNXoZbgMMA/Gjcndx4jDJBVgMxRtswOCK10qe4pdcOi
         J5iA==
X-Gm-Message-State: APjAAAWcRPd1F10sjMdUkW1RWGQ3Ll+SImJXBvshRiLjBHFqBwA1L6H1
        /3qjJKhQCqLnFqY7X2oXLCg=
X-Google-Smtp-Source: APXvYqw0+yavpWLuAnKNZ2bGSUjdXIADD2Vh4j32jQxF5axuMILTAeNq9967/q5vL51iBsiY/9Loag==
X-Received: by 2002:a17:902:29e9:: with SMTP id h96mr27832008plb.258.1556292852215;
        Fri, 26 Apr 2019 08:34:12 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:34:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 20/27] Documentation: x86: convert i386/IO-APIC.txt to reST
Date:   Fri, 26 Apr 2019 23:31:43 +0800
Message-Id: <20190426153150.21228-21-changbin.du@gmail.com>
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
 .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     | 26 ++++++++++++-------
 Documentation/x86/i386/index.rst              | 10 +++++++
 Documentation/x86/index.rst                   |  1 +
 3 files changed, 27 insertions(+), 10 deletions(-)
 rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
 create mode 100644 Documentation/x86/i386/index.rst

diff --git a/Documentation/x86/i386/IO-APIC.txt b/Documentation/x86/i386/IO-APIC.rst
similarity index 93%
rename from Documentation/x86/i386/IO-APIC.txt
rename to Documentation/x86/i386/IO-APIC.rst
index 15f5baf7e1b6..aec98f742763 100644
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
@@ -13,7 +21,7 @@ usually worked around by the kernel. If your MP-compliant SMP board does
 not boot Linux, then consult the linux-smp mailing list archives first.
 
 If your box boots fine with enabled IO-APIC IRQs, then your
-/proc/interrupts will look like this one:
+/proc/interrupts will look like this one::
 
    ---------------------------->
   hell:~> cat /proc/interrupts
@@ -37,14 +45,14 @@ none of those IRQ sources is performance-critical.
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
@@ -56,7 +64,7 @@ lines):
      PIRQ1 ----| |-  `----| |-  `----| |-  `----| |--------| |
                `-'        `-'        `-'        `-'        `-'
 
-Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD:
+Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD::
 
                                ,-.
                          INTD--| |
@@ -78,19 +86,19 @@ to have non shared interrupts). Slot5 should be used for videocards, they
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
 
@@ -105,7 +113,7 @@ won't function properly (e.g. if it's inserted as a module).
 If you have 2 PCI buses, then you can use up to 8 pirq values, although such
 boards tend to have a good configuration.
 
-Be prepared that it might happen that you need some strange pirq line:
+Be prepared that it might happen that you need some strange pirq line::
 
 	append="pirq=0,0,0,0,0,0,9,11"
 
@@ -115,5 +123,3 @@ Good luck and mail to linux-smp@vger.kernel.org or
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
index 526f7a008b8e..19323c5b89ce 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -26,3 +26,4 @@ Linux x86 Support
    microcode
    resctrl_ui
    usb-legacy-support
+   i386/index
-- 
2.20.1

