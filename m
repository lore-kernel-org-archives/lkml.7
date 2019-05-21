Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B29FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C5D2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="h5AjC6Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfEUJBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:01:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44392 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfEUJBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:01:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id g18so15609485otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ge56bwxr1RPinKCaA6qo1Uck5R0XoR6kdkJ4YNKckMc=;
        b=h5AjC6Mury7j/vs+iLkOmEAaE9pSmrreKStll7qg6WbttKGcMWzj+PeLls12HlaL9U
         ko5T47luNIErtzfDhPvzo4nM0HqL/FLA0fbbf7dPJNclRjaWDek+B/bzUyrK/licwrfq
         lL4wP+snRHohgq3xznEngLs1jWftI3MbI07fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ge56bwxr1RPinKCaA6qo1Uck5R0XoR6kdkJ4YNKckMc=;
        b=HyvZv3TzZ6C/gXKMK34OutjF6oVGIEBJ7NJLPEd/E9jSf1pxV6MOvZN2SxqFprYqth
         SFjjbHtrxYcY82ifNA8qcXPv5l2ANPNCzL8CV4KtgolXQVjf89OegDMZKXFRsJgJFQXn
         k/qBLxUDNIxEOYCPz9pgzdsQpIgtYrdRKVOKsDdrnHlFcSPlC0zDEMPmAqRPvdATK1dC
         NuiF9fVH1lOxkMfkb9AjxyBh8c7SKmcRN/41q/X3jrYwzz9TnwsQaafd/PUj+4wsmE8U
         2gSkTzKA7AZat5N82TlMctvOg7djXk7LsaRwmYp1gIdjkcLPtUo7aSyEBQcr9cg/VeQ4
         mAbg==
X-Gm-Message-State: APjAAAXzGQJDSfLAX8XEojXlqd1XwKeAqhCfAltN/8qtDkyWoZt59Te5
        TKQsr2be1KggreY+xr1P/S8o6yLITjVBCqptkuL8aQeQL3pzbw==
X-Google-Smtp-Source: APXvYqz81wmT2WjBOs3p+AbBFqdEzhYVoOVSKq1+SvoU8I15bm/o7O5s+9s0p39Smjg1DKlxuffZsAIZS0JlCq/hzOM=
X-Received: by 2002:a05:6830:1584:: with SMTP id i4mr21772823otr.109.1558429277453;
 Tue, 21 May 2019 02:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
 <20190520115608.GK18914@techsingularity.net>
In-Reply-To: <20190520115608.GK18914@techsingularity.net>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Tue, 21 May 2019 05:01:06 -0400
Message-ID: <CAO9zADzz9QJ9Rp_Acy5GRggfYZzDwYYNWhCvPc9XHd+G=gS5zw@mail.gmail.com>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at ffffea0002030000
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 7:56 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Sun, May 12, 2019 at 04:27:45AM -0400, Justin Piszcz wrote:
> > Hello,
> >
> > I've turned off zram/zswap and I am still seeing the following during
> > periods of heavy I/O, I am returning to 5.0.xx in the meantime.
> >
> > Kernel: 5.1.1
> > Arch: x86_64
> > Dist: Debian x86_64
> >
> > [29967.019411] BUG: unable to handle kernel paging request at ffffea0002030000
> > [29967.019414] #PF error: [normal kernel read fault]
> > [29967.019415] PGD 103ffee067 P4D 103ffee067 PUD 103ffed067 PMD 0
> > [29967.019417] Oops: 0000 [#1] SMP PTI
> > [29967.019419] CPU: 10 PID: 77 Comm: khugepaged Tainted: G
> >    T 5.1.1 #4
> > [29967.019420] Hardware name: Supermicro X9SRL-F/X9SRL-F, BIOS 3.2 01/16/2015
> > [29967.019424] RIP: 0010:isolate_freepages_block+0xb9/0x310
> > [29967.019425] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49
> > 8d 45 79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef
> > 00 00 00 <48> 8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01
> > 0f 84
>
> If you have debugging symbols installed, can you translate the faulting
> address with the following?
>
> ADDR=`nm /path/to/vmlinux-or-debuginfo-file | grep "t isolate_freepages_block\$" | awk '{print $1}'`
> addr2line -i -e vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))`

Another event this morning, this occurred when copying a single ~25GB
backup file from one block device device (3ware HW RAID) to a SW
RAID-1 (mdadm):

With this event, it was a fault and khugepaged is not stuck at 100%
but this may be related as the stack trace is similar where
compaction_alloc is utilizing most of the CPU:
https://lkml.org/lkml/2019/5/9/225

# ADDR=`nm /usr/src/linux/vmlinux | grep "t isolate_freepages_block\$"
| awk '{print $1}'`
# echo $ADDR
ffffffff812274f0
# addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0x83d))`
compaction.c:?
# addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0x8d0))`
compaction.c:?

