Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436ACECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA1120872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBOebo2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbfJOQzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:55:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37943 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388349AbfJOQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571158547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evrRH/7Cb3iwj/sIsHfP6N1ujE5REFtpGbjAchThxEI=;
        b=TBOebo2Zo3GXlcK5QVPirRx6E0MSXOertBnycgJDQ+BIwWMeqtbgey596LgLEKclPH/wOt
        j4jVu85BJXqCL5b3702qCvWqplFtqaywwLqtRmI1F7ONb9XW7zfBgJcCx9HBBviu7BmgLR
        kyvyII8P2lXsXM8N6Jp8utWuWEBUn0k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-nWbd8Ln3O0OrvEqYsb1-Xw-1; Tue, 15 Oct 2019 12:55:44 -0400
Received: by mail-ed1-f69.google.com with SMTP id n14so12585688edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3qaIkOTipftLe8AfzJDidtHctRZS4qNtfpx4+nUFnk=;
        b=fBYb5X8duIameBpGspGVao17VotEIOBIBP95Ut+aLLGfQmK3fD7b2Roo1FBVFJYDRd
         3jMtVNsTVuUG1l+xibp1IA9iA7qBGqTO+gFR6uAFHkmRRLANemZMExfqRZkc8zHyJBhP
         /8lPxhV/PRdvKVkjuU9SmEaDxzx2IIdMzq/a0sotqQNTnbcgscuOVMigu0ABBDCRaOhG
         GmUPbCLJsr/zIrzE4q9MQk9PDcBmPnSxShl3RIEEMkrJc9IMwu8lzLWzAc4eAulfU2qS
         Y6d2H/W5GjqRIuTNAy6rVbmgLllN8LwFLamPmYnO3JZeElFxf7Qf2OIaoISOTSXcJJVM
         rx0A==
X-Gm-Message-State: APjAAAXFqgiaqB/AGER1qrFg5oyXshZ+rONj2Xl7HiY7IbovbpkzcFkY
        AL7fkb0MBmw3FFSRIIrp3ZDWQXUurgkP+ZKoXp3GcyK3rr4uS2v00jSNr/6INBO5YMAZHob3qNL
        sGPYw3DabIwCXfLyz6AE/gn63
X-Received: by 2002:a17:906:3e50:: with SMTP id t16mr35467803eji.177.1571158542242;
        Tue, 15 Oct 2019 09:55:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTCro8ljeXP1eV4SBXZ3Qz/WE6zxPoADmqJRwNRA/SRr+pp8aHDbBUi11Ld6d8Spt8uDcHvA==
X-Received: by 2002:a17:906:3e50:: with SMTP id t16mr35467782eji.177.1571158541930;
        Tue, 15 Oct 2019 09:55:41 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id d24sm1568455edp.27.2019.10.15.09.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:55:41 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] pidfd: avoid linux/wait.h and sys/wait.h name clashes
Date:   Tue, 15 Oct 2019 18:55:30 +0200
Message-Id: <20191015165531.27469-1-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011163811.8607-1-ckellner@redhat.com>
References: <20191011163811.8607-1-ckellner@redhat.com>
MIME-Version: 1.0
X-MC-Unique: nWbd8Ln3O0OrvEqYsb1-Xw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

Both linux/wait.h and sys/wait.h contain values for the first argument
of 'waitid' (P_ALL, P_PID, ...).  While the former uses defines the
latter uses an enum. When linux/wait.h is included before sys/wait.h
this will lead to an error, because P_ALL, P_PID, ... will already
have been substituted to 0, 1, ... respectively and this the resulting
code will be 'typedef enum {0, 1, ...'.
Remove 'linux/wait.h' and rename P_PIDFD to avoid a future clash, in
case P_PIDFD gets added to the idtype_t enum in sys/wait.h.

Signed-off-by: Christian Kellner <christian@kellner.me>
---
 tools/testing/selftests/pidfd/pidfd.h           |  4 ++--
 tools/testing/selftests/pidfd/pidfd_open_test.c |  1 -
 tools/testing/selftests/pidfd/pidfd_poll_test.c |  1 -
 tools/testing/selftests/pidfd/pidfd_wait.c      | 14 +++++++-------
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftest=
s/pidfd/pidfd.h
index c6bc68329f4b..9d5e76bd5466 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,8 +16,8 @@
=20
 #include "../kselftest.h"
