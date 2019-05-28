Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9635C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E31208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559071914;
	bh=v6V1Pzozk9erqFo+opgFOxqVB5yhH9oE+B7kiFIuhmU=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=eN83M/8P589t32CJY6ZScImy7v9QzgaBY4Tf65qKFUNqtN0otiXBxluwKOzHYx1sM
	 D2DDrceFnbPWWt7NRN6hhb12kd7+QqH4zzaOggpvJUUh38Sc0mIF7KCh4FW9xRsdUF
	 rOoDp8Ff9B4Jl/0aXCPdsT48n0PifaMEhQQnXWH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfE1Tbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbfE1Tbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:31:53 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6898208C3;
        Tue, 28 May 2019 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559071912;
        bh=v6V1Pzozk9erqFo+opgFOxqVB5yhH9oE+B7kiFIuhmU=;
        h=Date:From:To:cc:Subject:From;
        b=v3Wlk1sYcIPkkfSeKXCOQq5OeV5qTrOt7JDRLfREEcSf0Xoq0GWu7wEAeRYWIRmLj
         T/NHyIwV3s6sGTr4KRdUb6vAHNxd6bVJe/Srm6Jg7ZWooKzq0dot6DeQN0BeuLtw0a
         Iw9XBv7LKIE0fwhxSDhI0ZpP+sCryuVyHYpRbjyk=
Date:   Tue, 28 May 2019 21:31:49 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] cpu/hotplug: fix notify_cpu_starting() reference in
 bringup_wait_for_ap()
Message-ID: <nycvar.YFH.7.76.1905282128100.1962@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

bringup_wait_for_ap() comment references cpu_notify_starting(), but the 
function is actually called notify_cpu_starting(). Fix that.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f2ef10460698..be82cbc11a8a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -522,7 +522,7 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	/*
 	 * SMT soft disabling on X86 requires to bring the CPU out of the
 	 * BIOS 'wait for SIPI' state in order to set the CR4.MCE bit.  The
-	 * CPU marked itself as booted_once in cpu_notify_starting() so the
+	 * CPU marked itself as booted_once in notify_cpu_starting() so the
 	 * cpu_smt_allowed() check will now return false if this is not the
 	 * primary sibling.
 	 */

-- 
Jiri Kosina
SUSE Labs

