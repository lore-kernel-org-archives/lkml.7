Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74BEC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A45A2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MwaQo/sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfG3UWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:22:43 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42862 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfG3UWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:22:41 -0400
Received: by mail-vs1-f65.google.com with SMTP id 190so44538798vsf.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pin0BuTXFnXV44G2flY25lTnFWMYHt64CpWd+XH6ETA=;
        b=MwaQo/snLaTmUW8IZXDeePhdxb/RsZzo4M/sy2FCghzWJ+LGyWSt4d1bAcihPmbKWA
         QZUcepkSu1qSlwsL7sBTWY1mTYwy+A4Exx1NBR2WBOu0pZpKS44/6mRiiv7HKoWFyJEa
         xgE5BvTVSDYRuXQzF7GAlz+18uR7g8CBf0epvBs1Z9p4fwOzjMWHV5hrJD2TIViEXjUE
         m4yJWb5hBfEdGRCOfeTynr53zJT16uk001fwDSb/gw30Nqb4nVfD968d8uFVmZF7sxtn
         5CXZqulTWaAPk49O4f41T8zNNUJbp1m0IamZbcSQjQZxR8UbNp5VMiwqHdtvJOIzHy1k
         7xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pin0BuTXFnXV44G2flY25lTnFWMYHt64CpWd+XH6ETA=;
        b=k4P+zHVHomfWbovqFCKLVEk4QfylvmZsJZBYGwDuYCgK+qM07WD4NklT0IyUUPQPiq
         SYOBOBJU9++62Mxg0Re8lXnklzXtX20od9R3M7TWX04o84+SCLIhUq6GfJFCQ0/GvjY4
         BimwAriuTfa0NZtlDnmygvV2zF8l4OAC7sXQjvrbLBo1B3rHJY5vY5l1MSbK8fw6IdMm
         j/WzFHxqOXCjFmBtMHQxHCahzsnEjUoKpqoUu2JDU7uyPF0qRt8GUZNOjgADihOueMU3
         ARFoX5016NZZ9KtllMWXfRvz7z3QSArJiA+kIFpgA1b9NMVezzQeHapwAJ3hOmzfDYNa
         ajgQ==
X-Gm-Message-State: APjAAAU+8jbMOeJUzRDJc0zTwu6HbndVMNb//AV4H0D73mlkHEpYt+OF
        4bu/Vt8+gDClV41GYYgSoa84IA==
X-Google-Smtp-Source: APXvYqzCQKMn3kQgsxVVTS+nvJGcRT6kiXUdTnCk6iYhCnfnEIIWu4+Ziap7KLToglten9rcOVKQ+w==
X-Received: by 2002:a67:ab0d:: with SMTP id u13mr77352236vse.145.1564518159717;
        Tue, 30 Jul 2019 13:22:39 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o9sm44044033vkd.27.2019.07.30.13.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 13:22:39 -0700 (PDT)
Message-ID: <1564518157.11067.34.camel@lca.pw>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
From:   Qian Cai <cai@lca.pw>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Tue, 30 Jul 2019 16:22:37 -0400
In-Reply-To: <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
         <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 12:57 -0700, Andrew Morton wrote:
> On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com>
> wrote:
> 
> > Add mempool allocations for struct kmemleak_object and
> > kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> > under memory pressure. Additionally, mask out all the gfp flags passed
> > to kmemleak other than GFP_KERNEL|GFP_ATOMIC.
> > 
> > A boot-time tuning parameter (kmemleak.mempool) is added to allow a
> > different minimum pool size (defaulting to NR_CPUS * 4).
> 
> Why would anyone ever want to alter this?  Is there some particular
> misbehaviour which this will improve?  If so, what is it?

So it can tolerant different systems and workloads. For example, there are some
machines with slow disk and fast CPUs. When they are under memory pressure, it
could take a long time to swap before the OOM kicks in to free up some memory.
As the results, it needs a large mempool for kmemleak or suffering from higher
chance of a kmemleak metadata allocation failure.

> 
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2011,6 +2011,12 @@
> >  			Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
> >  			the default is off.
> >  
> > +	kmemleak.mempool=
> > +			[KNL] Boot-time tuning of the minimum kmemleak
> > +			metadata pool size.
> > +			Format: <int>
> > +			Default: NR_CPUS * 4
> > +

Catalin, BTW, it is right now unable to handle a large size. I tried to reserve
64M (kmemleak.mempool=67108864),

