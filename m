Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD29BC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9510021E70
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AbW4TPp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfGVIQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:16:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47505 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfGVIQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:16:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8GCGM3736965
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:16:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8GCGM3736965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563783373;
        bh=Er/zpdYqDrS+nF2bYXpTJiIZ8+6n9MbMxcjKijzI0qo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AbW4TPp71fIy4DNrjjPrC3yW0rspKcwLlvHks6c2iE4ZutFJhZKcjyWBpvgzlRJBh
         XkFnHBVULPG8k8ZIfG8aYqgoOmz7ttLtlPRPgIz9FhCEvrAJ1eNPCKkiuYlqHSlZW2
         rSCCs+PF1q+h322oyBIAZ7f+/cgcFLakwxnQLO/O8GXFLrN9mnqVpzWUSemeYOSZP6
         QN/9pkQpzG0aIj7QcTrRrAE65Rcws4U/N0P+5cyz9BMzcJChRTOlb7jKFZHUQ+YF8D
         y28MxTyOBzjmPO3PrXRJaTDoEOq5SAaL2PgnqJMedD8ltdB/cDKnQzpwR4IL6xiPLz
         wzIhMADrRJmDA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8GCne3736962;
        Mon, 22 Jul 2019 01:16:12 -0700
Date:   Mon, 22 Jul 2019 01:16:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-229b969b3d38bc28bcd55841ee7ca9a9afb922f3@git.kernel.org>
Cc:     andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, andrew.cooper3@citrix.com,
          mingo@kernel.org, luto@kernel.org, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <dc04a9f8b234d7b0956a8d2560b8945bcd9c4bf7.1563117760.git.luto@kernel.org>
References: <dc04a9f8b234d7b0956a8d2560b8945bcd9c4bf7.1563117760.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Initialize TPR to block interrupts 16-31
Git-Commit-ID: 229b969b3d38bc28bcd55841ee7ca9a9afb922f3
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

Commit-ID:  229b969b3d38bc28bcd55841ee7ca9a9afb922f3
Gitweb:     https://git.kernel.org/tip/229b969b3d38bc28bcd55841ee7ca9a9afb922f3
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Sun, 14 Jul 2019 08:23:14 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:12:32 +0200

x86/apic: Initialize TPR to block interrupts 16-31

The APIC, per spec, is fundamentally confused and thinks that interrupt
vectors 16-31 are valid.  This makes no sense -- the CPU reserves vectors
0-31 for exceptions (faults, traps, etc).  Obviously, no device should
actually produce an interrupt with vector 16-31, but robustness can be
improved by setting the APIC TPR class to 1, which will prevent delivery of
an interrupt with a vector below 32.

Note: This is *not* intended as a security measure against attackers who
control malicious hardware.  Any PCI or similar hardware that can be
controlled by an attacker MUST be behind a functional IOMMU that remaps
interrupts.  The purpose of this change is to reduce the chance that a
certain class of device malfunctions crashes the kernel in hard-to-debug
ways.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/dc04a9f8b234d7b0956a8d2560b8945bcd9c4bf7.1563117760.git.luto@kernel.org

---
 arch/x86/kernel/apic/apic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f5291362da1a..84032bf81476 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1561,11 +1561,14 @@ static void setup_local_APIC(void)
 #endif
 
 	/*
-	 * Set Task Priority to 'accept all'. We never change this
-	 * later on.
+	 * Set Task Priority to 'accept all except vectors 0-31'.  An APIC
+	 * vector in the 16-31 range could be delivered if TPR == 0, but we
+	 * would think it's an exception and terrible things will happen.  We
+	 * never change this later on.
 	 */
 	value = apic_read(APIC_TASKPRI);
 	value &= ~APIC_TPRI_MASK;
+	value |= 0x10;
 	apic_write(APIC_TASKPRI, value);
 
 	apic_pending_intr_clear();
