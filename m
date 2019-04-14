Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D8C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87972084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="e/mIYmtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDNUPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:15:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45000 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:15:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id i13so2135949edf.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pmnpw1WexUqJgkx/tqwqzimvX6ITzB1N6znVU/yqhE8=;
        b=e/mIYmtVmiPhqcTCUIiWix31Fdw8olIu8gfgT7DxWehhcB2RRoqsE3CBsc1SNgaBk8
         9yLqCKFRuTEEAQBj65kIHZ9W6gyvd7KaBHbBrPhwbctZzjt2yqH1Fl/wjNYdJdyZjYVT
         ZgZDL5tNKa0O5641yyJ8GqmAAv+N7sW89DpVaHpTdVGS2eY5c2XCZE8jSkLCRO7eFD0Y
         hQI3WFKWA8ObUceDfLFiqE1YqoxTBqfXri7TdeWSdMw8afViMGdiPl+q0A1Uf+kfe0IK
         hiz9rKRLdyVKYv7esr+8b+UsQyoWK1L7d9a7B0lHP9HS+Dj7BrCQi2E3+YZ1cNivTBeo
         VvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pmnpw1WexUqJgkx/tqwqzimvX6ITzB1N6znVU/yqhE8=;
        b=MAZKVoxmHhnruiDcadmL6cZaYq/mMUa+LZ4j9Ix7FVgIoL0j82iEs0OTsrwxlFMX4d
         nqVq24m9a1Ti8+UKYwgFsXqWS0nyD5nNJ7REW2D62OZn0cQqYcnvy+751hpUQqixyYzl
         Tz70Cj6rR+Rt7kmLixn6RSmWZD6dvzHhsRJNahLuty00sHPs/wR97itj+lg1S99YuCWo
         LSzxHjEVwb86OVB4IZBh0hrlw1pfApeKS7TQQpPTTIKysic/5QTIhKjl88WzRN6e0Fx/
         aR4yDaUpKRZXZUv7kBbwClAzGaR+WEZscoOo6vbz71e3jpZCiNDypfmXB1oaDmrEAeoe
         5gCA==
X-Gm-Message-State: APjAAAUjOyOWcfA9jLbji6vwwecXTM4wdE+ThVxbIYQHIkHC6/N7N5E8
        leyGRU0QksvhwnC/JqdoO+QFyw==
X-Google-Smtp-Source: APXvYqzDOFiZ3lThxtmbz2VONCUmh+oZHFESs54zK0LaAMF7FKKpueQxj9TTQZS+szmCXcujMgGMiQ==
X-Received: by 2002:a17:906:6d99:: with SMTP id h25mr13987974ejt.187.1555272912454;
        Sun, 14 Apr 2019 13:15:12 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id n21sm3383068edq.14.2019.04.14.13.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 13:15:11 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/4] clone: add CLONE_PIDFD
Date:   Sun, 14 Apr 2019 22:14:32 +0200
Message-Id: <20190414201436.19502-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

This patchset makes it possible to retrieve pid file descriptors at
process creation time by introducing the new flag CLONE_PIDFD to the
clone() system call as previously discussed.

As decided last week [1] Jann and I have refined the implementation of
pidfds as anonymous inodes. Based on last weeks RFC we have only tweaked
documentation and naming, as well as making the sample program how to
get easy metadata access from a pidfd a little cleaner and more paranoid
when checking for errors.
The sample program can also serve as a test for the patchset.

When clone is called with CLONE_PIDFD a pidfd instead of a pid will be
returned. To make it possible for users of CLONE_PIDFD to apply standard
error checking that is common all across userspace, file descriptor
numbering for pidfds starts at 1 and not 0. This has the major advantage
that users can do:

int pidfd = clone(CLONE_PIDFD);
if (pidfd < 0) {
       /* handle error */
       exit(EXIT_FAILURE):
}

if (pidfd == 0) {
       /* child */
       exit(EXIT_SUCCESS);
}

/* parent */
exit(EXIT_SUCCESS);

We have also taken care that pidfds are created *after* the fd table has
been unshared to not leak pidfds into child processes.
pidfd creation during clone is split into two distinct steps:
1. preparing both an fd and a file referencing struct pid for fd_install()
2. fd_install()ing the pidfd
Step 1. is performed before clone's point of no return and especially
before write_lock_irq(&tasklist_lock) is taken.
Performing 1. before clone's point of no return ensures that we don't
need to fail a process that is already visible to userspace when pidfd
creation fails. Step 2. happens after attach_pid() is performed and the
process is visible to userspace.
Technically, we could have also performed step 1. and 2. together before
clone's point of no return and then calling close on the file descriptor
on failure. This would slightly increase code-locality but it is
semantically more correct and clean to bring the pidfd into existence
once the process is fully attached and not before.

The actual code for CLONE_PIDFD in patch 2 is completely confined to
fork.c (apart from the CLONE_PIDFD definition of course) and is rather
small and hopefully good to review. 

The additional changes listed under David's name in the diffstat below
are here to make anon_inodes available unconditionally. They are needed
for the new mount api and thus for core vfs code in addition to pidfds.
David knows this and he has informed Al that this patch is sent out
here. The changes themselves are rather automatic.

As promised I have also contacted Joel who has sent a patchset to make
pidfds pollable. He has been informed and is happy to port his patchset
once we have moved forward [2].
Jann and I currently plan to target this patchset for inclusion in the 5.2
merge window.

Thanks!
Jann & Christian

[1]: https://lore.kernel.org/lkml/CAHk-=wifyY+XGNW=ZC4MyTHD14w81F8JjQNH-GaGAm2RxZ_S8Q@mail.gmail.com/
[2]: https://lore.kernel.org/lkml/20190411200059.GA75190@google.com/

Christian Brauner (3):
  clone: add CLONE_PIDFD
  signal: support CLONE_PIDFD with pidfd_send_signal
  samples: show race-free pidfd metadata access

David Howells (1):
  Make anon_inodes unconditional

 arch/arm/kvm/Kconfig           |   1 -
 arch/arm64/kvm/Kconfig         |   1 -
 arch/mips/kvm/Kconfig          |   1 -
 arch/powerpc/kvm/Kconfig       |   1 -
 arch/s390/kvm/Kconfig          |   1 -
 arch/x86/Kconfig               |   1 -
 arch/x86/kvm/Kconfig           |   1 -
 drivers/base/Kconfig           |   1 -
 drivers/char/tpm/Kconfig       |   1 -
 drivers/dma-buf/Kconfig        |   1 -
 drivers/gpio/Kconfig           |   1 -
 drivers/iio/Kconfig            |   1 -
 drivers/infiniband/Kconfig     |   1 -
 drivers/vfio/Kconfig           |   1 -
 fs/Makefile                    |   2 +-
 fs/notify/fanotify/Kconfig     |   1 -
 fs/notify/inotify/Kconfig      |   1 -
 include/linux/pid.h            |   2 +
 include/uapi/linux/sched.h     |   1 +
 init/Kconfig                   |  10 --
 kernel/fork.c                  | 117 +++++++++++++++++++++-
 kernel/signal.c                |  14 ++-
 kernel/sys_ni.c                |   3 -
 samples/Makefile               |   2 +-
 samples/pidfd/Makefile         |   6 ++
 samples/pidfd/pidfd-metadata.c | 172 +++++++++++++++++++++++++++++++++
 26 files changed, 305 insertions(+), 40 deletions(-)
 create mode 100644 samples/pidfd/Makefile
 create mode 100644 samples/pidfd/pidfd-metadata.c

-- 
2.21.0

