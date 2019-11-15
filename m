Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8682CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3962E20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WB/rYisy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKOMgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:36:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727628AbfKOMgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573821394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zv+Y9CxgauSzdlCsCDl/Q9xLcRyQJDitEYajtnl9yag=;
        b=WB/rYisyR5KacpZ6ewM55zD+0bGFk9y/N5TlRyOCnvOh7Pv/yqhLKXzjD0L6wewuMzLRNC
        WOdrLXhYMayn96UlcLlHcesa6Z6KurvBucEdPpLQZX961xSgM1ov6u4Jp5XNrHug9DNygJ
        Cdee2MwZn85A1UyXJLpOgkcwctwaUUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-xiC4is2ZNjuywst1whQX-A-1; Fri, 15 Nov 2019 07:36:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4F0F1005500;
        Fri, 15 Nov 2019 12:36:29 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-116.ams2.redhat.com [10.36.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76CE05D6BE;
        Fri, 15 Nov 2019 12:36:24 +0000 (UTC)
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
Subject: [PATCH v11 1/2] fork: extend clone3() to support setting a PID
Date:   Fri, 15 Nov 2019 13:36:20 +0100
Message-Id: <20191115123621.142252-1-areber@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: xiC4is2ZNjuywst1whQX-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main motivation to add set_tid to clone3() is CRIU.

To restore a process with the same PID/TID CRIU currently uses
/proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
ns_last_pid and then (quickly) does a clone(). This works most of the
time, but it is racy. It is also slow as it requires multiple syscalls.

Extending clone3() to support *set_tid makes it possible restore a
process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
race free (as long as the desired PID/TID is available).

This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
on clone3() with *set_tid as they are currently in place for ns_last_pid.

The original version of this change was using a single value for
set_tid. At the 2019 LPC, after presenting set_tid, it was, however,
decided to change set_tid to an array to enable setting the PID of a
process in multiple PID namespaces at the same time. If a process is
created in a PID namespace it is possible to influence the PID inside
and outside of the PID namespace. Details also in the corresponding
selftest.

To create a process with the following PIDs:

      PID NS level         Requested PID
        0 (host)              31496
        1                        42
        2                         1

For that example the two newly introduced parameters to struct
clone_args (set_tid and set_tid_size) would need to be:

  set_tid[0] =3D 1;
  set_tid[1] =3D 42;
  set_tid[2] =3D 31496;
  set_tid_size =3D 3;

If only the PIDs of the two innermost nested PID namespaces should be
defined it would look like this:

  set_tid[0] =3D 1;
  set_tid[1] =3D 42;
  set_tid_size =3D 2;

The PID of the newly created process would then be the next available
free PID in the PID namespace level 0 (host) and 42 in the PID namespace
at level 1 and the PID of the process in the innermost PID namespace
would be 1.

The set_tid array is used to specify the PID of a process starting
from the innermost nested PID namespaces up to set_tid_size PID namespaces.

set_tid_size cannot be larger then the current PID namespace level.

Signed-off-by: Adrian Reber <areber@redhat.com>
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v2:
 - Removed (size < sizeof(struct clone_args)) as discussed with
   Christian and Dmitry
 - Added comment to ((set_tid !=3D 1) && idr_get_cursor() <=3D 1) (Oleg)
 - Use idr_alloc() instead of idr_alloc_cyclic() (Oleg)

v3:
 - Return EEXIST if PID is already in use (Christian)
 - Drop CLONE_SET_TID (Christian and Oleg)
 - Use idr_is_empty() instead of idr_get_cursor() (Oleg)
 - Handle different `struct clone_args` sizes (Dmitry)

v4:
 - Rework struct size check with defines (Christian)
 - Reduce number of set_tid checks (Oleg)
 - Less parentheses and more robust code (Oleg)
 - Do ns_capable() on correct user_ns (Oleg, Christian)

v5:
 - make set_tid checks earlier in alloc_pid() (Christian)
 - remove unnecessary comment and struct size check (Christian)

v6:
 - remove CLONE_SET_TID from description (Christian)
 - add clone3() tests for different clone_args sizes (Christian)
 - move more set_tid checks to alloc_pid() (Oleg)
 - make all set_tid checks lockless (Oleg)

v7:
 - changed set_tid to be an array to set the PID of a process
   in multiple nested PID namespaces at the same time as discussed
   at LPC 2019 (container MC)

v8:
 - skip unnecessary memset() (Rasmus)
 - replace set_tid copy loop with a single copy (Christian)
 - more parameter error checking (Christian)
 - cache set_tid in alloc_pid() (Oleg)
 - move code in "else" branch (Oleg)

v9:
 - added kernel-doc to include/uapi/linux/sched.h (Christian)
 - moved a variable to limit its scope; keep all set_tid_size
   related changes in one place (Oleg)

v10:
 - added CLONE_ARGS_SIZE_VER1 to sched.h (Christian)

v11:
 - abort alloc_pid() correctly if one of the PIDs specified in
   set_pid[] is invalid (Andrei)
---
 include/linux/pid.h           |  3 +-
 include/linux/pid_namespace.h |  2 +
 include/linux/sched/task.h    |  3 ++
 include/uapi/linux/sched.h    | 53 +++++++++++++++++---------
 kernel/fork.c                 | 24 +++++++++++-
 kernel/pid.c                  | 72 +++++++++++++++++++++++++++--------
 kernel/pid_namespace.c        |  2 -
 7 files changed, 122 insertions(+), 37 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 034e3cd60dc0..998ae7d24450 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -124,7 +124,8 @@ extern struct pid *find_vpid(int nr);
 extern struct pid *find_get_pid(int nr);
 extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
=20
-extern struct pid *alloc_pid(struct pid_namespace *ns);
+extern struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
+=09=09=09     size_t set_tid_size);
 extern void free_pid(struct pid *pid);
 extern void disable_pid_allocation(struct pid_namespace *ns);
