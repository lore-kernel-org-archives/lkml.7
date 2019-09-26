Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE6C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C576222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="XIcualA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfIZHUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:20:17 -0400
Received: from mxc2.seznam.cz ([77.75.77.23]:23137 "EHLO mxc2.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbfIZHUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:20:17 -0400
X-Greylist: delayed 791 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 03:20:15 EDT
Received: from email.seznam.cz
        by email-smtpc8b.ng.seznam.cz (email-smtpc8b.ng.seznam.cz [10.23.13.225])
        id 0f190ab81f91b0840f1327f9;
        Thu, 26 Sep 2019 09:20:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1569482414; bh=Yo3MGE6g0v3SIKjabMFH1O/DPX4XY5RQxx5L4SxxowA=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
         Content-Type:Content-Transfer-Encoding;
        b=XIcualA30B6EJOCuFHfWe1virfJaJZrfOh1pULlYdICJrUjGSEStbnjXn5tNLJGuJ
         1H+gv9VpoVagnzjE18C8r9s2XpK7nCyjajHgqiG+NjXaeEWUWR82HF4SSbF3uGNrYq
         RFpbk+RlKi31bx7ub2cGTe89+dzMVKfVcip4xPiQ=
Received: from unknown ([::ffff:62.24.65.155])
        by email.seznam.cz (szn-ebox-4.5.362) with HTTP;
        Thu, 26 Sep 2019 09:06:58 +0200 (CEST)
From:   "Zdenek Sojka" <zsojka@seznam.cz>
To:     <linux-kernel@vger.kernel.org>
Cc:     <tj@kernel.org>, <jiangshanlai@gmail.com>
Subject: =?utf-8?q?workqueue=3A_PF=5FMEMALLOC_task_14771=28cc1plus=29_is_f?=
        =?utf-8?q?lushing_!WQ=5FMEM=5FRECLAIM_events=3Agen6=5Fpm=5Frps=5Fwork?=
Date:   Thu, 26 Sep 2019 09:06:58 +0200 (CEST)
Message-Id: <12X.2yh9.1rKbaucucGw.1TZ6EI@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.45)
X-Mailer: szn-ebox-4.5.362
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've hit the following dmesg with a 5.3.1 kernel; it looks similar to http=
s://lkml.org/lkml/2019/8/28/754 , which should have been fixed as noted in=
 https://lkml.org/lkml/2019/8/28/763 (if the patch is in the 5.3 release)=


[ 2680.302771] ------------[ cut here ]------------
[ 2680.302862] workqueue: PF_MEMALLOC task 14771(cc1plus) is flushing !WQ_=
MEM_RECLAIM events:gen6_pm_rps_work
[ 2680.302868] WARNING: CPU: 5 PID: 14771 at kernel/workqueue.c:2600 check=
_flush_dependency+0x104/0x110
[ 2680.302870] Modules linked in:
[ 2680.302873] CPU: 5 PID: 14771 Comm: cc1plus Not tainted 5.3.1-gentoo #2=

[ 2680.302875] Hardware name: Dell Inc. Precision Tower 3620/0MWYPT, BIOS =
2.4.2 09/29/2017
[ 2680.302878] RIP: 0010:check_flush_dependency+0x104/0x110
[ 2680.302881] Code: 05 00 00 8b b6 88 03 00 00 48 8d 8b 78 01 00 00 49 89=
 e8 48 c7 c7 f0 bd a0 82 48 89 04 24 c6 05 9a 6d bb 01 01 e8 ce dd fd ff <=
