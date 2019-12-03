Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2652CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D952073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCvzfRol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLCONU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:13:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20803 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbfLCONS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575382397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RINt5H6E6S+CIkfZFzFtBlacv4PnZvqc51Ll/CPGA/U=;
        b=RCvzfRolM/ftmF5U9rYT9EwkvRr0ppeu+AMBAZ1Izlp02Ht8C+AYZu0DQboVTj3NUaevxl
        iy2XOvfN6YGZXlRY2EmN43b1Sg2R6Yb5KYEs3iaPWYXLVqzr22PnBqxCgWLF116Qa328PV
        b79irVVFsQyvMRbT8Ye2erkE4kOh6Tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-ujkGsWRbOpeTGc_fGdAlng-1; Tue, 03 Dec 2019 09:13:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B312F1085983;
        Tue,  3 Dec 2019 14:13:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3FB6C19C7F;
        Tue,  3 Dec 2019 14:13:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Dec 2019 15:13:10 +0100 (CET)
Date:   Tue, 3 Dec 2019 15:13:05 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 1/4] introduce set_restart_fn() and arch_set_restart_data()
Message-ID: <20191203141305.GB30688@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191203141239.GA30688@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191203141239.GA30688@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ujkGsWRbOpeTGc_fGdAlng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparation. Add the new helper which sets restart_block->fn and calls
the dummy arch_set_restart_data() helper.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/select.c                    | 10 ++++------
 include/linux/thread_info.h    | 12 ++++++++++++
 kernel/futex.c                 |  3 +--
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/hrtimer.c          |  2 +-
 kernel/time/posix-cpu-timers.c |  2 +-
 6 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 53a0c14..e517960 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1037,10 +1037,9 @@ static long do_restart_poll(struct restart_block *re=
start_block)
=20
 =09ret =3D do_sys_poll(ufds, nfds, to);
=20
-=09if (ret =3D=3D -ERESTARTNOHAND) {
-=09=09restart_block->fn =3D do_restart_poll;
-=09=09ret =3D -ERESTART_RESTARTBLOCK;
-=09}
+=09if (ret =3D=3D -ERESTARTNOHAND)
+=09=09ret =3D set_restart_fn(restart_block, do_restart_poll);
+
 =09return ret;
 }
=20
@@ -1062,7 +1061,6 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, u=
nsigned int, nfds,
 =09=09struct restart_block *restart_block;
=20
 =09=09restart_block =3D &current->restart_block;
-=09=09restart_block->fn =3D do_restart_poll;
 =09=09restart_block->poll.ufds =3D ufds;
 =09=09restart_block->poll.nfds =3D nfds;
=20
@@ -1073,7 +1071,7 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, u=
nsigned int, nfds,
 =09=09} else
 =09=09=09restart_block->poll.has_timeout =3D 0;
=20
-=09=09ret =3D -ERESTART_RESTARTBLOCK;
+=09=09ret =3D set_restart_fn(restart_block, do_restart_poll);
 =09}
 =09return ret;
 }
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 659a440..df8e3fb 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -39,6 +39,18 @@ enum {
=20
 #ifdef __KERNEL__
=20
+#ifndef arch_set_restart_data
+#define arch_set_restart_data(restart) do { } while (0)
+#endif
+
+static inline long set_restart_fn(struct restart_block *restart,
+=09=09=09=09=09long (*fn)(struct restart_block *))
+{
+=09restart->fn =3D fn;
+=09arch_set_restart_data(restart);
+=09return -ERESTART_RESTARTBLOCK;
+}
+
 #ifndef THREAD_ALIGN
 #define THREAD_ALIGN=09THREAD_SIZE
 #endif
diff --git a/kernel/futex.c b/kernel/futex.c
index bd18f60..f4f20e9 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2753,14 +2753,13 @@ static int futex_wait(u32 __user *uaddr, unsigned i=
nt flags, u32 val,
 =09=09goto out;
=20
 =09restart =3D &current->restart_block;
-=09restart->fn =3D futex_wait_restart;
 =09restart->futex.uaddr =3D uaddr;
 =09restart->futex.val =3D val;
 =09restart->futex.time =3D *abs_time;
 =09restart->futex.bitset =3D bitset;
 =09restart->futex.flags =3D flags | FLAGS_HAS_TIMEOUT;
=20
-=09ret =3D -ERESTART_RESTARTBLOCK;
+=09ret =3D set_restart_fn(restart, futex_wait_restart);
=20
 out:
 =09if (to) {
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 451f9d0..a2ddf56 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -829,9 +829,9 @@ static int alarm_timer_nsleep(const clockid_t which_clo=
ck, int flags,
 =09if (flags =3D=3D TIMER_ABSTIME)
 =09=09return -ERESTARTNOHAND;
=20
-=09restart->fn =3D alarm_timer_nsleep_restart;
 =09restart->nanosleep.clockid =3D type;
 =09restart->nanosleep.expires =3D exp;
+=09set_restart_fn(restart, alarm_timer_nsleep_restart);
 =09return ret;
 }
=20
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6560553..55f71c4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1932,9 +1932,9 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 =09}
=20
 =09restart =3D &current->restart_block;
-=09restart->fn =3D hrtimer_nanosleep_restart;
 =09restart->nanosleep.clockid =3D t.timer.base->clockid;
 =09restart->nanosleep.expires =3D hrtimer_get_expires_tv64(&t.timer);
+=09set_restart_fn(restart, hrtimer_nanosleep_restart);
 out:
 =09destroy_hrtimer_on_stack(&t.timer);
 =09return ret;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.=
c
index 42d512f..eacb0ca 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1335,8 +1335,8 @@ static int posix_cpu_nsleep(const clockid_t which_clo=
ck, int flags,
 =09=09if (flags & TIMER_ABSTIME)
 =09=09=09return -ERESTARTNOHAND;
=20
-=09=09restart_block->fn =3D posix_cpu_nsleep_restart;
 =09=09restart_block->nanosleep.clockid =3D which_clock;
+=09=09set_restart_fn(restart_block, posix_cpu_nsleep_restart);
 =09}
 =09return error;
 }
--=20
2.5.0


