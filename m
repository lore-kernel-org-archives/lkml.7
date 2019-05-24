Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB80C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E2121773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="VKr3W69i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbfEXLLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:11:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34432 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390760AbfEXLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:11:06 -0400
Received: by mail-io1-f68.google.com with SMTP id g84so7461413ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Us0ScZrMvHOFeUHt3wu7YFBQO7zkY9OXaUx/Vlx7/nA=;
        b=VKr3W69inH/db6ZNTFU5L+jQiMeiPx4sZUy4oWhYzklUuA+px4Vh/Ujply9/A+dOm7
         pHYu8NSj4OTnTNiCVUohYjRxNhZIfVbOdCFMnwG8w6OtrokpSMLWf5STFZQRAD4mqhev
         mVUiWnX0clsCj7MJOy6DsRabFmwtCwR+SMv+jRNxlm8P44tO9sdUfVtdqUQFt85d0rd8
         lHcQagw9FaWEWu4nOfYd9f3v6IpMD9oCD99xSU6gNbgoH2f5LpV8VnlKYMnVuz3V8yhZ
         NRAnSeaN5VAOnRDlQa8Yw0XfsmGr1lL+xVzBH2/O/KC0JHvCn9b2AMyMMlOU+vbYd1rk
         +dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Us0ScZrMvHOFeUHt3wu7YFBQO7zkY9OXaUx/Vlx7/nA=;
        b=e+fMx61jFTibMsBaXQQC+LrQ1BE8NSaD8S+z8qbbXkvYPK5Sfl7uP7zdcWn2Vr0zz7
         cRGurrbkjH+3iLec31RA79g8pIUlO81dJiARiYAmd0mDeqFyfwQtem3B4ys+JiJLw6Bh
         qglNQeYLa0WlpC4n6XOKAPjWm0xi2gWW5AOMDHt/T1HtnGr6ael+tMZw0C4IvPq+rMv3
         x5x/lYGk1HRy6Kn17rUWG3w+XclKdlW5om2uLLU8qIUiQ3jXGvIOj452XPlpPKncIwj7
         ZUTJqVmNuE9Dg+jW2ZCb/VNYx9BuWZt0uECtdNRQ2COLyMWcaJIbeIGv+avcWgzAvAGy
         3MsA==
X-Gm-Message-State: APjAAAUxn6SgqWGVxanB1FIsOrwaVq1yQkrSoLE+glxZBagpvh/RdL7x
        3qmoSN22oAOh4azZZ7srZLyZnw==
X-Google-Smtp-Source: APXvYqw+LvbLoOTPBAjUSxC9hepXsEOVVyF8GfEyQ7tnid64OhYAkwk4YnaAvf6et2Qahm65DUMrRA==
X-Received: by 2002:a5d:8a0b:: with SMTP id w11mr203175iod.261.1558696265468;
        Fri, 24 May 2019 04:11:05 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.37])
        by smtp.gmail.com with ESMTPSA id y194sm1024771itb.34.2019.05.24.04.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:11:04 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        fweimer@redhat.com
Cc:     jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 0/3] close_range()
Date:   Fri, 24 May 2019 13:10:44 +0200
Message-Id: <20190524111047.6892-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This is v3 of this patchset.

This fixes a braino spotted by Oleg (/me tips proverbial hat) and splits
the implementation of close_range() into adding the actual syscall and
the wiring-up of the syscall itself as requested by Arnd. It also adds a
missing bump of __NR_compat_syscalls for arm64 that Arnd spotted.

For controversy around whether or not this is the greatest idea and api
ever I refer the avid reader to the comment section of LWN.

/* v2 */
In accordance with some comments by Linus and Al there's a
cond_resched() added to the close loop similar to what is done for
close_files().

A common helper pick_file() for __close_fd() and __close_range() has
been split out. This allows to only make a cond_resched() call when
filp_close() has been called similar to what is done in close_files().
Maybe that's not worth it. Jann mentioned that cond_resched() looks
rather cheap.

So it maybe that we could simply do:

while (fd <= max_fd) {
       __close_fd(files, fd++);
       cond_resched();
}

I also added a missing test for close_range(fd, fd, 0).

Thanks!
Christian

Christian Brauner (3):
  open: add close_range()
  arch: wire-up close_range()
  tests: add close_range() tests

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/file.c                                     |  62 +++++++-
 fs/open.c                                     |  20 +++
 include/linux/fdtable.h                       |   2 +
 include/linux/syscalls.h                      |   2 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/core/.gitignore       |   1 +
 tools/testing/selftests/core/Makefile         |   6 +
 .../testing/selftests/core/close_range_test.c | 142 ++++++++++++++++++
 27 files changed, 250 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/core/.gitignore
 create mode 100644 tools/testing/selftests/core/Makefile
 create mode 100644 tools/testing/selftests/core/close_range_test.c

-- 
2.21.0

