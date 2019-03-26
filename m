Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F632070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OocMpMMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfCZPz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:55:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41473 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCZPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:55:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so11216347edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVhciA8a89NDVuDa/Yx+mTqlqgpVgbF9VqirSNRgANs=;
        b=OocMpMMfTX/d9a1ru+lmSKj1yH0YBd5thEzFsnbmlvVe89rymIeYiyQ/6O0QWOeyzc
         5TfySD1YTLYeIpHA0nsNzGFjXl9ZN1Y6KAev4sHz4ShA8Jzi2O+NQfR+sy61Fjiu3+jr
         qRIu1AMD0s5mq5rshciNieoxa+YEN2FYjAFFhuIzZPYezOuzj/MYhy14HiXiZtfIonpm
         4EyFaKr4jxoho8fpqg6qCqDTiXHdpdU1cOKZJjcfpaz+Q7vzDROszhwvqsfoBAJiIVKN
         d0pansubjmoZCUo/VipXnxtFHv4JFs+2pLa3NiY1iWHRbfp8YRpRM2BszCigYapRPaws
         589g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVhciA8a89NDVuDa/Yx+mTqlqgpVgbF9VqirSNRgANs=;
        b=VsQbdXR8Kebw7f+P1+CnqfUX6roGuqtgDCOmqloEqP3oRCrm0cjBsK0ezbBo+AthFd
         RJzFhSgAcfF9IH6Hqjn3oE2i97LHXBxDGV6sNFXUu2bEjWTL34Mg6NV7yb6ha9Y7Wqkj
         nOto5TCMDQ5nim5cGeL/w5+V1Q1lZDb2Nd7+gDmx947faKK16y/6BY2LRHhMsb235IWc
         pfjxCRcmLF/CjKp5kJE0c/4meA82RYkK493nMpSc0MEWz47zOds4b9m1XI2PTE3tSYSj
         ubtd1VEnWcYtleR+G9rhZ7ORNSvNx7c4EIZwKJtoOyH+RjsbfyQfZJfjDTV2hPd/gNwK
         Vc1w==
X-Gm-Message-State: APjAAAWO7xES83eFwwV5DdU/9ZRFqY1e9FJGb69NraAL2g4OZKRX1Nva
        /+iKRqSHCjxDRGUZLm5H3fTUHg==
X-Google-Smtp-Source: APXvYqz8oqBeVh6MZUE0AGrHvAkTb7wWRz6uSXZ4rCTCGMrrbXhGVDQx61lhH4bxUV3+383hmIq/PQ==
X-Received: by 2002:a50:add2:: with SMTP id b18mr21090841edd.43.1553615724069;
        Tue, 26 Mar 2019 08:55:24 -0700 (PDT)
Received: from localhost.localdomain (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id k32sm6651057ede.97.2019.03.26.08.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:55:23 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, khlebnikov@yandex-team.ru, luto@kernel.org,
        dhowells@redhat.com, serge@hallyn.com, ebiederm@xmission.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 0/4] pid: add pidctl()
Date:   Tue, 26 Mar 2019 16:55:09 +0100
Message-Id: <20190326155513.26964-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v1 of this patchset with various minor fixes which are listed in
the individual commits. Notably, pidfds are now O_CLOEXEC by default.

The pidctl() syscalls builds on, extends, and improves translate_pid()
[4] and serves as the natural connection between the pid-based and the
pidfd-based api.

I quote Konstantins original patchset first that has already been acked
and picked up by Eric before and whose functionality is preserved in
this syscall. Multiple people have asked when this patchset will be sent
in for merging (cf. [1], [2]). It has recently been revived by
Nagarathnam Muthusamy from Oracle [3].

The intention of the original translate_pid() syscall was twofold:
1. Provide translation of pids between pid namespaces especially for the
   case of deeply nested pid namespaces.
   The most obvious use-case is strace which has been waiting for this
   feature for a while.
2. Provide implicit pid namespace introspection

Both functionalities are preserved. The latter task has been improved
upon though. In the original version of the pachset passing pid as 1
would allow to deterimine the relationship between the pid namespaces.
This is inherhently racy. If pid 1 inside a pid namespace has died it
would report false negatives. For example, if pid 1 inside of the target
pid namespace already died, it would report that the target pid
namespace cannot be reached from the source pid namespace because it
couldn't find the pid inside of the target pid namespace and thus
falsely report to the user that the two pid namespaces are not related.
This problem is simple to avoid. In the new version we simply walk the
list of ancestors and check whether the namespace are related to each
other. By doing it this way we can reliably report what the relationship
between two pid namespace file descriptors looks like.

