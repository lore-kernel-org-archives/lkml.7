Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EAC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B5C222CD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213615;
	bh=2NH2aPOnWgCz8AGVS9bfabIWQVJ7FDudN2JH3TKaiso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y3/soOOhby5qB3cyvEKch1gScZVzDunncCoWQyp4PEeCVWGlnjg9onkl35MhragjD
	 GM/fX7wLVhetGFWVOrqj2MZXyOyGZfw/jm4eOjHqOq/Eb1EcG10Nhb7QS5ydreJnAY
	 NzE2+NEIht8L/pGRe2CgF76GAb6hrMJjaJ0D7pU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbfKHLqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391376AbfKHLqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E764222C2;
        Fri,  8 Nov 2019 11:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213597;
        bh=2NH2aPOnWgCz8AGVS9bfabIWQVJ7FDudN2JH3TKaiso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWSXSJNbYxP7MOQYjsZ+rubEHBiGQR3gcgSllqZAWxTCsmQwGX9DBEutykZ3qxBi6
         3yEz/U5yKwa/mnbVhVBaZNpYthDAl6vxFsaNpvEDZjf6xQriUPlhIX9948Xej0UkhH
         ugC5lkuhGA/8RP+Xc8W9Wj32oPyKAR+5Xcb0/bAg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 37/64] signal: Always ignore SIGKILL and SIGSTOP sent to the global init
Date:   Fri,  8 Nov 2019 06:45:18 -0500
Message-Id: <20191108114545.15351-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 86989c41b5ea08776c450cb759592532314a4ed6 ]

If the first process started (aka /sbin/init) receives a SIGKILL it
will panic the system if it is delivered.  Making the system unusable
and undebugable.  It isn't much better if the first process started
receives SIGSTOP.

So always ignore SIGSTOP and SIGKILL sent to init.

This is done in a separate clause in sig_task_ignored as force_sig_info
can clear SIG_UNKILLABLE and this protection should work even then.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 2bb1f9dc86c7d..30914b3c76b21 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -71,6 +71,10 @@ static int sig_task_ignored(struct task_struct *t, int sig, bool force)
 
 	handler = sig_handler(t, sig);
 
+	/* SIGKILL and SIGSTOP may not be sent to the global init */
+	if (unlikely(is_global_init(t) && sig_kernel_only(sig)))
+		return true;
+
 	if (unlikely(t->signal->flags & SIGNAL_UNKILLABLE) &&
 	    handler == SIG_DFL && !(force && sig_kernel_only(sig)))
 		return 1;
-- 
2.20.1

