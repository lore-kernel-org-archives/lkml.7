Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA97C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90192071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418745;
	bh=SFfvz0Kc7W4a0FIGmtaHxaA83yiAFH8FLxKr99BQamc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2UZteBm+SfktlZ8DiQW0mICgeqfzmArjj1C6C1R/4gzQtn6g4h3NanoIT+upg4me
	 jvtyPoleIT+lB2fYa3CT6rxwsCz76j1gn3FJn/tf6C91UUYPSoO+9xLED28h+vEfEU
	 15SIDnmp7dNGBYQTzTvnfYFdRVesqjbben5K+grk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfKVKcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:32:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbfKVKcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:32:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF102071B;
        Fri, 22 Nov 2019 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418739;
        bh=SFfvz0Kc7W4a0FIGmtaHxaA83yiAFH8FLxKr99BQamc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3MEFj2jAVMjEuHVwnelGL3TIjvJEgdEpfbkLYDOERZzzKbX+iQB8hRO6WbY5Y375
         G4axvCuxg3r+tzHeJ/WDbwRN7RRRXcx3o4K7o/ngiDHBgPCnL3Vc8mXbF7bCjYo33D
         jhA3JHXRqkWOCDaVSROEZjhE30ILRD50w8AcC8XM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 036/159] signal: Always ignore SIGKILL and SIGSTOP sent to the global init
Date:   Fri, 22 Nov 2019 11:27:07 +0100
Message-Id: <20191122100731.907587368@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

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
index 072fd152ab01e..3095b2309876d 100644
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



