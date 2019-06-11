Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC50BC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FF62145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmwopensource.org header.i=@vmwopensource.org header.b="gMRzw4i4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389187AbfFKMct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:32:49 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:43400 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389004AbfFKMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:32:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 497503F4C0;
        Tue, 11 Jun 2019 14:25:23 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=vmwopensource.org header.i=@vmwopensource.org header.b=gMRzw4i4;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=vmwopensource.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yb0vNCNrCl76; Tue, 11 Jun 2019 14:25:09 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9CE893F5EC;
        Tue, 11 Jun 2019 14:25:08 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id EB08D3619AA;
        Tue, 11 Jun 2019 14:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vmwopensource.org;
        s=mail; t=1560255908;
        bh=8SSMjg5S87UIXKzzTPf2fASPtyT5YDoyHJlCuHXj464=;
        h=From:To:Cc:Subject:Date:From;
        b=gMRzw4i46y1oAfDZUJ2LywkUYfekmuoX6aqewJklfhU9nCUbA6MDcbNuaRtcft1Qc
         tHI4tnrN0IyvR0CuFY7JKYiUdP13sYQdzDiSFEOcU3r2unZGMNjUCMuLEF44Gsr51R
         CXXDFm6S1cPfQjHgAkRWT+8OCA+uRA2m0QJNJaGo=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thellstrom@vmwopensource.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-mm@kvack.org
Subject: [PATCH v4 0/9] Emulated coherent graphics memory
Date:   Tue, 11 Jun 2019 14:24:45 +0200
Message-Id: <20190611122454.3075-1-thellstrom@vmwopensource.org>
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

The code has been tested and excercised by a tailored version of mesa
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