=20
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 49538b172483..2ed6af88794b 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -12,6 +12,8 @@
 #include <linux/ns_common.h>
 #include <linux/idr.h>
=20
+/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
+#define MAX_PID_NS_LEVEL 32
=20
 struct fs_pin;
=20
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 4b1c3b664f51..f1879884238e 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -26,6 +26,9 @@ struct kernel_clone_args {
 =09unsigned long stack;
 =09unsigned long stack_size;
 =09unsigned long tls;
+=09pid_t *set_tid;
+=09/* Number of elements in *set_tid */
+=09size_t set_tid_size;
 };
=20
 /*
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 1d500ed03c63..2e649cfa07f4 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -39,24 +39,38 @@
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
- * @flags:       Flags for the new process as listed above.
- *               All flags are valid except for CSIGNAL and
- *               CLONE_DETACHED.
- * @pidfd:       If CLONE_PIDFD is set, a pidfd will be
- *               returned in this argument.
- * @child_tid:   If CLONE_CHILD_SETTID is set, the TID of the
- *               child process will be returned in the child's
- *               memory.
- * @parent_tid:  If CLONE_PARENT_SETTID is set, the TID of
- *               the child process will be returned in the
- *               parent's memory.
- * @exit_signal: The exit_signal the parent process will be
- *               sent when the child exits.
- * @stack:       Specify the location of the stack for the
- *               child process.
- * @stack_size:  The size of the stack for the child process.
- * @tls:         If CLONE_SETTLS is set, the tls descriptor
- *               is set to tls.
+ * @flags:        Flags for the new process as listed above.
+ *                All flags are valid except for CSIGNAL and
+ *                CLONE_DETACHED.
+ * @pidfd:        If CLONE_PIDFD is set, a pidfd will be
+ *                returned in this argument.
+ * @child_tid:    If CLONE_CHILD_SETTID is set, the TID of the
+ *                child process will be returned in the child's
+ *                memory.
+ * @parent_tid:   If CLONE_PARENT_SETTID is set, the TID of
+ *                the child process will be returned in the
+ *                parent's memory.
+ * @exit_signal:  The exit_signal the parent process will be
+ *                sent when the child exits.
+ * @stack:        Specify the location of the stack for the
+ *                child process.
+ * @stack_size:   The size of the stack for the child process.
+ * @tls:          If CLONE_SETTLS is set, the tls descriptor
+ *                is set to tls.
+ * @set_tid:      Pointer to an array of type *pid_t. The size
+ *                of the array is defined using @set_tid_size.
+ *                This array is used select PIDs/TIDs for newly
+ *                created processes. The first element in this
+ *                defines the PID in the most nested PID
+ *                namespace. Each additional element in the array
+ *                defines the PID in the parent PID namespace of
+ *                the original PID namespace. If the array has
+ *                less entries than the number of currently
+ *                nested PID namespaces only the PIDs in the
+ *                corresponding namespaces are set.
+ * @set_tid_size: This defines the size of the array referenced
+ *                in @set_tid. This cannot be larger than the
+ *                kernel's limit of nested PID namespaces.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -71,10 +85,13 @@ struct clone_args {
 =09__aligned_u64 stack;
 =09__aligned_u64 stack_size;
 =09__aligned_u64 tls;
+=09__aligned_u64 set_tid;
+=09__aligned_u64 set_tid_size;
 };
 #endif
=20
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
+#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
=20
 /*
  * Scheduling policies
diff --git a/kernel/fork.c b/kernel/fork.c
index 954e875e72b1..417570263f1f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2087,7 +2087,8 @@ static __latent_entropy struct task_struct *copy_proc=
ess(
 =09stackleak_task_init(p);
=20
 =09if (pid !=3D &init_struct_pid) {
-=09=09pid =3D alloc_pid(p->nsproxy->pid_ns_for_children);
+=09=09pid =3D alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid,
+=09=09=09=09args->set_tid_size);
 =09=09if (IS_ERR(pid)) {
 =09=09=09retval =3D PTR_ERR(pid);
 =09=09=09goto bad_fork_cleanup_thread;
@@ -2590,6 +2591,7 @@ noinline static int copy_clone_args_from_user(struct =
kernel_clone_args *kargs,
 {
 =09int err;
 =09struct clone_args args;
+=09pid_t *kset_tid =3D kargs->set_tid;
=20
 =09if (unlikely(usize > PAGE_SIZE))
 =09=09return -E2BIG;
@@ -2600,6 +2602,15 @@ noinline static int copy_clone_args_from_user(struct=
 kernel_clone_args *kargs,
 =09if (err)
 =09=09return err;
=20
+=09if (unlikely(args.set_tid_size > MAX_PID_NS_LEVEL))
+=09=09return -EINVAL;
+
+=09if (unlikely(!args.set_tid && args.set_tid_size > 0))
+=09=09return -EINVAL;
+
+=09if (unlikely(args.set_tid && args.set_tid_size =3D=3D 0))
+=09=09return -EINVAL;
+
 =09/*
 =09 * Verify that higher 32bits of exit_signal are unset and that
 =09 * it is a valid signal
@@ -2617,8 +2628,16 @@ noinline static int copy_clone_args_from_user(struct=
 kernel_clone_args *kargs,
 =09=09.stack=09=09=3D args.stack,
 =09=09.stack_size=09=3D args.stack_size,
 =09=09.tls=09=09=3D args.tls,
+=09=09.set_tid_size=09=3D args.set_tid_size,
 =09};
=20
+=09if (args.set_tid &&
+=09=09copy_from_user(kset_tid, u64_to_user_ptr(args.set_tid),
+=09=09=09(kargs->set_tid_size * sizeof(pid_t))))
+=09=09return -EFAULT;
+
+=09kargs->set_tid =3D kset_tid;
+
 =09return 0;
 }
=20
@@ -2662,6 +2681,9 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *, u=
args, size_t, size)
 =09int err;
=20
 =09struct kernel_clone_args kargs;
+=09pid_t set_tid[MAX_PID_NS_LEVEL];
+
+=09kargs.set_tid =3D set_tid;
=20
 =09err =3D copy_clone_args_from_user(&kargs, uargs, size);
 =09if (err)
diff --git a/kernel/pid.c b/kernel/pid.c
index 7b5f6c963d72..2278e249141d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -157,7 +157,8 @@ void free_pid(struct pid *pid)
 =09call_rcu(&pid->rcu, delayed_put_pid);
 }
=20
-struct pid *alloc_pid(struct pid_namespace *ns)
+struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
+=09=09      size_t set_tid_size)
 {
 =09struct pid *pid;
 =09enum pid_type type;
@@ -166,6 +167,17 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 =09struct upid *upid;
 =09int retval =3D -ENOMEM;
=20
+=09/*
+=09 * set_tid_size contains the size of the set_tid array. Starting at
+=09 * the most nested currently active PID namespace it tells alloc_pid()
+=09 * which PID to set for a process in that most nested PID namespace
+=09 * up to set_tid_size PID namespaces. It does not have to set the PID
+=09 * for a process in all nested PID namespaces but set_tid_size must
+=09 * never be greater than the current ns->level + 1.
+=09 */
+=09if (set_tid_size > ns->level + 1)
+=09=09return ERR_PTR(-EINVAL);
+
 =09pid =3D kmem_cache_alloc(ns->pid_cachep, GFP_KERNEL);
 =09if (!pid)
 =09=09return ERR_PTR(retval);
