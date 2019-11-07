Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00AEC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FCF2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeNxoh4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbfKGPDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:03:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57625 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726810AbfKGPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573139015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rz7Flxivq/MsSwcTJWISr8XdYwP7g8dNxx0v7qQboaY=;
        b=aeNxoh4+5saKvptwaMqT8MgK1nhBU9UINOftBAIPVTja1PRHv6/1iwBD3XLSMBMYgCTIrw
        erez4VFhcRQavrvJKF+tzLDrTls0S6q+wQDOtOO5YI2x9PvPsf4veKt2/CtsRtyLPlyYiS
        tAK5KIyKvnfH7YqsuqeOydxcSouds1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-RVqa4xSAOlWCaLzfVm6j3A-1; Thu, 07 Nov 2019 10:03:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66FAA1800D6B;
        Thu,  7 Nov 2019 15:03:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7E71F5D6A0;
        Thu,  7 Nov 2019 15:03:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  7 Nov 2019 16:03:30 +0100 (CET)
Date:   Thu, 7 Nov 2019 16:03:23 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 00/12] futex: Cure robust/PI futex exit races
Message-ID: <20191107150323.GA24042@redhat.com>
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191106215534.241796846@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: RVqa4xSAOlWCaLzfVm6j3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06, Thomas Gleixner wrote:
>
>  fs/exec.c                |    2=20
>  include/linux/compat.h   |    2=20
>  include/linux/futex.h    |   38 +++--
>  include/linux/sched.h    |    3=20
>  include/linux/sched/mm.h |    6=20
>  kernel/exit.c            |   30 ----
>  kernel/fork.c            |   40 ++---
>  kernel/futex.c           |  324 ++++++++++++++++++++++++++++++++++++++++=
-------
>  8 files changed, 330 insertions(+), 115 deletions(-)

The whole series looks good to me.

But I am just curious, what do you all think about the patch below
instead of 10/12 and 12/12 ?

Oleg.


diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9e0de08..ad18433 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -621,6 +621,11 @@ struct wake_q_node {
 =09struct wake_q_node *next;
 };
=20
+struct wake_q_head {
+=09struct wake_q_node *first;
+=09struct wake_q_node **lastp;
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 =09/*
@@ -1055,6 +1060,7 @@ struct task_struct {
 =09struct list_head=09=09pi_state_list;
 =09struct futex_pi_state=09=09*pi_state_cache;
 =09unsigned int=09=09=09futex_state;
+=09struct wake_q_head=09=09futex_exit_q;
 #endif
 #ifdef CONFIG_PERF_EVENTS
 =09struct perf_event_context=09*perf_event_ctxp[perf_nr_task_contexts];
diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 26a2013..62805b5 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -35,11 +35,6 @@
=20
 #include <linux/sched.h>
=20
-struct wake_q_head {
-=09struct wake_q_node *first;
-=09struct wake_q_node **lastp;
-};
-
 #define WAKE_Q_TAIL ((struct wake_q_node *) 0x01)
=20
 #define DEFINE_WAKE_Q(name)=09=09=09=09\
diff --git a/kernel/futex.c b/kernel/futex.c
index 4b36bc8..87763c7 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1176,6 +1176,24 @@ static int attach_to_pi_state(u32 __user *uaddr, u32=
 uval,
 =09return ret;
 }
=20
+static void wait_for_owner_exiting(int ret)
+{
+=09struct wake_q_node *node =3D &current->wake_q;
+
+=09if (ret !=3D -EBUSY) {
+=09=09WARN_ON_ONCE(node->next); // XXX not really correct ...
+=09=09return;
+=09}
+
+=09for (;;) {
+=09=09set_current_state(TASK_UNINTERRUPTIBLE);
+=09=09if (!READ_ONCE(node->next))
+=09=09=09break;
+=09=09schedule();
+=09}
+=09__set_current_state(TASK_RUNNING);
+}
+
 static int handle_exit_race(u32 __user *uaddr, u32 uval,
 =09=09=09    struct task_struct *tsk)
 {
@@ -1185,8 +1203,10 @@ static int handle_exit_race(u32 __user *uaddr, u32 u=
val,
 =09 * If the futex exit state is not yet FUTEX_STATE_DEAD, tell the
 =09 * caller that the alleged owner is busy.
 =09 */
-=09if (tsk && tsk->futex_state !=3D FUTEX_STATE_DEAD)
+=09if (tsk && tsk->futex_state !=3D FUTEX_STATE_DEAD) {
+=09=09wake_q_add(&tsk->futex_exit_q, current);
 =09=09return -EBUSY;
+=09}
=20
 =09/*
 =09 * Reread the user space value to handle the following situation:
@@ -2104,6 +2124,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned=
 int flags,
 =09=09=09hb_waiters_dec(hb2);
 =09=09=09put_futex_key(&key2);
 =09=09=09put_futex_key(&key1);
+=09=09=09wait_for_owner_exiting(ret);
 =09=09=09cond_resched();
 =09=09=09goto retry;
 =09=09default:
@@ -2855,6 +2876,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned =
int flags,
 =09=09=09queue_unlock(hb);
 =09=09=09put_futex_key(&q.key);
 =09=09=09cond_resched();
+=09=09=09wait_for_owner_exiting(ret);
 =09=09=09goto retry;
 =09=09default:
 =09=09=09goto out_unlock_put_key;
@@ -3701,6 +3723,7 @@ static void futex_cleanup(struct task_struct *tsk)
 void futex_exit_recursive(struct task_struct *tsk)
 {
 =09tsk->futex_state =3D FUTEX_STATE_DEAD;
+=09wake_up_q(&tsk->futex_exit_q);
 }
=20
 static void futex_cleanup_begin(struct task_struct *tsk)
@@ -3718,16 +3741,17 @@ static void futex_cleanup_begin(struct task_struct =
*tsk)
 =09 */
 =09raw_spin_lock_irq(&tsk->pi_lock);
 =09tsk->futex_state =3D FUTEX_STATE_EXITING;
+=09wake_q_init(&tsk->futex_exit_q);
 =09raw_spin_unlock_irq(&tsk->pi_lock);
 }
=20
 static void futex_cleanup_end(struct task_struct *tsk, int state)
 {
-=09/*
-=09 * Lockless store. The only side effect is that an observer might
-=09 * take another loop until it becomes visible.
-=09 */
+=09raw_spin_lock_irq(&tsk->pi_lock);
 =09tsk->futex_state =3D state;
+=09raw_spin_unlock_irq(&tsk->pi_lock);
+
+=09wake_up_q(&tsk->futex_exit_q);
 }
=20
 void futex_exec_release(struct task_struct *tsk)