=20
-#ifndef P_PIDFD
-#define P_PIDFD 3
+#ifndef __P_PIDFD
+#define __P_PIDFD 3
 #endif
=20
 #ifndef CLONE_PIDFD
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testin=
g/selftests/pidfd/pidfd_open_test.c
index b9fe75fc3e51..8a59438ccc78 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -6,7 +6,6 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testin=
g/selftests/pidfd/pidfd_poll_test.c
index 4b115444dfe9..610811275357 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -3,7 +3,6 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <poll.h>
 #include <signal.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/sel=
ftests/pidfd/pidfd_wait.c
index 7079f8eef792..7e9170b84b81 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -54,7 +54,7 @@ static int test_pidfd_wait_simple(void)
 =09=09ksft_exit_fail_msg("%s test: failed to open /proc/self %s\n",
 =09=09=09=09   test_name, strerror(errno));
=20
-=09pid =3D sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+=09pid =3D sys_waitid(__P_PIDFD, pidfd, &info, WEXITED, NULL);
 =09if (pid =3D=3D 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: succeeded to wait on invalid pidfd %s\n",
@@ -67,7 +67,7 @@ static int test_pidfd_wait_simple(void)
 =09=09ksft_exit_fail_msg("%s test: failed to open /dev/null %s\n",
 =09=09=09=09   test_name, strerror(errno));
=20
-=09pid =3D sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+=09pid =3D sys_waitid(__P_PIDFD, pidfd, &info, WEXITED, NULL);
 =09if (pid =3D=3D 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: succeeded to wait on invalid pidfd %s\n",
@@ -83,7 +83,7 @@ static int test_pidfd_wait_simple(void)
 =09if (pid =3D=3D 0)
 =09=09exit(EXIT_SUCCESS);
=20
-=09pid =3D sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+=09pid =3D sys_waitid(__P_PIDFD, pidfd, &info, WEXITED, NULL);
 =09if (pid < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait on process with pid %d and pidfd %d: %s\=
n",
@@ -145,7 +145,7 @@ static int test_pidfd_wait_states(void)
 =09=09exit(EXIT_SUCCESS);
 =09}
=20
-=09ret =3D sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL);
+=09ret =3D sys_waitid(__P_PIDFD, pidfd, &info, WSTOPPED, NULL);
 =09if (ret < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait on WSTOPPED process with pid %d and pidf=
d %d: %s\n",
@@ -175,7 +175,7 @@ static int test_pidfd_wait_states(void)
 =09=09=09"%s test: failed to send signal to process with pid %d and pidfd =
%d: %s\n",
 =09=09=09test_name, parent_tid, pidfd, strerror(errno));
=20
-=09ret =3D sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL);
+=09ret =3D sys_waitid(__P_PIDFD, pidfd, &info, WCONTINUED, NULL);
 =09if (ret < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait WCONTINUED on process with pid %d and pi=
dfd %d: %s\n",
@@ -199,7 +199,7 @@ static int test_pidfd_wait_states(void)
 =09=09=09test_name, info.si_pid, parent_tid, pidfd,
 =09=09=09strerror(errno));
=20
-=09ret =3D sys_waitid(P_PIDFD, pidfd, &info, WUNTRACED, NULL);
+=09ret =3D sys_waitid(__P_PIDFD, pidfd, &info, WUNTRACED, NULL);
 =09if (ret < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait on WUNTRACED process with pid %d and pid=
fd %d: %s\n",
@@ -229,7 +229,7 @@ static int test_pidfd_wait_states(void)
 =09=09=09"%s test: failed to send SIGKILL to process with pid %d and pidfd=
 %d: %s\n",
 =09=09=09test_name, parent_tid, pidfd, strerror(errno));
=20
-=09ret =3D sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+=09ret =3D sys_waitid(__P_PIDFD, pidfd, &info, WEXITED, NULL);
 =09if (ret < 0)
 =09=09ksft_exit_fail_msg(
 =09=09=09"%s test: failed to wait on WEXITED process with pid %d and pidfd=
 %d: %s\n",
--=20
2.21.0

