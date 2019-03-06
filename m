Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D8D2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551864138;
	bh=Ni5Il5SJyLLsMbsVLkgA+TwtCi+ZAw1omkXVajFNQ2o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HUDZrRI1GLVhSPHzRxAQOR/TAAZp6sm0mYk/5LdLAQ7aSpQgOWRgR4xq25zCgizz7
	 8p4+lqN11jobOzDOpGd5WdYHWuZqJbQyyMy2UQSkqMpEgF7S2tgcFtmGuaqH6IYpFx
	 OcldYaaoOjar58lWfEIUYTw6+nQjn3Lh2UzO3EI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfCFJWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:22:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52803 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbfCFJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:22:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id f65so5147643wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 01:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Oc2GjTEdy8gSdKQ+jM0/hfernEqzymBawwOdEZNiexI=;
        b=OfxtmHJIQDKbe+Ko807LOKokFaK7akBvZ2QrgQB1HQGzSkL8JBLT5eqdTfhc+AjNJG
         NbViEFn4g6OOeHMyYt7gEhJJSKQDUh+nhSe2Q7PlF/VvdIiNxgucytb8uOc0eZZmIFVn
         FtomAsFaGavPppYDRcP+ER7Nr0o03BjtGtr2R2Lu4XIEpbVW6o/QGsYugAZQrk5CW8bJ
         iZG2PfT4uawDMm9wm5HTXHmE/gkfxRbxB+ZdzZV97Wlx6hNSc2cMPTAqEUavnx62hrPw
         LG/tX0yltO/INKsEZKTMqN9b4QixWC1kpH93FfKBMo06M2hRdKOiv9hy6C95huHGB78X
         jdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Oc2GjTEdy8gSdKQ+jM0/hfernEqzymBawwOdEZNiexI=;
        b=X4mT0QrlQeE+yezGK9SyxjfLpB+bNg92IYVlTT69FEhSJ9otx3eJvh4j0oQEVvA2v4
         EKsWVo67xaYfZrVwf5L87t86nxF9mS5GVSwHZ19tgR++IkDKC4WUVYXXY6y+G5ofwWaG
         QPNhA+S7vllMLL4egRPEhjB3o8yNw1pM4ooORDod8dMBHCDZqiM9hTEuGPLO6WCyz4qv
         /qafj6inOzET94QM7uOvwpW6Ygb6mfjXXu+oEhtbVgCxtGRukoaVFLfYq40gupKgyXc/
         Aw2qvOya7pOJzrLW92+iae49Nx7HtauuHWorpcrMS6d3NMgZtUh3pxZ2VRmo9NdfeCoY
         SI4A==
X-Gm-Message-State: APjAAAVk7ldcVNpJWMbmNDQHtxbIvx94BZTLABeC6IF2zWZbKKDh5ZZs
        B59ABnUkwp4nKQ3ynfnQ9xs=
X-Google-Smtp-Source: APXvYqxTgjGkUQHDCifitYRLDd7U1mFX6Ve+Br/lKN6iVNqYSqSubrV6VhvT7AbZrNpjaiNRb5yMZQ==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr1601902wmc.58.1551864134404;
        Wed, 06 Mar 2019 01:22:14 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n129sm983442wmf.21.2019.03.06.01.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 01:22:13 -0800 (PST)
Date:   Wed, 6 Mar 2019 10:22:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/alternatives changes for v5.1
Message-ID: <20190306092211.GA61063@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-alternatives-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-alternatives-for-linus

   # HEAD: 093ae8f9a86a974c920b613860f1f7fd5bbd70ab x86/TSC: Use RDTSCP

Small RDTSCP opimization, enabled by the newly added ALTERNATIVE_3(), and 
other small improvements.

 Thanks,

	Ingo

------------------>
Borislav Petkov (4):
      x86/alternatives: Add macro comments
      x86/alternatives: Print containing function
      x86/alternatives: Add an ALTERNATIVE_3() macro
      x86/TSC: Use RDTSCP


 arch/x86/include/asm/alternative.h | 39 +++++++++++++++++++++++++++++++-------
 arch/x86/include/asm/msr.h         | 16 ++++++++++++++--
 arch/x86/kernel/alternative.c      |  4 ++--
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 0660e14690c8..4c74073a19cc 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -94,13 +94,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define alt_total_slen		alt_end_marker"b-661b"
 #define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
 
