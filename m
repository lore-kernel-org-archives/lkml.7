Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAF8C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F35208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="EawTB6Jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfFZOIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:08:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42976 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZOIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:08:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so3536124edq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/IMBEx+SesAyWKiRBS4ur84ss5t4d1HSOLzWXAbsmDo=;
        b=EawTB6Jwu+DKx4pzn9adu+6cJt4EH0u1f5QSZUeW1OmfPV/lfpzNV36M7LjX6kpZjV
         Bjocv+ZmplfZTlNA2ap9OFKs+gZwN668831Jdx0d3eOEL77abY7lijO65YLVgnJrMzXT
         hunM7oXPnQ0HVim4E1Gr2UPo/XgFUga1bwf0VVuAl+qMdBR+c0O4Ot4iFCTApInS0qqw
         XA031QSAR4deUS/mWQaiYYV9cgMfrlAzk19OnwULGdCrZUUO7YexioofquBHbz6LJww0
         wHA9/snmQQfNgYNDvZi0PFhvtG7BQG6UbIfy8368pRqI5+0+yL9oRGpG67quButJkR1+
         Z3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/IMBEx+SesAyWKiRBS4ur84ss5t4d1HSOLzWXAbsmDo=;
        b=Hdu/R+QamsTMn4NejgPlFjZPQu2Apsb6GZEhqpE4th7ilYj/rlhgwI5JzZvGQ9cBrH
         vcDIBrsqHlv//N8sognFNB3JxFxI2rXL4bDzAeKDo4Oelu1wAtcP50+yY4dA+NyQS3Wf
         eVycH6dtXL5d8qrsDHlVG/ofWaIUpQh9dB7BfNTlVonuY3LUH1ezIq4LaArMMPIN9yXC
         cQZJ5ZXu506Mi0ujva/O548yjU4khh/Oxgks8Ba8pIfaHSRUNTEWoRXGBnJsDiYW2Bu/
         Ve6yBqGCzcklVVa8cvtXYxqOywLj/TS65d6mnXToL4v7nz/V03d56B5atv2QnxXKHUcs
         Aqag==
X-Gm-Message-State: APjAAAWI8zb0eLt83GmgWs5SykJN9ftIxtvEA37I3Ali7PObtep3izGq
        umbI654wl78VTetIVy9LPx2kJ90du8qBuw==
X-Google-Smtp-Source: APXvYqwjD1F73ZI9PSXLV2HxyEHsMbx3W2ReyjMc+3ficOUis3LVXPrQUJzxFXw8mlwJhKUmWPc05A==
X-Received: by 2002:a50:e718:: with SMTP id a24mr5430259edn.91.1561558102230;
        Wed, 26 Jun 2019 07:08:22 -0700 (PDT)
Received: from localhost.localdomain (cable-89-16-153-196.cust.telecolumbus.net. [89.16.153.196])
        by smtp.gmail.com with ESMTPSA id p18sm2983531ejr.61.2019.06.26.07.08.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 07:08:21 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org
Subject: [GIT PULL] fixes for v5.2-rc7
Date:   Wed, 26 Jun 2019 16:07:33 +0200
Message-Id: <20190626140733.21538-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request removes the validation of the pidfd return argument if
CLONE_PIDFD is specified:

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190626

for you to fetch changes up to bee19cd8f241ab3cd1bf79e03884e5371f9ef514:

  samples: make pidfd-metadata fail gracefully on older kernels (2019-06-24 15:55:50 +0200)

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

However, extending legacy clone this way would be a terrible idea and with
clone3 on the horizon and the ability to reuse CLONE_DETACHED with
CLONE_PIDFD there's no real need for this clutch. So remove the pidfd == 0
check and help userspace out.

Please consider pulling these changes from the signed for-linus-20190626 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-20190626

----------------------------------------------------------------
Dmitry V. Levin (2):
      fork: don't check parent_tidptr with CLONE_PIDFD
      samples: make pidfd-metadata fail gracefully on older kernels

 kernel/fork.c                  | 12 ------------
 samples/pidfd/pidfd-metadata.c |  8 ++++++--
 2 files changed, 6 insertions(+), 14 deletions(-)