Additionally, this syscall has been extended to allow the retrieval of
pidfds independent of procfs. These pidfds can e.g. be used with the new
pidfd_send_signal() syscall we recently merged. The ability to retrieve
pidfds independent of procfs had already been requested in the
pidfd_send_signal patchset by e.g. Andrew [4] and later again by Alexey
[5]. A use-case where a kernel is compiled without procfs but where
pidfds are still useful has been outlined by Andy in [6]. Regular
anon-inode based file descriptors are used that stash a reference to
struct pid in file->private_data and drop that reference on close.

With this pidctl() has three closely related functionalities that
provide a natural connection between the pid-based and the pidfd-based
api. To clarify the semantics and to make it easier for userspace to use
the syscall it has a command argument and three commands clearly
reflecting the functionalities (PIDCMD_QUERY_PID, PIDCMD_QUERY_PIDNS,
PIDCMD_GET_PIDFD).

Embedding the retrieval of pidfds into this syscall has two main
advantages:
- pidctl provides a natural and clean connection between the traditional
  pid-based and the newer pidfd-based process API
- allows the retrieval of pidfds for other pid namespaces while
  enforcing that
  - the caller must have been given access to two file descriptors
    referring to target and source pid namespace
  - the source pid namespace must be an ancestor of the target pid
    namespace
  - the pid must be translatable from the source pid namespace into the
    target pid namespace

Note that this patchset also includes Al's and David's commit to make anon
inodes unconditional. The original intention is to make it possible to use
anon inodes in core vfs functions. pidctl() has the same requirement so
David suggested I sent this in alongside this patch. Both are informed of
this.

The syscall comes with extensive testing for all functionalities.

/* References */
[1]: https://lore.kernel.org/lkml/37b17950-b130-7933-99a1-4846c61c8555@oracle.com/
[2]: https://lore.kernel.org/lkml/20181109034919.GA21681@altlinux.org/
[3]: https://lore.kernel.org/lkml/37b17950-b130-7933-99a1-4846c61c8555@oracle.com/
[4]: 3eb39f47934f9d5a3027fe00d906a45fe3a15fad
[5]: https://lore.kernel.org/lkml/20190320203910.GA2842@avx2/
[6]: https://lore.kernel.org/lkml/CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com/

Thanks!
Christian

Christian Brauner (3):
  pid: add pidctl()
  signal: support pidctl() with pidfd_send_signal()
  tests: add pidctl() tests

David Howells (1):
  Make anon_inodes unconditional

 arch/arm/kvm/Kconfig                        |   1 -
 arch/arm64/kvm/Kconfig                      |   1 -
 arch/mips/kvm/Kconfig                       |   1 -
 arch/powerpc/kvm/Kconfig                    |   1 -
 arch/s390/kvm/Kconfig                       |   1 -
 arch/x86/Kconfig                            |   1 -
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/x86/kvm/Kconfig                        |   1 -
 drivers/base/Kconfig                        |   1 -
 drivers/char/tpm/Kconfig                    |   1 -
 drivers/dma-buf/Kconfig                     |   1 -
 drivers/gpio/Kconfig                        |   1 -
 drivers/iio/Kconfig                         |   1 -
 drivers/infiniband/Kconfig                  |   1 -
 drivers/vfio/Kconfig                        |   1 -
 fs/Makefile                                 |   2 +-
 fs/notify/fanotify/Kconfig                  |   1 -
 fs/notify/inotify/Kconfig                   |   1 -
 include/linux/pid.h                         |   2 +
 include/linux/pid_namespace.h               |   8 +
 include/linux/syscalls.h                    |   2 +
 include/uapi/linux/wait.h                   |  14 +
 init/Kconfig                                |  10 -
 kernel/pid.c                                | 161 ++++++
 kernel/pid_namespace.c                      |  25 +
 kernel/signal.c                             |  29 +-
 kernel/sys_ni.c                             |   3 -
 tools/testing/selftests/pidfd/Makefile      |   2 +-
 tools/testing/selftests/pidfd/pidctl_test.c | 537 ++++++++++++++++++++
 30 files changed, 765 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidctl_test.c

-- 
2.21.0

