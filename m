Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C4C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6906620657
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cUYNkNwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFVTag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 15:30:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfFVTag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 15:30:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MJUTVD2308835
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 12:30:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MJUTVD2308835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561231830;
        bh=Q7Laq+aTn97e+dN94p3a4VY8Nsi04sZzpxyJiUSSu74=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cUYNkNwtpYiR5koWGcRuaXPm2zQzhzGkJieWcWYAMB8EvdeoXbyccIBJ+ycWj1fiG
         w+22+RoWI+a7Wp3pmxvyZxleSb+hxQaGAHoa+su7MXC9n8ziH2X4ZyWdNx/v135KYU
         61nUl6CWm9E1XMUDeU8i7hW7HWb3Weo4OgDzGGynTllUZSt3pCJ8TK97ME3UUIBjW8
         C0Nh/lEE3r23gUzzpd475/JY8tLEyACLCYh6DUtbIxmwD0r0JTzwzSDpMk7yFZaHET
         I2HCIOHTgl3zPUOVEb7IssZhvGfPQcdk1QWWJTItOl5bIU3H4UU47MQpXKyWw/FB1Z
         2ZNuct+bXf7MQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MJUTcx2308830;
        Sat, 22 Jun 2019 12:30:29 -0700
Date:   Sat, 22 Jun 2019 12:30:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-12063d431078be73d11cb5e48a17c6db5f0d8254@git.kernel.org>
Cc:     hpa@zytor.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20190621143643.25649-2-bigeasy@linutronix.de>
References: <20190621143643.25649-2-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Remove "it_signal = NULL"
 assignment in itimer_delete()
Git-Commit-ID: 12063d431078be73d11cb5e48a17c6db5f0d8254
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  12063d431078be73d11cb5e48a17c6db5f0d8254
Gitweb:     https://git.kernel.org/tip/12063d431078be73d11cb5e48a17c6db5f0d8254
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 21 Jun 2019 16:36:42 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 12:14:22 +0200

posix-timers: Remove "it_signal = NULL" assignment in itimer_delete()

itimer_delete() is invoked during do_exit(). At this point it is the
last thread in the group dying and doing the clean up.
Since it is the last thread in the group, there can not be any other
task attempting to lock the itimer which means the NULL assignment (which
avoids lookups in __lock_timer()) is not required.

The assignment and comment was copied in commit 0e568881178ff ("[PATCH]
fix posix-timers to have proper per-process scope") from
sys_timer_delete() which was/is the syscall interface and requires the
assignment.

Remove the superfluous ->it_signal = NULL assignment.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190621143643.25649-2-bigeasy@linutronix.de

---
 kernel/time/posix-timers.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 29176635991f..caa63e58e3d8 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -990,11 +990,6 @@ retry_delete:
 		goto retry_delete;
 	}
 	list_del(&timer->list);
-	/*
-	 * This keeps any tasks waiting on the spin lock from thinking
-	 * they got something (see the lock code above).
-	 */
-	timer->it_signal = NULL;
 
 	unlock_timer(timer, flags);
 	release_posix_timer(timer, IT_ID_SET);
