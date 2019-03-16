Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79409C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CCB218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bPGVNLSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCPBWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 21:22:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33144 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCPBWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 21:22:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id z7so9495922lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 18:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hzut7dT8+QvVW1V0sJTLJ9utxy+shoX/ss036x5BpVA=;
        b=bPGVNLSjpVlxjZt5Cp4rJwR3EPaPGQjpcKYU4bG4coaWBD3cnYD4NHS/HyuPkx+GUQ
         7GFGbPMSOs8rsmtiGNnHg+1usahY5q96znUsQGTo9CFIzDN1UkGqbY7ckqBmATZ62F2V
         VAVA60PcknbtKA39oADw/5dVYi6DC6jjkvXcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hzut7dT8+QvVW1V0sJTLJ9utxy+shoX/ss036x5BpVA=;
        b=cIVuLpJLwEQbNplGsy+LvKhONxOF4XSwGZPo1ZGgzYFk54lXJbUiDbl4t7WMNE8RxP
         IhO7mNTkJnRcLf7MN+SO8GLXmWcot5U3I2bG53AWv0o5pBSQVW11Ip66vNqeD2n0loIk
         XN8Bt6WBQgxJjA8TzHToyLvBEpeeEP05VGFdUyLYoO7SuTYWXdNIyMKpJdgpwhOIONeY
         oyhoi/hZBLBinjHI2p0GuiZNcN0piJKdE67SvyzhHuxK3F1Dxm/Kbbr40EwSOFN4aLgf
         P3nOn1bDg7UMDUxJmtZ38p8n6sicbZQ5aa6NlDJdS1GT5P9ehSecGa2wVBipU4EY2Y58
         x0Zw==
X-Gm-Message-State: APjAAAUK3eMZk6m7Mach4lTOuhxnm4LW4/ZG69tbm069GzvG6m3NzLq8
        JUOrKY19q+InIYDeTT3pF2BPfpnM1MkTikY2UBBhYg==
X-Google-Smtp-Source: APXvYqw3WiDgu+RpqBDGyD/IYii2edqmWy7ehNghQbRCpe5qQ8NwvucUImaakvPXuWiy0BCINjs1iXbGRKRpRTw+ioc=
X-Received: by 2002:a2e:810d:: with SMTP id d13mr3789983ljg.1.1552699369523;
 Fri, 15 Mar 2019 18:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190312135245.27591-1-christian@brauner.io>
In-Reply-To: <20190312135245.27591-1-christian@brauner.io>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 15 Mar 2019 18:22:38 -0700
Message-ID: <CAEXW_YRFUNqmaeVB9u2YbyLXHZhskYiP6_Ae1vqXqu+swtipVA@mail.gmail.com>
Subject: Re: [GIT PULL RESEND] pidfd changes for v5.1-rc1
To:     Christian Brauner <christian@brauner.io>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 6:53 AM Christian Brauner <christian@brauner.io> wrote:
>
> Hi Linus,
>
> This is a resend of the pull request for the pidfd_send_signal() syscall
> which I sent last Tuesday. I'm not sure whether you just wanted to take a
> closer look.
>
> The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:
>
>   Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git tags/pidfd-v5.1-rc1
>
> The patchset introduces the ability to use file descriptors from proc/<pid>
> as stable handles on struct pid. Even if a pid is recycled the handle will
> not change. For a start these fds can be used to send signals to the
> processes they refer to.

Joel from the Android team here. This will solve a long standing issue we
have with Android's low memory killer daemon (lmkd) where the killing of
a PID is racy with the traditional signal delivery methods. With this new API,
we can kill things correctly in a race free way. I hope this will get merged
soon and I look forward to further developing on top of this (such as
for support knowing when something was killed and waiting for it reliably -
right now we have a very suboptimal 100ms periodic polling loop to
check for process death, whichslows down how fast we can kill processes to
reclaim their memory).

thanks,

- Joel


>
> With the ability to use /proc/<pid> fds as stable handles on struct pid we
> can fix a long-standing issue where after a process has exited its pid can
> be reused by another process. If a caller sends a signal to a reused pid it
> will end up signaling the wrong process.
> With this patchset we enable a variety of use cases. One obvious example is
> that we can now safely delegate an important part of process management -
> sending signals - to processes other than the parent of a given process by
> sending file descriptors around via scm rights and not fearing that the
> given process will have been recycled in the meantime.
> It also allows for easy testing whether a given process is still alive or
> not by sending signal 0 to a pidfd which is quite handy.
> There has been some interest in this feature e.g. from systems management
> (systemd, glibc) and container managers. I have requested and gotten
> comments from glibc to make sure that this syscall is suitable for their
> needs as well. In the future I expect it to take on most other pid-based
> signal syscalls. But such features are left for the future once they are
> needed.
>
> The patchset has been sitting in linux-next for quite a while and has
> not caused any issues. It comes with selftests which verify basic
> functionality and also test that a recycled pid cannot be signaled via a
> pidfd.
>
> Jon has written about a prior version of this patchset. It should cover the
> basic functionality since not a lot has changed since then:
>
> https://lwn.net/Articles/773459/
>
> The commit message for the syscall itself is extensively documenting the
> syscall, including it's functionality and extensibility.
>
> /* Merge conflict and sycall number coordination */
> Please note, there will be a merge conflict between the Jens' io_uring
> patch set in the block tree and this tree. To minimize its impact Arnd
> worked with Jens and me to coordinate syscall numbers in advance.
> pidfd_send_signal() takes 424 and Jens' patchset took 425 to 427.
>
> /* Separate tree on kernel.org */
> At the beginning of last merge cycle it was suggested to move this patchset
> into a separate tree on kernel.org as there will be more work coming that
> will be extending the use of file descriptors for processes. The tree was
> announced in January:
>
> https://lore.kernel.org/lkml/20190108234722.bojj5bqowlutymnt@brauner.io/
>
> The pidfd tree is located on kernel.org
>
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/
>
> and it's for-next branch is already tracked by Stephen in linux-next since
> the beginning of the 5.0 development cycle. I'm prepared to deal with any
> fallouts coming from this work going forward.
>
> The only thing that has changed recently in these patches was the addition
> of two more Acked-by/Reviewed-by from  David Howells and tglx after the
> last round of reviews.
>
> Please consider pulling these changes from the signed pidfd-v5.1-rc1 tag.
>
> Thanks!
> Christian
>
> ----------------------------------------------------------------
> pidfd patches for v5.1-rc1
>
> ----------------------------------------------------------------
> Christian Brauner (2):
>       signal: add pidfd_send_signal() syscall
>       selftests: add tests for pidfd_send_signal()
>
>  arch/x86/entry/syscalls/syscall_32.tbl     |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl     |   1 +
>  fs/proc/base.c                             |   9 +
>  include/linux/proc_fs.h                    |   6 +
>  include/linux/syscalls.h                   |   3 +
>  include/uapi/asm-generic/unistd.h          |   4 +-
>  kernel/signal.c                            | 133 +++++++++-
>  kernel/sys_ni.c                            |   1 +
>  tools/testing/selftests/Makefile           |   1 +
>  tools/testing/selftests/pidfd/Makefile     |   6 +
>  tools/testing/selftests/pidfd/pidfd_test.c | 381 +++++++++++++++++++++++++++++
>  11 files changed, 539 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/pidfd/Makefile
>  create mode 100644 tools/testing/selftests/pidfd/pidfd_test.c
