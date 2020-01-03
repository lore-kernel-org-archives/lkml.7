Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0646DC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D386E21835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgACNxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:53:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgACNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:53:50 -0500
Received: from [172.58.142.171] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1inNOd-0002QD-Ue; Fri, 03 Jan 2020 13:53:48 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fixes v5.5-rc5
Date:   Fri,  3 Jan 2020 14:53:03 +0100
Message-Id: <20200103135303.19470-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are two fixes:

/* Summary */
- Panic earlier when global init exits to generate useable coredumps.
  Currently, when global init and all threads in its thread-group have exited
  we panic via:
  do_exit()
  -> exit_notify()
     -> forget_original_parent()
        -> find_child_reaper()
  This makes it hard to extract a useable coredump for global init from a
  kernel crashdump because by the time we panic exit_mm() will have already
  released global init's mm. We now panic slightly earlier. This has been
  a problem in certain environments such as Android. 

- Fix a race in assigning and reading taskstats for thread-groups with more
  than one thread.
  This patch has been waiting for quite a while since people disagreed on what
  the correct fix was at first.

/* Testing */
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were known.

The following changes since commit 219d54332a09e8d8741c1e1982f5eae56099de85:

  Linux 5.4 (2019-11-24 16:32:01 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-01-03

for you to fetch changes up to 43cf75d96409a20ef06b756877a2e72b10a026fc:

  exit: panic before exit_mm() on global init exit (2019-12-21 16:48:01 +0100)

Please consider pulling these changes from the signed for-linus-2020-01-03 tag.

Thanks and happy new year!
Christian

----------------------------------------------------------------
for-linus-2020-01-03

----------------------------------------------------------------
Christian Brauner (1):
      taskstats: fix data-race

chenqiwu (1):
      exit: panic before exit_mm() on global init exit

 kernel/exit.c      | 12 ++++++++----
 kernel/taskstats.c | 30 +++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 15 deletions(-)