@@ -174,24 +186,54 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 =09pid->level =3D ns->level;
=20
 =09for (i =3D ns->level; i >=3D 0; i--) {
-=09=09int pid_min =3D 1;
+=09=09int tid =3D 0;
+
+=09=09if (set_tid_size) {
+=09=09=09tid =3D set_tid[ns->level - i];
+
+=09=09=09retval =3D -EINVAL;
+=09=09=09if (tid < 1 || tid >=3D pid_max)
+=09=09=09=09goto out_free;
+=09=09=09/*
+=09=09=09 * Also fail if a PID !=3D 1 is requested and
+=09=09=09 * no PID 1 exists.
+=09=09=09 */
+=09=09=09if (tid !=3D 1 && !tmp->child_reaper)
+=09=09=09=09goto out_free;
+=09=09=09retval =3D -EPERM;
+=09=09=09if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
+=09=09=09=09goto out_free;
+=09=09=09set_tid_size--;
+=09=09}
=20
 =09=09idr_preload(GFP_KERNEL);
 =09=09spin_lock_irq(&pidmap_lock);
=20
-=09=09/*
-=09=09 * init really needs pid 1, but after reaching the maximum
-=09=09 * wrap back to RESERVED_PIDS
-=09=09 */
-=09=09if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
-=09=09=09pid_min =3D RESERVED_PIDS;
-
-=09=09/*
-=09=09 * Store a null pointer so find_pid_ns does not find
-=09=09 * a partially initialized PID (see below).
-=09=09 */
-=09=09nr =3D idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
-=09=09=09=09      pid_max, GFP_ATOMIC);
+=09=09if (tid) {
+=09=09=09nr =3D idr_alloc(&tmp->idr, NULL, tid,
+=09=09=09=09       tid + 1, GFP_ATOMIC);
+=09=09=09/*
+=09=09=09 * If ENOSPC is returned it means that the PID is
+=09=09=09 * alreay in use. Return EEXIST in that case.
+=09=09=09 */
+=09=09=09if (nr =3D=3D -ENOSPC)
+=09=09=09=09nr =3D -EEXIST;
+=09=09} else {
+=09=09=09int pid_min =3D 1;
+=09=09=09/*
+=09=09=09 * init really needs pid 1, but after reaching the
+=09=09=09 * maximum wrap back to RESERVED_PIDS
+=09=09=09 */
+=09=09=09if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
+=09=09=09=09pid_min =3D RESERVED_PIDS;
+
+=09=09=09/*
+=09=09=09 * Store a null pointer so find_pid_ns does not find
+=09=09=09 * a partially initialized PID (see below).
+=09=09=09 */
+=09=09=09nr =3D idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
+=09=09=09=09=09      pid_max, GFP_ATOMIC);
+=09=09}
 =09=09spin_unlock_irq(&pidmap_lock);
 =09=09idr_preload_end();
=20
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a6a79f85c81a..d40017e79ebe 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -26,8 +26,6 @@
=20
 static DEFINE_MUTEX(pid_caches_mutex);
 static struct kmem_cache *pid_ns_cachep;
-/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
-#define MAX_PID_NS_LEVEL 32
 /* Write once array, filled from the beginning. */
 static struct kmem_cache *pid_cache[MAX_PID_NS_LEVEL];
=20

base-commit: 7acdfe534e726450fe8051abc2f36380fb2c2c0e
--=20
2.23.0

