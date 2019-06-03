Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57BBC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBEA27C06
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfFCGl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:41:58 -0400
Received: from foss.arm.com ([217.140.101.70]:44986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfFCGl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:41:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28D5615A2;
        Sun,  2 Jun 2019 23:41:57 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA4653F5AF;
        Sun,  2 Jun 2019 23:41:53 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V2 0/4] arm64/mm: Clean ups for do_page_fault()
Date:   Mon,  3 Jun 2019 12:11:21 +0530
Message-Id: <1559544085-7502-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This contains some clean ups for page fault handling in do_page_fault().
This has been boot tested on arm64 platform along with some stress test
but just build tested on others.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoph Hellwig <hch@infradead.org>

Changes in V2:

- s/is_write_abort()/is_el0_write_abort() with a comment per Mark Rutland
- s/is_write/is_el0_write/ & updated commit message as required
- s/argument/local variable/ per Christoph Hellwig
- Preserved VMA check order for VM_FAULT_BADMAP & VM_FAULT_BADACCESS per Mark
- Preserved all existing __do_page_fault() in code comments per Mark
- Dropped 'fixes' from the series's subject line per Will Deacon

V1: https://lkml.org/lkml/2019/5/29/431

Anshuman Khandual (4):
  arm64/mm: Drop mmap_sem before calling __do_kernel_fault()
  arm64/mm: Drop task_struct argument from __do_page_fault()
  arm64/mm: Consolidate page fault information capture
  arm64/mm: Drop local variable vm_fault_t from __do_page_fault()

 arch/arm64/mm/fault.c | 72 +++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

-- 
2.7.4

