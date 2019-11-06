Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508DDFC6194
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224362173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVqZ07QD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbfKFWny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:43:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45803 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732658AbfKFWnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573080232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ehcenr1LSi0upLqj9Lbf+2rbNqzvy+MiD6O9YRzn41o=;
        b=bVqZ07QDFK2H6WT9tcBkkpuksqLdnfHSfZht245cVDpjAwwRafqTzogKIdl7Iuy4X1tBAB
        tgxwp04BC4tYkV0L703VqE160T3QsImwdAVug6FCho2z6yRuC2KzX/p7HbVuRz3n/1heKZ
        sqIlAOFoSgzUJ8lqJDkPwlKX4DDGlsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-qna9tDmHOLalurHbBo30iQ-1; Wed, 06 Nov 2019 17:43:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 053098017E0;
        Wed,  6 Nov 2019 22:43:48 +0000 (UTC)
Received: from dustball.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF7CE5C296;
        Wed,  6 Nov 2019 22:43:43 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org, longman@redhat.com,
        linux-kernel@vger.kernel.org, jstancek@redhat.com
Subject: [RFC PATCH] futex: don't retry futex_wait() with stale uaddr/val after spurious wakeup
Date:   Wed,  6 Nov 2019 23:43:19 +0100
Message-Id: <9179dbc3505e1de99ee36b09b0a12995239d73c3.1573079868.git.jstancek@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qna9tDmHOLalurHbBo30iQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assume following scenario: process A is sleeping on futex (uaddr1)
inside futex_wait(). Process B requeues this waiter via FUTEX_CMP_REQUEUE
to uaddr2, but doesn't wake it up. Later, process A spuriously wakes up
and futex_wait() retries to queue again with same uaddr1/val1:
        if (!signal_pending(current))
                goto retry;

Problem: Userspace fails to wake process A with futex(uaddr2, FUTEX_WAKE)

Store target uaddr/val in futex_requeue() and let futex_wait()
retry after spurious wake up using stored values.

Fixes: d58e6576b0de ("futex: Handle spurious wake up")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Waiman Long <longman@redhat.com>
---
 kernel/futex.c | 52 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index bd18f60e4c6c..c13cfee25d35 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -237,6 +237,9 @@ struct futex_q {
 =09struct rt_mutex_waiter *rt_waiter;
 =09union futex_key *requeue_pi_key;
 =09u32 bitset;
+
+=09u32 *uaddr;
+=09u32 val;
 } __randomize_layout;
=20
 static const struct futex_q futex_q_init =3D {
@@ -1939,6 +1942,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned=
 int flags,
 =09struct futex_hash_bucket *hb1, *hb2;
 =09struct futex_q *this, *next;
 =09DEFINE_WAKE_Q(wake_q);
+=09u32 curval, targetval;
=20
 =09if (nr_wake < 0 || nr_requeue < 0)
 =09=09return -EINVAL;
@@ -2005,30 +2009,32 @@ static int futex_requeue(u32 __user *uaddr1, unsign=
ed int flags,
 =09hb_waiters_inc(hb2);
 =09double_lock_hb(hb1, hb2);
=20
-=09if (likely(cmpval !=3D NULL)) {
-=09=09u32 curval;
-
+=09ret =3D get_futex_value_locked(&targetval, uaddr2);
+=09if (!ret && likely(cmpval !=3D NULL))
 =09=09ret =3D get_futex_value_locked(&curval, uaddr1);
=20
-=09=09if (unlikely(ret)) {
-=09=09=09double_unlock_hb(hb1, hb2);
-=09=09=09hb_waiters_dec(hb2);
+=09if (unlikely(ret)) {
+=09=09double_unlock_hb(hb1, hb2);
+=09=09hb_waiters_dec(hb2);
=20
+=09=09ret =3D get_user(targetval, uaddr2);
+=09=09if (!ret && likely(cmpval !=3D NULL))
 =09=09=09ret =3D get_user(curval, uaddr1);
-=09=09=09if (ret)
-=09=09=09=09goto out_put_keys;
=20
-=09=09=09if (!(flags & FLAGS_SHARED))
-=09=09=09=09goto retry_private;
+=09=09if (ret)
+=09=09=09goto out_put_keys;
=20
-=09=09=09put_futex_key(&key2);
-=09=09=09put_futex_key(&key1);
-=09=09=09goto retry;
-=09=09}
-=09=09if (curval !=3D *cmpval) {
-=09=09=09ret =3D -EAGAIN;
-=09=09=09goto out_unlock;
-=09=09}
+=09=09if (!(flags & FLAGS_SHARED))
+=09=09=09goto retry_private;
+
+=09=09put_futex_key(&key2);
+=09=09put_futex_key(&key1);
+=09=09goto retry;
+=09}
+
+=09if (likely(cmpval !=3D NULL) && (curval !=3D *cmpval)) {
+=09=09ret =3D -EAGAIN;
+=09=09goto out_unlock;
 =09}
=20
 =09if (requeue_pi && (task_count - nr_wake < nr_requeue)) {
@@ -2185,6 +2191,12 @@ static int futex_requeue(u32 __user *uaddr1, unsigne=
d int flags,
 =09=09=09}
 =09=09}
 =09=09requeue_futex(this, hb1, hb2, &key2);
+=09=09/*
+=09=09 * Save target uaddr/val, in case futex_wait() wakes
+=09=09 * up spuriously and retries to requeue.
+=09=09 */
+=09=09this->uaddr =3D uaddr2;
+=09=09this->val =3D targetval;
 =09=09drop_count++;
 =09}
=20
@@ -2717,6 +2729,8 @@ static int futex_wait(u32 __user *uaddr, unsigned int=
 flags, u32 val,
 =09if (!bitset)
 =09=09return -EINVAL;
 =09q.bitset =3D bitset;
+=09q.uaddr =3D uaddr;
+=09q.val =3D val;
=20
 =09to =3D futex_setup_timer(abs_time, &timeout, flags,
 =09=09=09       current->timer_slack_ns);
@@ -2725,7 +2739,7 @@ static int futex_wait(u32 __user *uaddr, unsigned int=
 flags, u32 val,
 =09 * Prepare to wait on uaddr. On success, holds hb lock and increments
 =09 * q.key refs.
 =09 */
-=09ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
+=09ret =3D futex_wait_setup(q.uaddr, q.val, flags, &q, &hb);
 =09if (ret)
 =09=09goto out;
=20
--=20
1.8.3.1

