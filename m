Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A692147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ejwfwiqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfCLNxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:53:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37833 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLNxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:53:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id m12so2371182edv.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grYfJYAiC2wLX3lcIRirqmW3qAqf871BsSEaaqjxMxs=;
        b=ejwfwiqFdrqTi5OejYk85yiqa+LoSYlEIdhtEVGeb9m05Kd0Yzg10SilCeqQPhzLsj
         jYvPEh6fPkSKVEHas2mP7SmshjU9r4tgfICN/tKTOiAaYNwjKzgvyN22Uo2Dq2HjttAP
         uxUVNzKEv632Xl+x5dlZfaKIuuyvt86Dt+2w+lQvj/WrAonLsNi/8Ln4uEeLbETQaKsx
         0EJQJ/BeyxCei5ZQHypASKl3eA1beaLQ6bCCoXcL0cXaRd4TCMx65QMxUSImKr+NSLq8
         HtDKw1Bn65VbeCmVqppJNMu+nz01sYZ4LV8Gmw0h/cBMVH7EZeJLCRAlAlm0xgnUlsNA
         KvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grYfJYAiC2wLX3lcIRirqmW3qAqf871BsSEaaqjxMxs=;
        b=FPf6gpOM8YNhoNOg6ho4G9N0B16Md8hAz0cGkCVI07WRdTLbeXd89qdsioJhhtRCeK
         ERape99IGN/fFzOsKH4WWqu6qis+j0DrhM0lvDuyWXnAEGd3EAgS8Lq3rmS+0El6uwFr
         uSKZQ+ph5FsUXYSh1ZlVs7RlZtQ0Uu280EbFg8LDOMAPJyJjDBZvBDHB3e05mIhwlz8d
         /1QMF0t4N3j6a210775tjLRftFGhi/3kuOUcNCD0GNgojIJMEJLTzKuYa9drPJlWsjQK
         S/sQdAgPLO2vYQmULNoaguaWHRpvVl+6JS28NIgj9mejGVF2X21vJ8Zd2cn4FNQEbv5g
         jdWw==
X-Gm-Message-State: APjAAAUoJFUuouiKmO9mAh2J38EbKGIB3pGG/NQmrhs3nO3Xg0roITBj
        F+apb4SzvrVZ+7CXo3feZwbBaE2KBLox0A==
X-Google-Smtp-Source: APXvYqxVlnULodkgXuxsJDfSwMZ9mPZ26Znhl4vmcmmkl5c0lBfq1blR54H+NsKnNGOjKYOetOcDfA==
X-Received: by 2002:a17:906:f87:: with SMTP id q7mr25898957ejj.237.1552398796689;
        Tue, 12 Mar 2019 06:53:16 -0700 (PDT)
Received: from localhost.localdomain ([172.56.7.135])
        by smtp.gmail.com with ESMTPSA id f5sm3683850ejf.25.2019.03.12.06.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:53:15 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        arnd@arndb.de, Christian Brauner <christian@brauner.io>
Subject: [GIT PULL RESEND] pidfd changes for v5.1-rc1
Date:   Tue, 12 Mar 2019 14:52:45 +0100
Message-Id: <20190312135245.27591-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a resend of the pull request for the pidfd_send_signal() syscall
which I sent last Tuesday. I'm not sure whether you just wanted to take a
closer look.

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git tags/pidfd-v5.1-rc1

The patchset introduces the ability to use file descriptors from proc/<pid>
as stable handles on struct pid. Even if a pid is recycled the handle will
not change. For a start these fds can be used to send signals to the
processes they refer to.

With the ability to use /proc/<pid> fds as stable handles on struct pid we
can fix a long-standing issue where after a process has exited its pid can
be reused by another process. If a caller sends a signal to a reused pid it
will end up signaling the wrong process.
With this patchset we enable a variety of use cases. One obvious example is
that we can now safely delegate an important part of process management -
sending signals - to processes other than the parent of a given process by
sending file descriptors around via scm rights and not fearing that the
given process will have been recycled in the meantime.
It also allows for easy testing whether a given process is still alive or
not by sending signal 0 to a pidfd which is quite handy.
There has been some interest in this feature e.g. from systems management
(systemd, glibc) and container managers. I have requested and gotten
comments from glibc to make sure that this syscall is suitable for their
needs as well. In the future I expect it to take on most other pid-based
signal syscalls. But such features are left for the future once they are
needed.

The patchset has been sitting in linux-next for quite a while and has
not caused any issues. It comes with selftests which verify basic
functionality and also test that a recycled pid cannot be signaled via a
pidfd.

Jon has written about a prior version of this patchset. It should cover the
basic functionality since not a lot has changed since then:

https://lwn.net/Articles/773459/

The commit message for the syscall itself is extensively documenting the
syscall, including it's functionality and extensibility.

/* Merge conflict and sycall number coordination */
Please note, there will be a merge conflict between the Jens' io_uring
patch set in the block tree and this tree. To minimize its impact Arnd
worked with Jens and me to coordinate syscall numbers in advance.
pidfd_send_signal() takes 424 and Jens' patchset took 425 to 427.

/* Separate tree on kernel.org */
At the beginning of last merge cycle it was suggested to move this patchset
into a separate tree on kernel.org as there will be more work coming that
will be extending the use of file descriptors for processes. The tree was
announced in January:

https://lore.kernel.org/lkml/20190108234722.bojj5bqowlutymnt@brauner.io/

The pidfd tree is located on kernel.org

https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/

and it's for-next branch is already tracked by Stephen in linux-next since
the beginning of the 5.0 development cycle. I'm prepared to deal with any
fallouts coming from this work going forward.

The only thing that has changed recently in these patches was the addition
of two more Acked-by/Reviewed-by from  David Howells and tglx after the
last round of reviews.

Please consider pulling these changes from the signed pidfd-v5.1-rc1 tag.

Thanks!
Christian

----------------------------------------------------------------
pidfd patches for v5.1-rc1

----------------------------------------------------------------
Christian Brauner (2):
      signal: add pidfd_send_signal() syscall
      selftests: add tests for pidfd_send_signal()

 arch/x86/entry/syscalls/syscall_32.tbl     |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl     |   1 +
 fs/proc/base.c                             |   9 +
 include/linux/proc_fs.h                    |   6 +
 include/linux/syscalls.h                   |   3 +
 include/uapi/asm-generic/unistd.h          |   4 +-
 kernel/signal.c                            | 133 +++++++++-
 kernel/sys_ni.c                            |   1 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/pidfd/Makefile     |   6 +
 tools/testing/selftests/pidfd/pidfd_test.c | 381 +++++++++++++++++++++++++++++
 11 files changed, 539 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/Makefile
 create mode 100644 tools/testing/selftests/pidfd/pidfd_test.c
