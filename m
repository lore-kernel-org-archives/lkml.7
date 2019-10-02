Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1640ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9571221D80
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="TP16gsNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfJBNsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:48:07 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:37486 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfJBNrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:47:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id B3DB63F5E0;
        Wed,  2 Oct 2019 15:47:44 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=TP16gsNU;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U15VLMZ20c45; Wed,  2 Oct 2019 15:47:40 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E9E943F530;
        Wed,  2 Oct 2019 15:47:39 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 83B9C360058;
        Wed,  2 Oct 2019 15:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570024059; bh=UwPfNrLWUuQMcTAN4GJRHUeo3QfF/FljmexYGHhv844=;
        h=From:To:Cc:Subject:Date:From;
        b=TP16gsNUdWGFDwGgS0VmFv047OUIiqPOopnBPreULa4hU3xP32e9IATojg+8GpEef
         z9QWoelvayrU0j8wPsq9taHWkMwv/z+P+I7osxxQpCOjDNB1tvx+7tTo0D1qFLy4MS
         0YhixqkytgKIfxy8hpcN/XuEKmWbm0TuG7YQPCxI=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH v3 0/7] Emulated coherent graphics memory take 2
Date:   Wed,  2 Oct 2019 15:47:23 +0200
Message-Id: <20191002134730.40985-1-thomas_os@shipmail.org>
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
