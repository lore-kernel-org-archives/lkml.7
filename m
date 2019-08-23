Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D41C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F117321670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfHXGHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:07:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40931 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXGHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:07:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so7057956pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kpBC9wVD3rWh02xV0sYdIYiu+PcR9z84eXUvsLd6pJ0=;
        b=A95/set1lK6zgiSVEZFrxIAF/wa8YZej9zk3uH8FgR1b3Qthgx5FwmnC2Erp7mcFu6
         Z3WTq3gEL7PAE7Jge8ATlCewfUZ1K6WpnJiF0Wktek4Wk7OkDdRkb5ZMAlbySqoJi50J
         1T1b+ettDvLFdeqwWO4ur0BgMgxqgc9rS3o01F+0JpToXup7ab5QOmNyMLYl1Txn7ZWQ
         sIOAaHJpZM5OovOsHaG1Xs/O9YoMiVO/hOO2+DHiZWpVS1hHrv1QS1R4M29jCITXWBpa
         UsS+I75Y+sxmxqemAmUzYkssji+H6QE01DE5AJVZ09m/R7fUCvP1R1q8TYSBoDtzT2ga
         h1mA==
X-Gm-Message-State: APjAAAXwSPgE07q5oI3VbVMNY80qRYWkCM1ACM5ykWgJxzWAIWWO0KMP
        FEYH+kdWToXFbPgYklZ7RhA=
X-Google-Smtp-Source: APXvYqwbz+4onUhSDO3lm/jchlUgk20PkWg+MV9DVa5l6uTctiocwUzwz59KC3goH/kDCcl6ah2Y3w==
X-Received: by 2002:a65:5a8c:: with SMTP id c12mr6905826pgt.73.1566626841751;
        Fri, 23 Aug 2019 23:07:21 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d12sm4951187pfn.11.2019.08.23.23.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:07:21 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 0/3] x86/mm/tlb: Defer TLB flushes with PTI
Date:   Fri, 23 Aug 2019 15:46:32 -0700
Message-Id: <20190823224635.15387-1-namit@vmware.com>
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

Nadav Amit (3):
  x86/mm/tlb: Defer PTI flushes
  x86/mm/tlb: Avoid deferring PTI flushes on shootdown
  x86/mm/tlb: Use lockdep irq assertions

 arch/x86/entry/calling.h        | 52 +++++++++++++++++++--
 arch/x86/include/asm/tlbflush.h | 31 ++++++++++--
 arch/x86/kernel/asm-offsets.c   |  3 ++
 arch/x86/mm/tlb.c               | 83 +++++++++++++++++++++++++++++++--
 4 files changed, 158 insertions(+), 11 deletions(-)

-- 
2.17.1