0f> 0b 48 8b 04 24 e9 62 ff ff ff 90 53 48 8b 1f e8 a7 67 06 00 85
[ 2680.302882] RSP: 0018:ffff888418d53728 EFLAGS: 00010092
[ 2680.302885] RAX: 000000000000005e RBX: ffff888444819600 RCX: 0000000000=
000000
[ 2680.302886] RDX: ffff888176616140 RSI: 0000000000000000 RDI: ffffffff81=
23c6a1
[ 2680.302888] RBP: ffffffff81ac7de0 R08: 0000000000000001 R09: 0000000000=
1ead00
[ 2680.302890] R10: 995e1f072b14c310 R11: 000000000000013a R12: ffff888176=
616140
[ 2680.302892] R13: 0000000000000001 R14: 0000000000000001 R15: ffff888455=
7eae40
[ 2680.302894] FS:  00005555559f0940(0000) GS:ffff888455800000(0000) knlGS=
:0000000000000000
[ 2680.302896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2680.302898] CR2: 0000000061600000 CR3: 000000017da52006 CR4: 0000000000=
3606e0
[ 2680.302899] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
[ 2680.302901] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
[ 2680.302903] Call Trace:
[ 2680.302906]  __flush_work+0xd2/0x420
[ 2680.302909]  ? sched_clock+0x5/0x10
[ 2680.302912]  ? sched_clock+0x5/0x10
[ 2680.302914]  ? sched_clock_cpu+0xc/0xb0
[ 2680.302917]  ? get_work_pool+0x90/0x90
[ 2680.302919]  ? mark_held_locks+0x47/0x70
[ 2680.302922]  ? get_work_pool+0x90/0x90
[ 2680.302924]  __cancel_work_timer+0x107/0x190
[ 2680.302928]  ? synchronize_irq+0x20/0x80
[ 2680.302931]  gen6_disable_rps_interrupts+0x72/0xb0
[ 2680.302933]  gen6_rps_idle+0x15/0xd0
[ 2680.302936]  intel_gt_park+0x55/0x60
[ 2680.302939]  __intel_wakeref_put_last+0xf/0x40
[ 2680.302941]  __engine_park+0x7e/0xd0
[ 2680.302944]  __intel_wakeref_put_last+0xf/0x40
[ 2680.302947]  i915_request_retire+0x231/0x4c4
[ 2680.302949]  i915_retire_requests+0x8c/0x10c
[ 2680.302952]  i915_gem_shrink+0x4aa/0x6f0
[ 2680.302955]  ? mutex_trylock+0x114/0x130
[ 2680.302957]  i915_gem_shrinker_scan+0x127/0x160
[ 2680.302960]  do_shrink_slab+0x131/0x320
[ 2680.302962]  shrink_node+0xf7/0x380
[ 2680.302965]  do_try_to_free_pages+0xbf/0x2c0
[ 2680.302967]  try_to_free_pages+0xe0/0x250
[ 2680.302970]  __perform_reclaim.isra.22+0xb9/0x170
[ 2680.302973]  __alloc_pages_nodemask+0x6a2/0x1270
[ 2680.302975]  ? __alloc_pages_nodemask+0x3d0/0x1270
[ 2680.302978]  ? __lock_acquire+0x246/0x1a60
[ 2680.302980]  ? sched_clock+0x5/0x10
[ 2680.302982]  ? sched_clock_cpu+0xc/0xb0
[ 2680.302985]  ? __lock_release+0x15f/0x2a0
[ 2680.302987]  do_huge_pmd_anonymous_page+0x141/0x5c0
[ 2680.302990]  __handle_mm_fault+0xf28/0x10e0
[ 2680.302993]  __do_page_fault+0x23a/0x4e0
[ 2680.302996]  page_fault+0x39/0x40
[ 2680.302998] RIP: 0033:0x60003a2c
[ 2680.303001] Code: 03 01 00 74 22 4c 89 0f c6 00 0f 48 8b 07 f7 c6 00 02=
 00 00 74 30 48 8d 50 01 48 89 17 c6 00 38 48 8b 07 4c 8d 48 01 4c 89 0f <=
40> 88 30 c3 4c 89 0f c6 00 f3 48 8b 07 4c 8d 48 01 e9 50 ff ff ff
[ 2680.303003] RSP: 002b:00007ffe02b5ec18 EFLAGS: 00010246
[ 2680.303005] RAX: 0000000061600000 RBX: 0000000060327120 RCX: 0000000000=
000005
[ 2680.303007] RDX: 0000000000000000 RSI: 000000000000008b RDI: 0000000060=
3271a8
[ 2680.303009] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000061=
600001
[ 2680.303011] R10: 0000000000000000 R11: 0000000060079ac8 R12: 0000000000=
000003
[ 2680.303012] R13: ffffffffffffffe0 R14: 0000000060327120 R15: 0000555555=
a7a2f0
[ 2680.303014] irq event stamp: 154652
[ 2680.303018] hardirqs last  enabled at (154651): [<ffffffff811e892d>] __=
cancel_work_timer+0x7d/0x190
[ 2680.303020] hardirqs last disabled at (154652): [<ffffffff8200ace1>] _r=
aw_spin_lock_irq+0x11/0x70
[ 2680.303023] softirqs last  enabled at (142674): [<ffffffff811cb6fd>] ir=
q_exit+0x9d/0xe0
[ 2680.303026] softirqs last disabled at (142663): [<ffffffff811cb6fd>] ir=
q_exit+0x9d/0xe0
[ 2680.303027] ---[ end trace 6b426c94345d96fc ]---


Please let me know if I can provide more information.

Best regards,
Zdenek Sojka
