Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BA5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48860214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="HFVKFUix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbfDRKTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:19:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40555 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388369AbfDRKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:19:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id d46so1342751eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAU5wsUFIBBuQHlfBd7qK3PHR183Iv0JzkUJMzK5Aps=;
        b=HFVKFUixVEMmm+N/dfo2TDKKPIyseVQMs00k1g1Rlcgt6dFZRCTqmNPABbcbtkcKS9
         9WmOHBpWVXcntMmkv6M7ZkruTN8bGWRlKjiMZ71ShluSWAUkmqaQK60Rdbs7unMGV27l
         obgsSNs3CAOcqHt2Djx59mKxi/CGjWvVAT2IfA+nMAoJv8Hk+D7u6pi4oAeXU5NE+xue
         NJRmA1ovoG46KVRivrDYS8TnkewDv0h+vzgzBpKakzAttnmuyI+9BM+Dzs4tF5tDb9MY
         Bdqg2i6+CI+bIYZ2Fu+rLIVd599KXNEMLUWWvsrx1cvOweJJH6YTWRJ3q8t105D9ZPHM
         Cjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAU5wsUFIBBuQHlfBd7qK3PHR183Iv0JzkUJMzK5Aps=;
        b=me5nKghqDr3/q+pI6vtijqcZAhcs+ol2qR3dUJrvk3EwWCxd2UBBhMLhKOd3rfy08Y
         fyePjYpBAoVEBzjc6W0f7ZGhyeXWKMzbdkB7M0d2R6YRNW+7YKRss0AkH1VHLh/ouCoN
         NQSzV82Pp6JYgGoaYaBcwufl2AV1oDHpfeMmiFixkGPySg4SA5nyBWh8uMFuqY9cJaV1
         DmOZs6m2HRdGZ2mftb5SZTjX+CMnI31mcU+Wo0NI9B1x3WJBBlHZMR8/xFf+A0b+ZyKp
         RVtTvhUIwn0MQtTMBPR0HM40sD32d8MghVH0UVSE2rIu4VzstOxRS4KtkNn+jCztCKZP
         FLvQ==
X-Gm-Message-State: APjAAAUIY1GVzZBX8YJD1gMM6NigGPpP3tOvvXml73ivK+Obdc3soNW2
        sawBRrqLQwSTRFyyXewFXMExNw==
X-Google-Smtp-Source: APXvYqyh7WFYPxQHlWcOu7e4j+Thp4zbsITsymorNZ0qWamIbeJeelUHF9l5K0amFOeHR4XC7FEjIQ==
X-Received: by 2002:aa7:d351:: with SMTP id m17mr11893629edr.259.1555582760016;
        Thu, 18 Apr 2019 03:19:20 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id 31sm400479edf.18.2019.04.18.03.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:19:18 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, oleg@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 0/5]  clone: add CLONE_PIDFD
Date:   Thu, 18 Apr 2019 12:18:36 +0200
Message-Id: <20190418101841.4476-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

/* v2 summary */
Move put_user() into copy process before clone's point of no return so
that we can handle put_user() errors as suggested by Oleg. The good news
is that this again allows us to make the patch smaller.

/* v1 summary */
As suggested by Oleg, have pidfds returned in the fourth argument of
clone allowing us to return a pidfd and its pid to the caller at the
same time. This has various advantages:
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

Christian Brauner (4):
  clone: add CLONE_PIDFD
  signal: use fdget() since we don't allow O_PATH
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
 kernel/fork.c                  |  96 ++++++++++++++++++++++++++--
 kernel/signal.c                |  14 +++--
 kernel/sys_ni.c                |   3 -
 samples/Makefile               |   2 +-
 samples/pidfd/Makefile         |   6 ++
 samples/pidfd/pidfd-metadata.c | 112 +++++++++++++++++++++++++++++++++
 26 files changed, 225 insertions(+), 39 deletions(-)
 create mode 100644 samples/pidfd/Makefile
 create mode 100644 samples/pidfd/pidfd-metadata.c

-- 
2.21.0

