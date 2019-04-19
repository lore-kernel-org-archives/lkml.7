Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07FCC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB22204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="w4FKdiYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfDSSeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:34:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfDSSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:34:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIYHDc384135
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:34:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIYHDc384135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555698857;
        bh=HkLN3uLvaQusWAtPoOKgQckjhX+Fo28CPjJvGY72Owk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=w4FKdiYKWXXESRb88ojtbGXL3C5OhR+VwY96iPC4ZHFWSwgKNct65L4T8Xevnxbzt
         65Gectxr6Cc/EwKyb4mDE9fLJo7hAtsWTkeJcp6lh4JnskdpA3Fih5GmmuKyysXAY9
         mTOhR6XxJ9rhezl6IxBzytzwZVcQTayhuifVVZbLvij6cse9uOnkZxeSkHUIHGimky
         pbHEDPvHEcB+ioFUOof9c3Ys2XVhsaxbe1rWIuwV/UGnTqurV1crZOAOypuEGvLD49
         +XwKem4kOti5cdjB1xbOwwSx4HoHwEZ+0KQXGsNvp7zFVGPsiajtaa0pfB3UQMJg20
         8yH84VmXwtTUA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIYFJX384132;
        Fri, 19 Apr 2019 11:34:15 -0700
Date:   Fri, 19 Apr 2019 11:34:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for David Wang <tipbot@zytor.com>
Message-ID: <tip-987ddbe4870b53623d76ac64044c55a13e368113@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, davidwang@zhaoxin.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, pavel@ucw.cz,
          davidwang@zhaoxin.com, peterz@infradead.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <1545900110-2757-1-git-send-email-davidwang@zhaoxin.com>
References: <1545900110-2757-1-git-send-email-davidwang@zhaoxin.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/power: Optimize C3 entry on Centaur CPUs
Git-Commit-ID: 987ddbe4870b53623d76ac64044c55a13e368113
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

Commit-ID:  987ddbe4870b53623d76ac64044c55a13e368113
Gitweb:     https://git.kernel.org/tip/987ddbe4870b53623d76ac64044c55a13e368113
Author:     David Wang <davidwang@zhaoxin.com>
AuthorDate: Thu, 27 Dec 2018 16:41:50 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:28:06 +0200

x86/power: Optimize C3 entry on Centaur CPUs

For new Centaur CPUs the ucode will take care of the preservation of cache coherence
between CPU cores in C-states regardless of how deep the C-states are. So, it is not
necessary to flush the caches in software befor entering C3. This useless operation
will cause performance drop for the cores which share some caches with the idling core.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: brucechang@via-alliance.com
Cc: cooperyan@zhaoxin.com
Cc: len.brown@intel.com
Cc: linux-pm@kernel.org
Cc: qiyuanwang@zhaoxin.com
Cc: rjw@rjwysocki.net
Cc: timguo@zhaoxin.com
Link: http://lkml.kernel.org/r/1545900110-2757-1-git-send-email-davidwang@zhaoxin.com
[ Tidy up the comment. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/acpi/cstate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 158ad1483c43..cb6e076a6d39 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -51,6 +51,18 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
 	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
 			flags->bm_control = 0;
+	/*
+	 * For all recent Centaur CPUs, the ucode will make sure that each
+	 * core can keep cache coherence with each other while entering C3
+	 * type state. So, set bm_check to 1 to indicate that the kernel
+	 * doesn't need to execute a cache flush operation (WBINVD) when
+	 * entering C3 type state.
+	 */
+	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
+		if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&
+		    c->x86_stepping >= 0x0e))
+			flags->bm_check = 1;
+	}
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
