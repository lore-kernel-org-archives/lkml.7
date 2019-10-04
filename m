Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EFAC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEECE222C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbfJDJkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:40:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41522 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388187AbfJDJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:40:17 -0400
Received: from [185.81.136.18] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iGK4N-0007ns-BF; Fri, 04 Oct 2019 09:40:15 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] process fixes for v5.4-rc2
Date:   Fri,  4 Oct 2019 11:39:47 +0200
Message-Id: <20191004093947.14471-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This pull request contains a couple of fixes:

- Fix pidfd selftest compilation (Shuah Kahn)
  Due to a false linking instruction in the Makefile compilation for the
  pidfd selftests would fail on some systems.

- Fix compilation for glibc on RISC-V systems (Seth Forshee)
  In some scenarios linux/uapi/linux/sched.h is included where __ASSEMBLY__
  is defined causing a build failure because struct clone_args was not
  guarded by an #ifndef __ASSEMBLY__.

- Add missing clone3() and struct clone_args kernel-doc (Christian Brauner)
  clone3() and struct clone_args were missing kernel-docs. (The goal is to
  use kernel-doc for any function or type where it's worth it.)
  For struct clone_args this also contains a comment about the fact that
  it's versioned by size.

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20191003

for you to fetch changes up to 78f6face5af344f12f4bd48b32faa6f499a06f36:

  sched: add kernel-doc for struct clone_args (2019-10-03 21:19:29 +0200)

/* Testing */
All patches have seen exposure in linux-next and are based on v5.4-rc1.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next.

Please consider pulling these changes from the signed for-linus-20191003 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-20191003

----------------------------------------------------------------
Christian Brauner (2):
      fork: add kernel-doc for clone3
      sched: add kernel-doc for struct clone_args

Seth Forshee (1):
      sched: Add __ASSEMBLY__ guards around struct clone_args

Shuah Khan (1):
      selftests: pidfd: Fix undefined reference to pthread_create()

 include/uapi/linux/sched.h             | 28 ++++++++++++++++++++++++++--
 kernel/fork.c                          | 11 +++++++++++
 tools/testing/selftests/pidfd/Makefile |  2 +-
 3 files changed, 38 insertions(+), 3 deletions(-)
