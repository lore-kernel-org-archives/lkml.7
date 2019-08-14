Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98009C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BCD206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfHNLkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:40:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34565 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfHNLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:40:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so110814994wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yR5kMB9UYE/K6gpt0ZcJAvitmz+HTDZj5Nbsm04f4qw=;
        b=a+bP7qvFyzp0/DetDk22FzUVO5pIdxkh9Q7uJDrZN3heGZG5eJV/6r6I1x/IZSCdGC
         9uEwyXlZ5awLL4Uz4//U4LK0/WfdWpspfCHMuM+12tGOAnC8zfM8ua3pTkK6ebumRqOm
         Nmu8AjvJ/HowNG4YJaPxVbJPWiS6EJdix4fXHPGRfpovKk3TsSlvxapHOiQwuJ5DhTfV
         W8aMOmRzHHpXBqBheqONtt5umbbWCJ2RssANe1bNB15d3lB43FWXAI7QOgQap3k7ALZD
         RgvTUBpboxE/FWzRWcUofuywA6ZN703mN097XcZsKTamx/UinNZ+184KEj3zONJ/4AxP
         y9Tw==
X-Gm-Message-State: APjAAAVTuPa3XZalxZwbeQ46+Ll3PDBSJTYJxV2Y0HBLq4s1iPJsCgnD
        sI6nnjv2MG2Yd7ZXzvQtqjKeV7fgNId1QQ==
X-Google-Smtp-Source: APXvYqzwp0RaioJyYRmVpeWZnYkBV7F5gqSER+lp8YI+I1CAV3USJ7FynzorTlWgopgTW7Hf10FHoQ==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr10204792wrv.345.1565782803290;
        Wed, 14 Aug 2019 04:40:03 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id j9sm8924705wrx.66.2019.08.14.04.40.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 04:40:02 -0700 (PDT)
From:   christian.brauner@ubuntu.com
To:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Cc:     oleg@redhat.com, alistair23@gmail.com, ebiederm@xmission.com,
        arnd@arndb.de, dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: [PATCH v1 1/1] waitid: Add support for waiting for the current process group
Date:   Wed, 14 Aug 2019 13:38:22 +0200
Message-Id: <20190814113822.9505-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814113822.9505-1-christian.brauner@ubuntu.com>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814113822.9505-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

It was recently discovered that the linux version of waitid is not a
superset of the other wait functions because it does not include
support for waiting for the current process group.  This has two
downsides.  An extra system call is needed to get the current process
group, and a signal could come in between the system call that
retrieved the process gorup and the call to waitid that changes the
current process group.

Allow userspace to avoid both of those issues by defining
idtype == P_PGID and id == 0 to mean wait for the caller's process
group at the time of the call.

Arguments can be made for using a different choice of idtype and id
for this case but the BSDs already use this P_PGID and 0 to indicate
waiting for the current process's process group.  So be nice to user
space programmers and don't introduce an unnecessary incompatibility.

Some people have noted that the posix description is that
waitpid will wait for the current process group, and that in
the presence of pthreads that process group can change.  To get
clarity on this issue I looked at XNU, FreeBSD, and Luminos.  All of
those flavors of unix waited for the current process group at the
time of call and as written could not adapt to the process group
changing after the call.

At one point Linux did adapt to the current process group changing but
that stopped in 161550d74c07 ("pid: sys_wait... fixes").  It has been
over 11 years since Linux has that behavior, no programs that fail
with the change in behavior have been reported, and I could not
find any other unix that does this.  So I think it is safe to clarify
the definition of current process group, to current process group
at the time of the wait function.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Alistair Francis <alistair23@gmail.com>
Cc: Zong Li <zongbox@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: GNU C Library <libc-alpha@sourceware.org>
---
v1:
- Christian Brauner <christian.brauner@ubuntu.com>:
  - move find_get_pid() calls into the switch statements to minimize
    merge conflicts with P_PIDFD changes and adhere to coding style
    discussions we had for P_PIDFD
---
 kernel/exit.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 5b4a5dcce8f8..e70083b14f31 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1576,19 +1576,23 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 		type = PIDTYPE_PID;
 		if (upid <= 0)
 			return -EINVAL;
+
+		pid = find_get_pid(upid);
 		break;
 	case P_PGID:
 		type = PIDTYPE_PGID;
-		if (upid <= 0)
+		if (upid < 0)
 			return -EINVAL;
+
+		if (upid == 0)
+			pid = get_pid(task_pgrp(current));
+		else
+			pid = find_get_pid(upid);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (type < PIDTYPE_MAX)
-		pid = find_get_pid(upid);
-
 	wo.wo_type	= type;
 	wo.wo_pid	= pid;
 	wo.wo_flags	= options;
-- 
2.22.0

