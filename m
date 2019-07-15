Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C05C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D894E2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="IrZ1gJSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfGOPPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:15:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40033 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfGOPPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:15:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id y20so1423057otk.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOUynfjLcHpt+teu5Q4MrB30ERL83K6Jaz1qy9l5WbI=;
        b=IrZ1gJSObvjnw7y2sImbAer1PjNNFfAvKq5VKmSQtLFoQpkoakyYnD9bT5UkOu3OKm
         LiDBt+V/VQCeZb41B0b/67wv0SpXOLBk/Ouk68VjPCpdxwlng5KPiA7QaigenNFh8R3y
         aHnq7vtCLbbmzIA/Wo1yzEMK3Jii8WS4SZ0Cz0AveB24A52wSH1MXAqrNtWYxhLBFQVM
         bzJvSU8KXXrbhXN7Qyo+Z12OVphBrBlGsdvT7YiXB8r1dObH4XbaLj0IKibDU7N/txlw
         CRMcvOK8PK8yqM9PLViUwQD63g1VCJTZ9V+OXio5pB4MjP74ZJGsAquQ3RyQaBZWi+yc
         DajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uOUynfjLcHpt+teu5Q4MrB30ERL83K6Jaz1qy9l5WbI=;
        b=Zy30yb+xXda75zah1+7SjsGNJtsk8SKege1VvPxiFp3qpRZ4IX09gCmN6YGACqqjkO
         iN52GCiM6AD+kTFdukIv8qwe4RwvrA+uSwwlo4WnQd+Krqp24w0T3x2KAcMF6XIqmXw6
         wUGo8iuBwguAswOpk4iQPdKKc0Kizs62rKoEepL8XtH6Ve5VZyvZrpCQmxJym5LlT+uB
         ZUwCNg9QCfUXYwyti1esdOrq/+OQ0aMIbL3fW6NV6TD0XPmDEOc0nwX1qv5avZHELDbz
         0aP/8S6203gEF2u7ULhtIkpd1xw7y06aTdWEURnKtUQi+Tx4XhPoztSdq+AvpPGLlzH7
         uM7w==
X-Gm-Message-State: APjAAAURk0fiOMpbl9YyJFS2EDKKohO3aj72aSbWURoWu/PS3VJgc2WP
        vgSJ0xj9/1IuEWTFe7emd5U=
X-Google-Smtp-Source: APXvYqxI1FJM9g7M4T7J6MoEz+4BjZv+PMwOaktJ1io1blCI6WddVCwaIFwtNtijlQ7Aln2+8SwbDA==
X-Received: by 2002:a9d:170b:: with SMTP id i11mr20238541ota.60.1563203723455;
        Mon, 15 Jul 2019 08:15:23 -0700 (PDT)
Received: from localhost.localdomain ([208.54.86.135])
        by smtp.gmail.com with ESMTPSA id p126sm6286865oia.10.2019.07.15.08.15.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 08:15:22 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org
Subject: [GIT PULL] pidfd and clone3 fixes
Date:   Mon, 15 Jul 2019 17:15:09 +0200
Message-Id: <20190715151509.3151-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This contains a bugfix for CLONE_PIDFD when used with the legacy clone
syscall. two fixes to ensure that syscall numbering and clone3
entrypoint implementations will stay consistent, and an update for the
maintainers file:

The following changes since commit 964a4eacef67503a1154f7e0a75f52fbdce52022:

  Merge tag 'dlm-5.3' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm (2019-07-12 17:37:53 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190715

for you to fetch changes up to 69b53720e92c1bdea854a2fc204477ddabfa902b:

  MAINTAINERS: add new entry for pidfd api (2019-07-15 12:59:44 +0200)

/* Summary */
The addition of clone3 broke CLONE_PIDFD for legacy clone on all
architectures that use do_fork() directly instead of calling the clone
syscall itself. (Fwiw, cleaning do_fork() up is on my todo.)
The reason this happened was that during conversion of  _do_fork() to use
struct kernel_clone_args we missed that do_fork() is called directly by
various architectures. This is fixed by making sure that the pidfd argument
in struct kernel_clone_args is correctly initialized with the parent_tidptr
argument passed down from do_fork(). Additionally, do_fork() missed a check
to make CLONE_PIDFD and CLONE_PARENT_SETTID mutually exclusive just a
clone() does. This is now fixed too.

When clone3() was introduced we skipped architectures that require special
handling for fork-like syscalls. Their syscall tables did not contain any
mention of clone3(). To make sure that Arnd's work to make syscall numbers
on all architectures identical (minus alpha) was not for naught we are
placing a comment in all syscall tables that do not yet implement clone3().
The comment makes it clear that 435 is reserved for clone3 and should not
be used.

Also, this PR contains a patch to make the clone3() syscall definition in
asm-generic/unist.h conditional on __ARCH_WANT_SYS_CLONE3. This lets us
catch new architectures that implicitly make use of clone3 without setting
__ARCH_WANT_SYS_CLONE3 which is a good indicator that they did not check
whether it needs special treatment or not.

Last, this contains a patch to add me as maintainer for pidfd stuff so
people can start blaming me (more).

Please consider pulling from the signed for-linus-20190715 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-20190715

----------------------------------------------------------------
Christian Brauner (3):
      arch: mark syscall number 435 reserved for clone3
      unistd: protect clone3 via __ARCH_WANT_SYS_CLONE3
      MAINTAINERS: add new entry for pidfd api

Dmitry V. Levin (1):
      clone: fix CLONE_PIDFD support

 MAINTAINERS                               | 11 +++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl    |  1 +
 arch/ia64/kernel/syscalls/syscall.tbl     |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl     |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl   |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl  |  1 +
 arch/s390/kernel/syscalls/syscall.tbl     |  1 +
 arch/sh/kernel/syscalls/syscall.tbl       |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl    |  1 +
 arch/x86/ia32/sys_ia32.c                  |  4 ++++
 include/linux/sched/task.h                |  1 +
 include/uapi/asm-generic/unistd.h         |  2 ++
 kernel/fork.c                             | 17 +++++++++++++++--
 16 files changed, 44 insertions(+), 2 deletions(-)