[    0.039254][    T0] WARNING: CPU: 0 PID: 0 at mm/page_alloc.c:4707
__alloc_pages_nodemask+0x3b8/0x1780
[    0.039284][    T0] Modules linked in:
[    0.039309][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc2-next-
20190730+ #3
[    0.039328][    T0] NIP:  c000000000395038 LR: c0000000003d9320 CTR:
0000000000000000
[    0.039355][    T0] REGS: c00000000170f710 TRAP: 0700   Not tainted  (5.3.0-
rc2-next-20190730+)
[    0.039384][    T0] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR:
24000884  XER: 20040000
[    0.039431][    T0] CFAR: c000000000394cd4 IRQMASK: 0 
[    0.039431][    T0] GPR00: c0000000003d9320 c00000000170f9a0 c000000001708c00
0000000000040cc0 
[    0.039431][    T0] GPR04: 0000000000000010 0000000000000000 0000000000000000
c000000002aac080 
[    0.039431][    T0] GPR08: 0000001ffb3a0000 0000000000000000 c0000000003d9320
0000000000000000 
[    0.039431][    T0] GPR12: 0000000024000882 c000000002760000 0000000000000000
0000000000000000 
[    0.039431][    T0] GPR16: 0000000000000000 0000000000000000 0000000000000000
0000000000000000 
[    0.039431][    T0] GPR20: 0000000000000000 0000000000000001 0000000010004d9c
00000000100053ed 
[    0.039431][    T0] GPR24: ffffffffffffffff ffffffffffffffff c0000000002e9544
0000000100000000 
[    0.039431][    T0] GPR28: 0000000000000cc0 0000000100000000 0000000000040cc0
c0000000027e8c48 
[    0.039646][    T0] NIP [c000000000395038]
__alloc_pages_nodemask+0x3b8/0x1780
[    0.039693][    T0] LR [c0000000003d9320] kmalloc_large_node+0x100/0x1a0
[    0.039727][    T0] Call Trace:
[    0.039749][    T0] [c00000000170f9a0] [0000000000000001] 0x1 (unreliable)
[    0.039776][    T0] [c00000000170fbe0] [0000000000000000] 0x0
[    0.039795][    T0] [c00000000170fc80] [c0000000003e5080]
__kmalloc_node+0x520/0x890
[    0.039816][    T0] [c00000000170fd20] [c0000000002e9544]
mempool_init_node+0xb4/0x1e0
[    0.039836][    T0] [c00000000170fd80] [c0000000002e975c]
mempool_create_node+0xcc/0x150
[    0.039857][    T0] [c00000000170fdf0] [c000000000b2a730]
kmemleak_init+0x16c/0x54c
[    0.039878][    T0] [c00000000170fef0] [c000000000ae460c]
start_kernel+0x69c/0x7cc
[    0.039908][    T0] [c00000000170ff90] [c00000000000a7d4]
start_here_common+0x1c/0x434
[    0.039945][    T0] Instruction dump:
[    0.039976][    T0] 4bffff14 e92d0968 39291020 3bc00001 f9210148 4bfffd98
7d435378 4bf94eed 
[    0.040012][    T0] 60000000 4bfffdfc 70692000 4082ffd0 <0fe00000> 3bc00000
4bfffedc 39200000 
[    0.040049][    T0] ---[ end trace 038320b411324ff7 ]---
[    0.040100][    T0] kmemleak: Kernel memory leak detector disabled


[   16.192449][    T1] BUG: Unable to handle kernel data access at
0xffffffffffffb2aa
[   16.192473][    T1] Faulting instruction address: 0xc000000000b2a2fc
[   16.192500][    T1] Oops: Kernel access of bad area, sig: 11 [#1]
[   16.192526][    T1] LE PAGE_SIZE=64K MMU=Radix MMU=Hash SMP NR_CPUS=256
DEBUG_PAGEALLOC NUMA PowerNV
[   16.192567][    T1] Modules linked in:
[   16.192593][    T1] CPU: 4 PID: 1 Comm: swapper/0 Tainted:
G        W         5.3.0-rc2-next-20190730+ #3
[   16.192646][    T1] NIP:  c000000000b2a2fc LR: c0000000003e6e48 CTR:
c0000000000b4380
[   16.192698][    T1] REGS: c00000002aaef9d0 TRAP: 0380   Tainted:
G        W          (5.3.0-rc2-next-20190730+)
[   16.192750][    T1] MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR:
28002884  XER: 20040000
[   16.192801][    T1] CFAR: c00000000043769c IRQMASK: 0 
[   16.192801][    T1] GPR00: c0000000003e6e48 c00000002aaefc60 c000000001708c00
0000000000000002 
[   16.192801][    T1] GPR04: c000000002c42648 0000000000000000 0000000000000000
ffffffff00001e77 
[   16.192801][    T1] GPR08: 0000000000000000 0000000000000001 0000000000000800
0000000000000000 
[   16.192801][    T1] GPR12: 0000000000002000 c000001fffffbc00 c0000000000103d8
0000000000000000 
[   16.192801][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000
0000000000000000 
[   16.192801][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000
0000000000000000 
[   16.192801][    T1] GPR24: 0000000000000000 c000000002aa9c80 c0000000018d0730
c0000000003c9270 
[   16.192801][    T1] GPR28: 000000000000b100 c00c00000000b100 c000000002c42648
c000000002aa9c80 
[   16.193126][    T1] NIP [c000000000b2a2fc] log_early+0x8/0x160
[   16.193153][    T1] LR [c0000000003e6e48] kmem_cache_free+0x428/0x740
[   16.193190][    T1] Call Trace:
[   16.193213][    T1] [c00000002aaefc60] [0000000000000366] 0x366 (unreliable)
[   16.193243][    T1] [c00000002aaefd00] [c0000000003c9270]
__mpol_put+0x50/0x70
[   16.193272][    T1] [c00000002aaefd20] [c0000000003c9488]
do_set_mempolicy+0x108/0x170
[   16.193314][    T1] [c00000002aaefdb0] [c000000000010434]
kernel_init+0x64/0x150
[   16.193363][    T1] [c00000002aaefe20] [c00000000000b1cc]
ret_from_kernel_thread+0x5c/0x70
[   16.193412][    T1] Instruction dump:
[   16.193436][    T1] aaaaaaaa aaaaaaaa aaaaaaaa aaaaaaaa aaaaaaaa aaaaaaaa
aaaaaaaa aaaaaaaa 
[   16.193486][    T1] aaaaaaaa aaaaaaaa aaaaaaaa aaaaaaaa <aaaaaaaa> aaaaaaaa
aaaaaaaa aaaaaaaa 
[   16.193556][    T1] ---[ end trace 038320b411324ff9 ]---
[   16.587204][    T1] 
[   17.587316][    T1] Kernel panic - not syncing: Fatal exception
