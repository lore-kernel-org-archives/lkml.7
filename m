Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D9C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B0A20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfFGJNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:13:10 -0400
Received: from foss.arm.com ([217.140.110.172]:36098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFGJNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:13:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 386C0337;
        Fri,  7 Jun 2019 02:13:09 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB33E3F96A;
        Fri,  7 Jun 2019 02:13:05 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 0/2] arm64/mm: Clean ups for do_page_fault()
Date:   Fri,  7 Jun 2019 14:43:04 +0530
Message-Id: <1559898786-28530-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This contains some clean ups for page fault handling in do_page_fault().
This has been boot tested on arm64 platform along with some stress tests
but just build tested on others. Contains remaining two patches from v3
series after the first two patches were merged.

This series applies on arm64 tree:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git (for-next/core)

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoph Hellwig <hch@infradead.org>

Changes in V3:

- Dropped first two patches which got queued up for 5.3
- Rebased on branch for-next/core on arm64 tree
- s/is_el0_write_abort/is_write_abort/ with a comment per Mark and Catalin
- s/is_el0_write/is_write following the above change
- Updated commit message on [PATCH V3 2/2] per Catalin

Changes in V2: (https://lkml.org/lkml/2019/6/3/79)

- s/is_write_abort()/is_el0_write_abort() with a comment per Mark Rutland
- s/is_write/is_el0_write/ & updated commit message as required
- s/argument/local variable/ per Christoph Hellwig
- Preserved VMA check order for VM_FAULT_BADMAP & VM_FAULT_BADACCESS per Mark
- Preserved all existing __do_page_fault() in code comments per Mark
- Dropped 'fixes' from the series's subject line per Will Deacon

V1: https://lkml.org/lkml/2019/5/29/431

Anshuman Khandual (2):
  arm64/mm: Consolidate page fault information capture
  arm64/mm: Refactor __do_page_fault()

 arch/arm64/mm/fault.c | 56 +++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

-- 
2.7.4

