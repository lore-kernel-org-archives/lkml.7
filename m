Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDEDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFD120872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PFMlpB0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfDPREs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:04:48 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33877 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPREr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:04:47 -0400
Received: by mail-vs1-f65.google.com with SMTP id t78so11985268vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wnq/ir3KN8G0Q+0FYGS/6E/Voq3AyaDVXtGGcqnoSBU=;
        b=PFMlpB0Bnttx8UpJXQoEDxmfGNIj/jdl96CnSOD7MVdjqPkyn1YndKfV0T3ASfE6/w
         6Ibt8epPC0rMFKad1WcuC1Nuw6CsrdD3V7IsGeuoJHD6CZZrKWEzg50/dfDBZvOklOaB
         bKKY/ThHz/4QWdiz+iJW3Eb5xd6tChO2Xn7DaZTmb+r75fOzYqCTNDGI3HFlSkOTh45l
         5kazXZgHOrFqCR39M9OaaI4nWwkpSfTUkULzUW0p+avQEJXv/BpRt4kAZp6i0UaLztTI
         9+XF/Qn7mVVdePdXoPNkSbPwr/pQWIVpbOb8C2oz1/ecdkFBo3NblpriinjqPuzWfabT
         sZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wnq/ir3KN8G0Q+0FYGS/6E/Voq3AyaDVXtGGcqnoSBU=;
        b=PzbPtyvWQFSyBgjX8DyE4PkXQZwiOjCqQkOLEUhvBEkdttdRm9LMoQlwA0x9X3jaf0
         bvuRgIXoNsv4/Mo3jrNZIZVb36KvPWTDD+tIAb5O39LDrylo3mk+GeUb4AA4bu+Vfjy8
         eNSv8VCBSVQAjohqLE1WGSm2dSODBW3AAYeL6SX0g6LfGnotYuzHDWwayocUQTsfI2Y/
         J9h2cKBu94bgVNU8gim8N2FolRToOBcXTCBO76NfEN+91Ec0wJQeDx07SrkveDxAeAdq
         +c9jtsbTXwwnL2yOiCB+g2eedHYEkdQiuL0lKIw2+h9BGkvBqqic4YF/IQ0VTNNHSU8C
         8jIQ==
X-Gm-Message-State: APjAAAUA1cj35v5Vg2lpYD+GTT+r6rfxGobr4d8G2Y3GOOtwIDOrl5jh
        eMKewTxO+ghEVONwTrEa1OsLkA==
X-Google-Smtp-Source: APXvYqxQ05cwr4PvIRes0ptSuNrC/KQB/34aX20DDFOzdJhY4Tj0TmQM837CugQPQmJ9CEqSiAoamw==
X-Received: by 2002:a67:f358:: with SMTP id p24mr46080551vsm.3.1555434286427;
        Tue, 16 Apr 2019 10:04:46 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
        by smtp.gmail.com with ESMTPSA id c192sm45178368vka.10.2019.04.16.10.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:04:45 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 0/4] clone: add CLONE_PIDFD
Date:   Tue, 16 Apr 2019 19:02:29 +0200
Message-Id: <20190416170233.10208-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This is v1.
The only significant change is to have pidfds returned in the fourth
argument of clone allowing us to return a pidfd and its pid to the
caller at the same time. This has various advantages:
- callers get the associated pid for the pidfd without additional
  parsing 
  This makes it easier for userspce to get metadata access through
  procfs.
- the type of the return value for clone() remains unchanged
  (was changed to return an fd in the previous iteration)
- pid file descriptor numbering can start at 0 as is customary for
  file descriptors
  (was changed to start at 1 in the previous patchset to not break
   fork()-like error checking when returning pidfds)
- finally, the patchset has gotten smaller

The patchset makes it possible to retrieve pid file descriptors at
process creation time by introducing the new flag CLONE_PIDFD to the
clone() system call as previously discussed.

As decided last week [1] Jann and I have refined the implementation of
pidfds as anonymous inodes. Based on last weeks RFC we have only tweaked
documentation and naming, as well as making the sample program how to
get easy metadata access from a pidfd a little cleaner and more paranoid
when checking for errors.
The sample program can also serve as a test for the patchset.

When clone is called with CLONE_PIDFD a pidfd will be returned in the
fourth argument of clone. This is based on an idea from Oleg. It allows
us to return a pidfd and the associated pid to the caller at the same
time.

We have taken care that pidfds are created *after* the fd table has
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
 init/Kconfig                   |  10 ---
 kernel/fork.c                  | 121 +++++++++++++++++++++++++++++++--
 kernel/signal.c                |  14 ++--
 kernel/sys_ni.c                |   3 -
 samples/Makefile               |   2 +-
 samples/pidfd/Makefile         |   6 ++
 samples/pidfd/pidfd-metadata.c | 112 ++++++++++++++++++++++++++++++
 26 files changed, 250 insertions(+), 39 deletions(-)
 create mode 100644 samples/pidfd/Makefile
 create mode 100644 samples/pidfd/pidfd-metadata.c

-- 
2.21.0

