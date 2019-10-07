Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0C7C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4753421D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XbKDMWvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfJGLZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfJGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2DP7SdddmBPCqTl/EX42Xv/iKdY/IVrkhlnqstt7XuU=; b=XbKDMWvbnvsAV/H/eZiu8yg+lp
        qgXEq2x4REFjFVe6WtV9Ii7Mnl/dqpqv1s9H/ZYW8vbvCN5s581lC7tQvlD6iudnSJdeNpPQLlev+
        w68udFUw4rZ+RhSEI7Sc4e+Sbyb0dA/ztS6UuO9B5kBM58KCzAjO97ijAZ3X6g8uFH/utRDynIYst
        ExCv+PBe27TFH+pYcuqHkFOPZ/CgLjXVzKF9ysSe1Dva0+PYPq+y0VbrHXJz/UlZMYZbIhMuocnLO
        l8R0be989o1MFScsC55yZE/jcntUZ8Ji4DsZr4gexMoKBvMwemodlqhAYpL/2T3ve/MDudslNBkYV
        fk84iJMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0003Gx-5J; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38FDD30709E;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DD155202A1952; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007083831.15486812.0@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 11/13] static_call: Handle tail-calls
References: <20191007082708.01393931.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC can turn our static_call(name)(args...) into a tail call, in which
case we get a JMP.d32 into the trampoline (which then does a further
tail-call).

Teach objtool to recognise and mark these in .static_call_sites and
adjust the code patching to deal with this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/static_call.c           |    4 ++--
 include/linux/static_call.h             |    4 ++--
 include/linux/static_call_types.h       |    7 +++++++
 kernel/static_call.c                    |   21 +++++++++++++--------
 tools/include/linux/static_call_types.h |    7 +++++++
 tools/objtool/check.c                   |   18 +++++++++++++-----
 6 files changed, 44 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -41,7 +41,7 @@ static void __static_call_transform(void
 	text_poke_bp(insn, code, size, NULL);
 }
 
-void arch_static_call_transform(void *site, void *tramp, void *func)
+void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 {
 	mutex_lock(&text_mutex);
 
@@ -49,7 +49,7 @@ void arch_static_call_transform(void *si
 		__static_call_transform(tramp, jmp + !func, func);
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
-		__static_call_transform(site, !func, func);
+		__static_call_transform(site, 2*tail + !func, func);
 
 	mutex_unlock(&text_mutex);
 }
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -64,7 +64,7 @@
 /*
  * Either @site or @tramp can be NULL.
  */
-extern void arch_static_call_transform(void *site, void *tramp, void *func);
+extern void arch_static_call_transform(void *site, void *tramp, void *func, bool tail);
 #endif
 
 
@@ -137,7 +137,7 @@ void __static_call_update(struct static_
 {
 	cpus_read_lock();
 	WRITE_ONCE(key->func, func);
-	arch_static_call_transform(NULL, tramp, func);
+	arch_static_call_transform(NULL, tramp, func, false);
 	cpus_read_unlock();
 }
 
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -13,6 +13,13 @@
 #define STATIC_CALL_TRAMP_STR(name) __stringify(STATIC_CALL_TRAMP(name))
 
 /*
+ * Flags in the low bits of static_call_site::key.
+ */
+#define STATIC_CALL_SITE_TAIL 1UL	/* tail call */
+#define STATIC_CALL_SITE_INIT 2UL	/* init section */
+#define STATIC_CALL_SITE_FLAGS 3UL
+
+/*
  * The static call site table needs to be created by external tooling (objtool
  * or a compiler plugin).
  */
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -15,8 +15,6 @@ extern struct static_call_site __start_s
 
 static bool static_call_initialized;
 
-#define STATIC_CALL_INIT 1UL
-
 /* mutex to protect key modules/sites */
 static DEFINE_MUTEX(static_call_mutex);
 
@@ -39,18 +37,23 @@ static inline void *static_call_addr(str
 static inline struct static_call_key *static_call_key(const struct static_call_site *site)
 {
 	return (struct static_call_key *)
-		(((long)site->key + (long)&site->key) & ~STATIC_CALL_INIT);
+		(((long)site->key + (long)&site->key) & ~STATIC_CALL_SITE_FLAGS);
 }
 
 /* These assume the key is word-aligned. */
 static inline bool static_call_is_init(struct static_call_site *site)
 {
-	return ((long)site->key + (long)&site->key) & STATIC_CALL_INIT;
+	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_INIT;
+}
+
+static inline bool static_call_is_tail(struct static_call_site *site)
+{
+	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_TAIL;
 }
 
 static inline void static_call_set_init(struct static_call_site *site)
 {
-	site->key = ((long)static_call_key(site) | STATIC_CALL_INIT) -
+	site->key = ((long)static_call_key(site) | STATIC_CALL_SITE_INIT) -
 		    (long)&site->key;
 }
 
@@ -104,7 +107,7 @@ void __static_call_update(struct static_
 
 	key->func = func;
 
-	arch_static_call_transform(NULL, tramp, func);
+	arch_static_call_transform(NULL, tramp, func, false);
 
 	/*
 	 * If uninitialized, we'll not update the callsites, but they still
@@ -153,7 +156,8 @@ void __static_call_update(struct static_
 				continue;
 			}
 
-			arch_static_call_transform(site_addr, NULL, func);
+			arch_static_call_transform(site_addr, NULL, func,
+				static_call_is_tail(site));
 		}
 	}
 
@@ -197,7 +201,8 @@ static int __static_call_init(struct mod
 			key->next = site_mod;
 		}
 
-		arch_static_call_transform(site_addr, NULL, key->func);
+		arch_static_call_transform(site_addr, NULL, key->func,
+				static_call_is_tail(site));
 	}
 
 	return 0;
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -13,6 +13,13 @@
 #define STATIC_CALL_TRAMP_STR(name) __stringify(STATIC_CALL_TRAMP(name))
 
 /*
+ * Flags in the low bits of static_call_site::key.
+ */
+#define STATIC_CALL_SITE_TAIL 1UL	/* tail call */
+#define STATIC_CALL_SITE_INIT 2UL	/* init section */
+#define STATIC_CALL_SITE_FLAGS 3UL
+
+/*
  * The static call site table needs to be created by external tooling (objtool
  * or a compiler plugin).
  */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -585,6 +585,10 @@ static int add_jump_destinations(struct
 		} else {
 			/* external sibling call */
 			insn->call_dest = rela->sym;
+			if (insn->call_dest->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
 			continue;
 		}
 
@@ -636,6 +640,10 @@ static int add_jump_destinations(struct
 
 				/* internal sibling call */
 				insn->call_dest = insn->jump_dest->func;
+				if (insn->call_dest->static_call_tramp) {
+					list_add_tail(&insn->static_call_node,
+						      &file->static_call_list);
+				}
 			}
 		}
 	}
@@ -1348,6 +1356,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	ret = add_jump_destinations(file);
 	if (ret)
 		return ret;
@@ -1372,10 +1384,6 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = read_static_call_tramps(file);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
@@ -2505,7 +2513,7 @@ static int create_static_call_sections(s
 		}
 		memset(rela, 0, sizeof(*rela));
 		rela->sym = key_sym;
-		rela->addend = 0;
+		rela->addend = is_sibling_call(insn) ? STATIC_CALL_SITE_TAIL : 0;
 		rela->type = R_X86_64_PC32;
 		rela->offset = idx * sizeof(struct static_call_site) + 4;
 		list_add_tail(&rela->list, &rela_sec->rela_list);


