Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2FCC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AA7205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b6gDC8EN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfESRMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:12:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41999 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:12:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4J9kSic2199405
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 19 May 2019 02:46:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4J9kSic2199405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558259189;
        bh=EZEwnXKHEaFP80xAKay6xT1gVs9KTDVZTlMPotFvqNg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=b6gDC8ENRMFKCLTan2gD7NIRuKZ5vAvs/Y1IHNgPWCwCwDLIZy3zp7fcq/a5w9bXN
         xxTDn7d/7egh+yxIZsoHjlcw2TRMHFGntiy60P/8qiUxGoYTwoHqyYy5zcvYnLqVSX
         XVi4jy/Rbhdw+QwGx43emLCANhXDtNf5ebOfAs7n3soienpJ7mFr7F219EeEiEAVS2
         SU4hvqZx6zxoeOtLZG0vKdjKIp/Cp6GCc1K3oTaxcSTUuqGm1ECZU165KOtDc2NI/C
         frvMSazF8tLTsAcMxcoMRTMfXi7g6Q9io19p53x8sjokwiKaFWet4x+Kh6dw8lakwm
         evTfPKW0OtA8w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4J9kPQC2199396;
        Sun, 19 May 2019 02:46:25 -0700
Date:   Sun, 19 May 2019 02:46:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joe Lawrence <tipbot@zytor.com>
Message-ID: <tip-7eaf51a2e094229b75cc0c315f1cbbe2f3960058@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, kamalesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, joe.lawrence@redhat.com,
        hpa@zytor.com, jpoimboe@redhat.com, mbenes@suse.cz
Reply-To: tglx@linutronix.de, mingo@kernel.org, mbenes@suse.cz,
          jpoimboe@redhat.com, hpa@zytor.com, joe.lawrence@redhat.com,
          linux-kernel@vger.kernel.org, kamalesh@linux.vnet.ibm.com
In-Reply-To: <20190517185117.24642-1-joe.lawrence@redhat.com>
References: <20190517185117.24642-1-joe.lawrence@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] stacktrace: Unbreak
 stack_trace_save_tsk_reliable()
Git-Commit-ID: 7eaf51a2e094229b75cc0c315f1cbbe2f3960058
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

Commit-ID:  7eaf51a2e094229b75cc0c315f1cbbe2f3960058
Gitweb:     https://git.kernel.org/tip/7eaf51a2e094229b75cc0c315f1cbbe2f3960058
Author:     Joe Lawrence <joe.lawrence@redhat.com>
AuthorDate: Fri, 17 May 2019 14:51:17 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 19 May 2019 11:43:22 +0200

stacktrace: Unbreak stack_trace_save_tsk_reliable()

Miroslav reported that the livepatch self-tests were failing, specifically
a case in which the consistency model ensures that a current executing
function is not allowed to be patched, "TEST: busy target module".

Recent renovations of stack_trace_save_tsk_reliable() left it returning
only an -ERRNO success indication in some configuration combinations:

  klp_check_stack()
    ret = stack_trace_save_tsk_reliable()
      #ifdef CONFIG_ARCH_STACKWALK && CONFIG_HAVE_RELIABLE_STACKTRACE
        stack_trace_save_tsk_reliable()
          ret = arch_stack_walk_reliable()
            return 0
            return -EINVAL
          ...
          return ret;
    ...
    if (ret < 0)
      /* stack_trace_save_tsk_reliable error */
    nr_entries = ret;                               << 0

Previously (and currently for !CONFIG_ARCH_STACKWALK &&
CONFIG_HAVE_RELIABLE_STACKTRACE) stack_trace_save_tsk_reliable() returned
the number of entries that it consumed in the passed storage array.

In the case of the above config and trace, be sure to return the
stacktrace_cookie.len on stack_trace_save_tsk_reliable() success.

Fixes: 25e39e32b0a3f ("livepatch: Simplify stack trace retrieval")
Reported-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: live-patching@vger.kernel.org
Cc: jikos@kernel.org
Cc: pmladek@suse.com
Link: https://lkml.kernel.org/r/20190517185117.24642-1-joe.lawrence@redhat.com

---
 kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 27bafc1e271e..90d3e0bf0302 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -206,7 +206,7 @@ int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
 
 	ret = arch_stack_walk_reliable(consume_entry, &c, tsk);
 	put_task_stack(tsk);
-	return ret;
+	return ret ? ret : c.len;
 }
 #endif
 
