Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6DCC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4C022CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfIDNfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:35:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54452 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbfIDNfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:35:50 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i5VRs-0007Zf-Il; Wed, 04 Sep 2019 13:35:48 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] core process updates for v5.4
Date:   Wed,  4 Sep 2019 15:34:18 +0200
Message-Id: <20190904133418.23573-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request includes the current process group and pidfd extensions
for the waitid() syscall, an extension to select a specifc pid for
clone3(), and various tests.
All changes are centered around process management not just the pidfd api.
For this reason the tag name is core-process-v5.4. If you have objections
and would rather see this split in separate PRs, please tell me.
With LPC/KSummit coming up and some additional travel I want to get this
out early before I'll start to see the first signs of
conference-season-brain.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/core-process-v5.4

for you to fetch changes up to 590ef0128b4277eaa9cb74d7ba878d48b261950c:

  waitid: Add support for waiting for the current process group (2019-08-14 22:20:47 +0200)

/* Summary */
This tag contains three features and various tests.

First, it adds support for waiting on process through pidfds by adding the
P_PIDFD type to the waitid() syscall. This completes the basic
functionality of the pidfd api (cf. [1]).
In the meantime we also have a new adition to the userspace projects that
make use of the pidfd api. The qt project was nice enough to send a mail
pointing out that they have a pr up to switch to the pidfd api (cf. [2]).

Second, this tag contains an extension to the waitid() syscall to make it
possible to wait on the current process group in a race free manner (even
though the actual problem is very unlikely) by specifing 0 together with
the P_PGID type. This extension traces back to a discussion on the glibc
development mailing list.

Third, this tag extends the clone3() syscall to create a process with a
specific PID to eliminate a race the checkpoint/restore crowd has been
struggling with in userspace. In order to request a process with a specific
PID the caller needs to have CAP_SYS_ADMIN in the owning user namespace of
the target pid namespace the process is supposed to be created in. The
target pid namespace also needs to either already have an init process with
PID 1 or the first clone3() call requesting a specific PID needs to request
PID 1.

There are also a range of tests for the features above. Additionally, the
test-suite which detected the pidfd-polling race we fixed in [3] is
included in this tag.

/* Testing */
All patches are based on v5.3-rc1 and have been sitting in linux-next since
then or at least before v5.3-rc3. None of them have caused failures or
warnings and they are passing the tests accompanying them.

/* Conflicts */
At the time of creating this PR no merge conflicts were observed in
linux-next.

Please consider pulling these changes from the signed core-process-v5.4 tag.

Thanks!
Christian

/* References */
[1]: https://lwn.net/Articles/794707/
[2]: https://codereview.qt-project.org/c/qt/qtbase/+/108456
[3]: commit b191d6491be6 ("pidfd: fix a poll race when setting exit_state")

----------------------------------------------------------------
core-process-v5.4

----------------------------------------------------------------
Adrian Reber (2):
      fork: extend clone3() to support setting a PID
      selftests: add tests for clone3()

Christian Brauner (2):
      pidfd: add P_PIDFD to waitid()
      pidfd: add pidfd_wait tests

Eric W. Biederman (1):
      waitid: Add support for waiting for the current process group

Suren Baghdasaryan (2):
      tests: move common definitions and functions into pidfd.h
      tests: add pidfd poll tests

 include/linux/pid.h                             |   6 +-
 include/linux/sched/task.h                      |   1 +
 include/uapi/linux/sched.h                      |   1 +
 include/uapi/linux/wait.h                       |   1 +
 kernel/exit.c                                   |  38 +++-
 kernel/fork.c                                   |  22 +-
 kernel/pid.c                                    |  37 +++-
 kernel/signal.c                                 |   7 +-
 tools/testing/selftests/clone3/.gitignore       |   2 +
 tools/testing/selftests/clone3/Makefile         |  11 +
 tools/testing/selftests/clone3/clone3.c         | 231 ++++++++++++++++++++
 tools/testing/selftests/clone3/clone3_set_tid.c | 161 ++++++++++++++
 tools/testing/selftests/pidfd/.gitignore        |   2 +
 tools/testing/selftests/pidfd/Makefile          |   2 +-
 tools/testing/selftests/pidfd/pidfd.h           |  30 +++
 tools/testing/selftests/pidfd/pidfd_open_test.c |   5 -
 tools/testing/selftests/pidfd/pidfd_poll_test.c | 117 ++++++++++
 tools/testing/selftests/pidfd/pidfd_test.c      |  14 --
 tools/testing/selftests/pidfd/pidfd_wait.c      | 271 ++++++++++++++++++++++++
 19 files changed, 923 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/clone3/.gitignore
 create mode 100644 tools/testing/selftests/clone3/Makefile
 create mode 100644 tools/testing/selftests/clone3/clone3.c
 create mode 100644 tools/testing/selftests/clone3/clone3_set_tid.c
 create mode 100644 tools/testing/selftests/pidfd/pidfd_poll_test.c
 create mode 100644 tools/testing/selftests/pidfd/pidfd_wait.c
