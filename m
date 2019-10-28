Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD32CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26801214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="QC9FLSQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfJ1UOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:14:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44014 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfJ1UOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:14:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id a194so9764755qkg.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m+3REzNPMTuz62QCN86CmNo1QH4WSYWkJwr0CVYc9KU=;
        b=QC9FLSQpSmjnit0aWLTBLyriTlwzTSs833/NOWlpj0Yh90urVfTFBw2I5U9/bbSEGq
         YSd4L1+WP7lVgYoBnKgdL7u5D9i7j2pAPWxoj6engcu/LoLwQqRYwzS1CgJ5qDvcANfI
         kNrujX/BYGHPW8N1jPLKePmwAI7bkwtRkUQP1+qAoXjtqA00suPteypfCVmQHoF3wwfH
         ZsWFBsGl6/bHPFvX/Jvupj8345ZN/K1pslFMhEwF5HZ4Z4Y809s4/KVAaHdyom+MIyIi
         fBd3Cpj0rL/SAOZOuZuBUv9bdganXvFWNp1r11zgHEUSh+V177IzA5mzxHOzwE/oBDC2
         qIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m+3REzNPMTuz62QCN86CmNo1QH4WSYWkJwr0CVYc9KU=;
        b=rvgBfCQY67XM+xiCjEd393/eh9nUcDzq8eo5j3mKwRb+TdmgDpdrz7FwntNRBWL+/B
         g7/OGKPM5ES2rglP39oPQB+tEU8YFIliGL/W68cALTV8ouCnnhMzeEqbiHYpZpd2NIvh
         Z4wjjjwQPfU11Z3ONk3HuQvn7enh8Y3h0tWftiEDVkaqZnXc97Q8EhB/3FH9AiCLqovt
         hSdQkHQc8hzqzRaxJ7EqxFrxvzjz1D/7TwiI0hKDontovkL9p4ClxiJUNwRbXTJ8XGaE
         YvyWlHPe2A8LYvku8FrBD4gpxeqOg5pZ1X1fhoiSQKTImYSQxNSwt20+cIy6ljMIlz+R
         JCqQ==
X-Gm-Message-State: APjAAAWJld2QP7xMv/lS05g9un47xVwmc58AD6bLCm3zr6/YFT7QJFao
        95Kd2vym4DTV9/rxsMsXoj+rKQ==
X-Google-Smtp-Source: APXvYqxv4NMZ3h1zVYvyoIBWDqcPEkznj6sPjvy5Mvwz06SxwTXrMtNOK4BzshJ4bsYbHaUHZmdL5Q==
X-Received: by 2002:ae9:f407:: with SMTP id y7mr17771371qkl.154.1572293686217;
        Mon, 28 Oct 2019 13:14:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:831b])
        by smtp.gmail.com with ESMTPSA id y186sm6720503qkd.71.2019.10.28.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 13:14:45 -0700 (PDT)
Date:   Mon, 28 Oct 2019 16:14:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     syzbot <syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, amir73il@gmail.com,
        darrick.wong@oracle.com, hughd@google.com, jack@suse.cz,
        jglisse@redhat.com, josef@toxicpanda.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sfr@canb.auug.org.au, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, william.kucharski@oracle.com,
        willy@infradead.org
Subject: Re: INFO: task hung in mpage_prepare_extent_to_map
Message-ID: <20191028201444.GA27425@cmpxchg.org>
References: <000000000000c50fd70595fdd5b2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c50fd70595fdd5b2@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:52:09PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    12d61c69 Add linux-next specific files for 20191024
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15a0fa97600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=afb75fd8c9fd5ed8
> dashboard link: https://syzkaller.appspot.com/bug?extid=efb9e48b9fbdc49bb34a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a63dc4e00000
> 
> The bug was bisected to:
> 
> commit 9c61acffe2b8833152041f7b6a02d1d0a17fd378
> Author: Song Liu <songliubraving@fb.com>
> Date:   Wed Oct 23 00:24:28 2019 +0000
> 
>     mm,thp: recheck each page before collapsing file THP
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13eb6ec0e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=101b6ec0e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17eb6ec0e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+efb9e48b9fbdc49bb34a@syzkaller.appspotmail.com
> Fixes: 9c61acffe2b8 ("mm,thp: recheck each page before collapsing file THP")
> 
> INFO: task khugepaged:1084 blocked for more than 143 seconds.
>       Not tainted 5.4.0-rc4-next-20191024 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> khugepaged      D27568  1084      2 0x80004000
> Call Trace:
>  context_switch kernel/sched/core.c:3384 [inline]
>  __schedule+0x94a/0x1e70 kernel/sched/core.c:4069
>  schedule+0xd9/0x260 kernel/sched/core.c:4136
>  io_schedule+0x1c/0x70 kernel/sched/core.c:5780
>  wait_on_page_bit_common mm/filemap.c:1175 [inline]
>  __lock_page+0x422/0xab0 mm/filemap.c:1383
>  lock_page include/linux/pagemap.h:480 [inline]
>  mpage_prepare_extent_to_map+0xb3f/0xf90 fs/ext4/inode.c:2668
>  ext4_writepages+0xb6a/0x2e70 fs/ext4/inode.c:2866
>  ? 0xffffffff81000000
>  do_writepages+0xfa/0x2a0 mm/page-writeback.c:2344
>  __filemap_fdatawrite_range+0x2bc/0x3b0 mm/filemap.c:421
>  __filemap_fdatawrite mm/filemap.c:429 [inline]
>  filemap_flush+0x24/0x30 mm/filemap.c:456

This is a double locking deadlock. The page lock is already held when
we call into filemap_flush() here, and does another lock_page() in
write_cache_pages().

To fix it, we have to either initiate flushing before acquiring the
page lock, or simply skip over dirty pages.

Maybe doing vfs_fsync_range() from the madvise(HUGEPAGE) call isn't a
bad idea after all? (I had discussed this with Song off-list before.)
