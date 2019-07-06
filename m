Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1891EC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF3B20843
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="V9Srk96l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGFVi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 17:38:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36080 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfGFViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 17:38:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so12349737ljj.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjzJT+Ug2ljIH+eSeawQbtkAq5PwdGtNp/nTgDIdoFk=;
        b=V9Srk96lJmI+I1DCntkuM0AyIq6ydmZa6ScG2spce+9ttK+z+1D2dTgtpJneKqad4I
         1nm+O2GigCPMFDUSH8SIoQGioEnFRp/zcGYh4LhMc1Gk+7+JHELYRDCNQDJr3T9lH60t
         MftEk/rwA+slBTfPUjj/GdK83sD+mvFMftQQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjzJT+Ug2ljIH+eSeawQbtkAq5PwdGtNp/nTgDIdoFk=;
        b=QybCQq+Z+OllREN5Kvh333ddNDNBAbXqrEeaQYfE5jUP4wFEDBLygFDpntZyKGDrfj
         qAVbiDf02wGh/bWJwGKGXaTzwCtqPDfkmeA64S2ybIj2dOULPdj5ZdmCIDTOxZtpgBk8
         N8r8RoQyhDyuW2I593udmzW4tF6A3CqB0kAI/6wxIrXJYSYHY0BBO7HZMRCweWuiyX8G
         lALweff38eGBiKGxpQLtYxrZ/3CHfoxdaw0R7kgsEEKa49ePkrCNOOBqZK4QatAEad2P
         aMWRFU4DDf/j5Yl6xG5pweYv+SdwLf9XqePLY5VS2YvBIp9GiYknfDj+zcwZOY0BN9OO
         1Ktg==
X-Gm-Message-State: APjAAAXJ1w8SZopC5CaBL7VxI7N5M0UamrDewstbv+VIwwA/puxA3+1i
        HGev+kcS+hdqk29wpvG9qRKXLg==
X-Google-Smtp-Source: APXvYqw3xRdjUvkdGLRSIcoY1bNsDkHY0zejAiAFzDMTkZ32HpoDR4zyyPJfjAlDbxXYX8e/J5l7jA==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr5659575ljk.90.1562449132999;
        Sat, 06 Jul 2019 14:38:52 -0700 (PDT)
