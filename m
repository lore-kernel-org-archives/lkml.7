Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E0C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A94220645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562055249;
	bh=DcM6BvikXnZQVDyUoJmwoTLl3k6lVmvyEkQXJvPKY7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5OPJtxmHvJ/ryK67AiJdAi8C7ANOkKt9NHBdTYwEw8pOeHw10koTc4/yPLB7tyN5
	 Zmb4RwMYJb3TirkXlT4rOoyp3xtX3hMD/3kd193D8MWmWSvtRrRpF+0R2RyGpIX27+
	 p7ro2MkCR+gq++vbvWRnj3Y1sifbTW7pyD4BSk8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfGBIOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbfGBIGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:06:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BBD921850;
        Tue,  2 Jul 2019 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054797;
        bh=DcM6BvikXnZQVDyUoJmwoTLl3k6lVmvyEkQXJvPKY7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVEHbgNUz63MUf1GNfrusqMjeHVsAragR6akxjGVrAfBdRhOJVSu+F9VD9upjR++W
         QRdUpi+f+TaGAvy2cXVku+JajPMJYrmsOSaKmqUH7a3A/+IqEAjCTZjMyJLM767Omw
         8M06K8/0vlLom63Isrz0BTngXcRZEF1V28ZV34ow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 38/72] mm/page_idle.c: fix oops because end_pfn is larger than max_pfn
Date:   Tue,  2 Jul 2019 10:01:39 +0200
Message-Id: <20190702080126.637385479@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 7298e3b0a149c91323b3205d325e942c3b3b9ef6 upstream.

Currently the calcuation of end_pfn can round up the pfn number to more
than the actual maximum number of pfns, causing an Oops.  Fix this by
ensuring end_pfn is never more than max_pfn.

This can be easily triggered when on systems where the end_pfn gets
rounded up to more than max_pfn using the idle-page stress-ng stress test:

sudo stress-ng --idle-page 0

  BUG: unable to handle kernel paging request at 00000000000020d8
  #PF error: [normal kernel read fault]
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 1 PID: 11039 Comm: stress-ng-idle- Not tainted 5.0.0-5-generic #6-Ubuntu
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  RIP: 0010:page_idle_get_page+0xc8/0x1a0
  Code: 0f b1 0a 75 7d 48 8b 03 48 89 c2 48 c1 e8 33 83 e0 07 48 c1 ea 36 48 8d 0c 40 4c 8d 24 88 49 c1 e4 07 4c 03 24 d5 00 89 c3 be <49> 8b 44 24 58 48 8d b8 80 a1 02 00 e8 07 d5 77 00 48 8b 53 08 48
  RSP: 0018:ffffafd7c672fde8 EFLAGS: 00010202
  RAX: 0000000000000005 RBX: ffffe36341fff700 RCX: 000000000000000f
  RDX: 0000000000000284 RSI: 0000000000000275 RDI: 0000000001fff700
  RBP: ffffafd7c672fe00 R08: ffffa0bc34056410 R09: 0000000000000276
  R10: ffffa0bc754e9b40 R11: ffffa0bc330f6400 R12: 0000000000002080
  R13: ffffe36341fff700 R14: 0000000000080000 R15: ffffa0bc330f6400
  FS: 00007f0ec1ea5740(0000) GS:ffffa0bc7db00000(0000) knlGS:0000000000000000
  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000000020d8 CR3: 0000000077d68000 CR4: 00000000000006e0
  Call Trace:
    page_idle_bitmap_write+0x8c/0x140
    sysfs_kf_bin_write+0x5c/0x70
    kernfs_fop_write+0x12e/0x1b0
    __vfs_write+0x1b/0x40
    vfs_write+0xab/0x1b0
    ksys_write+0x55/0xc0
    __x64_sys_write+0x1a/0x20
    do_syscall_64+0x5a/0x110
    entry_SYSCALL_64_after_hwframe+0x44/0xa9

Link: http://lkml.kernel.org/r/20190618124352.28307-1-colin.king@canonical.com
Fixes: 33c3fc71c8cf ("mm: introduce idle page tracking")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_idle.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -136,7 +136,7 @@ static ssize_t page_idle_bitmap_read(str
 
 	end_pfn = pfn + count * BITS_PER_BYTE;
 	if (end_pfn > max_pfn)
-		end_pfn = ALIGN(max_pfn, BITMAP_CHUNK_BITS);
+		end_pfn = max_pfn;
 
 	for (; pfn < end_pfn; pfn++) {
 		bit = pfn % BITMAP_CHUNK_BITS;
@@ -181,7 +181,7 @@ static ssize_t page_idle_bitmap_write(st
 
 	end_pfn = pfn + count * BITS_PER_BYTE;
 	if (end_pfn > max_pfn)
-		end_pfn = ALIGN(max_pfn, BITMAP_CHUNK_BITS);
+		end_pfn = max_pfn;
 
 	for (; pfn < end_pfn; pfn++) {
 		bit = pfn % BITMAP_CHUNK_BITS;