-#define __OLDINSTR(oldinstr, num)					\
+#define OLDINSTR(oldinstr, num)						\
+	"# ALT: oldnstr\n"						\
 	"661:\n\t" oldinstr "\n662:\n"					\
+	"# ALT: padding\n"						\
 	".skip -(((" alt_rlen(num) ")-(" alt_slen ")) > 0) * "		\
-		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"
-
-#define OLDINSTR(oldinstr, num)						\
-	__OLDINSTR(oldinstr, num)					\
+		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
 	alt_end_marker ":\n"
 
 /*
@@ -116,11 +115,23 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * additionally longer than the first replacement alternative.
  */
 #define OLDINSTR_2(oldinstr, num1, num2) \
+	"# ALT: oldinstr2\n"									\
 	"661:\n\t" oldinstr "\n662:\n"								\
+	"# ALT: padding2\n"									\
 	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
 		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
 	alt_end_marker ":\n"
 
+#define OLDINSTR_3(oldinsn, n1, n2, n3)								\
+	"# ALT: oldinstr3\n"									\
+	"661:\n\t" oldinsn "\n662:\n"								\
+	"# ALT: padding3\n"									\
+	".skip -((" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
+		" - (" alt_slen ")) > 0) * "							\
+		"(" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
+		" - (" alt_slen ")), 0x90\n"							\
+	alt_end_marker ":\n"
+
 #define ALTINSTR_ENTRY(feature, num)					      \
 	" .long 661b - .\n"				/* label           */ \
 	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
@@ -129,8 +140,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
 	" .byte " alt_pad_len "\n"			/* pad len */
 
-#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */     \
-	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n\t"
+#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */	\
+	"# ALT: replacement " #num "\n"						\
+	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
 
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, newinstr, feature)			\
@@ -153,6 +165,19 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
 	".popsection\n"
 
+#define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
+	OLDINSTR_3(oldinsn, 1, 2, 3)						\
+	".pushsection .altinstructions,\"a\"\n"					\
+	ALTINSTR_ENTRY(feat1, 1)						\
+	ALTINSTR_ENTRY(feat2, 2)						\
+	ALTINSTR_ENTRY(feat3, 3)						\
+	".popsection\n"								\
+	".pushsection .altinstr_replacement, \"ax\"\n"				\
+	ALTINSTR_REPLACEMENT(newinsn1, feat1, 1)				\
+	ALTINSTR_REPLACEMENT(newinsn2, feat2, 2)				\
+	ALTINSTR_REPLACEMENT(newinsn3, feat3, 3)				\
+	".popsection\n"
+
 /*
  * Alternative instructions for different CPU types or capabilities.
  *
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 91e4cf189914..5cc3930cb465 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -217,6 +217,8 @@ static __always_inline unsigned long long rdtsc(void)
  */
 static __always_inline unsigned long long rdtsc_ordered(void)
 {
+	DECLARE_ARGS(val, low, high);
+
 	/*
 	 * The RDTSC instruction is not ordered relative to memory
 	 * access.  The Intel SDM and the AMD APM are both vague on this
@@ -227,9 +229,19 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	 * ordering guarantees as reading from a global memory location
 	 * that some other imaginary CPU is updating continuously with a
 	 * time stamp.
+	 *
+	 * Thus, use the preferred barrier on the respective CPU, aiming for
+	 * RDTSCP as the default.
 	 */
-	barrier_nospec();
-	return rdtsc();
+	asm volatile(ALTERNATIVE_3("rdtsc",
+				   "mfence; rdtsc", X86_FEATURE_MFENCE_RDTSC,
+				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
+				   "rdtscp", X86_FEATURE_RDTSCP)
+			: EAX_EDX_RET(val, low, high)
+			/* RDTSCP clobbers ECX with MSR_TSC_AUX. */
+			:: "ecx");
+
+	return EAX_EDX_VAL(val, low, high);
 }
 
 static inline unsigned long long native_read_pmc(int counter)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ebeac487a20c..d458c7973c56 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -393,10 +393,10 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			continue;
 		}
 
-		DPRINTK("feat: %d*32+%d, old: (%px len: %d), repl: (%px, len: %d), pad: %d",
+		DPRINTK("feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
-			instr, a->instrlen,
+			instr, instr, a->instrlen,
 			replacement, a->replacementlen, a->padlen);
 
 		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
