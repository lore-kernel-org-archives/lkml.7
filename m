Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE8FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979382173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyNVcz0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfHYL2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 07:28:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41337 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 07:28:03 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so30578363ioj.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=C14nfWyt0iidqReRCOmecHAYDO2sZOU70ff5sYCUtZ4=;
        b=QyNVcz0vvj2nmGldZ4Qxa6auQPEp3flN3CFrZHzBr5wKi392VM8S9qZrezXTh3c8ql
         G35L2xSUvGfKvFzCKGS/YWvLy0SKGSFAHuHhCmZYxOF01pGFJUBmtJ/Y5BbXv5+dw8yO
         3srjsKacHMktfoZCHjaoZQo7RjZqFkVukn4pXegDDP3kU6Hg66Et/5qV6a/pUrSSV0Ao
         7N738c0NbLagzLrNtDFWPVj1FQkXCMOtIr/+1oD8RXXXUoRM45dlwQIKjChMiHPQZ/Z8
         xPxzzWGLgm5tp1/uykifbFSc0qDQom0rbswaoYW09xFkZstYBb2IQaVU7Dgho/G9tPOO
         +rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=C14nfWyt0iidqReRCOmecHAYDO2sZOU70ff5sYCUtZ4=;
        b=ukWBdGJktU3dDCMpWhiWQIvGnuzGC9k6yeTG6XvKc/cDxjZYpG4bSgcj1FYES3nf9L
         cnl9mMeT5ltHSTrgniubOFKrgFq9P2foz0OXm++SM7FPQJUTfjWgPxq+65R7ZpKiPoqI
         HJBEwK6qj+a4kmMXSHTE55yJ3iuWUdqLFjAZxXJpJEtXxgua/d0hSa7PdeEJ2RY15Ne3
         WEjnBHy8j66SC8Z6JDaTPngvxMl61JNuEaTFMpqUIpWh4W7mVFL0XqT7dJC7a5IbZ/hd
         cZe2n3nWEV7wvWp3fj+4VUTouwNjobr/uKbNe6qXg0VEvDFl/60WgIUSflFjibwNCv7d
         Mv3Q==
X-Gm-Message-State: APjAAAVguKFEEqWDwUmgvlBFfbwwq77J6NaNxSU3EpnuwBe7x9pFfArj
        FLPr3WL+cydBry+m+J4Ex76sygxTly8LbwGjkdmq6c1sxVE=
X-Google-Smtp-Source: APXvYqxUfQlQWgZl9jh/mioyCNmSMiwwKlzLHOxqZ4QtoYJ9ujVTghEXCB577AMsKzdynbwpiVyElM716gFfDjTtAeo=
X-Received: by 2002:a02:852d:: with SMTP id g42mr7405968jai.93.1566732481618;
 Sun, 25 Aug 2019 04:28:01 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 25 Aug 2019 16:27:50 +0500
Message-ID: <CABXGCsNuQMnJeXZ8Fc0CKFxvKqZTxBsJ62NYcrQXR-LT7c2JHQ@mail.gmail.com>
Subject: gnome-shell stuck because of amdgpu driver [5.3 RC5]
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
I left unblocked gnome-shell at noon, and when I returned at the
evening I discovered than monitor not sleeping and show open gnome
activity. At first, I thought that some application did not let fall
asleep the system. But when I try to move the mouse, I realized that
the system hanged. So I connect via ssh and tried to investigate the
problem. I did not see anything strange in kernel logs. And my last
idea before trying to kill the gnome-shell process was dumps tasks
that are in uninterruptable (blocked) state.

After [Alt + PrnScr + W] I saw this:

