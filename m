Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF193C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91D6217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390050AbfKEP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:57:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51297 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389949AbfKEP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:57:35 -0500
Received: from [185.81.136.19] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iS1D2-0007OY-Lm; Tue, 05 Nov 2019 15:57:33 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thread fixes
Date:   Tue,  5 Nov 2019 16:52:17 +0100
Message-Id: <20191105155217.23759-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This changes clone3() to do basic stack validation and to set up the stack
depending on whether or not it is growing up or down. With clone3() the
expectation is now very simply that the .stack argument points to the
lowest address of the stack and that .stack_size specifies the initial
stack size. This is diferent from legacy clone() where the "stack" argument
had to point to the lowest or highest address of the stack depending on the
architecture.

clone3() was released with 5.3. Currently, it is not documented and very
unclear to userspace how the stack and stack_size argument have to be
passed. After talking to glibc folks we concluded that changing clone3() to
determine stack direction and doing basic validation is the right course of
action.
Note, this is a potentially user visible change. In the very unlikely case,
that it breaks someone's use-case we will revert. (And then e.g.
place the new behavior under an appropriate flag.)
Note that passing an empty stack will continue working just as before.
Breaking someone's use-case is very unlikely. Neither glibc nor musl
currently expose a wrapper for clone3(). There is currently also no real
motivation for anyone to use clone3() directly. First, because using
clone{3}() with stacks requires some assembly (see glibc and musl). Second,
because it does not provide features that legacy clone() doesn't. New
features for clone3() will first happen in v5.5 which is why v5.4 is still
a good time to try and make that change now and backport it to v5.3.

I did a codesearch on https://codesearch.debian.net, github, and gitlab and
could not find any software currently relying directly on clone3(). I
expect this to change once we land CLONE_CLEAR_SIGHAND which was a request
coming from glibc at which point they'll likely start using it.

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2019-11-05

for you to fetch changes up to fa729c4df558936b4a1a7b3e2234011f44ede28b:

  clone3: validate stack arguments (2019-11-05 15:50:14 +0100)

/* Testing */
All patches have seen exposure in linux-next and are based on v5.4-rc5.
The patch has a recent change date because I added Arnd's ack.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next.

Please consider pulling these changes from the signed for-linus-2019-11-05 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2019-11-05

----------------------------------------------------------------
Christian Brauner (1):
      clone3: validate stack arguments

 include/uapi/linux/sched.h |  4 ++++
 kernel/fork.c              | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)
