Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2473CC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A9821019
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfFGHxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:53:39 -0400
Received: from swift.blarg.de ([138.201.185.127]:39168 "EHLO swift.blarg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfFGHxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:53:38 -0400
Received: by swift.blarg.de (Postfix, from userid 1000)
        id E6BCF4051E; Fri,  7 Jun 2019 09:53:35 +0200 (CEST)
Date:   Fri, 7 Jun 2019 09:53:35 +0200
From:   Max Kellermann <max@blarg.de>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
Message-ID: <20190607075335.GA30441@swift.blarg.de>
Mail-Followup-To: Justin Piszcz <jpiszcz@lucidpixels.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
 <20190509111343.rvmy5noqlf4os3zk@box>
 <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
 <20190606172440.GA24838@swift.blarg.de>
 <20190607074052.GA30233@swift.blarg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607074052.GA30233@swift.blarg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/07 09:40, Max Kellermann <max@blarg.de> wrote:
> On 2019/06/06 19:24, Max Kellermann <max@blarg.de> wrote:
> > I have the same problem (kernel 5.1.7), but over here, it's a PHP
> > process, not khugepaged, which is looping inside compaction_alloc.
> 
> This is what happened an hour later:
> 
>  kernel tried to execute NX-protected page - exploit attempt? (uid: 33333)
>  BUG: unable to handle kernel paging request at ffffffffc036f00f

Another machine in the cluster has just crashed (same kernel, and
hugepage/compaction again):

 BUG: unable to handle kernel paging request at ffffd43382060000
 #PF error: [normal kernel read fault]
 PGD 85fff8067 P4D 85fff8067 PUD 85fff7067 PMD 0 
 Oops: 0000 [#2] SMP PTI
 CPU: 27 PID: 117908 Comm: php-cgi7.0 Tainted: G      D           5.1.7-cmag1-th+ #5
 Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/17/2018
 RIP: 0010:isolate_freepages_block+0xa3/0x380
 Code: 10 4c 89 c0 c7 44 24 0c 00 00 00 00 4d 89 de 48 c1 e0 06 f6 c3 1f 48 89 44 24 18 44 89 c8 49 89 d1 41 89 c4 0f 84 03 01 00 00 <49> 8b 07 83 c5 01 a9 00 00 01 00 75 0c 49 8b 47 08 a8 01 0f 84 b8
 RSP: 0018:ffffad0d258bf898 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000081800 RCX: ffffad0d258bfb89
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9c08ffffc8e0
 RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000081bff
 R10: 0000000000000000 R11: ffffad0d258bfb89 R12: 0000000000000000
 R13: ffffad0d258bfb10 R14: ffffad0d258bfb89 R15: ffffd43382060000
 FS:  00007f92c1c84740(0000) GS:ffff9c08df9c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffd43382060000 CR3: 0000000966150002 CR4: 00000000001606e0
 Call Trace:
  compaction_alloc+0x7e6/0x870
  ? move_freelist_tail+0xd0/0xd0
  migrate_pages+0xaa/0x780
  ? isolate_freepages_block+0x380/0x380
  compact_zone+0x6ec/0xca0
  compact_zone_order+0xd8/0x120
  try_to_compact_pages+0xb1/0x260
  __alloc_pages_direct_compact+0x87/0x160
  __alloc_pages_slowpath+0x427/0xd50
  __alloc_pages_nodemask+0x2d6/0x310
  do_huge_pmd_anonymous_page+0x131/0x680
  ? vma_merge+0x24f/0x3a0
  __handle_mm_fault+0xbca/0x1260
  handle_mm_fault+0x135/0x1b0
  __do_page_fault+0x242/0x4b0
  ? page_fault+0x8/0x30
  page_fault+0x1e/0x30
 RIP: 0033:0x55ab2b7205ee
 Code: 24 18 01 00 00 41 8b 8c 24 48 01 00 00 8d 51 01 41 3b 94 24 4c 01 00 00 41 89 94 24 48 01 00 00 7e 08 41 89 94 24 4c 01 00 00 <4c> 89 20 49 8b 94 24 38 01 00 00 45 31 db 41 bd 00 10 00 00 41 b9
 RSP: 002b:00007ffd79f76750 EFLAGS: 00010202
 RAX: 00007f929b800000 RBX: 0000000000000011 RCX: 0000000000000007
 RDX: 0000000000000008 RSI: 0000000000200000 RDI: 00007f929b800000
 RBP: 0000000000000006 R08: ffffffffffffffff R09: 0000000000000000
 R10: 0000000000000022 R11: 0000000000000246 R12: 00007f92bd000040
 R13: 00000000ffffffff R14: 0000000000000200 R15: 00007f929c7ac648
 Modules linked in:
 CR2: ffffd43382060000
 ---[ end trace 73412f77c0bd1f72 ]---
 RIP: 0010:isolate_freepages_block+0xa3/0x380
 Code: 10 4c 89 c0 c7 44 24 0c 00 00 00 00 4d 89 de 48 c1 e0 06 f6 c3 1f 48 89 44 24 18 44 89 c8 49 89 d1 41 89 c4 0f 84 03 01 00 00 <49> 8b 07 83 c5 01 a9 00 00 01 00 75 0c 49 8b 47 08 a8 01 0f 84 b8
 RSP: 0018:ffffad0d0894f898 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000082000 RCX: ffffad0d0894fb89
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9c08ffffc8e0
 RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000000823ff
 R10: 0000000000000000 R11: ffffad0d0894fb89 R12: 0000000000000000
 R13: ffffad0d0894fb10 R14: ffffad0d0894fb89 R15: ffffd43382080000
 FS:  00007f92c1c84740(0000) GS:ffff9c08df9c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffd43382060000 CR3: 0000000966150002 CR4: 00000000001606e0
