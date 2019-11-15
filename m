Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBFC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F5C2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9WnwgKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfKOMgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:36:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20637 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727496AbfKOMgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573821398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYqh447ato/X+1rMl03JQuHMnRrMhLTJ/rTJVaC6rN0=;
        b=Z9WnwgKNas187opu7n8ktPynp808onAhK69j4qjXGcZrdrQB2PUzitON4Rc95MbzDoVeVl
        biLZU8VsjkOGK5pn8gC7cmaaYYtK6nfdb1OmBOfutK7grPekG5eFEbWxOJrs4e9geTgzQ6
        2Mv/6qGflx5hiRg6/Ccw6e1KEu6xQVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ZQ_ZVHtwPMCcSwA918a0bg-1; Fri, 15 Nov 2019 07:36:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D33C107ACC4;
        Fri, 15 Nov 2019 12:36:33 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-116.ams2.redhat.com [10.36.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12CE45D6BE;
        Fri, 15 Nov 2019 12:36:30 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>
Subject: [PATCH v11 2/2] selftests: add tests for clone3() with *set_tid
Date:   Fri, 15 Nov 2019 13:36:21 +0100
Message-Id: <20191115123621.142252-2-areber@redhat.com>
In-Reply-To: <20191115123621.142252-1-areber@redhat.com>
References: <20191115123621.142252-1-areber@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ZQ_ZVHtwPMCcSwA918a0bg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tests clone3() with *set_tid to see if all desired PIDs are working
as expected. The tests are trying multiple invalid input parameters as
well as creating processes while specifying a certain PID in multiple
PID namespaces at the same time.

Additionally this moves common clone3() test code into clone3_selftests.h.

Signed-off-by: Adrian Reber <areber@redhat.com>
---
v9:
 - applied all changes from Christian's review (except using the
   NSpid: parsing code from selftests/pidfd/pidfd_fdinfo_test.c)

v10:
 - added even more '\n' and include file fixes (Christian)

v11:
 - added more return code checking at multiple places (Andrei)
 - also add set_tid/set_tid_size to internal struct (Andrei)
---
 tools/testing/selftests/clone3/.gitignore     |   1 +
 tools/testing/selftests/clone3/Makefile       |   2 +-
 tools/testing/selftests/clone3/clone3.c       |   8 +-
 .../selftests/clone3/clone3_clear_sighand.c   |  20 +-
 .../selftests/clone3/clone3_selftests.h       |  35 ++
 .../testing/selftests/clone3/clone3_set_tid.c | 381 ++++++++++++++++++
 6 files changed, 421 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/clone3/clone3_selftests.h
 create mode 100644 tools/testing/selftests/clone3/clone3_set_tid.c

diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/self=
tests/clone3/.gitignore
index 2a30ae18b06e..0dc4f32c6cb8 100644
--- a/tools/testing/selftests/clone3/.gitignore
+++ b/tools/testing/selftests/clone3/.gitignore
@@ -1,2 +1,3 @@
 clone3
 clone3_clear_sighand
+clone3_set_tid
diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selfte=
sts/clone3/Makefile
index eb26eb793c80..cf976c732906 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS +=3D -g -I../../../../usr/include/
=20
-TEST_GEN_PROGS :=3D clone3 clone3_clear_sighand
+TEST_GEN_PROGS :=3D clone3 clone3_clear_sighand clone3_set_tid
=20
 include ../lib.mk
diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selfte=
sts/clone3/clone3.c
index 0f8a9ef40117..4669b3d418e7 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -18,6 +18,7 @@
 #include <sched.h>
=20
 #include "../kselftest.h"
