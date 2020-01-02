Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA7C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA3320848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Es9bqKua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgABV2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:28:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37262 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgABV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:28:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so58697188otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 13:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mPyYNeuJ8jdelp0hEmXr58iJYwW0qjnIucFiePEeqCY=;
        b=Es9bqKuaYrLvmKq0wWpuMM26XVR2BxXZklRDrYgUK9uzqOSjN+iZ/VUTD1JwFgCmwh
         MdY7lIS6zvsH6eqhmf7FUtH6Fseg18CDeJI8iTOjen9wG9bT9jWvzZfVd4AVQ7gmvhOi
         1UDkOEJWbf1zimW/X2Q9oeVu3KR0CEvVAq2UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mPyYNeuJ8jdelp0hEmXr58iJYwW0qjnIucFiePEeqCY=;
        b=jtv/AFmzKSQpHVmC0vNvyZYUX6Cfryg1FP7WKi/VoQkfTaZJffA1E44M3bAm4sxSL8
         JiXlOxWS193CHwEZrkxKC8OragW52uGeWWM65lDP9QLWwp5mt8PSEl+5zBcMpPGCpQvs
         l/q38m/B/wjdlVsvDwJ6Tc4dzdgL7dAL3jATFuIUeLcIsobvk9QWdk4bOHoKoh3wEZuy
         cGIfdYPgToRjieNXPYzoZkBTPVxQaGvnY9ztbBzisk42PbdI45ghZturptNAbYwQGDfc
         aBmFd1n7mBmR00aX/uYZRpVxdZBX3c5OH//8tXX6Zsyq/7ecpfKNgwEO+A0yMsBCEC8+
         VF7A==
X-Gm-Message-State: APjAAAXkv3gHNapQpttwBHKOpLSwzMqRo8PthAOlSpHs+KIZkB3bmyGa
        qq3Pf7o8DiZeGywJOM55JzRR6h/pdsE=
X-Google-Smtp-Source: APXvYqwL22kyN5PQ36kmExSkoSiq+INoOb3DODfZFAI+PI0qAJfMkbdPfTJ+xTEKDZJyp0AxtsqtPA==
X-Received: by 2002:a05:6830:110a:: with SMTP id w10mr97739164otq.300.1578000513407;
        Thu, 02 Jan 2020 13:28:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l82sm17066060oib.41.2020.01.02.13.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 13:28:32 -0800 (PST)
Date:   Thu, 2 Jan 2020 13:28:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [GIT PULL] seccomp fixes for v5.5-rc5
Message-ID: <202001021325.8D02D326B2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp fixes for v5.5-rc5. The bulk of this is fixing
the surrounding samples and selftests so that seccomp can correctly
validate the seccomp_notify_ioctl buffer as being initially zeroed.

Thanks!

-Kees

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.5-rc5

for you to fetch changes up to e4ab5ccc357b978999328fadae164e098c26fa40:

  selftests/seccomp: Catch garbage on SECCOMP_IOCTL_NOTIF_RECV (2020-01-02 13:15:45 -0800)

----------------------------------------------------------------
Fixes for seccomp_notify_ioctl uapi sanity

- Fix samples and selftests to zero passed-in buffer (Sargun Dhillon)
- Enforce zeroed buffer checking (Sargun Dhillon)
- Verify buffer sanity check in selftest (Sargun Dhillon)

----------------------------------------------------------------
Sargun Dhillon (4):
      samples/seccomp: Zero out members based on seccomp_notif_sizes
      selftests/seccomp: Zero out seccomp_notif
      seccomp: Check that seccomp_notif is zeroed out by the user
      selftests/seccomp: Catch garbage on SECCOMP_IOCTL_NOTIF_RECV

 kernel/seccomp.c                              |  7 +++++++
 samples/seccomp/user-trap.c                   |  4 ++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 15 ++++++++++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
Kees Cook
