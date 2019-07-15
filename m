Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA937C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93133205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vx5UHmP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfGOQFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:05:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42961 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfGOQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:05:00 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so4603164iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=abd3MzgGdND+mibf+9QP7+SAzCXmIg9aBJBUAlhxoSE=;
        b=Vx5UHmP4FSl+2sW2xSMATHmt/TstgDDB2D2BYOmRytxQn8jrzjv9CHvBN6ziokACKV
         yzABsXIgYMdyMShtxK0HrEeZ6yqmlt1ErRBouLjdWGCgNDX8nI3gIQGZ6TbZfGsRZAHQ
         G91t8osAi33e15JefGOz/Q8Tfy03uYvccBxHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=abd3MzgGdND+mibf+9QP7+SAzCXmIg9aBJBUAlhxoSE=;
        b=bdTGJlfNNCcdr1SHPNc96CVXfROyD+H+uln81kNP6OXqlEC9xY8LlVHVKwvez5Xqng
         LMeF89tpaMUyj8qOR6HMPr6ueANWnW6axSxyrqrumvHkSngdYSsCSxovRN5Av4yp2b4X
         AjuTXDQkI5Go9uso9h85jkomchxcPC7Il8OC1NftHsF2qB6z+kt+P3vmJeJVhSju9F5d
         UrVrzy5yK00gmx7rRYiY9XQOvKK0IF2nMni8Ta2iq0cTeqGSiG0RW4aLnk1wCKWlxlKy
         uL18GgEnYeFnrNI5RPXPKgbks1ysedTm2dOSqZMoCApLfwSEYcXQmiWNdro28QX0omU/
         /8hQ==
X-Gm-Message-State: APjAAAUw7hc2IwVWepZIGe+phulf0dNNfzEKWpH4x1gHXp+g7crMJuN4
        cFmNpGSCmPvD6LjqccjbXgmV56csf8znXR7YV9oHKA==
X-Google-Smtp-Source: APXvYqxIWrDZQA5aJHb2ZwP6MlOqQQByu0F7zWYD236UlUTqOmdsc6Xfpir6+WTeVaRUAFknNlgvqiYC7RyKKDGoS4g=
X-Received: by 2002:a05:6638:81:: with SMTP id v1mr27332807jao.72.1563206699374;
 Mon, 15 Jul 2019 09:04:59 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 15 Jul 2019 09:04:48 -0700
Message-ID: <CAJ-EccPGqp4PmRkFk505QhDKHWn-ajxS0__Nk9VS32jV_+3Y2A@mail.gmail.com>
Subject: [GIT PULL] SafeSetID LSM changes for 5.3
To:     torvalds@linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm maintaining the new SafeSetID LSM and was told to set up my own
tree for sending pull requests rather than sending my changes through
James Morris and the security subsystem tree.

This is my first time doing one of these pull requests so hopefully I
didn't screw something up.

Thanks,
Micah
---
The following changes since commit fec88ab0af9706b2201e5daf377c5031c62d11f7:
Merge tag 'for-linus-hmm' of
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-07-14
19:42:11 -0700)
are available in the Git repository at:
https://github.com/micah-morton/linux.git tags/safesetid-5.3
for you to fetch changes up to e10337daefecb47209fd2af5f4fab0d1a370737f:
LSM: SafeSetID: fix use of literal -1 in capable hook (2019-07-15
08:08:03 -0700)
----------------------------------------------------------------
SafeSetID patches for 5.3
These changes from Jann Horn fix a couple issues in the recently added
SafeSetID LSM:

(1) There was a simple logic bug in one of the hooks for the LSM where
the code was incorrectly returning early in some cases before all
security checks had been passed.
(2) There was a more high level issue with how this LSM gets configured
that could allow for a program to bypass the security restrictions
by switching to an allowed UID and then again to any other UID on
the system if the target UID of the first transition is
unconstrained on the system. Luckily this is an easy fix that we now
enforce at the time the LSM gets configured.

There are also some changes from Jann that make policy updates for this
LSM atomic. Kees Cook, Jann and myself have reviewed these changes and they
look good from our point of view.
Signed-off-by: Micah Morton <mortonm@chromium.org>
----------------------------------------------------------------
Jann Horn (10):
LSM: SafeSetID: fix pr_warn() to include newline
LSM: SafeSetID: fix check for setresuid(new1, new2, new3)
LSM: SafeSetID: refactor policy hash table
LSM: SafeSetID: refactor safesetid_security_capable()
LSM: SafeSetID: refactor policy parsing
LSM: SafeSetID: fix userns handling in securityfs
LSM: SafeSetID: rewrite userspace API to atomic updates
LSM: SafeSetID: add read handler
LSM: SafeSetID: verify transitive constrainedness
LSM: SafeSetID: fix use of literal -1 in capable hook
security/safesetid/lsm.c | 276 +++++++++++++-----------------------------
security/safesetid/lsm.h | 34 ++++--
security/safesetid/securityfs.c | 307
+++++++++++++++++++++++++++++------------------
tools/testing/selftests/safesetid/safesetid-test.c | 18 ++-
4 files changed, 306 insertions(+), 329 deletions(-)
