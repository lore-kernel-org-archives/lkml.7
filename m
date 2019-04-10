Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3902DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBCD20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Kd+6cFww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDJXnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:43:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42284 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJXnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:43:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id x61so3529210edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIMNEh2vPfzrrCxdsJzL69YQ3W48fev0dxbBa2Zsgwc=;
        b=Kd+6cFwwioeWV6KypbD4kHtpkF5SaG1BPTA6X51VABokn1dmoFhkKemCbbq+A3zeoM
         d/GV/+/oio95hhlww2xOrR7U/a7Wx3A6Ey7Bkidb8qgIketmN8s6P4pCgWZCMKZ4pTx0
         wrwV+4gisMf4flOGgHvVBOqz+49jT3OpFWqidfFSctBrtXAGCjkk23eCAOGrfIB8cxn1
         Aeb60cWru2kpNB7oSZQWme6Q7sMLszI5orvm4eBhdz/OKM85fM0PhByOeIiylnbTybQa
         K7lt/nPyDvGQ3wFz7rQ6WVk7MIowF1ASR8vXRcQM83p9278i1lMWDV3wJraaRMPAGviC
         x02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIMNEh2vPfzrrCxdsJzL69YQ3W48fev0dxbBa2Zsgwc=;
        b=KwbEsoNccp/rWojsWOp1DOwQP2fDJrdZWO8TnevW2EXuucm4wO671GXasjmRDtvV5h
         2Zh5yI9wsiFy1/W59FWdJtfRidKR6jjZrZnsVHZmFf15Vkq6twTz7rCvpzCIynIroU2P
         SyCWikXN8g5hTMr5HXADvrii0UaOhtpBAxagLSJRygCuWpHbD+pNN68ns1+iAe7fWwRy
         CVaQMFvuVg/zLuPg602stROJz6Vtgvxw9/Fm6CSNquiYmuMI0hlCsGPMW6pVQvav5AB0
         h6lqyjCOIDoASEJcckMrG87e040Xusk6DmssCsgeoDbcilmCssuS2E/FDb1rbL8bJ4Nj
         8PMA==
X-Gm-Message-State: APjAAAXO/9tf90bXt10V3r/qQshnxLYBGoFLfPvkmXjXyJAwnOAJRPwW
        6Elw7i5RTOBNJU6ME0zNiQzxnw==
X-Google-Smtp-Source: APXvYqw7z7PLlTugCKHNkFo1HfWxLDeZX0sRBkpDsrG3dyG0KI3YuRCnWlwLcULe9yl3qcJUdFhCKw==
X-Received: by 2002:a50:fb81:: with SMTP id e1mr14253119edq.243.1554939809954;
        Wed, 10 Apr 2019 16:43:29 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id f8sm4833015edt.36.2019.04.10.16.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:43:28 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [RFC PATCH] fork: add CLONE_PIDFD
Date:   Thu, 11 Apr 2019 01:40:40 +0200
Message-Id: <20190410234045.29846-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

This is an RFC for adding a new CLONE_PIDFD flag to clone() as
previously discussed.
While implementing this Jann and I ran into additional complexity that
prompted us to send out an initial RFC patchset to make sure we still
think going forward with the current implementation is a good idea and
also provide an alternative approach:

RFC-1:
This is an RFC for the implementation of pidfds as /proc/<pid> file
descriptors.
The tricky part here is that we need to retrieve a file descriptor for
/proc/<pid> before clone's point of no return. Otherwise, we need to fail
the creation of a process that has already passed all barriers and is
visible in userspace. Getting that file descriptor then becomes a rather
intricate dance including allocating a detached dentry that we need to
commit once attach_pid() has been called.
Note that this RFC only includes the logic we think is needed to return
/proc/<pid> file descriptors from clone. It does *not* yet include the even
more complex logic needed to restrict procfs itself. And the additional
logic needed to prevent attacks such as openat(pidfd, "..", ...) and access
to /proc/<pid>/net/ on top of the procfs restriction.

There are a couple of reasons why we stopped short of this and decided to
sent out an RFC first:
- Even the initial part of getting file descriptors from /proc/<pid> out
  of clone() required rather complex code that struck us as very
  inelegant and heavy (which granted, might partially caused by not seeing
  a cleaner way to implement this). Thus, it felt like we needed to see
  whether this is even remotely considered acceptable.
- While discussing further aspects of this approach with Al we received
  rather substantiated opposition to exposing even more codepaths to
  procfs.
- Restricting access to procfs properly requires a lot of invasive work
  even touching core vfs functions such as
  follow_dotdot()/follow_dotdot_rcu() which also caused 2.

RFC-2:
This alternative patchset uses anonymous file descriptors instead of
file descriptors from /proc/<pid>.
A pidfd in this style comes with additional information in fdinfo: the pid
of the process it refers to in the current pid namespace (Pid: %d).

We have chosen to implement this alternative to illustrate how
strikingly simple this patchset is in comparision to the original
approach.
To remove worries about missing metadata access we have written a POC
that illustrates how a combination of CLONE_PIDFD, fdinfo, and
pidfd_send_signal() can be used to gain race-free access to process
metadata through /proc/<pid>. The sample program can easily be
translated into a helper that would be suitable for inclusion in libc so
that users don't have to worry about writing it themselves.

Thanks!
Jann & Christian

RFC-1:
Christian Brauner (1):
  fork: add CLONE_PIDFD via /proc/<pid>

 fs/proc/base.c             | 130 ++++++++++++++++++++++++++++++++++---
 fs/proc/fd.c               |   4 +-
 fs/proc/internal.h         |   2 +-
 fs/proc/namespaces.c       |   2 +-
 include/linux/proc_fs.h    |  19 ++++++
 include/uapi/linux/sched.h |   1 +
 kernel/fork.c              |  40 ++++++++++--
 7 files changed, 180 insertions(+), 18 deletions(-)

RFC-2:
Christian Brauner (3):
  fork: add CLONE_PIDFD via anonymous inode
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
 kernel/fork.c                  |  94 +++++++++++++++++-
 kernel/signal.c                |  14 ++-
 kernel/sys_ni.c                |   3 -
 samples/Makefile               |   2 +-
 samples/pidfd/Makefile         |   6 ++
 samples/pidfd/pidfd-metadata.c | 169 +++++++++++++++++++++++++++++++++
 26 files changed, 279 insertions(+), 40 deletions(-)
 create mode 100644 samples/pidfd/Makefile
 create mode 100644 samples/pidfd/pidfd-metadata.c

-- 
2.21.0

