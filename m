Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5463BC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C1121670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfHXGNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:13:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43806 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfHXGNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:13:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so8052749pfn.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kSi1/f8j26P6m8VkHa3OU1uYHBFvYkufKJqChTfaGcc=;
        b=YP0wfvloC0RE4H8ukBubrZDuNyLFFAVVZhXIpAiwiYLlY1x75ZwBD40z9AZrPFV2H9
         iyXtGRCxDmv2g4dcnk0QmO0t/WXZmWeisGz/lx6vrtG4kREdDwOWWoEBg0D1PBxTt/Y9
         0Wee8tw+s5JAfFSlDC7QfCjIpmhCs8ShJQWntAke8Cd6A3pGmQANPz+Otg9TFYinPJxo
         UlkiebRBdD/GXWggxHIO9n95SypnP3fI8TcbkrK+OnTtVhUYyfgw0msSn4m+DWmUwarR
         OPUIEcQywiIYjXFkadiEMmg2dnlEZCh5ZwWDV6izmrdxf7vbm586sdH2lXcfZTin/55Z
         Jblw==
X-Gm-Message-State: APjAAAXnHjJNrgCvj1Eu5p+LnkBHMYB7dbRfKMO1hCga15Fk4NIoI6GP
        qTi1tcU9f3C49q8rH+xD5gc=
X-Google-Smtp-Source: APXvYqyzmotg29WlYT9pkXK9P9heCKncRbC/vqUX7XZvWupKAL1OcGsRxV+aRC0/tGr4G+kqHzuB+g==
X-Received: by 2002:a63:f357:: with SMTP id t23mr7202481pgj.421.1566627201449;
        Fri, 23 Aug 2019 23:13:21 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o9sm3691360pgv.19.2019.08.23.23.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:13:20 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH v2 0/3] x86/mm/tlb: Defer TLB flushes with PTI
Date:   Fri, 23 Aug 2019 15:52:45 -0700
Message-Id: <20190823225248.15597-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INVPCID is considerably slower than INVLPG of a single PTE, but it is
currently used to flush PTEs in the user page-table when PTI is used.

Instead, it is possible to defer TLB flushes until after the user
page-tables are loaded. Preventing speculation over the TLB flushes
should keep the whole thing safe. In some cases, deferring TLB flushes
in such a way can result in more full TLB flushes, but arguably this
behavior is oftentimes beneficial.

These patches are based and evaluated on top of the concurrent
TLB-flushes v4 patch-set.

I will provide more results later, but it might be easier to look at the
time an isolated TLB flush takes. These numbers are from skylake,
showing the number of cycles that running madvise(DONTNEED) which
results in local TLB flushes takes:

n_pages		concurrent	+deferred-pti		change
-------		----------	-------------		------
 1		2119		1986 			-6.7%
 10		6791		5417 			 -20%

Please let me know if I missed something that affects security or
performance.

[ Yes, I know there is another pending RFC for async TLB flushes, but I
  think it might be easier to merge this one first ]

RFC v1 -> RFC v2:
  * Wrong patches were sent before

Nadav Amit (3):
  x86/mm/tlb: Change __flush_tlb_one_user interface
  x86/mm/tlb: Defer PTI flushes
  x86/mm/tlb: Avoid deferring PTI flushes on shootdown

 arch/x86/entry/calling.h              |  52 +++++++++++-
 arch/x86/include/asm/paravirt.h       |   5 +-
 arch/x86/include/asm/paravirt_types.h |   3 +-
 arch/x86/include/asm/tlbflush.h       |  55 +++++++-----
 arch/x86/kernel/asm-offsets.c         |   3 +
 arch/x86/kernel/paravirt.c            |   7 +-
 arch/x86/mm/tlb.c                     | 117 ++++++++++++++++++++++++--
 arch/x86/xen/mmu_pv.c                 |  21 +++--
 8 files changed, 218 insertions(+), 45 deletions(-)

-- 
2.17.1

