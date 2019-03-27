Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A9EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44872070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Zc5F0Y8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfC0WTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:19:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44835 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfC0WTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:19:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so15431256edh.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xRBROKR+pVCNaBYX52vAyYKcC+NvmczenCUt71H18mU=;
        b=Zc5F0Y8Jis1TLyQMO2adYooMtHvmmPpQViPdhYNQh8hhRF8K4U8u9qJ5k3qNP/XCxA
         0JtlA8MForWAyaVH2JGVU5hdJP+Ep0h41PCNOVV+Q1AqIVBfkK98prIOXsSJqrgj99Tz
         lsAA82K9j1yb3q35zFZ5r16kPdqniI6tAnboRLE4lU2dQTfQhE9Avn10K+AmdboAKsgZ
         fVFfVQu/pCLxfp7JclQUigrFpe7nUrbZhyxpQaZq5+VG7Gx+kwZrou0IM5vbcZOn3kZH
         hQJGtpPce7NUV2isR0fSNv9SeAjgac5hizs4VTS6dTik9uyXt0sKP2h5FZmiN8SpdQ1b
         KGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xRBROKR+pVCNaBYX52vAyYKcC+NvmczenCUt71H18mU=;
        b=tOA45MAedvp2ETDwil0T993E22U9vI/xe3v+W5HWzJNOnjVG5V+oDzmbk4ROnPpO3G
         T50nlCIL9zsZradn46WPwuw8Ca9dqXG1szssu8J1p8a1G6Q+jvKSI6cx3dCSBIEWmDSV
         SM//QouJB0vuwxYNgnB9al5rvWbkbm40pTRvY+0k8dLc64WfGO1V83VPkGZoyVkyaqSa
         A1n69iEu8NsArvhCk0s4LIMQ7LH9ql3meSsHuqzuyahoMAsomSSqAwugg7gpI+++jd2c
         ZCyIljc/8QlzfLSYUJT1VHEdju3n6tAUDOZiBI7gNGkvCkwcfrWkuN8GfEJFgVhFHGVF
         4olw==
X-Gm-Message-State: APjAAAUTpEsjSGwawR06VRMbNzarj05blW5sG4YZRBPxu0rMpD0cD7Er
        SuGTLrcKPvD+9xZj8yavaxA9mQ==
X-Google-Smtp-Source: APXvYqxQCj+7HWoz6bP0m4KpNxHvQOO9XzJm4nsS7MxsA4HHZgvU5eqeZivYfL+C4ouG9KQUzk7B0w==
X-Received: by 2002:aa7:c598:: with SMTP id g24mr16350982edq.293.1553725179417;
        Wed, 27 Mar 2019 15:19:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id l20sm1878067ejb.30.2019.03.27.15.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 15:19:38 -0700 (PDT)
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
Subject: [PATCH v1 0/4] pidfd_open()
Date:   Wed, 27 Mar 2019 23:19:06 +0100
Message-Id: <20190327221910.5897-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This is v1 of this patchset. No major changes. Just fixing nits that
Jann detected.

After the discussion over the last days, this is a fresh approach to
getting pidfds independent of the translate_pid() patchset.

pidfd_open() allows to retrieve pidfds for processes and removes the
dependency of pidfd on procfs.
These pidfds are allocated using anon_inode_getfd(), are O_CLOEXEC by
default and can be used with the pidfd_send_signal() syscall. They are not
dirfds and as such have the advantage that we can make them pollable or
readable in the future if we see a need to do so. Currently they do not
support any advanced operations. The pidfds are not associated with a
specific pid namespaces but rather only reference struct pid of a given
process in their private_data member.

One of the oustanding issues has been how to get information about a given
process if pidfds are regular file descriptors and do not provide access to
the process /proc/<pid> directory.
Various solutions have been proposed. The one that most people prefer is to
be able to retrieve a file descriptor to /proc/<pid> based on a pidfd (and
the other way around).
IF PROCFD_TO_PIDFD is passed as a flag together with a file descriptor to a
/proc mount in a given pid namespace and a pidfd pidfd_open() will return a
file descriptor to the corresponding /proc/<pid> directory in procfs
mounts' pid namespace. pidfd_open() is very careful to verify that the pid
hasn't been recycled in between.
IF PIDFD_TO_PROCFD is passed as a flag together with a file descriptor
referencing a /proc/<pid> directory a pidfd referencing the struct pid
stashed in /proc/<pid> of the process will be returned.
The pidfd_open() syscalls in that manner resembles openat() as it uses a
flag argument to modify what type of file descriptor will be returned.

The pidfd_open() implementation together with the flags argument strikes me
as an elegant compromise between splitting this into multiple syscalls and
avoiding ioctls().

Note that this patchset also includes Al's and David's commit to make anon
inodes unconditional. The original intention is to make it possible to use
anon inodes in core vfs functions. pidctl() has the same requirement so
David suggested I sent this in alongside this patch. Both are informed of
this.

The syscall comes with appropriate basic testing.

/* Examples */
// Retrieve pidfd
int pidfd = pidfd_open(1234, -1, -1, 0);

// Retrieve /proc/<pid> handle for pidfd
int procfd = open("/proc", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
int procpidfd = pidfd_open(-1, procfd, pidfd, PIDFD_TO_PROCFD);

// Retrieve pidfd for /proc/<pid>
int procpidfd = open("/proc/1234", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
int pidfd = pidfd_open(-1, procpidfd, -1, PROCFD_TO_PIDFD);

Thanks!
Christian

Christian Brauner (3):
  pid: add pidfd_open()
  signal: support pidfd_open() with pidfd_send_signal()
  tests: add pidfd_open() tests

David Howells (1):
  Make anon_inodes unconditional

 arch/arm/kvm/Kconfig                          |   1 -
 arch/arm64/kvm/Kconfig                        |   1 -
 arch/mips/kvm/Kconfig                         |   1 -
 arch/powerpc/kvm/Kconfig                      |   1 -
 arch/s390/kvm/Kconfig                         |   1 -
 arch/x86/Kconfig                              |   1 -
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/x86/kvm/Kconfig                          |   1 -
 drivers/base/Kconfig                          |   1 -
 drivers/char/tpm/Kconfig                      |   1 -
 drivers/dma-buf/Kconfig                       |   1 -
 drivers/gpio/Kconfig                          |   1 -
 drivers/iio/Kconfig                           |   1 -
 drivers/infiniband/Kconfig                    |   1 -
 drivers/vfio/Kconfig                          |   1 -
 fs/Makefile                                   |   2 +-
 fs/notify/fanotify/Kconfig                    |   1 -
 fs/notify/inotify/Kconfig                     |   1 -
 include/linux/pid.h                           |   2 +
 include/linux/syscalls.h                      |   2 +
 include/uapi/linux/wait.h                     |   3 +
 init/Kconfig                                  |  10 -
 kernel/pid.c                                  | 242 ++++++++++++++++++
 kernel/signal.c                               |  14 +-
 kernel/sys_ni.c                               |   3 -
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 .../testing/selftests/pidfd/pidfd_open_test.c | 201 +++++++++++++++
 28 files changed, 464 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_open_test.c

-- 
2.21.0

