Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2D2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A1A21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SllwjcEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKLHvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:51:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35430 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726954AbfKLHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573545078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zpp3B2qvifxL9+rHPvcFQiOgMFipOSx8rwk9pxJzH/U=;
        b=SllwjcEk/CGkNOth1DSoOaNXEf06VIbojDTRm1NyfrnD+gAp68tAaRjPAjMif81sgrcA8r
        V054s93HF4SfIQYiyeF2a09lMjeKhTzrnylNilSAyf1ONXnVjsoRhX5GwP3TzTc3cqcTEU
        L3J+sjyBXiOxb6+Acbeq5Oi0DGxTJnQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-3OAVfnLXPquGQ6Yb9-xOQw-1; Tue, 12 Nov 2019 02:51:15 -0500
Received: by mail-wr1-f71.google.com with SMTP id u2so11459924wrm.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+jtP09mh/hBHr1BaQiCMU2lAYzPF+a6Icbf+zUckPfE=;
        b=Vg61dSxZByxXgXqyQO9lJ3z56bTQdAun9I8xw15B1fq+zSYsdALo8SA0olD26eGF3m
         ursRBXFibmzqrBqn42YxNgay9NWJWtXrKQNKCm6GeUVCGVuVGElQ9q82YhSHWcJ+YqAE
         jWANAGRHnfnQNtkxBE23hoDdGqjGxouKkbQVjtUgvJSZscCFNgT0NnioHMcaR58dUyMs
         7xIN3QRZcrJyyZETRUgSF7AtPDBzM702fKcGqSkPJ7xJDFmgGObj3ZcRY91lZHW627QR
         xuVnA32yg0Yp4oiAqxuf0Wd7VcrMgbbyY9H3Gy3XnjOmRMYaE8JB8raNsngSafQriXzj
         gtsQ==
X-Gm-Message-State: APjAAAVGPpP3abfGKttImhHkMiTD6zfwTeQyzVWmzdC3JENNMnlRmXDO
        vCDRePiPdnRTSt0JsjDEG4lKnhlleSfymJdiPzXoje8VwfOgaYBiMTpR3CklpykQ0hwlaNCsUbX
        HCf5Pd1rZzG3U/XV0ERy+0Mff
X-Received: by 2002:adf:edc5:: with SMTP id v5mr1420859wro.322.1573545073638;
        Mon, 11 Nov 2019 23:51:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwo/4eV7tp69/ZOHWQ2u63ttMBRKNrMUBm17zgfnXWPO/9+BajNQ0ySoKgb2cti/C9MCo8eiA==
X-Received: by 2002:adf:edc5:: with SMTP id v5mr1420835wro.322.1573545073221;
        Mon, 11 Nov 2019 23:51:13 -0800 (PST)
Received: from localhost.localdomain.com ([151.29.177.194])
        by smtp.gmail.com with ESMTPSA id i71sm39498658wri.68.2019.11.11.23.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 23:51:12 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, glenn@aurora.tech
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, luca.abeni@santannapisa.it,
        c.scordino@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, juri.lelli@redhat.com
Subject: [PATCH 0/2] Fix SCHED_DEADLINE nested priority inheritance
Date:   Tue, 12 Nov 2019 08:50:54 +0100
Message-Id: <20191112075056.19971-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
X-MC-Unique: 3OAVfnLXPquGQ6Yb9-xOQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Glenn reported a bug concerning SCHED_DEADLINE nested (cross-class)
priority inheritance. With his words:

"""
Hello maintainers,

My application produces a BUG in deadline.c when a SCHED_DEADLINE task
contends with CFS tasks on nested PTHREAD_PRIO_INHERIT mutexes.  I
believe the bug is triggered when a CFS task that was boosted by a
SCHED_DEADLINE task boosts another CFS task (nested priority
inheritance).

I am able to reproduce the bug on 4.15, 4.19-rt, and 5.3.0-19-generic
(an Ubuntu kernel) kernels.

I have a small test program that can reproduce the issue.  Please find
the source code for this test at the end of this email.  I have tested
on an Intel Xeon 8276 CPU, as well as within a x86_64 VM.  I can try
this test with a 4.19-rt kernel on aarch64, if desired.

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
 Code: ...
 RSP: 002b:00007fa58ac54ef0 EFLAGS: 00000293 ORIG_RAX: 0000000000000023
 RAX: ffffffffffffffda RBX: ffffffffffffff98 RCX: 00007fa58b52330d
 RDX: 00007fa58b81d780 RSI: 00007fa58ac54f00 RDI: 00007fa58ac54f00
 RBP: 0000000000000000 R08: 00007fa58ac55700 R09: 0000000000000000
 R10: 0000000000000735 R11: 0000000000000293 R12: 0000000000000000
 R13: 00007ffc807fd43f R14: 00007fa58ac559c0 R15: 0000000000000000
 Modules linked in: ...
 ---[ end trace 0000000000000002 ]=E2=80=94
"""

