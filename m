Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DCFC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54312218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142477;
	bh=6MASBMvSjedbUBKnlD71QlaSd44QwcHpO8AQ3LfEVJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=coLa7DWh8JRuJNHmCmu4ccmJ1XL05fHrxH0394veQviBuP0J9L1uLBSHxSy1cfXjd
	 2n512ZJp5sACmqj63LxoGM/xtWDFFGRG0hvHCXEvMHEPIWwrdkjWHNHP1rpMKSRDer
	 shUPtVYnmHfKnhL+1I5jVsR7EYAOb9v0GRcxZ3ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfKSFr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731276AbfKSFrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:47:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1135521783;
        Tue, 19 Nov 2019 05:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142467;
        bh=6MASBMvSjedbUBKnlD71QlaSd44QwcHpO8AQ3LfEVJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=af5zeFcAfQjDT4rmEV80mCpsX9pPLwo/KN+JFbi90YWmQgdk5988NAsxBJP48qQ/F
         kWjTBCsUbaHFmtnZi6sNMyDyCexF5sYl8hELFiuPrVEaKbWnSVAGeMn+4iEIGIPcmV
         gQWrmekzcmSKKpuVfcFj6JVoDVCSVcwet51suR2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 092/239] signal: Properly deliver SIGILL from uprobes
Date:   Tue, 19 Nov 2019 06:18:12 +0100
Message-Id: <20191119051320.368558389@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

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
index 01941cffa9c2f..c74fc98262508 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1854,7 +1854,7 @@ static void handle_trampoline(struct pt_regs *regs)
 
  sigill:
 	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
-	force_sig_info(SIGILL, SEND_SIG_FORCED, current);
+	force_sig(SIGILL, current);
 
 }
 
@@ -1970,7 +1970,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 
 	if (unlikely(err)) {
 		uprobe_warn(current, "execute the probed insn, sending SIGILL.");
-		force_sig_info(SIGILL, SEND_SIG_FORCED, current);
+		force_sig(SIGILL, current);
 	}
 }
 
-- 
2.20.1



