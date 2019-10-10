Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A06D20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="NAaNoRX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbfJJMno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:43:44 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:46830 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387850AbfJJMnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:43:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 839293F66E;
        Thu, 10 Oct 2019 14:43:31 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=NAaNoRX/;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t1tejHvEyFaS; Thu, 10 Oct 2019 14:43:25 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 67FB33F260;
        Thu, 10 Oct 2019 14:43:23 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C051A36016C;
        Thu, 10 Oct 2019 14:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570711402; bh=DUBZteFxRv+biRAr6ikt9dxEsTdkCF11hutElrgSLqA=;
        h=From:To:Cc:Subject:Date:From;
        b=NAaNoRX/AmaY33dT8r1CHyHyVrTM0aSbQBgT3unS/YYrbVbmH28TCylntbnj5bHyp
         vW62Rkaoi+tNnDDEwoeMf+bvzonXkVwAq9fW/5jHi7eeo6RnlB51GTaeplfhNxfIE4
         oFL8fVBbA9mcq5pkN7dRjjF3XeyueXYygpH0zf4k=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [PATCH v5 0/8] Emulated coherent graphics memory take 2
Date:   Thu, 10 Oct 2019 14:43:06 +0200
Message-Id: <20191010124314.40067-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellström <thellstrom@vmware.com>

Graphics APIs like OpenGL 4.4 and Vulkan require the graphics driver
to provide coherent graphics memory, meaning that the GPU sees any
content written to the coherent memory on the next GPU operation that
touches that memory, and the CPU sees any content written by the GPU
to that memory immediately after any fence object trailing the GPU
operation is signaled.

Paravirtual drivers that otherwise require explicit synchronization
needs to do this by hooking up dirty tracking to pagefault handlers
and buffer object validation.

Provide mm helpers needed for this and that also allow for huge pmd-
and pud entries (patch 1-3), and the associated vmwgfx code (patch 4-7).

The code has been tested and exercised by a tailored version of mesa
where we disable all explicit synchronization and assume graphics memory
is coherent. The performance loss varies of course; a typical number is
around 5%.

I would like to merge this code through the DRM tree, so an ack to include
the new mm helpers in that merge would be greatly appreciated.

Changes since RFC:
- Merge conflict changes moved to the correct patch. Fixes intra-patchset
  compile errors.
- Be more aggressive when turning ttm vm code into helpers. This makes sure
  we can use a const qualifier on the vmwgfx vm_ops.
- Reinstate a lost comment an fix an error path that was broken when turning
  the ttm vm code into helpers.
- Remove explicit type-casts of struct vm_area_struct::vm_private_data
- Clarify the locking inversion that makes us not being able to use the mm
  pagewalk code.

Changes since v1:
- Removed the vmwgfx maintainer entry for as_dirty_helpers.c, updated
  commit message accordingly
- Removed the TTM patches from the series as they are merged separately
  through DRM.
Changes since v2:
- Split out the pagewalk code from as_dirty_helpers.c and document locking.
- Add pre_vma and post_vma callbacks to the pagewalk code.
- Remove huge pmd and -pud asserts that would trip when we protect vmas with
  struct address_space::i_mmap_rwsem rather than with
  struct vm_area_struct::mmap_sem.
- Do some naming cleanup in as_dirty_helpers.c
Changes since v3:
- Extensive renaming of the dirty helpers including the filename.
- Update walk_page_mapping() doc.
- Update the pagewalk code to not unconditionally split pmds if a pte_entry()
  callback is present. Update the dirty helper pmd_entry accordingly.
- Use separate walk ops for the dirty helpers.
- Update the pagewalk code to take the pagetable lock in walk_pte_range.
Changes since v4:
- Fix pte pointer confusion in patch 2/8
- Skip the pagewalk code conditional split patch for now, and update the
  mapping_dirty_helper accordingly. That problem will be solved in a cleaner
  way in a follow-up patchset.
  
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