He also provided a reproducer (appended to this cover) with which I was
able to confirm that tip/sched/core is affect as well.

Proposed fix is composed of 2 patches

 1 - Trigger priority inheritance (boost) for "indirect" cases as well;
     where I (improperly?) consider "indirect" a non-SCHED_DEADLINE waiter
     currently boosted from a different lock chain containing a
     SCHED_DEADLINE task
 2 - Temporarily copy static parameters to non-SCHED_DEADLINE boosted
     tasks, so that they can be used in "indirect" cases

Now. This is pretty far from ideal, I know. Consider it a stop gap
solution (hack, if it makes any sense) to proper proxy execution (on
which I'm still working :-/). Better ideas are more than welcome!

Best,

Juri

Juri Lelli (2):
  sched/deadline: Fix nested priority inheritace at enqueue time
  sched/deadline: Temporary copy static parameters to boosted
    non-DEADLINE entities

 kernel/sched/core.c     |  6 ++++--
 kernel/sched/deadline.c | 19 ++++++++++++++++++-
 kernel/sched/sched.h    |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

--=20
2.17.2

--->8---
=E2=80=94 test case =E2=80=94

/* gcc main.c -lpthread */

/*
 * This program reproduces a kernel bug at line
 * https://elixir.bootlin.com/linux/v4.15/source/kernel/sched/deadline.c#L1=
405, but not limited
 * to the version v4.15.
 *
 * This is bug is triggered when a non-deadline task that was boosted by a =
deadline task boosts
 * another non-deadline task.
 *
 * So the execution order of locking steps are the following
 * (N1 and N2 are non-deadline tasks. D1 is a deadline task. M1 and M2 are =
mutexes that are enabled
 * with priority inheritance.)
 *
 * Time moves forward as this timeline goes down:
 *
 * N1              N2               D1
 * |               |                |
 * |               |                |
 * Lock(M1)        |                |
 * |               |                |
 * |             Lock(M2)           |
 * |               |                |
 * |               |              Lock(M2)
 * |               |                |
 * |             Lock(M1)           |
 * |             (!!bug triggered!) |
 *
 */

#define _GNU_SOURCE
#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/unistd.h>
#include <pthread.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>

#define gettid() syscall(__NR_gettid)

#define SCHED_DEADLINE 6

#ifdef __x86_64__
#define __NR_sched_setattr 314
#define __NR_sched_getattr 315
#endif

#ifdef __i386__
#define __NR_sched_setattr 351
#define __NR_sched_getattr 352
#endif

#ifdef __arm__
#define __NR_sched_setattr 380
#define __NR_sched_getattr 381
#endif

static volatile int step;
pthread_mutex_t m1;
pthread_mutex_t m2;

struct sched_attr {
    __u32 size;

    __u32 sched_policy;
    __u64 sched_flags;

    /* SCHED_NORMAL, SCHED_BATCH */
    __s32 sched_nice;

    /* SCHED_FIFO, SCHED_RR */
    __u32 sched_priority;

    /* SCHED_DEADLINE (nsec) */
    __u64 sched_runtime;
    __u64 sched_deadline;
    __u64 sched_period;
};

int sched_setattr(pid_t pid, const struct sched_attr *attr,
                  unsigned int flags) {
    return syscall(__NR_sched_setattr, pid, attr, flags);
}

int sched_getattr(pid_t pid, struct sched_attr *attr, unsigned int size,
                  unsigned int flags) {
    return syscall(__NR_sched_getattr, pid, attr, size, flags);
}

void *run_normal_1(void *data) {
    int x =3D 0;

    printf("normal thread started [%ld]\n", gettid());

    // N1 locks M1
    printf("N1 is locking M1\n");
    pthread_mutex_lock(&m1);
    printf("N1 locked M1\n");

    // Notify N2
    step =3D 1;
    // Wait to be boosted by N2 (on M1)
    sleep(10);

    // Won't be able to reach here because of the rt_mutex + sched_deadline=
 bug.
    printf("N1 is unlocking M1\n");
    pthread_mutex_unlock(&m1);
    printf("N1 unlocked M1\n");

    printf("normal thread dies [%ld]\n", gettid());
    return NULL;
}

void *run_normal_2(void *data) {
    int x =3D 0;

    printf("normal thread started [%ld]\n", gettid());

    // N2 locks M2
    printf("N2 is locking M2\n");
    pthread_mutex_lock(&m2);
    printf("N2 locked M2\n");

    // Wait until N1 locked M1
    while (step < 1) {
        x++;
    }

    // Notify D1
    step =3D 2;
    // Wait to be boosted by D1 (on M2)
    sleep(5);

    printf("N2 is locking M1\n");
    // This will boost N1 and trigger the bug.
    pthread_mutex_lock(&m1);
    // Won't reach here because of the bug
    printf("N2 locked M1\n");

    printf("N2 is unlocking M1\n");
    pthread_mutex_unlock(&m1);
    printf("N2 unlocked M1\n");

    printf("N2 is unlocking M2\n");
    pthread_mutex_unlock(&m2);
    printf("N2 unlocked M2\n");

    printf("normal thread dies [%ld]\n", gettid());
    return NULL;
}

void *run_deadline(void *data) {
    struct sched_attr attr;
    int x =3D 0;
    int ret =3D 0;
    unsigned int flags =3D 0;

    printf("deadline thread started [%ld]\n", gettid());

    attr.size =3D sizeof(attr);
    attr.sched_flags =3D 0;
    attr.sched_nice =3D 0;
    attr.sched_priority =3D 0;

    /* This creates a 10ms/30ms reservation */
    attr.sched_policy =3D SCHED_DEADLINE;
    attr.sched_runtime =3D 10 * 1000 * 1000;
    attr.sched_period =3D attr.sched_deadline =3D 30 * 1000 * 1000;

    ret =3D sched_setattr(0, &attr, flags);
    if (ret < 0) {
        step =3D 0;
        perror("sched_setattr");
        exit(-1);
    }

    // Wait until N2 locked M2
    while (step < 2) {
        x++;
    }

    printf("D1 is locking M2\n");
    // This will boost N2
    pthread_mutex_lock(&m2);
    printf("D1 locked M2\n");

    sleep(10);
    // Won't reach here because of the bug.

    printf("D1 is unlocking M2\n");
    pthread_mutex_unlock(&m2);
    printf("D1 unlocked M2\n");

    printf("deadline thread dies [%ld]\n", gettid());
    return NULL;
}

int main(int argc, char **argv) {
    pthread_t thread[3];

    printf("main thread [%ld]\n", gettid());

    int rtn;
    pthread_mutexattr_t mutexattr;
    if ((rtn =3D pthread_mutexattr_init(&mutexattr) !=3D 0)) {
        fprintf(stderr, "pthread_mutexattr_init: %s", strerror(rtn));
        exit(1);
    }
    if ((rtn =3D pthread_mutexattr_setprotocol(&mutexattr,
                                             PTHREAD_PRIO_INHERIT)) !=3D 0)=
 {
        fprintf(stderr, "pthread_mutexattr_setprotocol: %s", strerror(rtn))=
;
        exit(1);
    }

    if ((rtn =3D pthread_mutex_init(&m1, &mutexattr)) !=3D 0) {
        fprintf(stderr, "pthread_mutexattr_init: %s", strerror(rtn));
        exit(1);
    }

    if ((rtn =3D pthread_mutex_init(&m2, &mutexattr)) !=3D 0) {
        fprintf(stderr, "pthread_mutexattr_init: %s", strerror(rtn));
        exit(1);
    }

    // use this volatile variable to coordinate execution order between thr=
eads
    step =3D 0;
    pthread_create(thread, NULL, run_normal_1, NULL);
    pthread_create(thread + 1, NULL, run_normal_2, NULL);
    pthread_create(thread + 2, NULL, run_deadline, NULL);

    pthread_join(thread[0], NULL);
    pthread_join(thread[1], NULL);
    pthread_join(thread[2], NULL);

    printf("main dies [%ld]\n", gettid());
    return 0;
}

