Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418B7C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D7F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfFQOoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:44:22 -0400
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:20134 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFQOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:44:21 -0400
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [192.168.231.132]) by mgwkm04.jp.fujitsu.com with smtp
         id 2860_a48c_ffb2cb9e_91b6_4026_a430_2415c2179bb5;
        Mon, 17 Jun 2019 23:32:57 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
        by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 2669AAC00C7;
        Mon, 17 Jun 2019 23:32:57 +0900 (JST)
Received: from G01JPEXCHKW15.g01.fujitsu.local (G01JPEXCHKW15.g01.fujitsu.local [10.0.194.54])
        by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id 46F098B48E8;
        Mon, 17 Jun 2019 23:32:56 +0900 (JST)
Received: from localhost.localdomain (10.17.204.146) by
 G01JPEXCHKW15.g01.fujitsu.local (10.0.194.54) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 23:32:55 +0900
From:   Takao Indoh <indou.takao@jp.fujitsu.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        QI Fuli <qi.fuli@fujitsu.com>,
        "Takao Indoh" <indou.takao@fujitsu.com>
Subject: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush instruction within the same inner shareable domain
Date:   Mon, 17 Jun 2019 23:32:53 +0900
Message-ID: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takao Indoh <indou.takao@fujitsu.com>

I found a performance issue related on the implementation of Linux's TLB
flush for arm64.

When I run a single-threaded test program on moderate environment, it
usually takes 39ms to finish its work. However, when I put a small
apprication, which just calls mprotest() continuously, on one of sibling
cores and run it simultaneously, the test program slows down significantly.
It becomes 49ms(125%) on ThunderX2. I also detected the same problem on
ThunderX1 and Fujitsu A64FX.

I suppose the root cause of this issue is the implementation of Linux's TLB
flush for arm64, especially use of TLBI-is instruction which is a broadcast
to all processor core on the system. In case of the above situation,
TLBI-is is called by mprotect().

This is not a problem for small environment, but this causes a significant
performance noise for large-scale HPC environment, which has more than
thousand nodes with low latency interconnect.

To fix this problem, this patch adds new boot parameter
'disable_tlbflush_is'.  In the case of flush_tlb_mm() *without* this
parameter, TLB entry is invalidated by __tlbi(aside1is, asid). By this
instruction, all CPUs within the same inner shareable domain check if there
are TLB entries which have this ASID, this causes performance noise. OTOH,
when this new parameter is specified, TLB entry is invalidated by
__tlbi(aside1, asid) only on the CPUs specified by mm_cpumask(mm).
Therefore TLB flush is done on minimal CPUs and performance problem does
not occur. Actually I confirm the performance problem is fixed by this
patch.

Takao Indoh (2):
  arm64: mm: Restore mm_cpumask (revert commit 38d96287504a ("arm64: mm:
    kill mm_cpumask usage"))
  arm64: tlb: Add boot parameter to disable TLB flush within the same
    inner shareable domain

 .../admin-guide/kernel-parameters.txt         |   4 +
 arch/arm64/include/asm/mmu_context.h          |   7 +-
 arch/arm64/include/asm/tlbflush.h             |  61 ++-----
 arch/arm64/kernel/Makefile                    |   2 +-
 arch/arm64/kernel/smp.c                       |   6 +
 arch/arm64/kernel/tlbflush.c                  | 155 ++++++++++++++++++
 arch/arm64/mm/context.c                       |   2 +
 7 files changed, 186 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm64/kernel/tlbflush.c

-- 
2.20.1

