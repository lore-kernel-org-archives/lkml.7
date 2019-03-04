Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2C9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4486520835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCDUIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:08:46 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:47195 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCDUIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:08:46 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXY6b-1gTCfp3f3v-00Z2OQ; Mon, 04 Mar 2019 21:07:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/ftrace: avoid an unused-function warning
Date:   Mon,  4 Mar 2019 21:07:39 +0100
Message-Id: <20190304200748.1418790-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nklnExSuFdJPbitRhNjdFGGb6Ob0uFIGnEQxpkQ81TU7sFuMY4c
 +pmK2jZDKIOsZunuzfrHKye4pcZeSoDfRXGMsACoSPoS/alfheGIL0163fGGdGt3qKxc/O2
 bGoNTt7yXEwFLsegyKQIQHVi+zn4PBVEERGz42VSp4rrSiMfF+RGiathm6q7Z7+admii1C0
 z3I9Pf4XLklRtkuO1fJ0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dC39UAWXT3I=:1IaOMBzDetAo2faRVlDj95
 CXW/jOx+4e3C0AudMD2yitWUf/LHiyuGKSXh/IbRgIYaeWUe9+x6jZQ0GhunJP3T3ju+Rmf0E
 8LFx+QhOOHYXZCj6IbKfbj3YmhqPmMs+Bz4/ztqg01vj/m8Xal+Qo84qd+FJG9CQz3NeGxGHv
 WqOaKt+aVR75AUumdHH3GMa1mTndQpjLpEbLG8OHj/T0HBECdT0aalBYIr6DfUvGxUyuiULdZ
 h+QxnaMC3UJUGZ8hlbH7j1g6nrLMkfTm98iqLK4fgKnSLftI6Zw+024a0fVSPczPl/gfnA6VB
 swKe3oWl9iKeCBZSRbih8uFBGK3KpzuSyG77l1RT+gDkWFWhLJwfS1TQlMPGGFeruKNV3qPJs
 VAjekPP3BqkOXJ7PBhNIA9Leu/xs7dhp9Kq/hnyz4RPzlNzOVj66Ckun7NBAGjaLMFlwaJxtf
 Y8ccJJShfbV+I+9GCjEyFNpaW76UuDiiSFwssd9HxxUwhEqeMhKWg2JEqSFt2HsA1QFdMXm4+
 rWflFLdxg6S75LZ4/C+cvduMBrOvvo5Lf3MOAfLnL4OIKD+DT+KPAXG9hGFemN7yl8IOg2M3y
 1+zls+4SRm7FMz6hvvOZkTPecgYwlHs1Vo2CzcD10jG6qqaihXA+hgYv4r9gVpiQhOYHPIYuH
 4QnrA9jFbFvbkYhPY+tI/zORZsKfl3uV1ID0q9j+eNWcLkPPIjsSTeXgVzf8GURVLO4nSAAiB
 urbzhUih2s4QpwoCBN2KSTV97DCIdnQOLS2rFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the configuration, ftrace_jmp_replace() sometimes
has no callers at all, since one of the users was removed:

arch/x86/kernel/ftrace.c:669:23: error: 'ftrace_jmp_replace' defined but not used [-Werror=unused-function]

Rather than trying to figure out the correct #ifdef check for this
time, just mark it __maybe_unused and let the compiler drop it
silently.

Fixes: d2a68c4effd8 ("x86/ftrace: Do not call function graph from dynamic trampolines")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/ftrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 3e3789c8f8e1..905056240411 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -665,8 +665,7 @@ int __init ftrace_dyn_arch_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_FUNCTION_GRAPH_TRACER)
-static unsigned char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
+static __maybe_unused unsigned char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
 {
 	static union ftrace_code_union calc;
 
@@ -679,7 +678,6 @@ static unsigned char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
 	 */
 	return calc.code;
 }
-#endif
 
 /* Currently only x86_64 supports dynamic trampolines */
 #ifdef CONFIG_X86_64
-- 
2.20.0

