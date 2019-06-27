Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9F1C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAC2208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cJ5MloTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfF0XjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:39:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0XjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:39:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNd2sn499951
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:39:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNd2sn499951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678745;
        bh=r3+YokSaxPkSU25VQUGEv3owDZ8kozG3eCEyXXJiklU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cJ5MloTDiib9uHeiZ2PtQaWKQOvj+6glT4SECk3kuO+YoKM1m4s3Cp9bI7DPiB6C8
         0nTj1vrtV7QovCsabvV7bT/YWub7whJ/KbKuK1N9ZcBkQ76kcMbmKNHlwK3JAhfxck
         qHvYduE2WfWOsutrC8aHekFM1IaTYxz/hUbbC2YrtqTXdwiqiUOwfxzgdAVx56qUmJ
         kJoU3vdMuTxGwiL4DTYftpJbR6cv/NvPTsd7id8sHdwsR60Bb4ZCbpYAlqRFm2io0z
         XRmK2PtGMo9eZmuMCQfhUa/a3HvBf2zdy6Pn7oQERHrGduG1Z5sYs211+TDZaBbmBM
         e9NVF72WBFKFw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNd26Q499921;
        Thu, 27 Jun 2019 16:39:02 -0700
Date:   Thu, 27 Jun 2019 16:39:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-4ce78e2094fc2736f8ecd04ec85e5566acaed516@git.kernel.org>
Cc:     eranian@google.com, peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        ashok.raj@intel.com, andi.kleen@intel.com,
        ricardo.neri-calderon@linux.intel.com,
        Suravee.Suthikulpanit@amd.com, ravi.v.shankar@intel.com
Reply-To: eranian@google.com, peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          andi.kleen@intel.com, ashok.raj@intel.com,
          ricardo.neri-calderon@linux.intel.com,
          Suravee.Suthikulpanit@amd.com, ravi.v.shankar@intel.com
In-Reply-To: <20190623132434.754768274@linutronix.de>
References: <20190623132434.754768274@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Sanitize stub functions
Git-Commit-ID: 4ce78e2094fc2736f8ecd04ec85e5566acaed516
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

Commit-ID:  4ce78e2094fc2736f8ecd04ec85e5566acaed516
Gitweb:     https://git.kernel.org/tip/4ce78e2094fc2736f8ecd04ec85e5566acaed516
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:48 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:17 +0200

x86/hpet: Sanitize stub functions

Mark them inline and remove the pointless 'return;' statement.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.754768274@linutronix.de

---
 arch/x86/kernel/hpet.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 638aaff39819..cb120e412dc6 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -692,16 +692,10 @@ static int hpet_cpuhp_dead(unsigned int cpu)
 }
 #else
 
-static void hpet_msi_capability_lookup(unsigned int start_timer)
-{
-	return;
-}
+static inline void hpet_msi_capability_lookup(unsigned int start_timer) { }
 
 #ifdef CONFIG_HPET
-static void hpet_reserve_msi_timers(struct hpet_data *hd)
-{
-	return;
-}
+static inline void hpet_reserve_msi_timers(struct hpet_data *hd) { }
 #endif
 
 #define hpet_cpuhp_online	NULL
@@ -820,7 +814,7 @@ static struct clocksource clocksource_hpet = {
 	.resume		= hpet_resume_counter,
 };
 
-static int hpet_clocksource_register(void)
+static int __init hpet_clocksource_register(void)
 {
 	u64 start, now;
 	u64 t1;
