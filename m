Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F326BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979D7205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="aKYBZr5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEGMtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:49:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36758 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfEGMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:49:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so18610192edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y8t4rKTgFSrcWtoXEcGBSgAKDDJ3jkMe3Lo/rVHhIQE=;
        b=aKYBZr5+R/TK6nAJFN7EqSzeDO/OimeNFdHBTJv44NQSId/OIMCQ9sdFBylo3sZ1X5
         p1oJcuGgfcfHEYMFyLzQJ2+q7DSeyoW6L8s6KhczCerbsoVNND7kNsw7jvjvHzxCVqtb
         cEe7k5BLcqjDwFLwoiOQ6cYCU15KKqN2xUzpOQ+V+lSCJPx8YUJYx8I39KWBGGJHtzUl
         Uqd8/PvwEYXTWPsG7gPkJFy1oIDAmsLocrJIbFyUNxvsJzznoFHZnC1s++RL2Sc9mo0N
         U4DNfgg2/Uw35xOiccIhQoYfDxDEZRzFG4QPQZyq7MmPJOcaDoN7nQbgcGRQecjlfU24
         hFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y8t4rKTgFSrcWtoXEcGBSgAKDDJ3jkMe3Lo/rVHhIQE=;
        b=KKN64IhcfQtH80aB4obuJHsu3OnWXv5OQnvPWaHJxyWtO0cjKGtSLF9QQHAKvnDVLM
         RKXFPJyi31dcbGNLJYjybyGdctO6oWJ20LZUgIB6sHkq7Br3IRt1xS6GXNmx0ThZQjb9
         XuvQ3CXmTizedDPkNJcRglCmUW7ett513N9LKj6WlLc5IqeaeX75LJKgHITQHVfvFsCa
         /Vpr52+S61C+yRezpL0qCfkN77VCS4VNg4hfakA8b3Ppb5mvJhwC21sj3KQcqka7f+Xx
         Sgvxnj7kWQDn9suzWdfrriVkAC1XlJgvs9Vi9fsgq2eeigRzcSftUABRhoRaNiHzKHuM
         yGxg==
X-Gm-Message-State: APjAAAUmBwlz6H6f6atD4pBVuApOiRhmwPRNeNcEKa+gkVCSZjHMbcUh
        YPmq/YfkhgY17Um5/1wXBsQ7uEEFMjbN+Q==
X-Google-Smtp-Source: APXvYqz4zvgu8UfDhCfYCUMN46fw5GAPmRdkApuHB8zZ/KgSaaygM3hDcGChxtB+L26NKZmy9zS9lQ==
X-Received: by 2002:a50:dece:: with SMTP id d14mr32467824edl.97.1557233349697;
        Tue, 07 May 2019 05:49:09 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id a13sm4170761eda.87.2019.05.07.05.49.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 05:49:09 -0700 (PDT)
Date:   Tue, 7 May 2019 14:49:07 +0200
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, jannh@google.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd patches for v5.2-rc1
Message-ID: <20190507124906.idfuoi45nxywhlkb@brauner.io>
References: <20190506123659.23591-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190506123659.23591-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 02:36:59PM +0200, Christian Brauner wrote:
> Hi Linus,
> 
> This is the promised pull request for the CLONE_PIDFD flag to the clone()
> syscall in its agreed upon form:
> 
> The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:
> 
>   Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-v5.2-rc1
> 
> for you to fetch changes up to 0786de75cbc560f779378c862b8bac16bee74d10:

I just realized that this still includes the old hash for the tag where
Jann's email is not fixed up. The fixed tag didn't get pushed to
kernel.org correctly. Probably just my incompetence. I fixed it. So this
should read:

for you to fetch changes up to 43c6afee48d4d866d5eb984d3a5dbbc7d9b4e7bf:

Sorry about that!
Christian

