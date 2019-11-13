Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A9C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982F0222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpX0SBqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKMIDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:03:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56001 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbfKMIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573632218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOqZ4sAQvUxkR5VUvsaiwKgAmuDeLZzFu9zvX07Nwg0=;
        b=NpX0SBqqKddRMP5fj4yA4AS6C6/eV7Uma4PFC9KMu38DhILHjFPl1wY2ZpDtA03lnk9dRA
        m2sPJKU22gNYv1K4exloxFerDzHV3gx5kfC8zgKL0bXUvVgq8USB9Ifloxrt+PI3uAHcDi
        yGERwsNKS1p9F40NB5mqMyQDL64Jsk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-ix3CHW8cM068F2eTuOZbEw-1; Wed, 13 Nov 2019 03:03:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F29CE8C1690;
        Wed, 13 Nov 2019 08:03:33 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 816D96019C;
        Wed, 13 Nov 2019 08:03:31 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>
Subject: [PATCH v8 2/2] selftests: add tests for clone3()
Date:   Wed, 13 Nov 2019 09:03:01 +0100
Message-Id: <20191113080301.1197762-2-areber@redhat.com>
In-Reply-To: <20191113080301.1197762-1-areber@redhat.com>
References: <20191113080301.1197762-1-areber@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ix3CHW8cM068F2eTuOZbEw-1
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

Signed-off-by: Adrian Reber <areber@redhat.com>
---
 tools/testing/selftests/clone3/.gitignore     |   1 +
 tools/testing/selftests/clone3/Makefile       |   2 +-
 .../testing/selftests/clone3/clone3_set_tid.c | 345 ++++++++++++++++++
 3 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/clone3/clone3_set_tid.c

diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/self=
tests/clone3/.gitignore
index 85d9d3ba2524..d56c3c49d869 100644
--- a/tools/testing/selftests/clone3/.gitignore
+++ b/tools/testing/selftests/clone3/.gitignore
@@ -1 +1,2 @@
 clone3
+clone3_set_tid
diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selfte=
sts/clone3/Makefile
index ea922c014ae4..2d292545ca8e 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -2,6 +2,6 @@
=20
 CFLAGS +=3D -I../../../../usr/include/
