Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6871CC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3326321924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214797;
	bh=rLuchZSaVl6hL2AxWE69LD1xaNk+KTTrNRmLnVGEBPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AW1Y5jrJHdbac/b0gX/j4TPkFihkcVUojp1S0BsHeoxewegTYyvb1ot7YcnjMvOe3
	 ePN2xi49EYV5SjO9LdJjrfP4OGJ5msMOYDrnomBS9wrkgGxiGVLrEaVhCMtqQCzwZ9
	 2FXvEAevdtHqgzo0xq2v+XYZ9DjHaY5WWGJTPSC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391841AbfKHMGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:06:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732686AbfKHLlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C720D21D82;
        Fri,  8 Nov 2019 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213269;
        bh=rLuchZSaVl6hL2AxWE69LD1xaNk+KTTrNRmLnVGEBPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFj2lXxav6F9ATeQslynt6WTbtmrfkDbjStAQTfUvm0qIAz9UNGpI5SKb9GRK/N0J
         1Fc0unH/vnySnTzD90paemqOUHKNIEjyi1AmGmZiVnObuAI7fi7dExOoK6BxRuiVZn
         JCcmLKbZTW3IHI/n+YAT9RczQQAu+crxQVR0vfb4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 132/205] signal: Properly deliver SIGILL from uprobes
Date:   Fri,  8 Nov 2019 06:36:39 -0500
Message-Id: <20191108113752.12502-132-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 55a3235fc71bf34303e34a95eeee235b2d2a35dd ]

For userspace to tell the difference between a random signal and an
exception, the exception must include siginfo information.

Using SEND_SIG_FORCED for SIGILL is thus wrong, and it will result
in userspace seeing si_code == SI_USER (like a random signal) instead
of si_code == SI_KERNEL or a more specific si_code as all exceptions
deliver.

Therefore replace force_sig_info(SIGILL, SEND_SIG_FORCE, current)
with force_sig(SIG_ILL, current) which gets this right and is
shorter and easier to type.

Fixes: 014940bad8e4 ("uprobes/x86: Send SIGILL if arch_uprobe_post_xol() fails")
Fixes: 0b5256c7f173 ("uprobes: Send SIGILL if handle_trampoline() fails")
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 578d4ac54484f..c173e4131df88 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1858,7 +1858,7 @@ static void handle_trampoline(struct pt_regs *regs)
 
  sigill:
 	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
-	force_sig_info(SIGILL, SEND_SIG_FORCED, current);
+	force_sig(SIGILL, current);
 
 }
 
@@ -1974,7 +1974,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 
 	if (unlikely(err)) {
 		uprobe_warn(current, "execute the probed insn, sending SIGILL.");
-		force_sig_info(SIGILL, SEND_SIG_FORCED, current);
+		force_sig(SIGILL, current);
 	}
 }
 
-- 
2.20.1

