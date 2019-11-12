Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B1CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA5A21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlAw5jrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLHvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:51:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725283AbfKLHvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573545077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuqMV+XI1zjk0ppB2G8dlQfAkSWQWFMzVv+Ux2CFKOg=;
        b=hlAw5jrrr5RSYAe4AbsNX1Qgxyz5Z+EAxI2kEb79zuiwr35Neg9ugywhCQ0x0y6Kp7OnqY
        xsUqXP+jbY4+jWCbpyTJBPN+XguZ4OzxIE+ilGsgCNBoLpyGMRJrBMSkQ05TpEpwJPI8HP
        /t380z/iKvG1ZV3IMiQ0fQUtrV9FKPA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-8H2tdbzoM4yuthCxJ2N_tg-1; Tue, 12 Nov 2019 02:51:16 -0500
Received: by mail-wm1-f72.google.com with SMTP id v8so830076wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5HCUSc7z0s3gBXwPQa7m4nkTymvyozbUxwrxPFnytc=;
        b=hKfLIiGQ49mpd0Z5qKxPYufCUX1+m+EtUFKerOhjq1ROk7VtQbjkP4cPtsTySvr7xb
         eiYGNOMczay5tG9VBWE8uqFtxtSyBeCNVITEEOpA5EICyJQLqip7f0s3ahh/+MuQvvPy
         tTJlb0lgFK4oPqTC4ifpBEB21YiPpF/Mdzp/lz5upis5H1uzIgYQ8cbXh6uPdK3Ouywy
         zbRXQnN4U4s8JxBBoI0uuYN+mmIiwQw6T+4+o4ef2w61xdPSbf+2jnL1zl2jFHqfaiv7
         Idu64j/WSwEB2ctH5bVMtMJ8+s7+qhB3/RSBjNfvuG1GI8g20J/qIJqO9n7NRomm0+M0
         9v2w==
X-Gm-Message-State: APjAAAV5szmp+Tq8CPq75su0kDirvkYRn4AZSXv6v8YN/8FPIiWVn/XJ
        kUGMhecD+bSCWbUGJaJ/4GWqoOcQYqBp1xWatJ49ROYyQcutNmDUDjkZNKfls2HrhKVXz7u3+6x
        H4yuKwCI/Xwa61jgwjgF8sAPI
X-Received: by 2002:a5d:5444:: with SMTP id w4mr23600983wrv.164.1573545074761;
        Mon, 11 Nov 2019 23:51:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9cEZniQsPVvMRkQS29yriEDi765xHWrNHGWwb8NbUUx5fVQcvRQdaiRp2ti0B+Ampr7JntA==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr23600954wrv.164.1573545074398;
        Mon, 11 Nov 2019 23:51:14 -0800 (PST)
Received: from localhost.localdomain.com ([151.29.177.194])
        by smtp.gmail.com with ESMTPSA id i71sm39498658wri.68.2019.11.11.23.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 23:51:13 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, glenn@aurora.tech
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, luca.abeni@santannapisa.it,
        c.scordino@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, juri.lelli@redhat.com
Subject: [PATCH 1/2] sched/deadline: Fix nested priority inheritace at enqueue time
Date:   Tue, 12 Nov 2019 08:50:55 +0100
Message-Id: <20191112075056.19971-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191112075056.19971-1-juri.lelli@redhat.com>
References: <20191112075056.19971-1-juri.lelli@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 8H2tdbzoM4yuthCxJ2N_tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glenn reported that "an application [he developed produces] a BUG in
deadline.c when a SCHED_DEADLINE task contends with CFS tasks on nested
PTHREAD_PRIO_INHERIT mutexes.  I believe the bug is triggered when a CFS
task that was boosted by a SCHED_DEADLINE task boosts another CFS task
(nested priority inheritance).

Here is the BUG output on a 4.19-rt kernel:

 ------------[ cut here ]------------
 kernel BUG at kernel/sched/deadline.c:1462!
 invalid opcode: 0000 [#1] PREEMPT SMP
 CPU: 12 PID: 19171 Comm: dl_boost_bug Tainted: P           O      4.19.72-=
rt25-appaloosa-v1.5 #1
 Hardware name: Intel Corporation S2600BPB/S2600BPB, BIOS SE5C620.86B.02.01=
.0008.031920191559 03/19/2019
 RIP: 0010:enqueue_task_dl+0x335/0x910
 Code: ...
 RSP: 0018:ffffc9000c2bbc68 EFLAGS: 00010002
 RAX: 0000000000000009 RBX: ffff888c0af94c00 RCX: ffffffff81e12500
 RDX: 000000000000002e RSI: ffff888c0af94c00 RDI: ffff888c10b22600
 RBP: ffffc9000c2bbd08 R08: 0000000000000009 R09: 0000000000000078
 R10: ffffffff81e12440 R11: ffffffff81e1236c R12: ffff888bc8932600
 R13: ffff888c0af94eb8 R14: ffff888c10b22600 R15: ffff888bc8932600
 FS:  00007fa58ac55700(0000) GS:ffff888c10b00000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fa58b523230 CR3: 0000000bf44ab003 CR4: 00000000007606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  ? intel_pstate_update_util_hwp+0x13/0x170
  rt_mutex_setprio+0x1cc/0x4b0
  task_blocks_on_rt_mutex+0x225/0x260
  rt_spin_lock_slowlock_locked+0xab/0x2d0
  rt_spin_lock_slowlock+0x50/0x80
  hrtimer_grab_expiry_lock+0x20/0x30
  hrtimer_cancel+0x13/0x30
  do_nanosleep+0xa0/0x150
  hrtimer_nanosleep+0xe1/0x230
  ? __hrtimer_init_sleeper+0x60/0x60
  __x64_sys_nanosleep+0x8d/0xa0
  do_syscall_64+0x4a/0x100
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x7fa58b52330d
 ...
 ---[ end trace 0000000000000002 ]=E2=80=94

He also provided a simple reproducer creating the situation below:

 So the execution order of locking steps are the following
 (N1 and N2 are non-deadline tasks. D1 is a deadline task. M1 and M2
 are mutexes that are enabled * with priority inheritance.)

 Time moves forward as this timeline goes down:

 N1              N2               D1
 |               |                |
 |               |                |
 Lock(M1)        |                |
 |               |                |
 |             Lock(M2)           |
 |               |                |
 |               |              Lock(M2)
 |               |                |
 |             Lock(M1)           |
 |             (!!bug triggered!) |

This patch (of a 2 patches series) fixes one part of the problem, by
correctly triggering priority inheritance in cases top lock waiter is a
boosted non-DEADLINE entity (like in the example above, N2 and N1).

Reported-by: Glenn Elliott <glenn@aurora.tech>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2dc48720f189..951a7b44156f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1482,7 +1482,7 @@ static void enqueue_task_dl(struct rq *rq, struct tas=
k_struct *p, int flags)
 =09 *   boosted due to a SCHED_DEADLINE pi-waiter).
 =09 * Otherwise we keep our runtime and deadline.
 =09 */
-=09if (pi_task && dl_prio(pi_task->normal_prio) && p->dl.dl_boosted) {
+=09if (pi_task && dl_prio(pi_task->prio) && p->dl.dl_boosted) {
 =09=09pi_se =3D &pi_task->dl;
 =09} else if (!dl_prio(p->normal_prio)) {
 =09=09/*
--=20
2.17.2