=20
-TEST_GEN_PROGS :=3D clone3
+TEST_GEN_PROGS :=3D clone3 clone3_set_tid
=20
 include ../lib.mk
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testin=
g/selftests/clone3/clone3_set_tid.c
new file mode 100644
index 000000000000..9a234fd2031e
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -0,0 +1,345 @@
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
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+
+#include "../kselftest.h"
+
+#ifndef MAX_PID_NS_LEVEL
+#define MAX_PID_NS_LEVEL 32
+#endif
+
+static int pipe_1[2];
+static int pipe_2[2];
+
+static pid_t raw_clone(struct clone_args *args)
+{
+=09return syscall(__NR_clone3, args, sizeof(struct clone_args));
+}
+
+static int call_clone3_set_tid(pid_t *set_tid,
+=09=09=09       size_t set_tid_size,
+=09=09=09       int flags,
+=09=09=09       int expected_pid,
+=09=09=09       int wait_for_it)
+{
+=09int status;
+=09int ret =3D 0;
+=09pid_t pid =3D -1;
+=09struct clone_args args =3D {0};
+
+=09args.flags =3D flags;
+=09args.exit_signal =3D SIGCHLD;
+=09args.set_tid =3D (__u64)set_tid;
+=09args.set_tid_size =3D set_tid_size;
+
+=09pid =3D raw_clone(&args);
+=09if (pid < 0) {
+=09=09ksft_print_msg("%s - Failed to create new process\n",
+=09=09=09       strerror(errno));
+=09=09return -errno;
+=09}
+
+=09if (pid =3D=3D 0) {
+=09=09char tmp =3D 0;
+=09=09ksft_print_msg("I am the child, my PID is %d (expected %d)\n",
+=09=09=09       getpid(), set_tid[0]);
+=09=09if (wait_for_it) {
+=09=09=09ksft_print_msg("[%d] Child is ready and waiting\n", getpid());
+=09=09=09/* Signal the parent that the child is ready */
+=09=09=09close(pipe_1[0]);
+=09=09=09write(pipe_1[1], &tmp, 1);
+=09=09=09close(pipe_1[1]);
+=09=09=09close(pipe_2[1]);
+=09=09=09read(pipe_2[0], &tmp, 1);
+=09=09=09close(pipe_2[0]);
+=09=09}
+
+=09=09if (set_tid[0] !=3D getpid())
+=09=09=09_exit(EXIT_FAILURE);
+=09=09_exit(EXIT_SUCCESS);
+=09}
+
+=09if (expected_pid =3D=3D 0 || expected_pid =3D=3D pid)
+=09=09ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
+=09=09=09       getpid(), pid);
+=09else {
+=09=09ksft_print_msg(
+=09=09=09"Expected child pid %d does not match actual pid %d\n",
+=09=09=09expected_pid, pid);
+=09=09ret =3D -1;
+=09}
+
+=09if (wait(&status) < 0) {
+=09=09ksft_print_msg("Child returned %s\n", strerror(errno));
+=09=09return -errno;
+=09}
+=09if (WEXITSTATUS(status))
+=09=09return WEXITSTATUS(status);
+
+=09return ret;
+}
+
+static void test_clone3_set_tid(pid_t *set_tid,
+=09=09=09=09size_t set_tid_size,
+=09=09=09=09int flags,
+=09=09=09=09int expected,
+=09=09=09=09int expected_pid,
+=09=09=09=09int wait_for_it)
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
+=09=09ksft_test_result_pass("[%d] Result (%d) matches expectation (%d)\n",
+=09=09=09getpid(), ret, expected);
+}
+int main(int argc, char *argv[])
+{
+=09FILE *f;
+=09char buf;
+=09pid_t pid;
+=09pid_t ns1;
+=09pid_t ns2;
+=09pid_t ns3;
+=09int status;
+=09char *proc;
+=09int ret =3D -1;
+=09pid_t ns_pid;
+=09int pid_max =3D 0;
+=09uid_t uid =3D getuid();
+=09char line[1024] =3D {0};
+=09pid_t set_tid[MAX_PID_NS_LEVEL * 2];
+=09pid_t set_tid_small[1];
+
+=09if (pipe(pipe_1) =3D=3D -1 || pipe(pipe_2))
+=09=09 ksft_exit_fail_msg("pipe() failed\n");
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
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -E2BIG, 0, 0);
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -E2BIG, 0, 0);
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0, -E2BIG, 0, 0)=
;
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -E2BIG, 0, 0);
+
+=09/* small set_tid array, but maximum set_tid_size */
+=09/* Find the current active PID */
+=09pid =3D fork();
+=09if (pid =3D=3D 0) {
+=09=09ksft_print_msg("Child has PID %d\n", getpid());
+=09=09_exit(EXIT_SUCCESS);
+=09}
+=09(void)wait(NULL);
+=09/* After the child has finished, its PID should be free. */
+=09set_tid_small[0] =3D pid;
+=09/*
+=09 * There is a chance that this can return -EFAULT as the actual
+=09 * set_tid array has only one entry, but we are telling the kernel
+=09 * that it has the size MAX_PID_NS_LEVEL. This could lead to a
+=09 * situation where copy_from_user() fails. So far it always
+=09 * succeeds and copies random data (whatever is after set_tid_small).
+=09 */
+=09test_clone3_set_tid(set_tid_small, MAX_PID_NS_LEVEL, 0, -EINVAL, 0, 0);
+
+=09/*
+=09 * This can actually work if this test running in a MAX_PID_NS_LEVEL - =
1
+=09 * nested PID namespace.
+=09 */
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
+
+=09memset(&set_tid, 0xff, sizeof(set_tid));
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -E2BIG, 0, 0);
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -E2BIG, 0, 0);
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0, -E2BIG, 0, 0)=
;
+=09test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -E2BIG, 0, 0);
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
+=09set_tid[0] =3D -1;
+=09test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+=09/* Claim that the set_tid array actually contains 2 elements. */
+=09test_clone3_set_tid(set_tid, 2, 0, -EINVAL, 0, 0);
+=09/* Try it in a new PID namespace */
+=09if (uid =3D=3D 0)
+=09=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
+=09else
+=09=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EPERM, 0, 0);
+
+=09/*
+=09 * Try with a valid PID (1) but as non-root. This should fail
+=09 * with -EPERM if running in the initial user namespace.
+=09 * As root it should tell us -EEXIST.
+=09 */
+=09set_tid[0] =3D 1;
+=09if (uid =3D=3D 0)
+=09=09test_clone3_set_tid(set_tid, 1, 0, -EEXIST, 0, 0);
+=09else
+=09=09test_clone3_set_tid(set_tid, 1, 0, -EPERM, 0, 0);
+
+=09/* Try it in a new PID namespace */
+=09if (uid =3D=3D 0)
+=09=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, 0, 0, 0);
+=09else
+=09=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EPERM, 0, 0);
+
+=09/* pid_max should fail everywhere */
+=09set_tid[0] =3D pid_max;
+=09test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+=09if (uid =3D=3D 0)
+=09=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
+=09else
+=09=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EPERM, 0, 0);
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
+=09=09usleep(500);
+=09=09_exit(EXIT_SUCCESS);
+=09}
+=09(void)wait(NULL);
+=09/* After the child has finished, its PID should be free. */
+=09set_tid[0] =3D pid;
+=09test_clone3_set_tid(set_tid, 1, 0, 0, 0, 0);
+=09/* This should fail as there is no PID 1 in that namespace */
+=09test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
+=09set_tid[0] =3D 1;
+=09set_tid[1] =3D pid;
+=09test_clone3_set_tid(set_tid, 2, CLONE_NEWPID, 0, pid, 0);
+
+=09ksft_print_msg("unshare PID namespace\n");
+=09unshare(CLONE_NEWPID);
+=09set_tid[0] =3D pid;
+=09/* This should fail as there is no PID 1 in that namespace */
+=09test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
+
+=09/* Let's create a PID 1 */
+=09ns_pid =3D fork();
+=09if (ns_pid =3D=3D 0) {
+=09=09ksft_print_msg("Child in PID namespace has PID %d\n", getpid());
+=09=09set_tid[0] =3D 2;
+=09=09test_clone3_set_tid(set_tid, 1, 0, 0, 2, 0);
+=09=09set_tid[0] =3D 1;
+=09=09set_tid[1] =3D 42;
+=09=09set_tid[2] =3D pid;
+=09=09/*
+=09=09 * This should fail as there are not enough active PID
+=09=09 * namespaces. Again assuming this is running in the host's
+=09=09 * PID namespace. Not yet nested.
+=09=09 */
+=09=09test_clone3_set_tid(set_tid, 4, CLONE_NEWPID, -EINVAL, 0, 0);
+=09=09/*
+=09=09 * This should work and from the parent we should see
+=09=09 * something like 'NSpid:=09pid=0942=091'.
+=09=09 */
+=09=09test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, 1);
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
+=09asprintf(&proc, "/proc/%d/status", pid);
+=09f =3D fopen(proc, "r");
+=09if (f =3D=3D NULL)
+=09=09ksft_exit_fail_msg(
+=09=09=09"%s - Could not open %s\n",
+=09=09=09strerror(errno), proc);
+=09while (fgets(line, 1024, f)) {
+=09=09if (strstr(line, "NSpid")) {
+=09=09=09/* Verify that all generated PIDs are as expected. */
+=09=09=09sscanf(line, "NSpid:\t%d\t%d\t%d", &ns3, &ns2, &ns1);
+=09=09=09break;
+=09=09}
+=09}
+=09fclose(f);
+=09free(proc);
+=09close(pipe_2[0]);
+=09/* Tell the clone3()'d child to finish. */
+=09write(pipe_2[1], &buf, 1);
+=09close(pipe_2[1]);
+
+=09if (wait(&status) < 0) {
+=09=09ksft_print_msg("Child returned %s\n", strerror(errno));
+=09=09ret =3D -errno;
+=09=09goto out;
+=09}
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

