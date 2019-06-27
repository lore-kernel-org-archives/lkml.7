Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FBFC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383AC2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF0Msn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:48:43 -0400
Received: from foss.arm.com ([217.140.110.172]:53638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0Msm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:48:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF6942B;
        Thu, 27 Jun 2019 05:48:41 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9656E3F718;
        Thu, 27 Jun 2019 05:48:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/2] arm64/mm: Enable THP migration
Date:   Thu, 27 Jun 2019 18:18:14 +0530
Message-Id: <1561639696-16361-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables THP migration without split on arm64 by subscribing
to ARCH_ENABLE_THP_MIGRATION. Before that it modifies arm64 platform THP
helpers like pmd_present() and pmd_trans_huge() to comply with expected
generic MM semantics as concluded from a previous discussion [1].

Initial THP migration and stress tests look good for various THP sizes. I
will continue testing this further. But meanwhile looking for some early
reviews, feedbacks and suggestions on the approach.

This is based on linux-next tree (next-20190626).

Question:

Instead of directly using PTE_SPECIAL, would it be better to override the
same bit as PMD_SPLITTING and create it's associated helpers to make this
more clear and explicit ?

[1] https://lkml.org/lkml/2018/10/9/220

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  arm64/mm: Change THP helpers to comply with generic MM semantics
  arm64/mm: Enable THP migration without split

 arch/arm64/Kconfig               |  4 ++++
 arch/arm64/include/asm/pgtable.h | 32 +++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.7.4

