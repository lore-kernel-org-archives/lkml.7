Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14266C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3FA24BC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3mAGvJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfEaS1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:27:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42112 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfEaS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:27:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so3226718pgd.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bbOqnbmTGXv/6/haJB5JLsDUylGaUzhOYgszuwARoI=;
        b=q3mAGvJtn/FGfV5nqwCBNUkHV2yfFVW/ZH8teze3YIS4vx/yz/KQVsxWIOgvan37n+
         9aaMX2KNuiMUxYhFH6kCLdCQ3lqWNoMxLoxYJqIhqtF48CAR70F2hCzaMzru8Ue2eNY1
         OITa4PMxjQsb6BVOdunQQK3xduHsxEp2ycL0+7h7q7pA8UuF40TYB490dwb5KADwoPQs
         dxZiMKY4WMl5pSPIJOUaN9hqKQw2Sp7woWaQCcEgj3IaOi+F37mktiz05ih+QSihJ1YW
         SQKn7HlK4ZZtKEGBtiweqZuqbFCtqwR+7dOYJCovF+W2YnHoLetG00/2f7hP9XNt1Mgs
         JTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bbOqnbmTGXv/6/haJB5JLsDUylGaUzhOYgszuwARoI=;
        b=W/9xjJqK3S5Rh08XQDB2IR3RVloVave5OxX4Po9cXKf/UzEa+iv35pnwv2eMNMuFAH
         GSYan/X2LsekHU0oJYfTAV1SNE6oY/TnQof9ElZsJ7w6BigfLwGV08vow63KrNds0RjF
         Le96lWBJYdXkCNzTJP1LeQliy4tNAX0WZLXWroJ2VGl+ERUZ1Uu/QcSo2snui4XD4Vwv
         HEM0jxxthRCm/uFzcvY8TtniLPg9rluIndhJ1Iyy0mYIywz1B0zznkLuK2ftit0MBxD0
         lIHwLKFobe0WNfhw+LIqvjWYGZ4Agp0VjHZdUukJUGFLO0q2ijokr/6zKiuJKBfx5gv0
         ASvQ==
X-Gm-Message-State: APjAAAXcC57hSHNvfwNvZRmkCf0yZII2t8SeB1pG71oaoSyJeHxwhI4R
        LVAsi0N3wkghoM0G8qz62P0MOaL7DcGbPS2oNKI=
X-Google-Smtp-Source: APXvYqwQMcr1qn0FkaYD3DdOVIWXjRV6sg40ZSZOHCBykJYBOaDa1v/PIa0HksZ5+N2GYPqKhF22NlekYme7g+TIHug=
X-Received: by 2002:aa7:8dc3:: with SMTP id j3mr12239577pfr.141.1559327251853;
 Fri, 31 May 2019 11:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190531024102.21723-1-ying.huang@intel.com> <2d8e1195-e0f1-4fa8-b0bd-b9ea69032b51@oracle.com>
In-Reply-To: <2d8e1195-e0f1-4fa8-b0bd-b9ea69032b51@oracle.com>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Fri, 31 May 2019 11:27:20 -0700
Message-ID: <CAA42JLZ=X_gzvH6e3Kt805gJc0PSLSgmE5ozPDjXeZbiSipuXA@mail.gmail.com>
Subject: Re: [PATCH -mm] mm, swap: Fix bad swap file entry warning
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Dexuan Cui <decui@microsoft.com>, v-lide@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:00 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/30/19 7:41 PM, Huang, Ying wrote:
> > From: Huang Ying <ying.huang@intel.com>
> >
> > Mike reported the following warning messages
> >
> >   get_swap_device: Bad swap file entry 1400000000000001
> >
> > This is produced by
> >
> > - total_swapcache_pages()
> >   - get_swap_device()
> >
> > Where get_swap_device() is used to check whether the swap device is
> > valid and prevent it from being swapoff if so.  But get_swap_device()
> > may produce warning message as above for some invalid swap devices.
> > This is fixed via calling swp_swap_info() before get_swap_device() to
> > filter out the swap devices that may cause warning messages.
> >
> > Fixes: 6a946753dbe6 ("mm/swap_state.c: simplify total_swapcache_pages() with get_swap_device()")
> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>
> Thank you, this eliminates the messages for me:
>
> Tested-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> --
> Mike Kravetz

Hi,
Did you know about the panic reported here:
https://marc.info/?t=155930773000003&r=1&w=2

"Kernel panic - not syncing: stack-protector: Kernel stack is
corrupted in: write_irq_affinity.isra"

This panic is reported on PowerPC and x86.

In the case of x86, we see a lot of "get_swap_device: Bad swap file entry"
errors before the panic:

...
[   24.404693] get_swap_device: Bad swap file entry 5800000000000001
[   24.408702] get_swap_device: Bad swap file entry 5c00000000000001
[   24.412510] get_swap_device: Bad swap file entry 6000000000000001
[   24.416519] get_swap_device: Bad swap file entry 6400000000000001
[   24.420217] get_swap_device: Bad swap file entry 6800000000000001
[   24.423921] get_swap_device: Bad swap file entry 6c00000000000001
[   24.427685] get_swap_device: Bad swap file entry 7000000000000001
[   24.760678] Kernel panic - not syncing: stack-protector: Kernel
stack is corrupted in: write_irq_affinity.isra.7+0xe5/0xf0
[   24.760975] CPU: 25 PID: 1773 Comm: irqbalance Not tainted
5.2.0-rc2-2fefea438dac #1
[   24.760975] Hardware name: Microsoft Corporation Virtual
Machine/Virtual Machine, BIOS 090007  06/02/2017
[   24.760975] Call Trace:
[   24.760975]  dump_stack+0x46/0x5b
[   24.760975]  panic+0xf8/0x2d2
[   24.760975]  ? write_irq_affinity.isra.7+0xe5/0xf0
[   24.760975]  __stack_chk_fail+0x15/0x20
[   24.760975]  write_irq_affinity.isra.7+0xe5/0xf0
[   24.760975]  proc_reg_write+0x40/0x60
[   24.760975]  vfs_write+0xb3/0x1a0
[   24.760975]  ? _cond_resched+0x16/0x40
[   24.760975]  ksys_write+0x5c/0xe0
[   24.760975]  do_syscall_64+0x4f/0x120
[   24.760975]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.760975] RIP: 0033:0x7f93bcdde187
[   24.760975] Code: c3 66 90 41 54 55 49 89 d4 53 48 89 f5 89 fb 48
83 ec 10 e8 6b 05 02 00 4c 89 e2 41 89 c0 48 89 ee 89 df b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 a4 05 02
00 48
[   24.760975] RSP: 002b:00007ffc4600d900 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[   24.760975] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f93bcdde187
[   24.760975] RDX: 0000000000000008 RSI: 00005595ad515540 RDI: 0000000000000006
[   24.760975] RBP: 00005595ad515540 R08: 0000000000000000 R09: 00005595ab381820
[   24.760975] R10: 0000000000000008 R11: 0000000000000293 R12: 0000000000000008
[   24.760975] R13: 0000000000000008 R14: 00007f93bd0b62a0 R15: 00007f93bd0b5760
[   24.760975] Kernel Offset: 0x3a000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   24.760975] ---[ end Kernel panic - not syncing: stack-protector:
Kernel stack is corrupted in: write_irq_affinity.isra.7+0xe5/0xf0 ]---

Thanks,
-- Dexuan
