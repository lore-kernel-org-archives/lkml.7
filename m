Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CDC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25CE2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="KFQNLPu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfK0IcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:32:19 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:38248 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfK0IcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:32:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id CE8CA41CE1;
        Wed, 27 Nov 2019 09:32:14 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="KFQNLPu2";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6TwXtQa_G2Zk; Wed, 27 Nov 2019 09:32:05 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 11C9B41BA4;
        Wed, 27 Nov 2019 09:32:02 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 378D3360140;
        Wed, 27 Nov 2019 09:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1574843522; bh=Og4luRQdluh+hAMeX8+BJha1sCbiLJlldQtmSpb2990=;
        h=From:To:Cc:Subject:Date:From;
        b=KFQNLPu2ssbAmbmSpaB/4Liu4TF37qg9ct9Iy4I7iR2RDRYvn6IUmptkZ5amxQbgW
         CEcw6ILpLYYfsjaNOriLp8hcEl+lVPKqDbUMwsP0w8+mVtPxs6o8RcV4Rs+oaA66y3
         mFL+3G6a6skaGARalHB7+HRkxOCyRD/aYPEeGXUQ=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC PATCH 0/7] Huge page-table entries for TTM
Date:   Wed, 27 Nov 2019 09:31:13 +0100
Message-Id: <20191127083120.34611-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to save TLB space and CPU usage this patchset enables huge- and giant
page-table entries for TTM and TTM-enabled graphics drivers.

Patch 1 introduces a vma_is_special_huge() function to make the mm code
take the same path as DAX when splitting huge- and giant page table entries,
(which is zapping the page-table entry and rely on re-faulting).

Patch 2 makes the mm code split existing huge page-table entries
on huge_fault fallbacks. Typically on COW or on buffer-objects that want
write-notify. COW and write-notification is always done on the lowest
page-table level. See the patch log message for additional considerations.

Patch 3 introduces functions to allow the graphics drivers to manipulate
the caching- and encryption flags of huge page-table entries without ugly
hacks.

Patch 4 implements the huge_fault handler in TTM.

This enables huge page-table entries, provided that the kernel is configured
to support transhuge pages, either by default or using madvise().
However, they are unlikely to be inserted unless the kernel buffer object
pfns and user-space addresses align perfectly. There are various options
here, but since buffer objects that reside in system pages typically start
at huge page boundaries if they are backed by huge pages, we try to enforce
buffer object starting pfns and user-space addresses to be huge page-size
aligned if their size exceeds a huge page-size. If pud-size transhuge
("giant") pages are enabled by the arch, the same holds for those.

Patch 5 implements a drm helper to align user-space addresses according
to the above scheme, if possible.

Patch 6 implements a TTM range manager that does the same for graphics IO
memory.

Patch 7 finally hooks up the helpers of patch 5 and 6 to the vmwgfx driver.
A similar change is needed for graphics drivers that wants a reasonable
likelyhood of actually using huge page-table entries.

Finally, if a buffer object size is not huge-page or giant-page aligned,
its size will NOT be inflated by this patchset. This means that the buffer
object tail will use smaller size page-table entries and thus no memory
overhead occurs. Drivers that want to pay the memory overhead price need to
implement their own scheme to inflate buffer-object sizes.

PMD size huge page-table-entries have been tested with vmwgfx and found to
work well both with system memory backed and IO memory backed buffer objects.

PUD size giant page-table-entries have seen limited (fault and COW) testing
using a modified kernel and a fake vmwgfx TTM memory type. The vmwgfx driver
does otherwise not support 1GB-size IO memory resources.

Comments and suggestions welcome.
Thomas


Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>


