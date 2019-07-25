Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD5CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6147121901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="scMBWUB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfGYOal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:30:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfGYOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:30:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEUVcV1040762
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:30:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEUVcV1040762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065031;
        bh=I08uRcINLQne8U8A8USwU5NdWiSz4Sng5NSDwD+Wu4U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=scMBWUB266f68+npfIxXZtPYEZTA38xw2huubnu2IyycA9ZYHD1y/tdoMLbOAKlNp
         v6Wk8BY/52EgzJEz+EacKkqq0A6DUgpGJ3z2lTFBiLQkkCgNPcW9mwDLP5o5Vu24IP
         xOm0i20RbHW4avZyl828OXagDXn1oB6AxOlX0XjjdcNBLDcaPg3rU7tfEUGi9B/ggL
         kOAOzmNy6Rdc9kQu3kshMfTPRg0Sx4zpjXqpjmwyql46g9CwVKAMftoxvZP6sNy41B
         J0ovCWyBBX7TP4EfXuhWhQMEkxTK0SUsuwWr2WEJb4/0REgg+QbBVIMAqapgTfGrkU
         kPLNNAZJu+d4g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEUUue1040759;
        Thu, 25 Jul 2019 07:30:30 -0700
Date:   Thu, 25 Jul 2019 07:30:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-bd82dba2fa6ae91061e5d31399d61fe65028f714@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190722105220.185838026@linutronix.de>
References: <20190722105220.185838026@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Add NMI_VECTOR wait to IPI shorthand
Git-Commit-ID: bd82dba2fa6ae91061e5d31399d61fe65028f714
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

Commit-ID:  bd82dba2fa6ae91061e5d31399d61fe65028f714
Gitweb:     https://git.kernel.org/tip/bd82dba2fa6ae91061e5d31399d61fe65028f714
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:59 +0200

x86/apic: Add NMI_VECTOR wait to IPI shorthand

To support NMI shorthand broadcasts add the safe wait for ICR idle for NMI
vector delivery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.185838026@linutronix.de

---
 arch/x86/kernel/apic/ipi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 50c9dcc6f60e..7236fefde396 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -30,7 +30,10 @@ void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
 	/*
 	 * Wait for idle.
 	 */
-	__xapic_wait_icr_idle();
+	if (unlikely(vector == NMI_VECTOR))
+		safe_apic_wait_icr_idle();
+	else
+		__xapic_wait_icr_idle();
 
 	/*
 	 * No need to touch the target chip field. Also the destination
