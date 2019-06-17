Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D6C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4463E20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="mnafpFme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfFQUY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:24:56 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:53890 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFQUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:24:55 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jun 2019 16:24:55 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 98259404EC;
        Mon, 17 Jun 2019 22:18:20 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=mnafpFme;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wMzdDbcLcI35; Mon, 17 Jun 2019 22:18:05 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 3E26F3F806;
        Mon, 17 Jun 2019 22:18:04 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id BA38A360195;
        Mon, 17 Jun 2019 22:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1560802684; bh=PScipI5AHw+qLkcTJBwlmyceItjajNZI6ZkbYCpIp5o=;
        h=From:To:Cc:Subject:Date:From;
        b=mnafpFmeQNH0EL9PxDDtoS88L4EEKidwRycfzY5O4F6w5cYXRS9jQd/8Sp41m7vbP
         IGa3xwnPcNIRFsIpwMtIL54qlzHImXSrhOKD0YrKYP4PMF8OYntCihTR0BEOx6vTCo
         WT3MhJYxH40T/yuSsoFkU1z+efK2N3j+ckFX8dPU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas@shipmail.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/9] Emulated coherent graphics memory
Date:   Mon, 17 Jun 2019 22:17:47 +0200
Message-Id: <20190617201756.12587-1-thomas@shipmail.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Planning to merge this through the drm/vmwgfx tree soon, so if there
are any objections, please speak up.

Graphics APIs like OpenGL 4.4 and Vulkan require the graphics driver
to provide coherent graphics memory, meaning that the GPU sees any
content written to the coherent memory on the next GPU operation that
touches that memory, and the CPU sees any content written by the GPU
to that memory immediately after any fence object trailing the GPU
operation has signaled.

Paravirtual drivers that otherwise require explicit synchronization
needs to do this by hooking up dirty tracking to pagefault handlers
and buffer object validation. This is a first attempt to do that for
the vmwgfx driver.

The mm patches has been out for RFC. I think I have addressed all the
feedback I got, except a possible softdirty breakage. But although the
dirty-tracking and softdirty may write-protect PTEs both care about,
that shouldn't really cause any operation interference. In particular
since we use the hardware dirty PTE bits and softdirty uses other PTE bits.

For the TTM changes they are hopefully in line with the long-term
strategy of making helpers out of what's left of TTM.

The code has been tested and exercised by a tailored version of mesa
where we disable all explicit synchronization and assume graphics memory
is coherent. The performance loss varies of course; a typical number is
around 5%.

Changes v1-v2:
- Addressed a number of typos and formatting issues.
- Added a usage warning for apply_to_pfn_range() and apply_to_page_range()
- Re-evaluated the decision to use apply_to_pfn_range() rather than
  modifying the pagewalk.c. It still looks like generically handling the
  transparent huge page cases requires the mmap_sem to be held at least
  in read mode, so sticking with apply_to_pfn_range() for now.
- The TTM page-fault helper vma copy argument was scratched in favour of
  a pageprot_t argument.
Changes v3:
- Adapted to upstream API changes.
Changes v4:
- Adapted to upstream mmu_notifier changes. (Jerome?)
- Fixed a couple of warnings on 32-bit x86
- Fixed image offset computation on multisample images.
Changes v5:
- Updated usage warning in patch 3/9 after review comments from Nadav Amit.
Changes v6:
- Updated exports of new functionality in patch 3/9 to EXPORT_SYMBOL_GPL
  after review comments from Christoph Hellwig.
Changes v7:
- Re-added removed comment in ttm_bo_vm.c (Review by Hillf Danton)
- Fixed an error path regression in ttm_bo_vm.c
  
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-mm@kvack.org
