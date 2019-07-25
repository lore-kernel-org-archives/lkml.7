Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049AFC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA8822BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="F8Fcu2KB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfGYOhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:37:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfGYOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:37:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEb5mL1041989
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:37:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEb5mL1041989
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065426;
        bh=u9lxvqAFP1MFrDEx8AitCxDJoiaz7jD7cA5B1dM0L4I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=F8Fcu2KBtPmilh4JvAdB9g/WXSAuHkhODL1mhydGunOm1hGvKDHp0A71GpgJqi7rR
         Wz/5nCAdH4D+HII57K8O4x42Qgy3aG7ZSiJj6C/cYfhWt8CspofzUNxomM5S9iHomI
         s40eRfVLnSPjSmiC+ito1j3U+/nk0bqFdGsRGKFBHqP3ilqoImZioNbaZooqG0sqcg
         jdHgypIlTCBLNvf3GdPw8d3pMZkPsCTZHBpCxp0ccj3cRqntMBPPkmuuFrp6Hjfytc
         iANlZYfEaWQ5wtDKHd8JEngrEBHrDzwTs1OMhKUPbD76V5Ce8/07sgL9jKQIvVRRP8
         s+7ydq/lshorA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEb5Kn1041986;
        Thu, 25 Jul 2019 07:37:05 -0700
Date:   Thu, 25 Jul 2019 07:37:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-43931d350f30c6cd8c2f498d54ef7d65750abc92@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190722105221.134696837@linutronix.de>
References: <20190722105221.134696837@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic/x2apic: Implement IPI shorthands support
Git-Commit-ID: 43931d350f30c6cd8c2f498d54ef7d65750abc92
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

Commit-ID:  43931d350f30c6cd8c2f498d54ef7d65750abc92
Gitweb:     https://git.kernel.org/tip/43931d350f30c6cd8c2f498d54ef7d65750abc92
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:30 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:12:02 +0200

x86/apic/x2apic: Implement IPI shorthands support

All callers of apic->send_IPI_all() and apic->send_IPI_allbutself() contain
the decision logic for shorthand invocation already and invoke
send_IPI_mask() if the prereqisites are not satisfied.

Implement shorthand support for x2apic.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105221.134696837@linutronix.de

---
 arch/x86/kernel/apic/local.h          |  1 +
 arch/x86/kernel/apic/x2apic_cluster.c |  4 ++--
 arch/x86/kernel/apic/x2apic_phys.c    | 12 ++++++++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 69ba777cef98..04797f05ce94 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -23,6 +23,7 @@ unsigned int x2apic_get_apic_id(unsigned long id);
 u32 x2apic_set_apic_id(unsigned int id);
 int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
 void x2apic_send_IPI_self(int vector);
+void __x2apic_send_IPI_shorthand(int vector, u32 which);
 
 /* IPI */
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index d0a13c88f777..45e92cba92f5 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -82,12 +82,12 @@ x2apic_send_IPI_mask_allbutself(const struct cpumask *mask, int vector)
 
 static void x2apic_send_IPI_allbutself(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLBUT);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
 }
 
 static void x2apic_send_IPI_all(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLINC);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
 static u32 x2apic_calc_apicid(unsigned int cpu)
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 5d50e1f9d4bf..bc9693841353 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -75,12 +75,12 @@ static void
 
 static void x2apic_send_IPI_allbutself(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLBUT);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
 }
 
 static void x2apic_send_IPI_all(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLINC);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
 static void init_x2apic_ldr(void)
@@ -112,6 +112,14 @@ void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest)
 	native_x2apic_icr_write(cfg, apicid);
 }
 
+void __x2apic_send_IPI_shorthand(int vector, u32 which)
+{
+	unsigned long cfg = __prepare_ICR(which, vector, 0);
+
+	x2apic_wrmsr_fence();
+	native_x2apic_icr_write(cfg, 0);
+}
+
 unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;
