Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93451C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691B721670
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B6FDdLEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfE1UXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:23:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49233 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfE1UXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:23:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SKNFUo2218253
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 13:23:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SKNFUo2218253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559074995;
        bh=dbKBuz+yvTlisXWUqNvZXnegXSorIEnr5uNUAaWn2zA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=B6FDdLEtiJ0huLjpyftYEi1iNDKb52YXlYmYLYwtLTIHlod7qZp7Pc/WcFX7NM80n
         XxG3P/1xZGu7C3lkeOil0QV2D84qeje21yrx2BYBKM9yFiiA8PZyzE+Jv9X1u+obuW
         QYFdQuRiTDfwshxIZeACQfhYSk69pXHVk2v+PtxYj2KVn/hanBMEH/0ulLASvJWc0R
         HU8qQNyNNlgttMdEPKaKqjsvXELbRTzY1gwiRuKnIkrs3kUgmZ7VvZQpwC8DlT9Dkt
         8I6Mo1xjoq5CCbS5Z1kfJ6MdC0Kramn5+6zcAacNxEiaKFGJCfQw3NJRBPtJxQ9DMy
         zq9oxoMgYlerg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SKNFmH2218245;
        Tue, 28 May 2019 13:23:15 -0700
Date:   Tue, 28 May 2019 13:23:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Kosina <tipbot@zytor.com>
Message-ID: <tip-f560201102035ba9def2fc21827dd34690dd126e@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        jpoimboe@redhat.com, jkosina@suse.cz, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jpoimboe@redhat.com,
          peterz@infradead.org, jkosina@suse.cz
In-Reply-To: <nycvar.YFH.7.76.1905282128100.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282128100.1962@cbobk.fhfr.pm>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] cpu/hotplug: Fix notify_cpu_starting() reference
 in bringup_wait_for_ap()
Git-Commit-ID: f560201102035ba9def2fc21827dd34690dd126e
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

Commit-ID:  f560201102035ba9def2fc21827dd34690dd126e
Gitweb:     https://git.kernel.org/tip/f560201102035ba9def2fc21827dd34690dd126e
Author:     Jiri Kosina <jkosina@suse.cz>
AuthorDate: Tue, 28 May 2019 21:31:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 28 May 2019 12:59:03 -0700

cpu/hotplug: Fix notify_cpu_starting() reference in bringup_wait_for_ap()

bringup_wait_for_ap() comment references cpu_notify_starting(), but the 
function is actually called notify_cpu_starting(). Fix that.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/nycvar.YFH.7.76.1905282128100.1962@cbobk.fhfr.pm

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