Received: from luke-XPS-13.home (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id j3sm1322449lfp.34.2019.07.06.14.38.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 14:38:52 -0700 (PDT)
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
X-Google-Original-From: Luke Nowakowski-Krijger <lnowakow@neg.ucsd.edu>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
        pbonzini@redhat.com, rkrcmar@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Documentation: kvm: Convert cpuid.txt to .rst
Date:   Sat,  6 Jul 2019 14:38:14 -0700
Message-Id: <e8cd24f40cdd23ed116679f4c3cfcf8849879bb4.1562448500.git.lnowakow@eng.ucsd.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1562448500.git.lnowakow@eng.ucsd.edu>
References: <cover.1562448500.git.lnowakow@eng.ucsd.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>

Convert cpuid.txt to .rst format to be parsable by sphinx. 

Change format and spacing to make function definitions and return values
much more clear. Also added a table that is parsable by sphinx and makes
the information much more clean. 

Signed-off-by: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
---
 Documentation/virtual/kvm/cpuid.rst | 99 +++++++++++++++++++++++++++++
 Documentation/virtual/kvm/cpuid.txt | 83 ------------------------
 2 files changed, 99 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/virtual/kvm/cpuid.rst
 delete mode 100644 Documentation/virtual/kvm/cpuid.txt

diff --git a/Documentation/virtual/kvm/cpuid.rst b/Documentation/virtual/kvm/cpuid.rst
new file mode 100644
index 000000000000..1a03336a500e
--- /dev/null
+++ b/Documentation/virtual/kvm/cpuid.rst
@@ -0,0 +1,99 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+KVM CPUID bits
+==============
+
+:Author: Glauber Costa <glommer@redhat.com>, Red Hat Inc, 2010
+
+A guest running on a kvm host, can check some of its features using
+cpuid. This is not always guaranteed to work, since userspace can
+mask-out some, or even all KVM-related cpuid features before launching
+a guest.
+
+KVM cpuid functions are:
+
+function: **KVM_CPUID_SIGNATURE (0x40000000)**
+
+returns::
+ 
+   eax = 0x40000001
+   ebx = 0x4b4d564b
+   ecx = 0x564b4d56
+   edx = 0x4d
+
+Note that this value in ebx, ecx and edx corresponds to the string "KVMKVMKVM".
+The value in eax corresponds to the maximum cpuid function present in this leaf,
+and will be updated if more functions are added in the future.
+Note also that old hosts set eax value to 0x0. This should
+be interpreted as if the value was 0x40000001.
+This function queries the presence of KVM cpuid leafs.
+
+function: **define KVM_CPUID_FEATURES (0x40000001)**
+
+returns::
+
+          ebx, ecx
+          eax = an OR'ed group of (1 << flag)
+
+where ``flag`` is defined as below:
+
++--------------------------------+------------+---------------------------------+
+| flag                           | value      | meaning                         |
++================================+============+=================================+
+| KVM_FEATURE_CLOCKSOURCE        | 0          | kvmclock available at msrs      |
+|                                |            | 0x11 and 0x12                   |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_NOP_IO_DELAY       | 1          | not necessary to perform delays |
+|                                |            | on PIO operations               |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_MMU_OP             | 2          | deprecated                      |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_CLOCKSOURCE2       | 3          | kvmclock available at msrs      |
+|                                |            | 0x4b564d00 and 0x4b564d01       |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_ASYNC_PF           | 4          | async pf can be enabled by      |
+|                                |            | writing to msr 0x4b564d02       |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_STEAL_TIME         | 5          | steal time can be enabled by    |
+|                                |            | writing to msr 0x4b564d03       |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_PV_EOI             | 6          | paravirtualized end of interrupt|
+|                                |            | handler can be enabled by       |
+|                                |            | writing to msr 0x4b564d04.      |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_PV_UNHAULT         | 7          | guest checks this feature bit   |
+|                                |            | before enabling paravirtualized |
+|                                |            | spinlock support                |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_PV_TLB_FLUSH       | 9          | guest checks this feature bit   |
+|                                |            | before enabling paravirtualized |
+|                                |            | tlb flush                       |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_ASYNC_PF_VMEXIT    | 10         | paravirtualized async PF VM EXIT|
+|                                |            | can be enabled by setting bit 2 |
+|                                |            | when writing to msr 0x4b564d02  |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_PV_SEND_IPI        | 11         | guest checks this feature bit   |
+|                                |            | before enabling paravirtualized |
+|                                |            | sebd IPIs                       |
++--------------------------------+------------+---------------------------------+
+| KVM_FEATURE_CLOCSOURCE_STABLE  | 24         | host will warn if no guest-side |
+| _BIT                           |            | per-cpu warps are expeced in    |
+|                                |            | kvmclock                        |
++--------------------------------+------------+---------------------------------+
+
+::
+
+      edx = an OR'ed group of (1 << flag)
+
+Where ``flag`` here is defined as below:
+
++--------------------------------+------------+---------------------------------+
+| flag                           | value      | meaning                         |
++================================+============+=================================+
+| KVM_HINTS_REALTIME             | 0          | guest checks this feature bit to|
+|                                |            | determine that vCPUs are never  |
+|                                |            | preempted for an unlimited time |
+|                                |            | allowing optimizations          |
++--------------------------------+------------+---------------------------------+
diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
deleted file mode 100644
index 97ca1940a0dc..000000000000
--- a/Documentation/virtual/kvm/cpuid.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-KVM CPUID bits
-Glauber Costa <glommer@redhat.com>, Red Hat Inc, 2010
-=====================================================
-
-A guest running on a kvm host, can check some of its features using
-cpuid. This is not always guaranteed to work, since userspace can
-mask-out some, or even all KVM-related cpuid features before launching
-a guest.
-
-KVM cpuid functions are:
-
-function: KVM_CPUID_SIGNATURE (0x40000000)
-returns : eax = 0x40000001,
-          ebx = 0x4b4d564b,
-          ecx = 0x564b4d56,
-          edx = 0x4d.
-Note that this value in ebx, ecx and edx corresponds to the string "KVMKVMKVM".
-The value in eax corresponds to the maximum cpuid function present in this leaf,
-and will be updated if more functions are added in the future.
-Note also that old hosts set eax value to 0x0. This should
-be interpreted as if the value was 0x40000001.
-This function queries the presence of KVM cpuid leafs.
-
-
-function: define KVM_CPUID_FEATURES (0x40000001)
-returns : ebx, ecx
-          eax = an OR'ed group of (1 << flag), where each flags is:
-
-
-flag                               || value || meaning
-=============================================================================
-KVM_FEATURE_CLOCKSOURCE            ||     0 || kvmclock available at msrs
-                                   ||       || 0x11 and 0x12.
-------------------------------------------------------------------------------
-KVM_FEATURE_NOP_IO_DELAY           ||     1 || not necessary to perform delays
-                                   ||       || on PIO operations.
-------------------------------------------------------------------------------
-KVM_FEATURE_MMU_OP                 ||     2 || deprecated.
-------------------------------------------------------------------------------
-KVM_FEATURE_CLOCKSOURCE2           ||     3 || kvmclock available at msrs
-                                   ||       || 0x4b564d00 and 0x4b564d01
-------------------------------------------------------------------------------
-KVM_FEATURE_ASYNC_PF               ||     4 || async pf can be enabled by
-                                   ||       || writing to msr 0x4b564d02
-------------------------------------------------------------------------------
-KVM_FEATURE_STEAL_TIME             ||     5 || steal time can be enabled by
-                                   ||       || writing to msr 0x4b564d03.
-------------------------------------------------------------------------------
-KVM_FEATURE_PV_EOI                 ||     6 || paravirtualized end of interrupt
-                                   ||       || handler can be enabled by writing
-                                   ||       || to msr 0x4b564d04.
-------------------------------------------------------------------------------
-KVM_FEATURE_PV_UNHALT              ||     7 || guest checks this feature bit
-                                   ||       || before enabling paravirtualized
-                                   ||       || spinlock support.
-------------------------------------------------------------------------------
-KVM_FEATURE_PV_TLB_FLUSH           ||     9 || guest checks this feature bit
-                                   ||       || before enabling paravirtualized
-                                   ||       || tlb flush.
-------------------------------------------------------------------------------
-KVM_FEATURE_ASYNC_PF_VMEXIT        ||    10 || paravirtualized async PF VM exit
-                                   ||       || can be enabled by setting bit 2
-                                   ||       || when writing to msr 0x4b564d02
-------------------------------------------------------------------------------
-KVM_FEATURE_PV_SEND_IPI            ||    11 || guest checks this feature bit
-                                   ||       || before using paravirtualized
-                                   ||       || send IPIs.
-------------------------------------------------------------------------------
-KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
-                                   ||       || per-cpu warps are expected in
-                                   ||       || kvmclock.
-------------------------------------------------------------------------------
-
-          edx = an OR'ed group of (1 << flag), where each flags is:
-
-
-flag                               || value || meaning
-==================================================================================
-KVM_HINTS_REALTIME                 ||     0 || guest checks this feature bit to
-                                   ||       || determine that vCPUs are never
-                                   ||       || preempted for an unlimited time,
-                                   ||       || allowing optimizations
-----------------------------------------------------------------------------------
-- 
2.20.1

