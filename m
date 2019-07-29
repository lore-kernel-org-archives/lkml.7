Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A55AC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BBB20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gUuXkOS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbfG2Q2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:28:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42535 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbfG2Q23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:28:29 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so90951474iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHVMtSjxHblhx8srqB8OuNrRbChIr9eVS1c++J6kqsE=;
        b=gUuXkOS07DLB8rjER8sOfxYBZ+PMPgw7mBd1QVP1d65kxP/UIs2709LyQoUtAXNzNv
         J3MmeaV+fCaVKcet3Un0AFU2HUO+1a2cTxpyEIAX2Enpo3OBBsFYJEU/VV3UeUo1gtNY
         PoWQUb1d/KjvGocN+bLnYjfV2U3TO9FNzIMJFCwo0FWCLHBa0HuON7k/Akw/dNzZDh7v
         ZgbjHEAuwJoLqBk1/bezqbp3ewiO8MeMfsuVX2KGfBjzvhLA7X2pDloMS0tRzXJDzZ2B
         d4wmWv9q46Ypwxs/o5sD+gGYQrbjfeyf0Y84jBWa1dW8MabeWz13NApFWdqFValIBtVl
         +zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHVMtSjxHblhx8srqB8OuNrRbChIr9eVS1c++J6kqsE=;
        b=HsAFCCLOSjtuTme+fzliIZwW6ANBci4h2liYfAK79DGgfcsxssVE/zL5P6gOdh1MCX
         03EKw5B4pYeKyJsg29ZOhfmrqmCexczRYfSCSxT7n4JXRhaGGrrwDvchNyo3BdHQ0SxD
         yWQ9kc+HSx2YSgQURKZneCk4R8BttEEM5UyNKm5dkx2uY9rVgEIiOtW3n3xR3ICwsJOM
         QLBirBr2h6UXIsexggAU0IwCez2kgvvpAT9IFL8VEDzH6z0Nl7DkwpBTw4f3iQZ3hkuA
         HH2z/0oGXhS7tgXR3BnLf5YbdwAdGSci74BcPfIU6w7CNCiKN7zEcsJeXdrwKebYQDka
         l1uQ==
X-Gm-Message-State: APjAAAVb9O/ULq+uDwvAQ9Chk6o234f0FeISiesKXWPWztMme6gDRjV+
        SxwBzluPjezKNOpQLsWab7s=
X-Google-Smtp-Source: APXvYqyskFjQclHZ6gnHk7M17Uzais67Lqu10XVHEYQYCYjkRKzKm2IR24VvJaPj4kAUd4cuQvh/Pg==
X-Received: by 2002:a02:8814:: with SMTP id r20mr17712166jai.115.1564417708655;
        Mon, 29 Jul 2019 09:28:28 -0700 (PDT)
Received: from localhost.localdomain ([162.223.5.124])
        by smtp.gmail.com with ESMTPSA id l11sm45420026ioj.32.2019.07.29.09.28.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 09:28:27 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     oleg@redhat.com, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, tj@kernel.org, tglx@linutronix.de,
        prsood@codeaurora.org, avagin@gmail.com,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] exit: make setting exit_state consistent
Date:   Mon, 29 Jul 2019 18:27:57 +0200
Message-Id: <20190729162757.22694-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit [1] we unconditionally set exit_state to EXIT_ZOMBIE before
calling into do_notify_parent(). This was done to eliminate a race when
querying exit_state in do_notify_pidfd().
Back then we decided to do the absolute minimal thing to fix this and
not touch the rest of the exit_notify() function where exit_state is
set.
Since this fix has not caused any issues change the setting of
exit_state to EXIT_DEAD in the autoreap case to account for the fact hat
exit_state is set to EXIT_ZOMBIE unconditionally. This fix was planned
but also explicitly requested in [2] and makes the whole code more
consistent.

/* References */
[1]: b191d6491be6 ("pidfd: fix a poll race when setting exit_state")
[2]: https://lore.kernel.org/lkml/CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 kernel/exit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 4436158a6d30..5b4a5dcce8f8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -734,9 +734,10 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 		autoreap = true;
 	}
 
-	tsk->exit_state = autoreap ? EXIT_DEAD : EXIT_ZOMBIE;
-	if (tsk->exit_state == EXIT_DEAD)
+	if (autoreap) {
+		tsk->exit_state = EXIT_DEAD;
 		list_add(&tsk->ptrace_entry, &dead);
+	}
 
 	/* mt-exec, de_thread() is waiting for group leader */
 	if (unlikely(tsk->signal->notify_count < 0))
-- 
2.22.0

