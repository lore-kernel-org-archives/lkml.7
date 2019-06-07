Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB96C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4949021479
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfFGHky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:40:54 -0400
Received: from swift.blarg.de ([138.201.185.127]:39136 "EHLO swift.blarg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFGHky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:40:54 -0400
Received: by swift.blarg.de (Postfix, from userid 1000)
        id 3B03B4061F; Fri,  7 Jun 2019 09:40:52 +0200 (CEST)
Date:   Fri, 7 Jun 2019 09:40:52 +0200
From:   Max Kellermann <max@blarg.de>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
Message-ID: <20190607074052.GA30233@swift.blarg.de>
Mail-Followup-To: Justin Piszcz <jpiszcz@lucidpixels.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
 <20190509111343.rvmy5noqlf4os3zk@box>
 <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
 <20190606172440.GA24838@swift.blarg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606172440.GA24838@swift.blarg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/06 19:24, Max Kellermann <max@blarg.de> wrote:
> I have the same problem (kernel 5.1.7), but over here, it's a PHP
> process, not khugepaged, which is looping inside compaction_alloc.

This is what happened an hour later:

 kernel tried to execute NX-protected page - exploit attempt? (uid: 33333)
 BUG: unable to handle kernel paging request at ffffffffc036f00f
 #PF error: [PROT] [INSTR]
 PGD 35fa10067 P4D 35fa10067 PUD 35fa12067 PMD 105ba71067 PTE 800000022d28e061
 Oops: 0011 [#1] SMP PTI
 CPU: 12 PID: 263514 Comm: php-cgi7.0 Not tainted 5.1.7-cmag1-th+ #5
 Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/17/2018
 RIP: 0010:0xffffffffc036f00f
 Code: Bad RIP value.
 RSP: 0018:ffffb63c4d547928 EFLAGS: 00010216
 RAX: 0000000000000000 RBX: ffffb63c4d547b10 RCX: 0000ffc004d021bd
 RDX: ffff9ac83fffc500 RSI: 7fe0026810dee7ff RDI: 7fe0026810dee400
 RBP: 7fe0026810dee400 R08: 0000000000000002 R09: 0000000000020300
 R10: 00010642641a0d3a R11: 0000000000000001 R12: 7fe0026810dee800
 R13: 0000000000000001 R14: 0000000000000000 R15: ffff9ac83fffc500
 FS:  00007fa5c1000740(0000) GS:ffff9ad01f600000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffc036efe5 CR3: 00000008eb8a0005 CR4: 00000000001606e0
 Call Trace:
  ? move_freelist_tail+0xd0/0xd0
  ? migrate_pages+0xaa/0x780
  ? isolate_freepages_block+0x380/0x380
  ? compact_zone+0x6ec/0xca0
  ? compact_zone_order+0xd8/0x120
  ? try_to_compact_pages+0xb1/0x260
  ? __alloc_pages_direct_compact+0x87/0x160
  ? __alloc_pages_slowpath+0x427/0xd50
  ? __alloc_pages_nodemask+0x2d6/0x310
  ? do_huge_pmd_anonymous_page+0x131/0x680
  ? vma_merge+0x24f/0x3a0
  ? __handle_mm_fault+0xbca/0x1260
  ? handle_mm_fault+0x135/0x1b0
  ? __do_page_fault+0x242/0x4b0
  ? page_fault+0x8/0x30
  ? page_fault+0x1e/0x30
 Modules linked in:
 CR2: ffffffffc036f00f
 ---[ end trace 0f31edf3041f5d9e ]---
 RIP: 0010:0xffffffffc036f00f
 Code: Bad RIP value.
 RSP: 0018:ffffb63c4d547928 EFLAGS: 00010216
 RAX: 0000000000000000 RBX: ffffb63c4d547b10 RCX: 0000ffc004d021bd
 RDX: ffff9ac83fffc500 RSI: 7fe0026810dee7ff RDI: 7fe0026810dee400
 RBP: 7fe0026810dee400 R08: 0000000000000002 R09: 0000000000020300
 R10: 00010642641a0d3a R11: 0000000000000001 R12: 7fe0026810dee800
 R13: 0000000000000001 R14: 0000000000000000 R15: ffff9ac83fffc500
 FS:  00007fa5c1000740(0000) GS:ffff9ad01f600000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffc036efe5 CR3: 00000008eb8a0005 CR4: 00000000001606e0