[32840.701909] sysrq: Show Blocked State
[32840.701976]   task                        PC stack   pid father
[32840.702407] gnome-shell     D11240  1900   1830 0x00000000
[32840.702438] Call Trace:
[32840.702446]  ? __schedule+0x352/0x900
[32840.702453]  schedule+0x3a/0xb0
[32840.702457]  schedule_timeout+0x289/0x3c0
[32840.702461]  ? find_held_lock+0x32/0x90
[32840.702464]  ? find_held_lock+0x32/0x90
[32840.702469]  ? mark_held_locks+0x50/0x80
[32840.702473]  ? _raw_spin_unlock_irqrestore+0x4b/0x60
[32840.702478]  dma_fence_default_wait+0x1f5/0x340
[32840.702482]  ? dma_fence_free+0x20/0x20
[32840.702487]  dma_fence_wait_timeout+0x182/0x1e0
[32840.702533]  amdgpu_fence_wait_empty+0xe7/0x210 [amdgpu]
[32840.702577]  amdgpu_pm_compute_clocks+0x70/0x5f0 [amdgpu]
[32840.702641]  dm_pp_apply_display_requirements+0x19e/0x1c0 [amdgpu]
[32840.702705]  dce12_update_clocks+0xd8/0x110 [amdgpu]
[32840.702766]  dc_commit_state+0x414/0x590 [amdgpu]
[32840.702834]  amdgpu_dm_atomic_commit_tail+0xd1e/0x1cf0 [amdgpu]
[32840.702840]  ? reacquire_held_locks+0xed/0x210
[32840.702848]  ? ttm_eu_backoff_reservation+0xa5/0x160 [ttm]
[32840.702853]  ? find_held_lock+0x32/0x90
[32840.702855]  ? find_held_lock+0x32/0x90
[32840.702860]  ? __lock_acquire+0x247/0x1910
[32840.702867]  ? find_held_lock+0x32/0x90
[32840.702871]  ? mark_held_locks+0x50/0x80
[32840.702874]  ? _raw_spin_unlock_irq+0x29/0x40
[32840.702877]  ? lockdep_hardirqs_on+0xf0/0x180
[32840.702881]  ? _raw_spin_unlock_irq+0x29/0x40
[32840.702884]  ? wait_for_completion_timeout+0x75/0x190
[32840.702895]  ? commit_tail+0x3c/0x70 [drm_kms_helper]
[32840.702902]  commit_tail+0x3c/0x70 [drm_kms_helper]
[32840.702909]  drm_atomic_helper_commit+0xe3/0x150 [drm_kms_helper]
[32840.702922]  drm_atomic_connector_commit_dpms+0xd7/0x100 [drm]
[32840.702936]  set_property_atomic+0xcc/0x140 [drm]
[32840.702955]  drm_mode_obj_set_property_ioctl+0xcb/0x1c0 [drm]
[32840.702968]  ? drm_mode_obj_find_prop_id+0x40/0x40 [drm]
[32840.702978]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[32840.702990]  drm_ioctl+0x208/0x390 [drm]
[32840.703003]  ? drm_mode_obj_find_prop_id+0x40/0x40 [drm]
[32840.703007]  ? sched_clock_cpu+0xc/0xc0
[32840.703012]  ? lockdep_hardirqs_on+0xf0/0x180
[32840.703053]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[32840.703058]  do_vfs_ioctl+0x411/0x750
[32840.703065]  ksys_ioctl+0x5e/0x90
[32840.703069]  __x64_sys_ioctl+0x16/0x20
[32840.703072]  do_syscall_64+0x5c/0xb0
[32840.703076]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[32840.703079] RIP: 0033:0x7f8bcab0f00b
[32840.703084] Code: Bad RIP value.
[32840.703086] RSP: 002b:00007ffe76c62338 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[32840.703089] RAX: ffffffffffffffda RBX: 00007ffe76c62370 RCX: 00007f8bcab=
0f00b
[32840.703092] RDX: 00007ffe76c62370 RSI: 00000000c01864ba RDI: 00000000000=
00009
[32840.703094] RBP: 00000000c01864ba R08: 0000000000000003 R09: 00000000c0c=
0c0c0
[32840.703096] R10: 000056476c86a018 R11: 0000000000000246 R12: 000056476c8=
ad940
[32840.703098] R13: 0000000000000009 R14: 0000000000000002 R15: 00000000000=
00003
[root@localhost ~]#
[root@localhost ~]# ps aux | grep gnome-shell
mikhail     1900  0.3  1.1 6447496 378696 tty2   Dl+  Aug24   2:10
/usr/bin/gnome-shell
mikhail     2099  0.0  0.0 519984 23392 ?        Ssl  Aug24   0:00
/usr/libexec/gnome-shell-calendar-server
mikhail    12214  0.0  0.0 399484 29660 pts/2    Sl+  Aug24   0:00
/usr/bin/python3 /usr/bin/chrome-gnome-shell
chrome-extension://gphhapmejobijbbhgpjhcjognlahblep/
root       22957  0.0  0.0 216120  2456 pts/10   S+   03:59   0:00
grep --color=3Dauto gnome-shell

After it, I tried to kill gnome-shell process with signal 9, but the
process won't terminate after several unsuccessful attempts.

Only [Alt + PrnScr + B] helped reboot the hanging system.
I am writing here because I hope some ampgpu hackers cal look in the
trace and understand that is happening.

Sorry, I don=E2=80=99t know how to reproduce this bug. But the problem itse=
lf
is very annoying.

Thanks.

GPU: AMD Radeon VII
Kernel: 5.3 RC5


--
Best Regards,
Mike Gavrilov.