# grep DEBUG_INFO /usr/src/linux/.config-5.1.3-2
CONFIG_DEBUG_INFO=y

I can help test again in a 2-3 weeks if needed but for now I need to
return back to disabling transparent huge pages.

[43775.068702] BUG: unable to handle kernel paging request at ffffea0002250000
[43775.068706] #PF error: [normal kernel read fault]
[43775.068707] PGD 103ffee067 P4D 103ffee067 PUD 103ffed067 PMD 0
[43775.068709] Oops: 0000 [#1] SMP PTI
[43775.068711] CPU: 1 PID: 77 Comm: khugepaged Tainted: G
  T 5.1.3 #2
[43775.068712] Hardware name: Supermicro X9SRL-F/X9SRL-F, BIOS 3.2 01/16/2015
[43775.068717] RIP: 0010:isolate_freepages_block+0xb9/0x310
[43775.068718] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49
8d 45 79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef
00 00 00 <48> 8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01
0f 84
[43775.068719] RSP: 0018:ffffc900003a7860 EFLAGS: 00010246
[43775.068720] RAX: 0000000000000000 RBX: ffffea0002250000 RCX: ffffc900003a7b69
[43775.068721] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff828c4d90
[43775.068721] RBP: 0000000000089400 R08: 0000000000000001 R09: 0000000000000000
[43775.068722] R10: 0000000000000202 R11: ffffffff828c49d0 R12: 0000000000000000
[43775.068723] R13: 0000000000000000 R14: ffffc900003a7af0 R15: 0000000000000000
[43775.068724] FS:  0000000000000000(0000) GS:ffff88903f840000(0000)
knlGS:0000000000000000
[43775.068725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[43775.068725] CR2: ffffea0002250000 CR3: 000000000280e002 CR4: 00000000001606e0
[43775.068726] Call Trace:
[43775.068730]  compaction_alloc+0x83d/0x8d0
[43775.068732]  migrate_pages+0x30d/0x750
[43775.068734]  ? isolate_migratepages_block+0xa10/0xa10
[43775.068735]  ? __reset_isolation_suitable+0x110/0x110
[43775.068736]  compact_zone+0x684/0xa70
[43775.068738]  compact_zone_order+0x109/0x150
[43775.068741]  ? schedule_timeout+0x1ba/0x290
[43775.068743]  ? record_times+0x13/0xa0
[43775.068744]  try_to_compact_pages+0x10d/0x220
[43775.068747]  __alloc_pages_direct_compact+0x93/0x180
[43775.068748]  __alloc_pages_nodemask+0x6c7/0xe20
[43775.068751]  ? __wake_up_common_lock+0xb0/0xb0
[43775.068752]  khugepaged+0x31f/0x19c0
[43775.068754]  ? __wake_up_common_lock+0xb0/0xb0
[43775.068755]  ? __wake_up_common_lock+0xb0/0xb0
[43775.068756]  ? collapse_shmem.isra.4+0xc20/0xc20
[43775.068759]  kthread+0x10a/0x120
[43775.068761]  ? __kthread_create_on_node+0x1b0/0x1b0
[43775.068762]  ret_from_fork+0x35/0x40
[43775.068763] CR2: ffffea0002250000
[43775.068764] ---[ end trace 1f63fc0e799750fe ]---
[43775.068766] RIP: 0010:isolate_freepages_block+0xb9/0x310
[43775.068767] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49
8d 45 79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef
00 00 00 <48> 8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01
0f 84
[43775.068767] RSP: 0018:ffffc900003a7860 EFLAGS: 00010246
[43775.068768] RAX: 0000000000000000 RBX: ffffea0002250000 RCX: ffffc900003a7b69
[43775.068769] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff828c4d90
[43775.068770] RBP: 0000000000089400 R08: 0000000000000001 R09: 0000000000000000
[43775.068770] R10: 0000000000000202 R11: ffffffff828c49d0 R12: 0000000000000000
[43775.068771] R13: 0000000000000000 R14: ffffc900003a7af0 R15: 0000000000000000
[43775.068772] FS:  0000000000000000(0000) GS:ffff88903f840000(0000)
knlGS:0000000000000000
[43775.068773] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[43775.068773] CR2: ffffea0002250000 CR3: 000000000280e002 CR4: 00000000001606e0
