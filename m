Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFF6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDA02133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfJDKmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:42:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42906 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:42:49 -0400
Received: from [185.81.136.18] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iGL1d-0002fw-KF; Fri, 04 Oct 2019 10:41:29 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] usercopy structs for v5.4-rc2
Date:   Fri,  4 Oct 2019 12:41:16 +0200
Message-Id: <20191004104116.20418-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This pull request contains the copy_struct_from_user() helper which got
split out from the openat2() patchset. It is a generic interface designed
to copy a struct from userspace.

The helper will be especially useful for structs versioned by size of which
we have quite a few. This allows for backwards compatibility, i.e. an
extended struct can be passed to an older kernel, or a legacy struct can be
passed to a newer kernel. For the first case (extended struct, older
kernel) the new fields in an extended struct can be set to zero and the
struct safely passed to an older kernel.

The most obvious benefit is that this helper lets us get rid of duplicate
code present in at least sched_setattr(), perf_event_open(), and clone3().
More importantly it will also help to ensure that users implementing
versioning-by-size end up with the same core semantics. This point is
especially crucial since we have at least one case where versioning-by-size
is used but with slighly different semantics: sched_setattr(),
perf_event_open(), and clone3() all do do similar checks to
copy_struct_from_user() while rt_sigprocmask(2) always rejects
differently-sized struct arguments.

With this pull request we also switch over sched_setattr(),
perf_event_open(), and clone3() to use the new helper.

I have carried these patches in a separate branch and taken care for them
to show up in linux-next. The only separate fix we we had to apply
was for a warning by clang when building the tests for using the result of
an assignment as a condition without parantheses. Given that this is a
reasonably sized change with proper testing it seemed ok to me to include
this in an rc2. If things break, we're around to fix them.

[1]: 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and code")

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/copy-struct-from-user-v5.4-rc2

for you to fetch changes up to 341115822f8832f0c2d8af2f7e151c4c9a77bcd1:

  usercopy: Add parentheses around assignment in test_copy_struct_from_user (2019-10-03 21:13:27 +0200)

/* Testing */
All patches have seen exposure in linux-next and are based on v5.4-rc1. The
copy_struct_from_user() helper comes with selftests.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next.

Please consider pulling these changes from the signed
copy-struct-from-user-v5.4-rc2 tag.

Thanks!
Christian

----------------------------------------------------------------
copy-struct-from-user-v5.4-rc2

----------------------------------------------------------------
Aleksa Sarai (4):
      lib: introduce copy_struct_from_user() helper
      clone3: switch to copy_struct_from_user()
      sched_setattr: switch to copy_struct_from_user()
      perf_event_open: switch to copy_struct_from_user()

Nathan Chancellor (1):
      usercopy: Add parentheses around assignment in test_copy_struct_from_user

 include/linux/bitops.h     |   7 +++
 include/linux/uaccess.h    |  70 +++++++++++++++++++++++
 include/uapi/linux/sched.h |   2 +
 kernel/events/core.c       |  47 +++-------------
 kernel/fork.c              |  34 +++---------
 kernel/sched/core.c        |  43 +++-----------
 lib/strnlen_user.c         |   8 +--
 lib/test_user_copy.c       | 136 +++++++++++++++++++++++++++++++++++++++++++--
 lib/usercopy.c             |  55 ++++++++++++++++++
 9 files changed, 288 insertions(+), 114 deletions(-)
