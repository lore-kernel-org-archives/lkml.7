Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2BBC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 19:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6133E2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 19:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKXTHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 14:07:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54929 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKXTHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 14:07:32 -0500
Received: from ip5f5bf7bc.dynamic.kabel-deutschland.de ([95.91.247.188] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iYxEG-0004Ae-F3; Sun, 24 Nov 2019 19:07:28 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread changes for v5.5
Date:   Sun, 24 Nov 2019 20:07:16 +0100
Message-Id: <20191124190716.26639-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the thread management changes for v5.5:

/* Summary */
- A pidfd's fdinfo file currently contains the field Pid:\t<pid> where
  <pid> is the pid of the process in the pid namespace of the procfs
  instance the fdinfo file for the pidfd was opened in.
  The fdinfo file has now gained a new
  NSpid:\t<ns-pid1>[\t<ns-pid2>[...]]
  field which lists the pids of the process in all child pid
  namespaces provided the pid namespace of the procfs instance it is
  looked up under has an ancestoral relationship with the pid
  namespace of the process. If it does not 0 will be shown and no
  further pid namespaces will be listed.
  Tests included.
  (Christian Kellner)

- If the process the pidfd references has already exited, print -1 for
  the Pid and NSpid fields in the pidfd's fdinfo file.
  Tests included.
  (me)

- Add CLONE_CLEAR_SIGHAND. This lets callers clear all signal handler
  that are not SIG_DFL or SIG_IGN at process creation time.
  This originated as a feature request from glibc to improve
  performance and elimate races in their posix_spawn() implementation.
  Tests included.
  (me)

- Add support for choosing a specific pid for a process with clone3().
  This is the feature which was part of the thread update for v5.4 but
  after a discussion at LPC in Lisbon we decided to delay it for one
  more cycle in order to make the interface more generic.
  This has now done It is now possible to choose a specific
  pid in a whole pid namespaces (sub)hierarchy instead of just one pid
  namespace. In order to choose a specific pid the caller must have
  CAP_SYS_ADMIN in all owning user namespaces of the target pid
  namespaces.
  Tests included.
  (Adrian Reber)

- Test improvements and extensions.
  (Andrei Vagin, me)

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.5

for you to fetch changes up to 11fde161ab37f2938504bf896b48afbd18ea71cd:

  selftests/clone3: skip if clone3() is ENOSYS (2019-11-18 08:59:03 +0100)

/* Testing */
All patches are based on v5.4-rc3 and have been sitting in linux-next.
No build failures or warnings were observed.
All old and new tests are passing.

/* Conflicts */
A trivial merge conflict with current mainline exists for
include/uapi/linux/sched.h. I've added a suggestion on how to resolve
this below (cf. [1]).

Please consider pulling these changes from the signed threads-v5.5 tag.

Thanks!
Christian

[1]:

diff --cc include/uapi/linux/sched.h
index 25b4fa00bad1,a0b1c224c72b..000000000000
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@@ -36,28 -39,38 +39,42 @@@
  #ifndef __ASSEMBLY__
  /**
   * struct clone_args - arguments for the clone3 syscall
-  * @flags:       Flags for the new process as listed above.
-  *               All flags are valid except for CSIGNAL and
-  *               CLONE_DETACHED.
-  * @pidfd:       If CLONE_PIDFD is set, a pidfd will be
-  *               returned in this argument.
-  * @child_tid:   If CLONE_CHILD_SETTID is set, the TID of the
-  *               child process will be returned in the child's
-  *               memory.
-  * @parent_tid:  If CLONE_PARENT_SETTID is set, the TID of
-  *               the child process will be returned in the
-  *               parent's memory.
-  * @exit_signal: The exit_signal the parent process will be
-  *               sent when the child exits.
-  * @stack:       Specify the location of the stack for the
-  *               child process.
-  *               Note, @stack is expected to point to the
-  *               lowest address. The stack direction will be
-  *               determined by the kernel and set up
-  *               appropriately based on @stack_size.
-  * @stack_size:  The size of the stack for the child process.
-  * @tls:         If CLONE_SETTLS is set, the tls descriptor
-  *               is set to tls.
+  * @flags:        Flags for the new process as listed above.
+  *                All flags are valid except for CSIGNAL and
+  *                CLONE_DETACHED.
+  * @pidfd:        If CLONE_PIDFD is set, a pidfd will be
+  *                returned in this argument.
+  * @child_tid:    If CLONE_CHILD_SETTID is set, the TID of the
+  *                child process will be returned in the child's
+  *                memory.
+  * @parent_tid:   If CLONE_PARENT_SETTID is set, the TID of
+  *                the child process will be returned in the
+  *                parent's memory.
+  * @exit_signal:  The exit_signal the parent process will be
+  *                sent when the child exits.
+  * @stack:        Specify the location of the stack for the
+  *                child process.
++ *                Note, @stack is expected to point to the
++ *                lowest address. The stack direction will be
++ *                determined by the kernel and set up
++ *                appropriately based on @stack_size.
+  * @stack_size:   The size of the stack for the child process.
+  * @tls:          If CLONE_SETTLS is set, the tls descriptor
+  *                is set to tls.
+  * @set_tid:      Pointer to an array of type *pid_t. The size
+  *                of the array is defined using @set_tid_size.
+  *                This array is used to select PIDs/TIDs for
+  *                newly created processes. The first element in
+  *                this defines the PID in the most nested PID
+  *                namespace. Each additional element in the array
+  *                defines the PID in the parent PID namespace of
+  *                the original PID namespace. If the array has
+  *                less entries than the number of currently
+  *                nested PID namespaces only the PIDs in the
+  *                corresponding namespaces are set.
+  * @set_tid_size: This defines the size of the array referenced
+  *                in @set_tid. This cannot be larger than the
+  *                kernel's limit of nested PID namespaces.
   *
   * The structure is versioned by size and thus extensible.
   * New struct members must go at the end of the struct and

----------------------------------------------------------------
threads-v5.5

----------------------------------------------------------------
Adrian Reber (3):
      selftests: add tests for clone3()
      fork: extend clone3() to support setting a PID
      selftests: add tests for clone3() with *set_tid

Andrei Vagin (3):
      selftests/clone3: flush stdout and stderr before clone3() and _exit()
      selftests/clone3: report a correct number of fails
      selftests/clone3: check that all pids are released on error paths

Christian Brauner (8):
      pidfd: check pid has attached task in fdinfo
      test: verify fdinfo for pidfd of reaped process
      pid: use pid_has_task() in __change_pid()
      exit: use pid_has_task() in do_wait()
      pid: use pid_has_task() in pidfd_open()
      clone3: add CLONE_CLEAR_SIGHAND
      tests: test CLONE_CLEAR_SIGHAND
      selftests/clone3: skip if clone3() is ENOSYS

Christian Kellner (2):
      pidfd: add NSpid entries to fdinfo
      pidfd: add tests for NSpid info in fdinfo

 MAINTAINERS                                        |   1 +
 include/linux/pid.h                                |   7 +-
 include/linux/pid_namespace.h                      |   2 +
 include/linux/sched/task.h                         |   3 +
 include/uapi/linux/sched.h                         |  56 ++-
 kernel/exit.c                                      |   2 +-
 kernel/fork.c                                      | 100 +++++-
 kernel/pid.c                                       |  86 +++--
 kernel/pid_namespace.c                             |   2 -
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/clone3/.gitignore          |   3 +
 tools/testing/selftests/clone3/Makefile            |   6 +
 tools/testing/selftests/clone3/clone3.c            | 202 +++++++++++
 .../selftests/clone3/clone3_clear_sighand.c        | 129 +++++++
 tools/testing/selftests/clone3/clone3_selftests.h  |  63 ++++
 tools/testing/selftests/clone3/clone3_set_tid.c    | 397 +++++++++++++++++++++
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c  | 296 +++++++++++++++
 18 files changed, 1304 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/selftests/clone3/.gitignore
 create mode 100644 tools/testing/selftests/clone3/Makefile
 create mode 100644 tools/testing/selftests/clone3/clone3.c
 create mode 100644 tools/testing/selftests/clone3/clone3_clear_sighand.c
 create mode 100644 tools/testing/selftests/clone3/clone3_selftests.h
 create mode 100644 tools/testing/selftests/clone3/clone3_set_tid.c
 create mode 100644 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