> 
>   samples: show race-free pidfd metadata access (2019-05-06 13:26:37 +0200)
> 
> /* Testing */
> The patches have been sitting in linux-next for quite a while.
> The recent change date on two of the commits is caused by a necessary
> update to Jann's mail address for the co-developed and signed-off-by lines.
> No semantic changes were done!
> 
> /* Conflicts with other trees */
> Please note, that the pidfd branch has two minor conflicts.  The first with
> akpm-current/current. The conflict and fix for it can be found under [1].
> The second with the kbuild tree. The conflict and fix for it can be found
> under [2].
> I'm happy to provide a fixed up tree but was told you usually prefer to do
> it yourself when reasonably small.
> 
> /* Summary */
> This patchset makes it possible to retrieve pidfds at process creation time
> by introducing the new flag CLONE_PIDFD to the clone() system call.  Linus
> originally suggested to implement this as a new flag to clone() instead of
> making it a separate system call.
> 
> After a thorough review from Oleg CLONE_PIDFD returns pidfds in the
> parent_tidptr argument. This means we can give back the associated pid and
> the pidfd at the same time. Access to process metadata information thus
> becomes rather trivial.
> 
> As has been agreed, CLONE_PIDFD creates file descriptors based on anonymous
> inodes similar to the new mount api.  They are made unconditional by this
> patchset as they are now needed by core kernel code (vfs, pidfd) even more
> than they already were before (timerfd, signalfd, io_uring, epoll etc.).
> The core patchset is rather small.  The bulky looking changelist is caused
> by David's very simple changes to Kconfig to make anon inodes unconditional.
> 
> A pidfd comes with additional information in fdinfo if the kernel supports
> procfs.  The fdinfo file contains the pid of the process in the callers pid
> namespace in the same format as the procfs status file, i.e. "Pid:\t%d".
> 
> To remove worries about missing metadata access this patchset comes with a
> sample/test program that illustrates how a combination of CLONE_PIDFD and
> pidfd_send_signal() can be used to gain race-free access to process
> metadata through /proc/<pid>.
> 
> Further work based on this patchset has been done by Joel.  His work makes
> pidfds pollable.  It finished too late for this merge window.  I would
> prefer to have it sitting in linux-next for a while and send it for
> inclusion during the 5.3 merge window.
> 
> Please consider pulling these changes from the signed pidfd-v5.2-rc1 tag.
> 
> Thanks!
> Christian
> 
> [1]: https://lore.kernel.org/lkml/20190423184657.3d16ba97@canb.auug.org.au/
> [2]: https://lore.kernel.org/lkml/20190502183125.3b53300e@canb.auug.org.au/
> 
> ----------------------------------------------------------------
> pidfd patches for v5.2-rc1
> 
> ----------------------------------------------------------------
> Christian Brauner (3):
>       clone: add CLONE_PIDFD
>       signal: support CLONE_PIDFD with pidfd_send_signal
>       samples: show race-free pidfd metadata access
> 
> David Howells (1):
>       Make anon_inodes unconditional
> 
>  arch/arm/kvm/Kconfig           |   1 -
>  arch/arm64/kvm/Kconfig         |   1 -
>  arch/mips/kvm/Kconfig          |   1 -
>  arch/powerpc/kvm/Kconfig       |   1 -
>  arch/s390/kvm/Kconfig          |   1 -
>  arch/x86/Kconfig               |   1 -
>  arch/x86/kvm/Kconfig           |   1 -
>  drivers/base/Kconfig           |   1 -
>  drivers/char/tpm/Kconfig       |   1 -
>  drivers/dma-buf/Kconfig        |   1 -
>  drivers/gpio/Kconfig           |   1 -
>  drivers/iio/Kconfig            |   1 -
>  drivers/infiniband/Kconfig     |   1 -
>  drivers/vfio/Kconfig           |   1 -
>  fs/Makefile                    |   2 +-
>  fs/notify/fanotify/Kconfig     |   1 -
>  fs/notify/inotify/Kconfig      |   1 -
>  include/linux/pid.h            |   2 +
>  include/uapi/linux/sched.h     |   1 +
>  init/Kconfig                   |  10 ----
>  kernel/fork.c                  | 108 +++++++++++++++++++++++++++++++++++++--
>  kernel/signal.c                |  12 +++--
>  kernel/sys_ni.c                |   3 --
>  samples/Makefile               |   2 +-
>  samples/pidfd/Makefile         |   6 +++
>  samples/pidfd/pidfd-metadata.c | 112 +++++++++++++++++++++++++++++++++++++++++
>  26 files changed, 236 insertions(+), 38 deletions(-)
>  create mode 100644 samples/pidfd/Makefile
>  create mode 100644 samples/pidfd/pidfd-metadata.c
