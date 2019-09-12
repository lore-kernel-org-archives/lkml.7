Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA0C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D312075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbfILNnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:43:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45145 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbfILNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:43:02 -0400
Received: from [46.189.28.128] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i8PND-0005QC-3X; Thu, 12 Sep 2019 13:43:00 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] clone3 exit signal fix
Date:   Thu, 12 Sep 2019 15:40:19 +0200
Message-Id: <20190912134019.2393-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a rather urgent last-minute bugfix for clone3() that should go in
before we release 5.3 with clone3().

clone3() did not verify that the exit_signal argument was set to a valid
signal. This can be used to cause a crash by specifying a signal greater
than NSIG. e.g. -1.

The commit from Eugene adds a check to copy_clone_args_from_user() to
verify that the exit signal is limited by CSIGNAL as with legacy clone()
and that the signal is valid. With this we don't get the legacy clone
behavior were an invalid signal could be handed down and would only be
detected and then ignored in do_notify_parent(). Users of clone3() will now
get a proper error right when they pass an invalid exit signal. Note, that
this is not a change in user-visible behavior since no kernel with clone3()
has been released yet.

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190912

for you to fetch changes up to a0eb9abd8af92d1aa34bc1e24dfbd1ba0bd6a56c:

  fork: block invalid exit signals with clone3() (2019-09-12 14:56:33 +0200)

Please consider pulling these changes from the signed for-linus-20190912 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-20190912

----------------------------------------------------------------
Eugene Syromiatnikov (1):
      fork: block invalid exit signals with clone3()

 kernel/fork.c | 10 ++++++++++
 1 file changed, 10 insertions(+)
