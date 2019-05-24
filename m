Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10397C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE4620879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vl27+EdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389246AbfEXIAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:00:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388996AbfEXIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:00:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O7xOm5115005
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 00:59:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O7xOm5115005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558684764;
        bh=gR+sVOfv9g9vi8Nv64InJyGxDz7fDw8ERv85hAVYXQM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vl27+EdKwkCt1uJzIw81rFHxSzKLBrXtPvlzcQqMpU7k4gV+1BYK6s3ATZBRrKu00
         7SbMQ2Yzz6ZqG5QNfSGXuABEuRsd+LpY6BsMJjkkPKunoTqx7v10YG7SfDuQbsR/d3
         dFzdfmK/Mm+eqxQZI0mQFRdrfw9CUd6VB5O/nZeiBFD80wAwWtcZUIoNjZywd8em8/
         ooW/q2X5Hbh123QICvlbr7FwGHoNj6Bebr6SqtvJqkeQXgPYnYCd4hVbStQb8YgH30
         xQL2ATxHti+1kuzdhwTwmM+Xfs3peWwcrcULISqpa3/H+Ju6fjT5Zyz1j8KWYNCuEh
         vpuRKiBULN8XQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O7xN0J115002;
        Fri, 24 May 2019 00:59:23 -0700
Date:   Fri, 24 May 2019 00:59:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-11e86dc7f2746210f9c7dc10deaa7658f8dc8350@git.kernel.org>
Cc:     mingo@kernel.org, brgerst@gmail.com, jgross@suse.com,
        hpa@zytor.com, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, brgerst@gmail.com, jgross@suse.com,
          hpa@zytor.com, peterz@infradead.org, bp@alien8.de,
          tglx@linutronix.de, dvlasenk@redhat.com,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <20190425095039.GC115378@gmail.com>
References: <20190425095039.GC115378@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Detect over-sized patching bugs in
 paravirt_patch_call()
Git-Commit-ID: 11e86dc7f2746210f9c7dc10deaa7658f8dc8350
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

Commit-ID:  11e86dc7f2746210f9c7dc10deaa7658f8dc8350
Gitweb:     https://git.kernel.org/tip/11e86dc7f2746210f9c7dc10deaa7658f8dc8350
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Thu, 25 Apr 2019 11:50:39 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 12:00:44 +0200

x86/paravirt: Detect over-sized patching bugs in paravirt_patch_call()

paravirt_patch_call() currently handles patching failures inconsistently:
we generate a warning in the retpoline case, but don't in other cases where
we might end up with a non-working kernel as well.

So just convert it all to a BUG_ON(), these patching calls are *not* supposed
to fail, and if they do we want to know it immediately.

This also makes the kernel smaller and removes an #ifdef ugly.

I tried it with a richly paravirt-enabled kernel and no patching bugs
were detected.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190425095039.GC115378@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/paravirt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7f9121f2fdac..544d386ded45 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -73,21 +73,21 @@ struct branch {
 static unsigned paravirt_patch_call(void *insnbuf, const void *target,
 				    unsigned long addr, unsigned len)
 {
+	const int call_len = 5;
 	struct branch *b = insnbuf;
-	unsigned long delta = (unsigned long)target - (addr+5);
+	unsigned long delta = (unsigned long)target - (addr+call_len);
 
-	if (len < 5) {
-#ifdef CONFIG_RETPOLINE
-		WARN_ONCE(1, "Failing to patch indirect CALL in %ps\n", (void *)addr);
-#endif
-		return len;	/* call too long for patch site */
+	if (len < call_len) {
+		pr_warn("paravirt: Failed to patch indirect CALL at %ps\n", (void *)addr);
+		/* Kernel might not be viable if patching fails, bail out: */
+		BUG_ON(1);
 	}
 
 	b->opcode = 0xe8; /* call */
 	b->delta = delta;
-	BUILD_BUG_ON(sizeof(*b) != 5);
+	BUILD_BUG_ON(sizeof(*b) != call_len);
 
-	return 5;
+	return call_len;
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
