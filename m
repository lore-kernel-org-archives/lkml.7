Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6126CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 23:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B542321897
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 23:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzSkYAg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfKAXji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 19:39:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57577 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbfKAXjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 19:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572651575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oBYEba37giIKH0qY+jTL36ZcV1ZjewOiLdyycI6S+wo=;
        b=NzSkYAg3dxdim9U+dkqvmnAT43UhojaT4b5g5gXKKjIg/aWLRVL4wlNQg7mUVfUgGacgCy
        gKOpRktfv6cKX5eYeZOqOe6mDTkpBsiekNylMN9os6QasPGOQJJFGRUiFHn4mS8F7z44DK
        ABSQTcAA4XYD5brHLAI1gq4Kttbfqsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-S09mapU2PbqGuKTDDtkcjQ-1; Fri, 01 Nov 2019 19:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B746F107ACC0;
        Fri,  1 Nov 2019 23:39:30 +0000 (UTC)
Received: from dustball.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D6605D6B7;
        Fri,  1 Nov 2019 23:39:28 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     ltp@lists.linux.it, jstancek@redhat.com, viro@zeniv.linux.org.uk,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, rfontana@redhat.com
Subject: [PATCH] kernel: use ktime_get_real_ts64() to calculate acct.ac_btime
Date:   Sat,  2 Nov 2019 00:39:24 +0100
Message-Id: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: S09mapU2PbqGuKTDDtkcjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fill_ac() calculates process creation time from current time as:
   ac->ac_btime =3D get_seconds() - elapsed

get_seconds() doesn't accumulate nanoseconds as regular time getters.
This creates race for user-space (e.g. LTP acct02), which typically
uses gettimeofday(), because process creation time sometimes appear
to be dated 'in past':

    acct("myfile");
    time_t start_time =3D time(NULL);
    if (fork()=3D=3D0) {
        sleep(1);
        exit(0);
    }
    waitpid(NULL);
    acct(NULL);

    // acct.ac_btime =3D=3D 1572616777
    // start_time =3D=3D 1572616778

Testing: 10 hours of LTP acct02 on s390x with CONFIG_HZ=3D100,
         test failed on unpatched kernel in 15 minutes

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Fontana <rfontana@redhat.com>
---
 kernel/acct.c   | 4 +++-
 kernel/tsacct.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 81f9831a7859..991c898160cd 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -417,6 +417,7 @@ static void fill_ac(acct_t *ac)
 =09struct pacct_struct *pacct =3D &current->signal->pacct;
 =09u64 elapsed, run_time;
 =09struct tty_struct *tty;
+=09struct timespec64 ts;
=20
 =09/*
 =09 * Fill the accounting struct with the needed info as recorded
@@ -448,7 +449,8 @@ static void fill_ac(acct_t *ac)
 =09}
 #endif
 =09do_div(elapsed, AHZ);
-=09ac->ac_btime =3D get_seconds() - elapsed;
+=09ktime_get_real_ts64(&ts);
+=09ac->ac_btime =3D ts.tv_sec - elapsed;
 #if ACCT_VERSION=3D=3D2
 =09ac->ac_ahz =3D AHZ;
 #endif
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 7be3e7530841..4d10854255ab 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -24,6 +24,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 =09const struct cred *tcred;
 =09u64 utime, stime, utimescaled, stimescaled;
 =09u64 delta;
+=09struct timespec64 ts;
=20
 =09BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
=20
@@ -34,7 +35,8 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 =09stats->ac_etime =3D delta;
 =09/* Convert to seconds for btime */
 =09do_div(delta, USEC_PER_SEC);
-=09stats->ac_btime =3D get_seconds() - delta;
+=09ktime_get_real_ts64(&ts);
+=09stats->ac_btime =3D ts.tv_sec - delta;
 =09if (thread_group_leader(tsk)) {
 =09=09stats->ac_exitcode =3D tsk->exit_code;
 =09=09if (tsk->flags & PF_FORKNOEXEC)
--=20
1.8.3.1

