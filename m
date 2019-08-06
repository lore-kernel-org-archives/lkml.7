Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0E9C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5342A2189E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127568;
	bh=dOVw1+t0bk3hP66ZoMzkoKnp7lOeABUi7vUvl+BUYHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sd1Qd792dBbCjhY2tZay3T+wAMaAXkMN02bIaLktkzVks0Fy/CAvLV3b93czdLkX8
	 Rh3jsnC+kp/BX7wSNKreVzexW8i6kq9ces9do2kY8zh/aCz09OETd35wERaAHpP54m
	 tESUvSlqMh0CM6OUQXhpSRlN34A84DsOK8Y7YP2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfHFVhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfHFVhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:37:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3B121873;
        Tue,  6 Aug 2019 21:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127452;
        bh=dOVw1+t0bk3hP66ZoMzkoKnp7lOeABUi7vUvl+BUYHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5A+dABLZK9AsPEvbciht1i8kuqWXtm+NdeopY+toyCFP2mqRX4D/Mve48BDp5wVE
         hxFzknl1AAFx94zAotsS1lI7tRB9WSymIK//8RlsmOvPYZBY/0eOigaVzN/A3sVPm4
         vv2Yimg7H8qaDhSK884Kly0Cqv+7c6MbOvcI5SSY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 08/17] exit: make setting exit_state consistent
Date:   Tue,  6 Aug 2019 17:37:05 -0400
Message-Id: <20190806213715.20487-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213715.20487-1-sashal@kernel.org>
References: <20190806213715.20487-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian@brauner.io>

[ Upstream commit 30b692d3b390c6fe78a5064be0c4bbd44a41be59 ]

Since commit b191d6491be6 ("pidfd: fix a poll race when setting exit_state")
we unconditionally set exit_state to EXIT_ZOMBIE before calling into
do_notify_parent(). This was done to eliminate a race when querying
exit_state in do_notify_pidfd().
Back then we decided to do the absolute minimal thing to fix this and
not touch the rest of the exit_notify() function where exit_state is
set.
Since this fix has not caused any issues change the setting of
exit_state to EXIT_DEAD in the autoreap case to account for the fact hat
exit_state is set to EXIT_ZOMBIE unconditionally. This fix was planned
but also explicitly requested in [1] and makes the whole code more
consistent.

/* References */
[1]: https://lore.kernel.org/lkml/CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com

Signed-off-by: Christian Brauner <christian@brauner.io>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index d9394fcd0e2c3..d8fee3e1ec1f2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -694,9 +694,10 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
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
2.20.1

