Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D294C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2FB22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="W7Ig1Eb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfGYOWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:22:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbfGYOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:22:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEMAPL1037537
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:22:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEMAPL1037537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064531;
        bh=AVmTYOxVuhPUGjUnnjqwYIiHywSp+08pFlxVJuqMW94=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=W7Ig1Eb47r+bYrFqjGi2qNLvw+gfDutqwoEBSU3ryKE4J8H1VLn02y6Xp2vIeHHVI
         AkvbriJTv9QgrwXy2RblNwgxWiIvpTgyax1fb0WUFDSd2/VLCbAsZ+OWNSLvnh4MJF
         EVnF3zlzH299fUwR7snqgIT26krM7/jr4wTLDfU8W2TeqyQinVuxNaL4W6SubJcW15
         JQqoGNGbqeCwzWNi8CCL4fA+phsUt11yfZf/2ejI7W1z3TXUPfYEBedfDsmRE+5Aed
         d36laexPrIDzBjo0LFAIaMBAMGNrv9x14LqX42zkZsbUNVS84SVe3ym1N8JTjhYLsp
         bvUPAVQiB6Ggg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEM9Ru1037515;
        Thu, 25 Jul 2019 07:22:09 -0700
Date:   Thu, 25 Jul 2019 07:22:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2640da4cccf5cc613bf26f0998b9e340f4b5f69c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20190722105219.068290579@linutronix.de>
References: <20190722105219.068290579@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Soft disable APIC before initializing it
Git-Commit-ID: 2640da4cccf5cc613bf26f0998b9e340f4b5f69c
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

Commit-ID:  2640da4cccf5cc613bf26f0998b9e340f4b5f69c
Gitweb:     https://git.kernel.org/tip/2640da4cccf5cc613bf26f0998b9e340f4b5f69c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:08 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:56 +0200

x86/apic: Soft disable APIC before initializing it

If the APIC was already enabled on entry of setup_local_APIC() then
disabling it soft via the SPIV register makes a lot of sense.

That masks all LVT entries and brings it into a well defined state.

Otherwise previously enabled LVTs which are not touched in the setup
function stay unmasked and might surprise the just booting kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.068290579@linutronix.de

---
 arch/x86/kernel/apic/apic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index fa0846d4e000..621992de49ee 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1522,6 +1522,14 @@ static void setup_local_APIC(void)
 		return;
 	}
 
+	/*
+	 * If this comes from kexec/kcrash the APIC might be enabled in
+	 * SPIV. Soft disable it before doing further initialization.
+	 */
+	value = apic_read(APIC_SPIV);
+	value &= ~APIC_SPIV_APIC_ENABLED;
+	apic_write(APIC_SPIV, value);
+
 #ifdef CONFIG_X86_32
 	/* Pound the ESR really hard over the head with a big hammer - mbligh */
 	if (lapic_is_integrated() && apic->disable_esr) {
