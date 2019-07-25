Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D78C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D0F21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="x5XHiksR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfGYO1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:27:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46969 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfGYO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:27:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PERWGW1040246
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:27:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PERWGW1040246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064853;
        bh=JjEfk/hvyafi5da4/uodwFLhB/2zbqdyVSnsBoPBuj0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=x5XHiksRFq7MBA4TpFXnNQr5bCydJciCJVsXW61BVGEq7vgG/Ll872ngvKcar4bOA
         s2Qdv55ZxggkkhoRASFMq4L2ehdqmTDk1Ll2aYjuA9zl5GCsmsR3qOf2Y8vb1joTUh
         JEXCQf008D+hpxq3I3XLar5KxLVhyCUyDjm2eCTVKb6aEP0ua4SCiPH8vEHuvpIYQ7
         1lKNt/dBBTr7d4c2cBgXBqqGuqLsykB47xLaKA2Fvflowa6K8ySsG8zV+8aDV3rTf0
         V+fb4o+TRRx9AssOepupabnsZOIukDQ5ahuwSvmhk8pbQCdVD225/T9jyyrbEHNO3r
         lxzG18Sfq+bPg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PERWGk1040243;
        Thu, 25 Jul 2019 07:27:32 -0700
Date:   Thu, 25 Jul 2019 07:27:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-82e574782345aa634e1544e80da85d71a9dbde19@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20190722105219.725264153@linutronix.de>
References: <20190722105219.725264153@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic/uv: Make x2apic_extra_bits static
Git-Commit-ID: 82e574782345aa634e1544e80da85d71a9dbde19
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

Commit-ID:  82e574782345aa634e1544e80da85d71a9dbde19
Gitweb:     https://git.kernel.org/tip/82e574782345aa634e1544e80da85d71a9dbde19
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:58 +0200

x86/apic/uv: Make x2apic_extra_bits static

Not used outside of the UV apic source.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.725264153@linutronix.de

---
 arch/x86/include/asm/apic.h        | 2 --
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e647aa095867..f53eda2c986b 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -467,8 +467,6 @@ static inline unsigned default_get_apic_id(unsigned long x)
 
 #ifdef CONFIG_X86_64
 extern void apic_send_IPI_self(int vector);
-
-DECLARE_PER_CPU(int, x2apic_extra_bits);
 #endif
 
 extern void generic_bigsmp_probe(void);
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 73a652093820..e6230af19864 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -22,7 +22,7 @@
 #include <asm/uv/uv.h>
 #include <asm/apic.h>
 
-DEFINE_PER_CPU(int, x2apic_extra_bits);
+static DEFINE_PER_CPU(int, x2apic_extra_bits);
 
 static enum uv_system_type	uv_system_type;
 static bool			uv_hubless_system;
