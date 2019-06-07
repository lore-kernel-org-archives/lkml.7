Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A77C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59E5208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfFGHue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:50:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39497 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfFGHue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:50:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so1115376wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nLFnTrO61LKgRgXHYPNZ1fqiI2iZKV8tUvcahKPfvaI=;
        b=cRpMGglIWys0F7l9KE3aPJNkOFwwcTBZG1N/1J5FzzKrHq4XY1P4+Rcrg7c6MMVWlV
         VAtJScY7OWQq9ZId5TcXb87KtwKflJI18OkT4P7jeox/OTiClPDytuMKnwz70k+Mo0aZ
         nL6SMcUwVSoAeneBNrIf19lDh02QMl54jRdWiadLWRKT3nnnXZW/8NBNQwBIOdpeBAQw
         +hboiXu4p1mB7jULQ/wKKP5zTm4K3N5PTUJHpCsIpvAKoDPboJVT47nPcqJKVOX8REav
         6R1d0nZWvFydT4p0v8Rkz+p+MjKEzoTs1XTebUInw+oFJCsTGDpPYhqsLCGG/0QjkuDw
         HnQA==
X-Gm-Message-State: APjAAAUDQDF+3h7i05TuzE3//Amloh5sUYX7WQcsfUR8sAtdcEjvTDhL
        QjjDiI+iIxZ5gw4ZmW7o9a/E6g==
X-Google-Smtp-Source: APXvYqzjxjyRT0+0FzcXHiJErFkCbJ5+FbyIi3LoLZkKRTVitMnRuF7dBy3/5dd8BPOqqY2xZ6MMVA==
X-Received: by 2002:a5d:4a82:: with SMTP id o2mr15934627wrq.154.1559893832237;
        Fri, 07 Jun 2019 00:50:32 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y2sm1131394wra.58.2019.06.07.00.50.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:50:31 -0700 (PDT)
Date:   Fri, 7 Jun 2019 09:50:30 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Max Kellermann <max@blarg.de>,
        Justin Piszcz <jpiszcz@lucidpixels.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
Message-ID: <20190607075030.s4tvf7m7mc2podmo@butterfly.localdomain>
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
 <20190509111343.rvmy5noqlf4os3zk@box>
 <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
 <20190606172440.GA24838@swift.blarg.de>
 <20190607074052.GA30233@swift.blarg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607074052.GA30233@swift.blarg.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, Jun 07, 2019 at 09:40:52AM +0200, Max Kellermann wrote:
> On 2019/06/06 19:24, Max Kellermann <max@blarg.de> wrote:
> > I have the same problem (kernel 5.1.7), but over here, it's a PHP
> > process, not khugepaged, which is looping inside compaction_alloc.
> 
> This is what happened an hour later:
> 
>  kernel tried to execute NX-protected page - exploit attempt? (uid: 33333)
>  BUG: unable to handle kernel paging request at ffffffffc036f00f
>  #PF error: [PROT] [INSTR]
>  PGD 35fa10067 P4D 35fa10067 PUD 35fa12067 PMD 105ba71067 PTE 800000022d28e061
>  Oops: 0011 [#1] SMP PTI
>  CPU: 12 PID: 263514 Comm: php-cgi7.0 Not tainted 5.1.7-cmag1-th+ #5
>  Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/17/2018
>  RIP: 0010:0xffffffffc036f00f
>  Code: Bad RIP value.
>  RSP: 0018:ffffb63c4d547928 EFLAGS: 00010216
>  RAX: 0000000000000000 RBX: ffffb63c4d547b10 RCX: 0000ffc004d021bd
>  RDX: ffff9ac83fffc500 RSI: 7fe0026810dee7ff RDI: 7fe0026810dee400
>  RBP: 7fe0026810dee400 R08: 0000000000000002 R09: 0000000000020300
>  R10: 00010642641a0d3a R11: 0000000000000001 R12: 7fe0026810dee800
>  R13: 0000000000000001 R14: 0000000000000000 R15: ffff9ac83fffc500
>  FS:  00007fa5c1000740(0000) GS:ffff9ad01f600000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffffffffc036efe5 CR3: 00000008eb8a0005 CR4: 00000000001606e0
>  Call Trace:
>   ? move_freelist_tail+0xd0/0xd0
>   ? migrate_pages+0xaa/0x780
>   ? isolate_freepages_block+0x380/0x380
>   ? compact_zone+0x6ec/0xca0
>   ? compact_zone_order+0xd8/0x120
>   ? try_to_compact_pages+0xb1/0x260
>   ? __alloc_pages_direct_compact+0x87/0x160
>   ? __alloc_pages_slowpath+0x427/0xd50
>   ? __alloc_pages_nodemask+0x2d6/0x310
>   ? do_huge_pmd_anonymous_page+0x131/0x680
>   ? vma_merge+0x24f/0x3a0
>   ? __handle_mm_fault+0xbca/0x1260
>   ? handle_mm_fault+0x135/0x1b0
>   ? __do_page_fault+0x242/0x4b0
>   ? page_fault+0x8/0x30
>   ? page_fault+0x1e/0x30
>  Modules linked in:
>  CR2: ffffffffc036f00f
>  ---[ end trace 0f31edf3041f5d9e ]---
>  RIP: 0010:0xffffffffc036f00f
>  Code: Bad RIP value.
>  RSP: 0018:ffffb63c4d547928 EFLAGS: 00010216
>  RAX: 0000000000000000 RBX: ffffb63c4d547b10 RCX: 0000ffc004d021bd
>  RDX: ffff9ac83fffc500 RSI: 7fe0026810dee7ff RDI: 7fe0026810dee400
>  RBP: 7fe0026810dee400 R08: 0000000000000002 R09: 0000000000020300
>  R10: 00010642641a0d3a R11: 0000000000000001 R12: 7fe0026810dee800
>  R13: 0000000000000001 R14: 0000000000000000 R15: ffff9ac83fffc500
>  FS:  00007fa5c1000740(0000) GS:ffff9ad01f600000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffffffffc036efe5 CR3: 00000008eb8a0005 CR4: 00000000001606e0

Make sure to check if e577c8b64d ("mm, compaction: make sure we isolate
a valid PFN") fixes your issue. It is staged for 5.1.8, BTW.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
