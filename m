Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FEC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60ED2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202763;
	bh=cVutxDFDEdt+LDlO09uWyo/GMeEHNCJu64x1A1e4IPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uzzXorTZzgg98JUWODKHxnXWr9VJL7roXxt6Ra8sAfUo7ijSM63k+/PBhA6e8KIRt
	 B+5PSkXra9zq3lEd7k7Nm7Fw+J4cIHQMd27Fk271XUOK5RRIqeOWuj1AaON27c2klE
	 gR14Tr0Y8VDCvN8WBwUNBmum1TmaNCM/GsAHPQjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbfGOO7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390049AbfGOOTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:19:12 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544BC205F4;
        Mon, 15 Jul 2019 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200351;
        bh=cVutxDFDEdt+LDlO09uWyo/GMeEHNCJu64x1A1e4IPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6NtQOBLpLZrZFsWRIe5w/mn0SjCeHDU7+Ij99dyw8iq6s0TIzJ8Mxy04jJVgY1CK
         N02tsn8NbqFvY8bMZJsT6vWeN3QxeBtRMUal0CPW/5U7lVjvNbzfm2nNmbzl2SIxE0
         hY8SigP1Do/ELCrLHryH9qjvGBRFVjAcqz26QEyo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Lezcano <daniel.lezcano@free.fr>,
        Serge Hallyn <serge@hallyn.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 021/158] signal/pid_namespace: Fix reboot_pid_ns to use send_sig not force_sig
Date:   Mon, 15 Jul 2019 10:15:52 -0400
Message-Id: <20190715141809.8445-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit f9070dc94542093fd516ae4ccea17ef46a4362c5 ]

The locking in force_sig_info is not prepared to deal with a task that
exits or execs (as sighand may change).  The is not a locking problem
in force_sig as force_sig is only built to handle synchronous
exceptions.

Further the function force_sig_info changes the signal state if the
signal is ignored, or blocked or if SIGNAL_UNKILLABLE will prevent the
delivery of the signal.  The signal SIGKILL can not be ignored and can
not be blocked and SIGNAL_UNKILLABLE won't prevent it from being
delivered.

So using force_sig rather than send_sig for SIGKILL is confusing
and pointless.

Because it won't impact the sending of the signal and and because
using force_sig is wrong, replace force_sig with send_sig.

Cc: Daniel Lezcano <daniel.lezcano@free.fr>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Fixes: cf3f89214ef6 ("pidns: add reboot_pid_ns() to handle the reboot syscall")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/pid_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 2a2ac53d8b8b..95271f180687 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -325,7 +325,7 @@ int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 	}
 
 	read_lock(&tasklist_lock);
-	force_sig(SIGKILL, pid_ns->child_reaper);
+	send_sig(SIGKILL, pid_ns->child_reaper, 1);
 	read_unlock(&tasklist_lock);
 
 	do_exit(0);
-- 
2.20.1

