Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B37C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8982D2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="eCcTDjdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbfDRKTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:19:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34834 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388583AbfDRKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:19:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id y67so1363640ede.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NoYfP/4JagMnvf0EArCfUuEkvYpv8x1mNHllZQwkRk4=;
        b=eCcTDjdQXg5fEhjTi8A4isM8PV6Y0S5ES1TXDDvNVfs506By59TG3tJEmhDAFISrha
         /ob8MkHkuSP0nI2xLuMoKc5dJMbCwkeNQ5x/t7MEGd9uOed/1GPOxERTjgBkjzbo9p+y
         9mM1vO0a6RPtLxJc/UQXWpi05KsaLGhO+X7SdzBf0w8joKhP1WIgQdNNux09YVmPtPJ1
         PuPRP6RlEf1tEuAgLMGgowauKz/YjTitCVvpzkBUVygDcUtqHiPD2dvsH4IClo1fErwB
         BYL6yURDCFsGdbGKSuxovEpcqPkjdqsRg1Y/ZwSgRSN37Uo3dCJ4aM/00rp/DJZgPvoy
         3Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NoYfP/4JagMnvf0EArCfUuEkvYpv8x1mNHllZQwkRk4=;
        b=SuohsJKj9QcmAyqYXxliUsokYc99oOUHnXXi9p952tq75mmfXv3ZU8IirwqcoiOIGY
         B7qZqCLBAD1AeUrOTjc+DRnv9yx4I+TlqX/+liRY4TYsVoj+BYqhzjywZtNpmrMFuDEk
         PUEjs2iccmGzZPgNJWAKimLM9w5uKb8g1/scYEjwCV+nb21ti/XGz8CcBUQdOrKN+vpd
         vkYEk0ountJqranRJjWkd7lCLExGHRRke8aUZ6S22bUXvxCY5BkMVHFxosXZvt1grz0l
         ihKHlCCes1xYr7cfTaNWehuTup+26cYXfX+HqwCVFDiOvPa9ZMjxFoW9UIRL30PKmGMR
         JvGw==
X-Gm-Message-State: APjAAAWIZ48N3mP1Qyg3Ajtbsk7tLZa5MldNtdlJ1tTNfUcXHn3v/7IR
        PCNV0yqBHmuOFjZ5c6HZqwOBdw==
X-Google-Smtp-Source: APXvYqz8bRAM2DP6vQhzGWaeh6TyUsR6XYsU9itUUlVsYgbw95n5gsNGlm5z8rv2n/WiBPDPPqmgkA==
X-Received: by 2002:a50:fc13:: with SMTP id i19mr16678184edr.35.1555582764293;
        Thu, 18 Apr 2019 03:19:24 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id 31sm400479edf.18.2019.04.18.03.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:19:23 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, oleg@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jann@thejh.net>
Subject: [PATCH v2 3/5] signal: use fdget() since we don't allow O_PATH
Date:   Thu, 18 Apr 2019 12:18:39 +0200
Message-Id: <20190418101841.4476-4-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418101841.4476-1-christian@brauner.io>
References: <20190418101841.4476-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the original commit for pidfd_send_signal() we don't allow to
signal processes through O_PATH file descriptors since it is semantically
equivalent to a write on the pidfd. We already correctly error out right
now and return EBADF if an O_PATH fd is passed. This is because we use
file->f_op to detect whether a pidfd is passed and O_PATH fds have their
file->f_op set to empty_fops in do_dentry_open() and thus fail the test.
Thus, there is no regression. It's just semantically correct to use fdget()
and return an error right from there instead of taking a reference and
returning an error later.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jann@thejh.net>
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
/* changelog */
v1: patch not present
v2:
- Oleg Nesterov <oleg@redhat.com>:
  - split out from following patch since the s/fdget_raw()/fdget()/
    replacement is a fix unrelated to the theme of the following patch
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index f98448cf2def..227ba170298e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3581,7 +3581,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (flags)
 		return -EINVAL;
 
-	f = fdget_raw(pidfd);
+	f = fdget(pidfd);
 	if (!f.file)
 		return -EBADF;
 
-- 
2.21.0

