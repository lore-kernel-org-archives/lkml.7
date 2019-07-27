Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF79C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 22:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83112147A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 22:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Q4rMJQtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbfG0WZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 18:25:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51471 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfG0WZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 18:25:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so50733127wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pt2DS+bSnWFp1N1RLTwE7bapb13KvM6fGjZ/XnqtFGA=;
        b=Q4rMJQtc2YDhP2Z5DDMbLiVzwH/c/RRzXPjT4W7XQMY7+LABrEKoMQlq5UbuH/8O9/
         NR0zPuQHgQFh1glKSDl8KQzJm7+QVh8DzWnhUEPIRugxX8ILk6SnVrBZ2L07u9eMLMaf
         9iJY3JVU55esX4h92K1Xg63G+26b9enZIXP8hF07/GsDpASa0YiVx1Dzmuaxt7FwP9In
         JAMDOhCBkntus9al2YVSRKw4WAjQdh5clBG5xkz7sPhH1oicHzFDKLynctMKUQJewNWA
         ZQCjdCl/6uA3sX56HuyVNSymQEuY1QYP0CN4z8DV8xWlUaI59QUUD1kdkKxabJbDjSvW
         FyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pt2DS+bSnWFp1N1RLTwE7bapb13KvM6fGjZ/XnqtFGA=;
        b=Vgg+bMBORPWYG3yAi+cBAUp39fMWJK3XtoirN8mY6SEL2dCpeHrYK8y15S0tXAb+4E
         1pavu5JbO3G1/GYXttRhmtLoL3MLgl7QBa/6k/qUwOu1tVGj0Nay0LHX/1QP4MX7Iz82
         KXDOHmtVS5xOrcSQ3219S+Exel697f3Po7HwVIBFI6rQKd6fPHUo2NF1D/36eopdwJwj
         8J2Sx1btZ0chNTEr5PzX1JVvByVGtxpEOhjNB6lL7KjPF9LQm1eQWFNI30yT/v79fVGg
         SCYtkqcqVusvbqyloj0gRmZoxh6HKLGpJlpE5jlb1xK/VoaEp5o+r3f2IfUMpOOPle79
         eO8A==
X-Gm-Message-State: APjAAAWphHHTwKpcmG6jlQlZE125eGFMkpzJrC/8pGQYlU6Fk9Uzptj4
        dNjBpoMdUjS/hN713es9xUoFmyTCI18=
X-Google-Smtp-Source: APXvYqxmBf+TeChmnc8Uf4bHS6cpS/XAllW9J91hKoLsQSZkNVqtKkatb1J5RWEw53mHQiWaS8MqXw==
X-Received: by 2002:a1c:a909:: with SMTP id s9mr90365270wme.20.1564266318504;
        Sat, 27 Jul 2019 15:25:18 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id g8sm54978721wmf.17.2019.07.27.15.25.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 15:25:17 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com,
        torvalds@linux-foundation.org
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, kernel-team@android.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 0/2] pidfd: waiting on processes through pidfds
Date:   Sun, 28 Jul 2019 00:22:28 +0200
Message-Id: <20190727222229.6516-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

/* v3 */
This adds the ability to wait on processes using pidfds. This is one of
the few missing pieces to make it possible to manage processes using
only pidfds.

Now major changes have occured since v2. The only thing that was changed
has been to move the translation of a pidfd into a struct pid to a
dedicated helper that also does a get_pid() on it to keep the exit code
identical for all switch cases.
I've also added a test to verify that we correctly fail when an invalid
file descriptor is passed.

The core patch for waitid is pleasantly small. The largest change is
caused by adding proper tests for waitid(P_PIDFD).

/* v2 */
Link: https://lore.kernel.org/lkml/20190727085201.11743-1-christian@brauner.io

/* v1 */
Link: https://lore.kernel.org/lkml/20190726093934.13557-1-christian@brauner.io

/* v0 */
Link: https://lore.kernel.org/lkml/20190724144651.28272-1-christian@brauner.io

Christian

Christian Brauner (2):
  pidfd: add P_PIDFD to waitid()
  pidfd: add pidfd_wait tests

 include/linux/pid.h                        |   4 +
 include/uapi/linux/wait.h                  |   1 +
 kernel/exit.c                              |  33 ++-
 kernel/fork.c                              |   8 +
 kernel/signal.c                            |   7 +-
 tools/testing/selftests/pidfd/pidfd.h      |  25 ++
 tools/testing/selftests/pidfd/pidfd_test.c |  14 --
 tools/testing/selftests/pidfd/pidfd_wait.c | 258 +++++++++++++++++++++
 8 files changed, 331 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_wait.c

-- 
2.22.0