+#include "clone3_selftests.h"
=20
 /*
  * Different sizes of struct clone_args
@@ -35,11 +36,6 @@ enum test_mode {
 =09CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
 };
=20
-static pid_t raw_clone(struct clone_args *args, size_t size)
-{
-=09return syscall(__NR_clone3, args, size);
-}
-
 static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mo=
de)
 {
 =09struct clone_args args =3D {
@@ -83,7 +79,7 @@ static int call_clone3(uint64_t flags, size_t size, enum =
test_mode test_mode)
=20
 =09memcpy(&args_ext.args, &args, sizeof(struct clone_args));
=20
-=09pid =3D raw_clone((struct clone_args *)&args_ext, size);
+=09pid =3D sys_clone3((struct clone_args *)&args_ext, size);
 =09if (pid < 0) {
 =09=09ksft_print_msg("%s - Failed to create new process\n",
 =09=09=09=09strerror(errno));
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/=
testing/selftests/clone3/clone3_clear_sighand.c
index 0d957be1bdc5..456783ad19d6 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -14,30 +14,12 @@
 #include <sys/wait.h>
=20
 #include "../kselftest.h"
+#include "clone3_selftests.h"
=20
 #ifndef CLONE_CLEAR_SIGHAND
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL
 #endif
=20
-#ifndef __NR_clone3
-#define __NR_clone3 -1
-struct clone_args {
-=09__aligned_u64 flags;
-=09__aligned_u64 pidfd;
-=09__aligned_u64 child_tid;
-=09__aligned_u64 parent_tid;
-=09__aligned_u64 exit_signal;
-=09__aligned_u64 stack;
-=09__aligned_u64 stack_size;
-=09__aligned_u64 tls;
-};
-#endif
-
-static pid_t sys_clone3(struct clone_args *args, size_t size)
-{
-=09return syscall(__NR_clone3, args, size);
-}
-
 static void test_clone3_supported(void)
 {
 =09pid_t pid;
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/test=
ing/selftests/clone3/clone3_selftests.h
new file mode 100644
index 000000000000..1a270390766a
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _CLONE3_SELFTESTS_H
+#define _CLONE3_SELFTESTS_H
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdint.h>
+#include <syscall.h>
+#include <linux/types.h>
+
+#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
+
+#ifndef __NR_clone3
+#define __NR_clone3 -1
+struct clone_args {
+=09__aligned_u64 flags;
+=09__aligned_u64 pidfd;
+=09__aligned_u64 child_tid;
+=09__aligned_u64 parent_tid;
+=09__aligned_u64 exit_signal;
+=09__aligned_u64 stack;
+=09__aligned_u64 stack_size;
+=09__aligned_u64 tls;
+=09__aligned_u64 set_tid;
+=09__aligned_u64 set_tid_size;
+};
+#endif
+
+static pid_t sys_clone3(struct clone_args *args, size_t size)
+{
+=09return syscall(__NR_clone3, args, size);
+}
+
+#endif /* _CLONE3_SELFTESTS_H */
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testin=
g/selftests/clone3/clone3_set_tid.c
new file mode 100644
index 000000000000..3480e1c46983
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Based on Christian Brauner's clone3() example.
+ * These tests are assuming to be running in the host's
+ * PID namespace.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+
+#include "../kselftest.h"
+#include "clone3_selftests.h"
+
+#ifndef MAX_PID_NS_LEVEL
+#define MAX_PID_NS_LEVEL 32
+#endif
+
+static int pipe_1[2];
+static int pipe_2[2];
+
+static int call_clone3_set_tid(pid_t *set_tid,
+=09=09=09       size_t set_tid_size,
+=09=09=09       int flags,
+=09=09=09       int expected_pid,
+=09=09=09       bool wait_for_it)
+{
+=09int status;
+=09pid_t pid =3D -1;
+
+=09struct clone_args args =3D {
+=09=09.flags =3D flags,
+=09=09.exit_signal =3D SIGCHLD,
+=09=09.set_tid =3D ptr_to_u64(set_tid),
+=09=09.set_tid_size =3D set_tid_size,
+=09};
+
+=09pid =3D sys_clone3(&args, sizeof(struct clone_args));
+=09if (pid < 0) {
+=09=09ksft_print_msg("%s - Failed to create new process\n",
+=09=09=09       strerror(errno));
+=09=09return -errno;
+=09}
+
+=09if (pid =3D=3D 0) {
+=09=09int ret;
+=09=09char tmp =3D 0;
+=09=09int exit_code =3D EXIT_SUCCESS;
+
+=09=09ksft_print_msg("I am the child, my PID is %d (expected %d)\n",
+=09=09=09       getpid(), set_tid[0]);
+=09=09if (wait_for_it) {
+=09=09=09ksft_print_msg("[%d] Child is ready and waiting\n",
+=09=09=09=09       getpid());
+
+=09=09=09/* Signal the parent that the child is ready */
+=09=09=09close(pipe_1[0]);
+=09=09=09ret =3D write(pipe_1[1], &tmp, 1);
+=09=09=09if (ret !=3D 1) {
+=09=09=09=09ksft_print_msg(
+=09=09=09=09=09"Writing to pipe returned %d", ret);
+=09=09=09=09exit_code =3D EXIT_FAILURE;
+=09=09=09}
+=09=09=09close(pipe_1[1]);
+=09=09=09close(pipe_2[1]);
+=09=09=09ret =3D read(pipe_2[0], &tmp, 1);
+=09=09=09if (ret !=3D 1) {
+=09=09=09=09ksft_print_msg(
+=09=09=09=09=09"Reading from pipe returned %d", ret);
+=09=09=09=09exit_code =3D EXIT_FAILURE;
+=09=09=09}
+=09=09=09close(pipe_2[0]);
+=09=09}
+
+=09=09if (set_tid[0] !=3D getpid())
+=09=09=09_exit(EXIT_FAILURE);
+=09=09_exit(exit_code);
+=09}
+
+=09if (expected_pid =3D=3D 0 || expected_pid =3D=3D pid) {
+=09=09ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
+=09=09=09       getpid(), pid);
+=09} else {
+=09=09ksft_print_msg(
+=09=09=09"Expected child pid %d does not match actual pid %d\n",
+=09=09=09expected_pid, pid);
+=09=09return -1;
+=09}
+
+=09if (waitpid(pid, &status, 0) < 0) {
+=09=09ksft_print_msg("Child returned %s\n", strerror(errno));
+=09=09return -errno;
+=09}
+
+=09if (!WIFEXITED(status))
+=09=09return -1;
+
+=09return WEXITSTATUS(status);
+}
+
+static void test_clone3_set_tid(pid_t *set_tid,
+=09=09=09=09size_t set_tid_size,
+=09=09=09=09int flags,
+=09=09=09=09int expected,
+=09=09=09=09int expected_pid,
+=09=09=09=09bool wait_for_it)
+{
+=09int ret;
+
+=09ksft_print_msg(
+=09=09"[%d] Trying clone3() with CLONE_SET_TID to %d and 0x%x\n",
+=09=09getpid(), set_tid[0], flags);
+=09ret =3D call_clone3_set_tid(set_tid, set_tid_size, flags, expected_pid,
+=09=09=09=09  wait_for_it);
+=09ksft_print_msg(
+=09=09"[%d] clone3() with CLONE_SET_TID %d says :%d - expected %d\n",
+=09=09getpid(), set_tid[0], ret, expected);
+=09if (ret !=3D expected)
+=09=09ksft_test_result_fail(
+=09=09=09"[%d] Result (%d) is different than expected (%d)\n",
+=09=09=09getpid(), ret, expected);
+=09else
+=09=09ksft_test_result_pass(
+=09=09=09"[%d] Result (%d) matches expectation (%d)\n",
+=09=09=09getpid(), ret, expected);
+}
+int main(int argc, char *argv[])
+{
+=09FILE *f;
+=09char buf;
+=09char *line;
+=09int status;
+=09int ret =3D -1;
+=09size_t len =3D 0;
+=09int pid_max =3D 0;
+=09uid_t uid =3D getuid();
+=09char proc_path[100] =3D {0};
+=09pid_t pid, ns1, ns2, ns3, ns_pid;
+=09pid_t set_tid[MAX_PID_NS_LEVEL * 2];
+
+=09if (pipe(pipe_1) < 0 || pipe(pipe_2) < 0)
+=09=09ksft_exit_fail_msg("pipe() failed\n");
+
+=09ksft_print_header();
+=09ksft_set_plan(27);
+
+=09f =3D fopen("/proc/sys/kernel/pid_max", "r");
+=09if (f =3D=3D NULL)
+=09=09ksft_exit_fail_msg(
+=09=09=09"%s - Could not open /proc/sys/kernel/pid_max\n",
+=09=09=09strerror(errno));
+=09fscanf(f, "%d", &pid_max);
+=09fclose(f);
+=09ksft_print_msg("/proc/sys/kernel/pid_max %d\n", pid_max);
+
+=09/* Try invalid settings */
+=09memset(&set_tid, 0, sizeof(set_tid));
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
+
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
+
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
+=09=09=09-EINVAL, 0, 0);
+
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
+
+=09/*
+=09 * This can actually work if this test running in a MAX_PID_NS_LEVEL - =
1
+=09 * nested PID namespace.
+=09 */
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
+
+=09memset(&set_tid, 0xff, sizeof(set_tid));
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
+
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
+
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
+=09=09=09-EINVAL, 0, 0);
+
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
+
+=09/*
+=09 * This can actually work if this test running in a MAX_PID_NS_LEVEL - =
1
+=09 * nested PID namespace.
+=09 */
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
+
+=09memset(&set_tid, 0, sizeof(set_tid));
+=09/* Try with an invalid PID */
+=09set_tid[0] =3D 0;
+=09test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+
+=09set_tid[0] =3D -1;
+=09test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+
+=09/* Claim that the set_tid array actually contains 2 elements. */
+=09test_clone3_set_tid(set_tid, 2, 0, -EINVAL, 0, 0);
+
+=09/* Try it in a new PID namespace */
+=09if (uid =3D=3D 0)
+=09=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
+=09else
+=09=09ksft_test_result_skip("Clone3() with set_tid requires root\n");
+
+=09/* Try with a valid PID (1) this should return -EEXIST. */
+=09set_tid[0] =3D 1;
+=09if (uid =3D=3D 0)
+=09=09test_clone3_set_tid(set_tid, 1, 0, -EEXIST, 0, 0);
+=09else
+=09=09ksft_test_result_skip("Clone3() with set_tid requires root\n");
+
+=09/* Try it in a new PID namespace */
+=09if (uid =3D=3D 0)
+=09=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, 0, 0, 0);
+=09else
+=09=09ksft_test_result_skip("Clone3() with set_tid requires root\n");
+
+=09/* pid_max should fail everywhere */
+=09set_tid[0] =3D pid_max;
+=09test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+
+=09if (uid =3D=3D 0)
+=09=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
+=09else
+=09=09ksft_test_result_skip("Clone3() with set_tid requires root\n");
+
+=09if (uid !=3D 0) {
+=09=09/*
+=09=09 * All remaining tests require root. Tell the framework
+=09=09 * that all those tests are skipped as non-root.
+=09=09 */
+=09=09ksft_cnt.ksft_xskip +=3D ksft_plan - ksft_test_num();
+=09=09goto out;
+=09}
+
+=09/* Find the current active PID */
+=09pid =3D fork();
+=09if (pid =3D=3D 0) {
+=09=09ksft_print_msg("Child has PID %d\n", getpid());
+=09=09_exit(EXIT_SUCCESS);
+=09}
+=09if (waitpid(pid, &status, 0) < 0)
+=09=09ksft_exit_fail_msg("Waiting for child %d failed", pid);
+
+=09/* After the child has finished, its PID should be free. */
+=09set_tid[0] =3D pid;
+=09test_clone3_set_tid(set_tid, 1, 0, 0, 0, 0);
+
+=09/* This should fail as there is no PID 1 in that namespace */
+=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
+
+=09/*
+=09 * Creating a process with PID 1 in the newly created most nested
+=09 * PID namespace and PID 'pid' in the parent PID namespace. This
+=09 * needs to work.
+=09 */
+=09set_tid[0] =3D 1;
+=09set_tid[1] =3D pid;
+=09test_clone3_set_tid(set_tid, 2, CLONE_NEWPID, 0, pid, 0);
+
+=09ksft_print_msg("unshare PID namespace\n");
+=09if (unshare(CLONE_NEWPID) =3D=3D -1)
+=09=09ksft_exit_fail_msg("unshare(CLONE_NEWPID) failed: %s\n",
+=09=09=09=09strerror(errno));
+
+=09set_tid[0] =3D pid;
+
+=09/* This should fail as there is no PID 1 in that namespace */
+=09test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+
+=09/* Let's create a PID 1 */
+=09ns_pid =3D fork();
+=09if (ns_pid =3D=3D 0) {
+=09=09ksft_print_msg("Child in PID namespace has PID %d\n", getpid());
+=09=09set_tid[0] =3D 2;
+=09=09test_clone3_set_tid(set_tid, 1, 0, 0, 2, 0);
+
+=09=09set_tid[0] =3D 1;
+=09=09set_tid[1] =3D -1;
+=09=09set_tid[2] =3D pid;
+=09=09/* This should fail as there is invalid PID at level '1'. */
+=09=09test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, -EINVAL, 0, 0);
+
+=09=09set_tid[0] =3D 1;
+=09=09set_tid[1] =3D 42;
+=09=09set_tid[2] =3D pid;
+=09=09/*
+=09=09 * This should fail as there are not enough active PID
+=09=09 * namespaces. Again assuming this is running in the host's
+=09=09 * PID namespace. Not yet nested.
+=09=09 */
+=09=09test_clone3_set_tid(set_tid, 4, CLONE_NEWPID, -EINVAL, 0, 0);
+
+=09=09/*
+=09=09 * This should work and from the parent we should see
+=09=09 * something like 'NSpid:=09pid=0942=091'.
+=09=09 */
+=09=09test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, true);
+
+=09=09_exit(ksft_cnt.ksft_pass);
+=09}
+
+=09close(pipe_1[1]);
+=09close(pipe_2[0]);
+=09while (read(pipe_1[0], &buf, 1) > 0) {
+=09=09ksft_print_msg("[%d] Child is ready and waiting\n", getpid());
+=09=09break;
+=09}
+
+=09snprintf(proc_path, sizeof(proc_path), "/proc/%d/status", pid);
+=09f =3D fopen(proc_path, "r");
+=09if (f =3D=3D NULL)
+=09=09ksft_exit_fail_msg(
+=09=09=09"%s - Could not open %s\n",
+=09=09=09strerror(errno), proc_path);
+
+=09while (getline(&line, &len, f) !=3D -1) {
+=09=09if (strstr(line, "NSpid")) {
+=09=09=09int i;
+
+=09=09=09/* Verify that all generated PIDs are as expected. */
+=09=09=09i =3D sscanf(line, "NSpid:\t%d\t%d\t%d",
+=09=09=09=09   &ns3, &ns2, &ns1);
+=09=09=09if (i !=3D 3) {
+=09=09=09=09ksft_print_msg(
+=09=09=09=09=09"Unexpected 'NSPid:' entry: %s",
+=09=09=09=09=09line);
+=09=09=09=09ns1 =3D ns2 =3D ns3 =3D 0;
+=09=09=09}
+=09=09=09break;
+=09=09}
+=09}
+=09fclose(f);
+=09free(line);
+=09close(pipe_2[0]);
+
+=09/* Tell the clone3()'d child to finish. */
+=09write(pipe_2[1], &buf, 1);
+=09close(pipe_2[1]);
+
+=09if (waitpid(ns_pid, &status, 0) < 0) {
+=09=09ksft_print_msg("Child returned %s\n", strerror(errno));
+=09=09ret =3D -errno;
+=09=09goto out;
+=09}
+
+=09if (!WIFEXITED(status))
+=09=09ksft_test_result_fail("Child error\n");
+
+=09if (WEXITSTATUS(status))
+=09=09/*
+=09=09 * Update the number of total tests with the tests from the
+=09=09 * child processes.
+=09=09 */
+=09=09ksft_cnt.ksft_pass =3D WEXITSTATUS(status);
+
+=09if (ns3 =3D=3D pid && ns2 =3D=3D 42 && ns1 =3D=3D 1)
+=09=09ksft_test_result_pass(
+=09=09=09"PIDs in all namespaces as expected (%d,%d,%d)\n",
+=09=09=09ns3, ns2, ns1);
+=09else
+=09=09ksft_test_result_fail(
+=09=09=09"PIDs in all namespaces not as expected (%d,%d,%d)\n",
+=09=09=09ns3, ns2, ns1);
+out:
+=09ret =3D 0;
+
+=09return !ret ? ksft_exit_pass() : ksft_exit_fail();
+}
--=20
2.23.0

