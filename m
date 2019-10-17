Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7BFFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2594A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ84Ozwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389462AbfJQM5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:57:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42736 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfJQM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:57:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so1765361otd.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzwnaF5E0NhR1cM5i+huNW3oCidI8gC26kz9mt79iqs=;
        b=XQ84OzwtgvCjV6ernd063jJjH6HQVu0l2UXHnIngxd21LQuDClgTAI9KizdYGwRlFu
         1DIJH2ZnR902Bdo3nrESpCk/Fi3cGFTE7Ryv5HhnTkf4yv5uVUssa9gXx2LXGJiQVDp7
         3k6f6PGysAbM33l+VVr/h48rNmG2HnNXRTQ19ehkpEeWs/+XuMvXk4FO5vaDQXi1YOhS
         PA9w7XCDaNMYZYTSyowuBb34D0INawMpRAqnoareBKtcwXRnU1VdqErGESIa65sDES3O
         FPo5KxCubyWFMmpTbz0MREzAG/AtHUDpmRjEaS2e8gHFV36MydIeQ9SUtPiJeHrz+hFc
         Zh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzwnaF5E0NhR1cM5i+huNW3oCidI8gC26kz9mt79iqs=;
        b=Dwu0ne0zYQ+h9XjV40zNZUKIUsCR/lZmUISky36USQemM/arrZPNd25/sTBsEDxS0U
         4D4Yow2PxVm/jE3CTwgTU8kxsUOe59k235fB0lMuZ0Pt0TYQzLXiyznG3xzjfaqhCC5c
         I2w2vLVzAo1mZwEGevaiAL4bTcH1z38Ft4Wf6fpA7VwhZOxectlWkLvuxBTL/3ApPcKJ
         TmuvpoZA4XQjR2IjMPZ5IfUwDpDA1G20ItMmx8Uw6Dd+mlnTAeC3nVe0/USSNrbTtEhf
         R0K84TiszViEh3LyEh0N8ZnOf+Z1PJwPCvfTMAtT2OGJOtoy0YnwojJ+1+fKvZAWC5hZ
         LMEg==
X-Gm-Message-State: APjAAAUnxVptkLvHoUo25bF/2ukK5kxZAaZrpTkbrv55DJ/93BgYzjru
        TUTh58pGUSUVqZbW1LaHiDyH+76rX9rmjFWY4yXCcQ==
X-Google-Smtp-Source: APXvYqy+y9M3GDWZi6YJ5Hw8mnZtdigVitXfIq4Ig/3i+If7C1GzF5himW6c6YMs0i+K+qEJppO+poTuCiSXCcISXZI=
X-Received: by 2002:a9d:6d89:: with SMTP id x9mr3019562otp.17.1571317019220;
 Thu, 17 Oct 2019 05:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000328b2905951a7667@google.com>
In-Reply-To: <000000000000328b2905951a7667@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Oct 2019 14:56:47 +0200
Message-ID: <CANpmjNPoBBJgMKLEAXs+bPhitF+WygseHgTkSJsuiK8WcsB==g@mail.gmail.com>
Subject: Re: KCSAN: data-race in task_dump_owner / task_dump_owner
To:     syzbot <syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com>
Cc:     adobriyan@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        casey@schaufler-ca.com, christian@brauner.io,
        Kees Cook <keescook@chromium.org>, kent.overstreet@gmail.com,
        khlebnikov@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Oct 2019 at 14:36, syzbot
<syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d724f94f x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=17884db3600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> dashboard link: https://syzkaller.appspot.com/bug?extid=e392f8008a294fdf8891
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in task_dump_owner / task_dump_owner
>
> write to 0xffff8881255bb7fc of 4 bytes by task 7804 on cpu 0:
>   task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
>   pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
>   pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
>   d_revalidate fs/namei.c:765 [inline]
>   d_revalidate fs/namei.c:762 [inline]
>   lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
>   walk_component+0x6d/0xe80 fs/namei.c:1804
>   link_path_walk.part.0+0x5d3/0xa90 fs/namei.c:2139
>   link_path_walk fs/namei.c:2070 [inline]
>   path_openat+0x14f/0x3530 fs/namei.c:3532
>   do_filp_open+0x11e/0x1b0 fs/namei.c:3563
>   do_sys_open+0x3b3/0x4f0 fs/open.c:1089
>   __do_sys_open fs/open.c:1107 [inline]
>   __se_sys_open fs/open.c:1102 [inline]
>   __x64_sys_open+0x55/0x70 fs/open.c:1102
>   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> write to 0xffff8881255bb7fc of 4 bytes by task 7813 on cpu 1:
>   task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
>   pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
>   pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
>   d_revalidate fs/namei.c:765 [inline]
>   d_revalidate fs/namei.c:762 [inline]
>   lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
>   walk_component+0x6d/0xe80 fs/namei.c:1804
>   lookup_last fs/namei.c:2271 [inline]
>   path_lookupat.isra.0+0x13a/0x5a0 fs/namei.c:2316
>   filename_lookup+0x145/0x2d0 fs/namei.c:2346
>   user_path_at_empty+0x4c/0x70 fs/namei.c:2606
>   user_path_at include/linux/namei.h:60 [inline]
>   vfs_statx+0xd9/0x190 fs/stat.c:187
>   vfs_stat include/linux/fs.h:3188 [inline]
>   __do_sys_newstat+0x51/0xb0 fs/stat.c:341
>   __se_sys_newstat fs/stat.c:337 [inline]
>   __x64_sys_newstat+0x3a/0x50 fs/stat.c:337
>   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 7813 Comm: ps Not tainted 5.3.0+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> ==================================================================

My understanding is, that for every access to /proc/<pid>,
d_revalidate is called, and /proc-fs implementation simply says that
pid_revalidate always revalidates by rewriting uid/gid because "owning
task may have performed a setuid(), etc." presumably so every access
to a /proc/<pid> entry always has the right uid/gid (in effect
updating /proc/<pid> lazily via d_revalidate).

Is it possible that one of the tasks above could be preempted after
doing its writes to *ruid/*rgid, another thread writing some other
values (after setuid / seteuid), and then the preempted thread seeing
the other values? Assertion here should never fail:
=== TASK 1 ===
| seteuid(1000);
| seteuid(0);
| stat("/proc/<pid-of-task-1>", &fstat);
| assert(fstat.st_uid == 0);
=== TASK 2 ===
| stat("/proc/<pid-of-task-1>", ...);


Best Wishes,
-- Marco
