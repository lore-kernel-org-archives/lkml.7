Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AC4229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RdMHbrqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389970AbfGYQHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:07:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbfGYQHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:07:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG78vP1073527
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:07:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG78vP1073527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070829;
        bh=XMJIeMc2T0qsC7Un47MzeAIrlWD8BxGBxFjhbS1GqU8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=RdMHbrqyHsXqf3+7g6Iop0pO9B6z/5DlQAZ0+Yp+GGMDzdaTZhpaC54Gqpl+HVro8
         D18Ywwpnbvhi9G3XBNPM3J6nvDf8KEalExBTPRmw4XHDjtfc69Ggl8gX4vKO4YZD4U
         VIrmlTaXKQsls9cYhsQIouNwBJmgmBejNvDkwbrHCcsoESP87jJyMNn4XfTuAu4qIG
         OpI6XuVJvC6ncJ2rylBGvm8572GmidrKSG1tnqHKWDRMGuaGgelDQ36mnbVU59yLDj
         Wm8BczmyTGw5Nufy1+MR9S5rBrQWviFvIr5BwauYqLIGYSwZ2bBSOW9JRMeAA1L7M4
         PzhwZWhT7fEMg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG77B71073524;
        Thu, 25 Jul 2019 09:07:07 -0700
Date:   Thu, 25 Jul 2019 09:07:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-5ea3f6fb37b79da33ac9211df336fd2b9f47c39f@git.kernel.org>
Cc:     jgross@suse.com, jolsa@redhat.com, zhenzhong.duan@oracle.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        boris.ostrovsky@oracle.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@kernel.org,
        namhyung@kernel.org
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          boris.ostrovsky@oracle.com, tglx@linutronix.de, hpa@zytor.com,
          jgross@suse.com, acme@kernel.org, zhenzhong.duan@oracle.com,
          jolsa@redhat.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, namhyung@kernel.org, bp@alien8.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <1564022366-18293-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1564022366-18293-1-git-send-email-zhenzhong.duan@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86: Apply more accurate check on hypervisor
 platform
Git-Commit-ID: 5ea3f6fb37b79da33ac9211df336fd2b9f47c39f
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

Commit-ID:  5ea3f6fb37b79da33ac9211df336fd2b9f47c39f
Gitweb:     https://git.kernel.org/tip/5ea3f6fb37b79da33ac9211df336fd2b9f47c39f
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Thu, 25 Jul 2019 10:39:26 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:41:30 +0200

perf/x86: Apply more accurate check on hypervisor platform

check_msr is used to fix a bug report in guest where KVM doesn't support
LBR MSR and cause #GP.

The msr check is bypassed on real HW to workaround a false failure,
see commit d0e1a507bdc7 ("perf/x86/intel: Disable check_msr for real HW")

When running a guest with CONFIG_HYPERVISOR_GUEST not set or "nopv"
enabled, current check isn't enough and #GP could trigger.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1564022366-18293-1-git-send-email-zhenzhong.duan@oracle.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b35519cbc8b4..c9075fc75cb6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -20,7 +20,6 @@
 #include <asm/intel-family.h>
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
-#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -4053,7 +4052,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 	 * Disable the check for real HW, so we don't
 	 * mess with potentionaly enabled registers:
 	 */
-	if (hypervisor_is_type(X86_HYPER_NATIVE))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return true;
 
 	/*
