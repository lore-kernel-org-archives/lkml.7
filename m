Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB39C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C502173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EbuaxWL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfJGLZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfJGLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uQo6ocjUlUt7PFFpKV1A7F1SiWhZI/lGvgNtZ4ObESo=; b=EbuaxWL51EJcql3zu12HGY6JIt
        0wUP85J/UQtpTA/R+EcvOn+yHB5G4/5zODYmqw/WH2HHhrDdTHQzeOYVqvqUVBsDhstdUHRU3s4ST
        ueV/gm1D/iPyw0dnNaFOA5Kqvqt6P0P/07LMlYKtxisEE5prrQIPafBeML5W4nOU1dCtLURzzMZEN
        tjSYP6v7mpMqPsf7zyBsJDVTvLuNCdPJL9/hHR0/FC7iAKeqS3Mpis1PfpiA03dDRlFlPeE79BchG
        YLorDHtbxyHENYnttDFxts6J84Hd9fyubhuexq4UpXT2fZit7lJd1pC7VIASqKFfchH2NFOINuL+d
        rSCTDg1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0003Gy-AV; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AEDA307276;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E224920244E40; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007083831.21184425.2@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 12/13] static_call: Allow early init
References: <20191007082708.01393931.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use static_call() to wire up x86_pmu, we need to
initialize earlier; copy some of the tricks from jump_label to enable
this.

Primarily we overload key->next to store a sites pointer when there
are no modules, this avoids having to use kmalloc() to initialize the
sites and allows us to run much earlier.

(arguably, this is much much earlier than needed for perf, but it
might allow other uses.)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/setup.c       |    2 +
 arch/x86/kernel/static_call.c |    3 ++
 include/linux/static_call.h   |   15 ++++++++++--
 kernel/static_call.c          |   52 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 67 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -73,6 +73,7 @@
 #include <linux/jiffies.h>
 #include <linux/mem_encrypt.h>
 #include <linux/sizes.h>
+#include <linux/static_call.h>
 
 #include <linux/usb/xhci-dbgp.h>
 #include <video/edid.h>
@@ -896,6 +897,7 @@ void __init setup_arch(char **cmdline_p)
 	early_cpu_init();
 	arch_init_ideal_nops();
 	jump_label_init();
+	static_call_init();
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -38,6 +38,9 @@ static void __static_call_transform(void
 	if (memcmp(insn, code, size) == 0)
 		return;
 
+	if (unlikely(system_state == SYSTEM_BOOTING))
+		return text_poke_early(insn, code, size);
+
 	text_poke_bp(insn, code, size, NULL);
 }
 
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -81,6 +81,8 @@ extern void arch_static_call_transform(v
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
+extern void __init static_call_init(void);
+
 struct static_call_mod {
 	struct static_call_mod *next;
 	struct module *mod; /* for vmlinux, mod == NULL */
@@ -89,7 +91,12 @@ struct static_call_mod {
 
 struct static_call_key {
 	void *func;
-	struct static_call_mod *next;
+	union {
+		/* bit0 => 0 - next, 1 - sites */
+		unsigned long type;
+		struct static_call_mod *next;
+		struct static_call_site *sites;
+	};
 };
 
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
@@ -100,7 +107,7 @@ extern int static_call_text_reserved(voi
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_NAME(name) = {		\
 		.func = _func,						\
-		.next = NULL,						\
+		.type = 1,						\
 	};								\
 	__ADDRESSABLE(STATIC_CALL_NAME(name));				\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
@@ -118,6 +125,8 @@ extern int static_call_text_reserved(voi
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
@@ -151,6 +160,8 @@ static inline int static_call_text_reser
 
 #else /* Generic implementation */
 
+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -94,10 +94,31 @@ static inline void static_call_sort_entr
 	     static_call_site_cmp, static_call_site_swap);
 }
 
+static inline bool static_call_key_has_next(struct static_call_key *key)
+{
+	return !(key->type & 1);
+}
+
+static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
+{
+	if (static_call_key_has_next(key))
+		return key->next->next;
+
+	return NULL;
+}
+
+static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
+{
+	if (static_call_key_has_next(key))
+		return key->next->sites;
+
+	return (struct static_call_site *)(key->type & ~1);
+}
+
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
 	struct static_call_site *site, *stop;
-	struct static_call_mod *site_mod;
+	struct static_call_mod *site_mod, first;
 
 	cpus_read_lock();
 	static_call_lock();
@@ -116,7 +137,13 @@ void __static_call_update(struct static_
 	if (WARN_ON_ONCE(!static_call_initialized))
 		goto done;
 
-	for (site_mod = key->next; site_mod; site_mod = site_mod->next) {
+	first = (struct static_call_mod){
+		.next = static_call_key_next(key),
+		.mod = NULL,
+		.sites = static_call_key_sites(key),
+	};
+
+	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
 		if (!site_mod->sites) {
 			/*
 			 * This can happen if the static call key is defined in
@@ -191,16 +218,35 @@ static int __static_call_init(struct mod
 		if (key != prev_key) {
 			prev_key = key;
 
+			if (!mod) {
+				key->sites = site;
+				key->type |= 1;
+				goto do_transform;
+			}
+
 			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
 			if (!site_mod)
 				return -ENOMEM;
 
+			if (!static_call_key_has_next(key)) {
+				site_mod->mod = NULL;
+				site_mod->next = NULL;
+				site_mod->sites = static_call_key_sites(key);
+
+				key->next = site_mod;
+
+				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+				if (!site_mod)
+					return -ENOMEM;
+			}
+
 			site_mod->mod = mod;
 			site_mod->sites = site;
 			site_mod->next = key->next;
 			key->next = site_mod;
 		}
 
+do_transform:
 		arch_static_call_transform(site_addr, NULL, key->func,
 				static_call_is_tail(site));
 	}
@@ -343,7 +389,7 @@ int static_call_text_reserved(void *star
 	return ret;
 }
 
-static void __init static_call_init(void)
+void __init static_call_init(void)
 {
 	int ret;
 


