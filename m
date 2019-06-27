Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DCEC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4112083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="IU/Kbska"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfF0LYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:24:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42166 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfF0LYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:24:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so2106466wrl.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 04:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+R8cZh89FEOeHcIUvPlsxuC14AmG6N9OhNcwtNtA4EA=;
        b=IU/KbskaBCUjKs+HsVZOriBfDVGNmyOJj1EBy5NhRvtb5iOp15a3Y3aIUXNcUGA3/I
         0Vcufe+9lsoYsN5tOnH9YrUI2EtMlV87yldccWBxGvyMPbSoJH3+sNWT8+sKYnTr5Yss
         bp3XeaBv3TMYAHDlEBFGARlv1383v9CXkoMXpdRGujjz+pfaDp0JGf85uPPfD6lGhLDC
         hhjv74ZQKNSqOnktKQE9uMP5YiUHrKDXVb392dnVRxGJp9c3RMG7bAvE/uu2U3wUoADd
         9ehi2H5bk4LOPi2m/ZNhxKiZWVKEyLs8JLT0ny6iTKZH7w80J8Jzq8tHUPvamxs6vGEq
         Df5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+R8cZh89FEOeHcIUvPlsxuC14AmG6N9OhNcwtNtA4EA=;
        b=oP6dZwJZ9e4+1eAkhv5qgdcMGUpRqdeh8CJxPEhVqD4LpKgrwgDsjGHh7FnJkgKmAZ
         q+2yUZmbXq1S9gTkqtETQhTKEQt4ChRONMhu0hxSHN2lbM6RQ8COLNK4fvYiJrCK/05i
         HB2JXHiyPK0nwoxb0WQAHVVAETtpw7brdoTwixzKA4wCKOIIWlZ3ZsIBZsx6LrTakGYp
         Yjf08NnnB41qhK8dKqIolzwK0lpt7hUTMvPGzztXOFdwQsNI476Z87VU2a1P0Nd6ryNB
         F4zxnU0QMiA9zi7cxegFNebLncNx5WF17gIlFjcQjxsobOV+6Pb57olJa/VPeCya6yw3
         CWXQ==
X-Gm-Message-State: APjAAAUCL3tj8MF5afbtFrulTe+5KgdgM1NEGKSHrDrPNJWTEgO/Wqqc
        GSF/7KSTA1o2yj3fdCGAy8Z5bA==
X-Google-Smtp-Source: APXvYqx2YMcDUdg8JmgKZtH2/yTcwwMyDZtWbBzZY1eJ7ooNk+VXizpTZdGwagViKvB6Hm1FzSUs9w==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr2892379wrq.143.1561634683056;
        Thu, 27 Jun 2019 04:24:43 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id z126sm7563789wmb.32.2019.06.27.04.24.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 04:24:42 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org,
        viro@zeniv.linux.org.uk, jannh@google.com
Subject: [GIT PULL] fixes for v5.2-rc7
Date:   Thu, 27 Jun 2019 13:24:30 +0200
Message-Id: <20190627112430.6590-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627045602.pqv67qxjj7ooaqir@brauner.io>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This contains a couple of fixes for the pidfd api by Dmitry, Al, and
myself:

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190627

for you to fetch changes up to 30d158b143b6575261ab610ae7b1b4f7fe3830b3:

  proc: remove useless d_is_dir() check (2019-06-27 12:25:09 +0200)

/* Remove check for pidfd == 0 with CLONE_PIDFD */
Userspace tools and libraries such as strace or glibc need a cheap and
reliable way to tell whether CLONE_PIDFD is supported.
The easiest way is to pass an invalid fd value in the return argument,
perform the syscall and verify the value in the return argument has been
changed to a valid fd.

However, if CLONE_PIDFD is specified we currently check if pidfd == 0 and
return EINVAL if not.

The check for pidfd == 0 was originally added to enable us to abuse the
return argument for passing additional flags along with CLONE_PIDFD in the
future.

Since extending legacy clone this way would be a terrible idea and with
clone3 on the horizon and the ability to reuse CLONE_DETACHED with
CLONE_PIDFD there's no real need for this clutch. So remove the pidfd == 0
check and help userspace out.

/* Avoid using anon_inode_getfd() and ksys_close() */
Accordig to Al, anon_inode_getfd() should only be used past the point of no
failure and ksys_close() should not be used at all since it is far too easy
to get wrong. Al's motto being "basically, once it's in descriptor table,
it's out of your control".
So Al's patch switches back to what we already had in v1 of the original
patchset and uses a anon_inode_getfile() + put_user() + fd_install()
sequence in the success path and a fput() + put_unused_fd() in the failure
path.

The other two changes should be trivial.

Please consider pulling these changes from the signed for-linus-20190627 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-20190627

----------------------------------------------------------------
Al Viro (1):
      copy_process(): don't use ksys_close() on cleanups

Christian Brauner (1):
      proc: remove useless d_is_dir() check

Dmitry V. Levin (2):
      fork: don't check parent_tidptr with CLONE_PIDFD
      samples: make pidfd-metadata fail gracefully on older kernels

 fs/proc/base.c                 |  3 +--
 kernel/fork.c                  | 58 +++++++++++++-----------------------------
 samples/pidfd/pidfd-metadata.c |  8 ++++--
 3 files changed, 25 insertions(+), 44 deletions(-)
