Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D1AECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDC021927
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="UQVesyL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfJNNWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:22:19 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:43352 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJNNWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:22:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id F1CF43F71B;
        Mon, 14 Oct 2019 15:22:15 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=UQVesyL9;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wYrT4GHhr-9o; Mon, 14 Oct 2019 15:22:15 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id C92EC3F6C6;
        Mon, 14 Oct 2019 15:22:12 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id EC4FC360162;
        Mon, 14 Oct 2019 15:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571059332; bh=hV+XVq7EUXh8y1VcYcoa8HQXtDcCKb0r7kHhhlkJX1U=;
        h=From:To:Cc:Subject:Date:From;
        b=UQVesyL9nEZpc05sLIm1aMteXfE9aDLWe5wiDDkRsK7yq48Xn+4Ic3NU1b7WmhX86
         gmU/TgMwyhEgfks7MjB8aX7ylth0HJlibkaHsFhk5L1bcHGHEdnXQ/TtgmOejCHOPS
         S1PV9c6taNCu/QHe3Y/u2/f3/cM3DwqIJqAYQ7mI=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     torvalds@linux-foundation.org,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v6 0/8] Emulated coherent graphics memory take 2
Date:   Mon, 14 Oct 2019 15:21:56 +0200
Message-Id: <20191014132204.7721-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
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
Changes since v5:
- Fix tlb flushing when we have other pending tlb flushes.
  
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
