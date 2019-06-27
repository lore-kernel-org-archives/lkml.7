Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BE0C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088EA208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sRRDHVKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfF0XmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:42:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52589 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfF0XmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:42:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNfnmV500531
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:41:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNfnmV500531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678909;
        bh=cfxfvkVxTcd6HLaYvJVL+i37CI6+stAG2SEKQa7Y89c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=sRRDHVKs/uvRe+IUKEtWWfwhJnr+V+CRPJbu0OT+iUf9j+ADG/KxDREb9jLO+sKOH
         KD1TxvU3LX/FoNrsR8hrtA+xexyDOTCWsUSPaYbjMGZ1RQwPCohHdCPFFryJmmCbaP
         PO0LCGGCddPBxlBqiwUjVpMyMCd9WTI23Wbk8stfIR0TkUJOVzs8jqLHH5mH/a+1+f
         VVxk66++Ek+Gw3FRpVWAHDK3MK7vsQy62RCVUjHp+97h7jIdn3uz+owl9B17Q3eV5V
         1Hosv0MdaM32WcyGxOW7xulmeO5m0L1zeJMgev3HCsZKRnguDs+czm0ooGTGr3cfXa
         JJ5/L002aiEzQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNfmnj500528;
        Thu, 27 Jun 2019 16:41:48 -0700
Date:   Thu, 27 Jun 2019 16:41:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-44b5be5733e119300115b98409cbcf9a45b8d3f1@git.kernel.org>
Cc:     tglx@linutronix.de, eranian@google.com,
        linux-kernel@vger.kernel.org, ravi.v.shankar@intel.com,
        andi.kleen@intel.com, Suravee.Suthikulpanit@amd.com,
        peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
        ricardo.neri-calderon@linux.intel.com, ashok.raj@intel.com
Reply-To: hpa@zytor.com, ravi.v.shankar@intel.com, mingo@kernel.org,
          ricardo.neri-calderon@linux.intel.com, ashok.raj@intel.com,
          andi.kleen@intel.com, tglx@linutronix.de, eranian@google.com,
          linux-kernel@vger.kernel.org, Suravee.Suthikulpanit@amd.com,
          peterz@infradead.org
In-Reply-To: <20190623132435.149535103@linutronix.de>
References: <20190623132435.149535103@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Simplify counter validation
Git-Commit-ID: 44b5be5733e119300115b98409cbcf9a45b8d3f1
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

Commit-ID:  44b5be5733e119300115b98409cbcf9a45b8d3f1
Gitweb:     https://git.kernel.org/tip/44b5be5733e119300115b98409cbcf9a45b8d3f1
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:19 +0200

x86/hpet: Simplify counter validation

There is no point to loop for 200k TSC cycles to check afterwards whether
the HPET counter is working. Read the counter inside of the loop and break
out when the counter value changed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132435.149535103@linutronix.de

---
 arch/x86/kernel/hpet.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 8c57dbf15e3b..74756c0a3a10 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -853,15 +853,13 @@ static bool __init hpet_counting(void)
 	 * 1 GHz == 200us
 	 */
 	do {
-		rep_nop();
+		if (t1 != hpet_readl(HPET_COUNTER))
+			return true;
 		now = rdtsc();
 	} while ((now - start) < 200000UL);
 
-	if (t1 == hpet_readl(HPET_COUNTER)) {
-		pr_warn("Counter not counting. HPET disabled\n");
-		return false;
-	}
-	return true;
+	pr_warn("Counter not counting. HPET disabled\n");
+	return false;
 }
 
 /**
