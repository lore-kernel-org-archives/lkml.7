Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B197BC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949E321849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbfGSSq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:46:56 -0400
Received: from 8bytes.org ([81.169.241.247]:36096 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbfGSSq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:46:56 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7592122E; Fri, 19 Jul 2019 20:46:54 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3 v3] Sync unmappings in vmalloc/ioremap areas
Date:   Fri, 19 Jul 2019 20:46:49 +0200
Message-Id: <20190719184652.11391-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a small patch-set to sync unmappings in the
vmalloc/ioremap areas between page-tables in the system.

This is only needed x86-32 with !SHARED_KERNEL_PMD, which is
the case on a PAE kernel with PTI enabled.

On affected systems the missing sync causes old mappings to
persist in some page-tables, causing data corruption and
other undefined behavior.

Please review.

Thanks,

	Joerg

Changes v2 -> v3:

	- Moved the vmalloc_sync_all() call to the lazy vmap
	  purge function as requested by Andy Lutomirski

	- Made sure that the code in vmalloc_sync_all()
	  really iterates over all pgds (pointed out by
	  Thomas Gleixner)

	- Added a couple of comments

Changes v1 -> v2:
 
	- Added correct Fixes-tags to all patches

Joerg Roedel (3):
  x86/mm: Check for pfn instead of page in vmalloc_sync_one()
  x86/mm: Sync also unmappings in vmalloc_sync_all()
  mm/vmalloc: Sync unmappings in vunmap_page_range()

 arch/x86/mm/fault.c | 15 ++++++---------
 mm/vmalloc.c        |  9 +++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.17.1

