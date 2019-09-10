Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC5C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DFB21479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391975AbfIJQBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:01:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46641 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbfIJQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:01:31 -0400
Received: from [148.69.85.38] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i7ia8-00040q-EB; Tue, 10 Sep 2019 16:01:28 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [GIT PULL v1] core process updates for v5.4
Date:   Tue, 10 Sep 2019 18:00:51 +0200
Message-Id: <20190910160051.3795-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904133418.23573-1-christian.brauner@ubuntu.com>
References: <20190904133418.23573-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a resend of the pull request for v5.4 with the clone3 extension for
choosing a specific pid at process creation time _dropped_: After an
in-person discussion between multiple parties at LPC/KSummit use-cases were
presented that require restoring nested pid namespaces. This means clone3
would need to create a process with specific pids in multiple pid
namespaces not just a single one. For this reason, it seems wise to delay
this feature one more cycle to get the semantics for this right. Sorry for
the churn! The rest is _unchanged_.

This pull request includes the current process group and pidfd extensions
for the waitid() syscall and various tests.
All changes are centered around process management not just the pidfd api.
For this reason the tag name is core-process-v5.4. If you have objections
and would rather see this split in separate PRs, please tell me.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/core-process-v5.4

for you to fetch changes up to 821cc7b0b205c0df64cce59aacc330af251fa8f7:

  waitid: Add support for waiting for the current process group (2019-09-10 17:05:46 +0200)

/* Summary */
This tag contains two features and various tests.

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
Christian Brauner (2):
      pidfd: add P_PIDFD to waitid()
      pidfd: add pidfd_wait tests

Eric W. Biederman (1):
      waitid: Add support for waiting for the current process group

Suren Baghdasaryan (2):
      tests: move common definitions and functions into pidfd.h
      tests: add pidfd poll tests

 include/linux/pid.h                             |   4 +
 include/uapi/linux/wait.h                       |   1 +
 kernel/exit.c                                   |  38 +++-
 kernel/fork.c                                   |   8 +
 kernel/signal.c                                 |   7 +-
 tools/testing/selftests/pidfd/.gitignore        |   2 +
 tools/testing/selftests/pidfd/Makefile          |   2 +-
 tools/testing/selftests/pidfd/pidfd.h           |  30 +++
 tools/testing/selftests/pidfd/pidfd_open_test.c |   5 -
 tools/testing/selftests/pidfd/pidfd_poll_test.c | 117 ++++++++++
 tools/testing/selftests/pidfd/pidfd_test.c      |  14 --
 tools/testing/selftests/pidfd/pidfd_wait.c      | 271 ++++++++++++++++++++++++
 12 files changed, 473 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_poll_test.c
 create mode 100644 tools/testing/selftests/pidfd/pidfd_wait.c
