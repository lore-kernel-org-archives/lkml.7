Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A396AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FD3218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfIRIsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:48:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41703 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbfIRIsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:48:46 -0400
Received: from static-dcd-cqq-121001.business.bouyguestelecom.com ([212.194.121.1] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iAVde-0004BF-Bx; Wed, 18 Sep 2019 08:48:38 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     keescook@chromium.org, luto@amacapital.net
Cc:     jannh@google.com, wad@chromium.org, shuah@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/4] seccomp: continue syscall from notifier
Date:   Wed, 18 Sep 2019 10:48:29 +0200
Message-Id: <20190918084833.9369-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This is the patchset coming out of the KSummit session Kees and I gave
in Lisbon last week (cf. [3] which also contains slides with more
details on related things such as deep argument inspection).
The simple idea is to extend the seccomp notifier to allow for the
continuation of a syscall. The rationale for this can be found in the
commit message to [1]. For the curious there is more detail in [2].
This patchset would unblock supervising an extended set of syscalls such
as mount() where a privileged process is supervising the syscalls of a
lesser privileged process and emulates the syscall for the latter in
userspace.
For more comments on security see [1].

Thanks!
Christian

/* References */
[1]: [PATCH 1/4] seccomp: add SECCOMP_RET_USER_NOTIF_ALLOW
[2]: https://lore.kernel.org/r/20190719093538.dhyopljyr5ns33qx@brauner.io
[3]: https://linuxplumbersconf.org/event/4/contributions/560

Christian Brauner (4):
  seccomp: add SECCOMP_RET_USER_NOTIF_ALLOW
  seccomp: add two missing ptrace ifdefines
  seccomp: avoid overflow in implicit constant conversion
  seccomp: test SECCOMP_RET_USER_NOTIF_ALLOW

 include/uapi/linux/seccomp.h                  |   2 +
 kernel/seccomp.c                              |  24 +++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 110 +++++++++++++++++-
 3 files changed, 131 insertions(+), 5 deletions(-)

-- 
2.23.0

