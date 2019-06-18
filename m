Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408DCC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CA020B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560887106;
	bh=3SVyETw2E2EX1ucf8dX5XihBlytLx4R2+9VoWquLfZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=siSLc3wGCJCR3wR/2xdgJNVU23lE3cOSM/lkmXp3s76rV93AGjbTEpV+A2htSi1+Y
	 nPTEy1TLnjycnLb/IyEIF0Ia1Zj2Cwcp9nTxgwDMugCrVE+uBPfzeoawZOSKNnAStc
	 VdbWgaFujT2V9EfHX1CgVuRzq80WLL8KbBY+1Xuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfFRTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbfFRTpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:45:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4AF2084B;
        Tue, 18 Jun 2019 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560887103;
        bh=3SVyETw2E2EX1ucf8dX5XihBlytLx4R2+9VoWquLfZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ux/8q1+R+SGkuJvyxGL5MB3IcTZzJnsY9YYEa8vnbLQQxX+jPZ2QB7LNc/awkQVT8
         KmXsHCVzPnOmtaydBRw3os8e2NolICsAgAYf7cg/CovkaTK/zb81ap2GkPdqCkCVX7
         zPfEs99C5nkuUu3LGsXblb+6J32MdX/+ImBYsnw0=
Date:   Tue, 18 Jun 2019 12:45:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: idle-page: fix oops because end_pfn is larger than
 max_pfn
Message-Id: <20190618124502.7b9c32a00a54f0c618a12ca4@linux-foundation.org>
In-Reply-To: <20190618124352.28307-1-colin.king@canonical.com>
References: <20190618124352.28307-1-colin.king@canonical.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 13:43:52 +0100 Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the calcuation of end_pfn can round up the pfn number to
> more than the actual maximum number of pfns, causing an Oops. Fix
> this by ensuring end_pfn is never more than max_pfn.
> 
> This can be easily triggered when on systems where the end_pfn gets
> rounded up to more than max_pfn using the idle-page stress-ng
> stress test:
> 

cc Vladimir.  This seems rather obvious - I'm wondering if the code was
that way for some subtle reason?

(I'll add a cc:stable to this)

From: Colin Ian King <colin.king@canonical.com>
Subject: mm/page_idle.c: fix oops because end_pfn is larger than max_pfn

Currently the calcuation of end_pfn can round up the pfn number to more
than the actual maximum number of pfns, causing an Oops.  Fix this by
ensuring end_pfn is never more than max_pfn.

This can be easily triggered when on systems where the end_pfn gets
rounded up to more than max_pfn using the idle-page stress-ng stress test:

sudo stress-ng --idle-page 0

[ 3812.222790] BUG: unable to handle kernel paging request at 00000000000020d8
[ 3812.224341] #PF error: [normal kernel read fault]
[ 3812.225144] PGD 0 P4D 0
[ 3812.225626] Oops: 0000 [#1] SMP PTI
[ 3812.226264] CPU: 1 PID: 11039 Comm: stress-ng-idle- Not tainted 5.0.0-5-generic #6-Ubuntu
[ 3812.227643] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[ 3812.229286] RIP: 0010:page_idle_get_page+0xc8/0x1a0
[ 3812.230173] Code: 0f b1 0a 75 7d 48 8b 03 48 89 c2 48 c1 e8 33 83 e0 07 48 c1 ea 36 48 8d 0c 40 4c 8d 24 88 49 c1 e4 07 4c 03 24 d5 00 89 c3 be <49> 8b 44 24 58 48 8d b8 80 a1 02 00 e8 07 d5 77 00 48 8b 53 08 48
[ 3812.234641] RSP: 0018:ffffafd7c672fde8 EFLAGS: 00010202
[ 3812.235792] RAX: 0000000000000005 RBX: ffffe36341fff700 RCX: 000000000000000f
[ 3812.237739] RDX: 0000000000000284 RSI: 0000000000000275 RDI: 0000000001fff700
[ 3812.239225] RBP: ffffafd7c672fe00 R08: ffffa0bc34056410 R09: 0000000000000276
[ 3812.241027] R10: ffffa0bc754e9b40 R11: ffffa0bc330f6400 R12: 0000000000002080
[ 3812.242555] R13: ffffe36341fff700 R14: 0000000000080000 R15: ffffa0bc330f6400
[ 3812.244073] FS: 00007f0ec1ea5740(0000) GS:ffffa0bc7db00000(0000) knlGS:0000000000000000
[ 3812.245968] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3812.247162] CR2: 00000000000020d8 CR3: 0000000077d68000 CR4: 00000000000006e0
[ 3812.249045] Call Trace:
[ 3812.249625] page_idle_bitmap_write+0x8c/0x140
[ 3812.250567] sysfs_kf_bin_write+0x5c/0x70
[ 3812.251406] kernfs_fop_write+0x12e/0x1b0
[ 3812.252282] __vfs_write+0x1b/0x40
[ 3812.253002] vfs_write+0xab/0x1b0
[ 3812.253941] ksys_write+0x55/0xc0
[ 3812.254660] __x64_sys_write+0x1a/0x20
[ 3812.255446] do_syscall_64+0x5a/0x110
[ 3812.256254] entry_SYSCALL_64_after_hwframe+0x44/0xa9

--- a/mm/page_idle.c~mm-idle-page-fix-oops-because-end_pfn-is-larger-than-max_pfn
+++ a/mm/page_idle.c
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
_

