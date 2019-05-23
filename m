Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B48EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A3B21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfEWKY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:24:29 -0400
Received: from foss.arm.com ([217.140.101.70]:42632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfEWKY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:24:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA97AA78;
        Thu, 23 May 2019 03:24:28 -0700 (PDT)
Received: from e111045-lin.cambridge.arm.com (unknown [10.1.39.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4DE43F718;
        Thu, 23 May 2019 03:24:26 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Nadav Amit <namit@vmware.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 0/4] arm64: wire up VM_FLUSH_RESET_PERMS
Date:   Thu, 23 May 2019 11:22:52 +0100
Message-Id: <20190523102256.29168-1-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the code introduced in v5.2 to manage the permissions
of executable vmalloc regions (and their linear aliases) more
strictly.

One of the things that came up in the internal discussion is
whether non-x86 architectures have any benefit at all from the
lazy vunmap feature, and whether it would perhaps be better to
implement eager vunmap instead.

Cc: Nadav Amit <namit@vmware.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: James Morse <james.morse@arm.com>

Ard Biesheuvel (4):
  arm64: module: create module allocations without exec permissions
  arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
  arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
  arm64: bpf: do not allocate executable memory

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cacheflush.h |  3 ++
 arch/arm64/kernel/module.c          |  4 +-
 arch/arm64/kernel/probes/kprobes.c  |  4 +-
 arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
 arch/arm64/net/bpf_jit_comp.c       |  2 +-
 mm/vmalloc.c                        | 11 -----
 7 files changed, 50 insertions(+), 23 deletions(-)

-- 
2.17.1

