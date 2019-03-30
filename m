Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD53C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9658218D9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gStoy4XW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfC3CNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:13:02 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33710 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbfC3CNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:13:02 -0400
Received: by mail-yw1-f73.google.com with SMTP id p73so2972043ywp.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 19:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ja0kZzqxxKAov08rxSFjoq9uqoPnfwCL9G8rzgiIods=;
        b=gStoy4XWlylFbDyJEt36O9HD8IwxKaUwaR6v0wTlLMzgYliKK7tjoW34TgZgStnX0q
         wDhaUPXhCG5/t2Btmuu85cLcE4bL5ORUNYmyt9JcDM40/iiqm/JRmYXjXoRdmMjlQ5FV
         FVHqLVfv86pbhW9w/zCwIAKCPSKBFBHNp1qxlVruIM7K5UZMR0pSvX6fUE9LwueYYIpg
         oS+TM9+JUhknxu2Gq4HEuQA0N19fTD0Bo2+sIYnWK6lK9YnTbtsPriKsjV/6ukdC6rLY
         TRHuRL96tbWfLbaqxzb0+s1/4du8FzX5jSicmSc6hMZ/aTJJzKuIY8siU43Zzc5PLn9l
         ZI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ja0kZzqxxKAov08rxSFjoq9uqoPnfwCL9G8rzgiIods=;
        b=USXpmeSjvlGmUP1AvvK2dWUfmwfd6lC5iKfUoZjTMn3gFISyivIZ0AHrWfrhH8aM9v
         kXBwx6TT04TXRcJ0vNPG2k+7VnC6vDHe8gaS5/56j8eoAp+mIckb3hWuJrhl1QzFcVsC
         oCv3Bw4WYfyIuOvbBXl/hacsqjOSaTtc72UD8ZhJTPFCV4xgsJzxsbFA7qeaH3e/vTxS
         Z9wykRqevThy2PhE+8pycFuK/AEdb6HD0YtDP7omakvtpJxt7YqNUZWHAoTftbBZGnan
         5aGqEGKYUd1/EzFzR5h2I17XrLG8fmE6vgv6MDEWc3pcBu4dwqnZvlYBJ+YLQQotqka7
         tlMA==
X-Gm-Message-State: APjAAAUW45+RN3A7eg8bf8gO9Nv3nwd0GR9d7168eLplUUbdz42KGEKD
        JMDa7GstvW2XTz9T/XkQkL9WauarKg==
X-Google-Smtp-Source: APXvYqz/zOD7o54HigpHdUUB2ikgGcqbskLH3aenI1KxUEIF8uuZUKdcXwpVpv1Rt8OSa3BgelFK+q3YvA==
X-Received: by 2002:a81:4e8e:: with SMTP id c136mr2541416ywb.9.1553911981854;
 Fri, 29 Mar 2019 19:13:01 -0700 (PDT)
Date:   Sat, 30 Mar 2019 03:12:32 +0100
Message-Id: <20190330021232.191205-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] signal: don't silently convert SI_USER signals to non-current pidfd
From:   Jann Horn <jannh@google.com>
To:     Christian Brauner <christian@brauner.io>, jannh@google.com
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current sys_pidfd_send_signal() silently turns signals with explicit
SI_USER context that are sent to non-current tasks into signals with
kernel-generated siginfo.
This is unlike do_rt_sigqueueinfo(), which returns -EPERM in this case.
If a user actually wants to send a signal with kernel-provided siginfo,
they can do that with pidfd_send_signal(pidfd, sig, NULL, 0); so allowing
this case is unnecessary.

Instead of silently replacing the siginfo, just bail out with an error;
this is consistent with other interfaces and avoids special-casing behavior
based on security checks.

Fixes: 3eb39f47934f ("signal: add pidfd_send_signal() syscall")
Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/signal.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b7953934aa99..f98448cf2def 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3605,16 +3605,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		if (unlikely(sig != kinfo.si_signo))
 			goto err;
 
+		/* Only allow sending arbitrary signals to yourself. */
+		ret = -EPERM;
 		if ((task_pid(current) != pid) &&
-		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)) {
-			/* Only allow sending arbitrary signals to yourself. */
-			ret = -EPERM;
-			if (kinfo.si_code != SI_USER)
-				goto err;
-
-			/* Turn this into a regular kill signal. */
-			prepare_kill_siginfo(sig, &kinfo);
-		}
+		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
+			goto err;
 	} else {
 		prepare_kill_siginfo(sig, &kinfo);
 	}
-- 
2.21.0.392.gf8f6787159e-goog

