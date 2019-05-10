Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17489C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF18208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="JMaBTjgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfEJM4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:56:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41684 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:56:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so5082520edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPnuhIzq3H5ZEW0js6MG3CCKFk6qafTaQQmgYa0pHts=;
        b=JMaBTjgEQvtdiVZfIF1EDk0FUQgdaG0SMhRshfg2wK/70GV6UUuoVXVMoIqQGPNViQ
         yGwjQKB4FTEcE8SokYVrOWBPhi2U0IswYzVM2B9MpwnbNydnUHPdeR2NAHeGNElu/BtK
         bdK25oRK/eFYihPf47REjH6uI702jaU70mYOhtThF951sl/o676oPAhEh0OuA3xayZ7f
         ssnNZZ2WF9OUlvoqW1mHYsuxmtUDmR9BWkdV0bhu1ZgilQnjbqV9DGkJ297wL7O4dHMj
         ki0Sghsomo8tzgAhHkeGd8bBXv7eOxP7r/V+lEbRNsb2qfPK3z7FNCxzMVXqTaF9XTtI
         c0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPnuhIzq3H5ZEW0js6MG3CCKFk6qafTaQQmgYa0pHts=;
        b=Zg9yT+MpstCeyurc7Su2AJBXpZdtoNetkOrdWu2i3JaHX++AwSgrqkaoWXoEEl8148
         HQcVWF1vr9H++EfVO6oLQNGYlEjF/ueJf9RCdkBGBcfKElwnfy9tOCqAvJi4NlpM4HOc
         KHrJ7HyDen2qqFRYBr2Jz4hR666eAE7S3CaJKcvs/zZGi0HGfPgXPnywm6wiEhgSZHWU
         9gT2IQkn45fX2RXoVGu36uPBes6FBSyod6P3ehqfk8fmPCvUfMjJxNxaNlWAl6C5nkYK
         iUyxoUz/zJYvjVdVdIBrXeySPElUeVi9BkOdHxcBa1iavZZQqzzGiCMMvc4vqYATmN60
         LEbg==
X-Gm-Message-State: APjAAAVAfh0/1K1wVIXr3HKlM32CGc2xZkBgjxmtJprYdG7w07K8oPF9
        YgYccqVTmKMSiXNGLggdSMeII9SFenOeAQ==
X-Google-Smtp-Source: APXvYqwuYuG1DFV03yxgfqXq7D/fi5FetHZFzeK9qrtp/9ZwHso9qkxNY/UMSdV+526GAVcejJKxfQ==
X-Received: by 2002:a17:906:eb97:: with SMTP id mh23mr8495196ejb.69.1557493003957;
        Fri, 10 May 2019 05:56:43 -0700 (PDT)
Received: from localhost.localdomain ([178.19.218.101])
        by smtp.gmail.com with ESMTPSA id e18sm740296ejf.77.2019.05.10.05.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 05:56:43 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     syzbot+3286e58549edc479faae@syzkaller.appspotmail.com,
        Christian Brauner <christian@brauner.io>
Subject: [GIT PULL] pidfd fixes for v5.2-rc1
Date:   Fri, 10 May 2019 14:54:47 +0200
Message-Id: <20190510125447.9179-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 8ea5b2abd07e2280a332bd9c1a7f4dd15b9b6c13:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2019-05-09 19:35:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-fixes-v5.2-rc1

for you to fetch changes up to c3b7112df86b769927a60a6d7175988ca3d60f09:

  fork: do not release lock that wasn't taken (2019-05-10 14:26:12 +0200)

I originally intended to send out a pr middle of next week to fix the bug you
reported but syzkaller found another bug that we should fix rather quickly.
Since no rc1 is out for 5.2 and the pidfd patchset had conflicts with Andrew's
tree and the kbuild tree I have simply based the pull request on current
mainline. 

/* Summary */
This pull request fixes two bugs.
The first one reported by Linus whereby the pidfd-metadata binary was not
placed in a .gitignore file.
The second one is rather urgent and fixes a locking issue found by syzkaller.
What happened is that during process creation we need to check whether the
cgroup we are in allows us to fork. To perform this check the cgroup needs to
guard itself against threadgroup changes and takes a lock. Prior to CLONE_PIDFD
the cleanup target "bad_fork_free_pid" would also need to release said lock.
That's not true anymore since CLONE_PIDFD so this is fixed here. Syzkaller has
tested the patch and was not able to reproduce the issue.

Please consider pulling these changes from the signed pidfd-fixes-v5.2-rc1 tag.
Christian

----------------------------------------------------------------
pidfd fixes for v5.2-rc1

----------------------------------------------------------------
Christian Brauner (2):
      samples: add .gitignore for pidfd-metadata
      fork: do not release lock that wasn't taken

 kernel/fork.c            | 5 +++--
 samples/pidfd/.gitignore | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 samples/pidfd/.gitignore
