Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B67C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7002070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfF1EpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:45:07 -0400
Received: from foss.arm.com ([217.140.110.172]:40226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfF1EpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:45:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E51F344;
        Thu, 27 Jun 2019 21:45:06 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F65A3F706;
        Thu, 27 Jun 2019 21:45:02 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/2] arm64: Enable vmemmap from device memory
Date:   Fri, 28 Jun 2019 10:14:41 +0530
Message-Id: <1561697083-7329-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables vmemmap mapping allocation from device memory ranges on
arm64. Before that it enables vmemmap_populate_basepages() to accommodate
struct vmem_altmap based requests.

This series is based on linux next (next-20190613) along with v6 arm64
hot-remove series [1]. 

[1] https://lkml.org/lkml/2019/6/19/3

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  mm/sparsemem: Add vmem_altmap support in vmemmap_populate_basepages()
  arm64/mm: Enable device memory allocation and free for vmemmap mapping

 arch/arm64/mm/mmu.c      | 57 +++++++++++++++++++++++++++++++-----------------
 arch/ia64/mm/discontig.c |  2 +-
 arch/x86/mm/init_64.c    |  4 ++--
 include/linux/mm.h       |  5 +++--
 mm/sparse-vmemmap.c      | 16 +++++++++-----
 5 files changed, 54 insertions(+), 30 deletions(-)

-- 
2.7.4

