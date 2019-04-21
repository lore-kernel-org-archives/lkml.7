Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DF0C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDC32080D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jizMIQth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDUSwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:52:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43255 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDUSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:52:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3LIqFBD1295810
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 21 Apr 2019 11:52:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3LIqFBD1295810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555872736;
        bh=bsEhR4Xqe/APRfa17wqW0jxDIaXT4NlBXNfJDHlfybI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=jizMIQth9fYH222YSdxG1w9Y+Ulfw1IRRv/wldyqcJD3p1DDqHTS+2CR1C0Ei6Wcn
         MC3qL+2MjG4mDVnfQin5mJjXTYTHJWyfsud9rEGNMXBep5c1CCBz82zPVokVAovu+2
         P2Z7y2loNv/ywByThQZwR0ECWLOZQTIZ0xYkdE1kT3Gft/tq7Mi2rRcSKq5AbE5Zuk
         d1VNE2CVNcekfYAx0aOK7yK50QP10NOGVzMMVvTFw+Q3LLC3xXTUoLOA0UWdgpDVa/
         Dmc7lJ8JjfPhPsc5seysDq2yuDEkMgKk8XWpTsh5wOriedGmrpmpG1QNzTMvi4Ihqu
         eid3oxG0wrNaw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3LIqDAd1295807;
        Sun, 21 Apr 2019 11:52:13 -0700
Date:   Sun, 21 Apr 2019 11:52:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-ea2f8d60603efbd1cb4e193a593945a2fe24d264@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@suse.de
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, bp@suse.de,
          peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org
In-Reply-To: <20190421183524.GC6048@zn.tnic>
References: <20190421183524.GC6048@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Make fault messages more succinct
Git-Commit-ID: ea2f8d60603efbd1cb4e193a593945a2fe24d264
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

Commit-ID:  ea2f8d60603efbd1cb4e193a593945a2fe24d264
Gitweb:     https://git.kernel.org/tip/ea2f8d60603efbd1cb4e193a593945a2fe24d264
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sun, 21 Apr 2019 20:35:24 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 21 Apr 2019 20:48:51 +0200

x86/fault: Make fault messages more succinct

So we are going to be staring at those in the next years, let's make
them more succinct. In particular:

 - change "address = " to "address: "

 - "-privileged" reads funny. It should be simply "kernel" or "user"

 - "from kernel code" reads funny too. "kernel mode" or "user mode" is
   more natural.

An actual example says more than 1000 words, of course:

  [    0.248370] BUG: kernel NULL pointer dereference, address: 00000000000005b8
  [    0.249120] #PF: supervisor write access in kernel mode
  [    0.249717] #PF: error_code(0x0002) - not-present page

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: riel@surriel.com
Cc: sean.j.christopherson@intel.com
Cc: yu-cheng.yu@intel.com
Link: http://lkml.kernel.org/r/20190421183524.GC6048@zn.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 74c9204c5751..a0df19b0897d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -630,13 +630,13 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 	}
 
 	if (address < PAGE_SIZE && !user_mode(regs))
-		pr_alert("BUG: kernel NULL pointer dereference, address = %px\n",
+		pr_alert("BUG: kernel NULL pointer dereference, address: %px\n",
 			(void *)address);
 	else
-		pr_alert("BUG: unable to handle page fault for address = %px\n",
+		pr_alert("BUG: unable to handle page fault for address: %px\n",
 			(void *)address);
 
-	pr_alert("#PF: %s-privileged %s from %s code\n",
+	pr_alert("#PF: %s %s in %s mode\n",
 		 (error_code & X86_PF_USER)  ? "user" : "supervisor",
 		 (error_code & X86_PF_INSTR) ? "instruction fetch" :
 		 (error_code & X86_PF_WRITE) ? "write access" :
