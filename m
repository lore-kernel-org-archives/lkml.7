Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B8120848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558021912;
	bh=QSVxLj4o4J6o9CK+uFDxNDJrRBbpSZz9f9Vd1pE3KN8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hsBDZFQQmbcWaJRJVuuJ7MBRGE8DEs1hUe6Unl2eKAJwV+J/AD0E72/dT7NrXhdPz
	 X50aseEqmgn/zTWnv+ncW0HCW44VNabaInI9Ny07tyZbEriyLg8DM0cUXYy1NCyQgB
	 MHeUXqQlD2fMI87HlpzFC8PGrbQ67tztlONaBMGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfEPPvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:51:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39020 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:51:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id w8so3978811wrl.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OioNcN35Lm+YEez/YaR4m4PLqY4Le+d1z20xgrLLTNM=;
        b=pQlrXziGZpbBonwH6++cQ0HSWdjp+5Oaaj5Kcym5bV7zOrGrZFx/EMjed7Gnw1IjNV
         3YvMKk2K06Qa0Je9h8u2CoOsK3bxgyVzJI2CDxt25IOMh4nFZlUrKe7oRoZ1aI0yH6G7
         Urxv2isGFqKI2F3a5nsaJ9AumZ7n2LPtWmxJdnjIeFJf/ZTO6tnheXPtAZGYYgopOzQl
         p+Uv4OZIN7Krjj06pvzh9JqcOFOrTmoloZyopA+ighHykkP5GD3sdMDexfiO6IxTsM4r
         cP0r/DFbOC/jdqjYzBVBjdUU2uatqgr4YhkihvvMrnhQ7CuZitjlYZJZDPVBRIfZt08b
         K7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OioNcN35Lm+YEez/YaR4m4PLqY4Le+d1z20xgrLLTNM=;
        b=ayGqnJcXyUEsyo3j3wwN5rYHpfQpS1ppxn/Au3AZPGh5hXuAQ2C/rUkN+suibtca31
         57LTMXPMux4esnCD/xZ4I4OiFRp29lJOf0wvht7YezIpFg67G9YUmSnj1p2Wu3YbCGrI
         s49qsz6kh54qu2GvCpJOaD3o24EhuN9JCZG9ur939JBFjL/66WxFe+TMuJl23pOgYLF9
         Egpd+aguBhnNonRJv0M8yEapRRURLBqVdONfnj9/O9ISpOB7qY3fopF9fQ9uzXjZaEQx
         bLIte36hZtQxZchiEsQqeRm16EdziyaVsLMV+hhF2y1X9QcTSlLDkmT0nFzyP+Anb9Jz
         dBJQ==
X-Gm-Message-State: APjAAAVKTAkh9ZDfA1OpcUVzFgFc3P9mdg07gY+5wRQrWhvvsqAMvldE
        zM7sGer1Cly9gVxAvKtJpcI=
X-Google-Smtp-Source: APXvYqw4gBDO4CXMKvwYZRNn2zOJEHoWoCb54KrUYcTsZ/y84VoLDxtF7Wn4Ltt8shgYTBvfSVKlSg==
X-Received: by 2002:adf:b612:: with SMTP id f18mr30445650wre.236.1558021909667;
        Thu, 16 May 2019 08:51:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h11sm7240814wrr.44.2019.05.16.08.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 08:51:49 -0700 (PDT)
Date:   Thu, 16 May 2019 17:51:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core kernel fixes
Message-ID: <20190516155146.GA48500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 2decec48b0fd28ffdbf4cc684bd04e735f0839dd objtool: Fix whitelist documentation typo

A handful of objtool updates, plus a documentation addition for 
__ab_c_size().

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (2):
      objtool: Don't use ignore flag for fake jumps
      objtool: Fix function fallthrough detection

Raphael Gault (1):
      objtool: Fix whitelist documentation typo

Rasmus Villemoes (1):
      overflow.h: Add comment documenting __ab_c_size()


 include/linux/overflow.h                         |  8 ++++++--
 tools/objtool/Documentation/stack-validation.txt |  2 +-
 tools/objtool/check.c                            | 11 +++++++----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 40b48e2133cb..6534a727cadb 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -278,11 +278,15 @@ static inline __must_check size_t array3_size(size_t a, size_t b, size_t c)
 	return bytes;
 }
 
-static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
+/*
+ * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
+ * struct_size() below.
+ */
+static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(n, size, &bytes))
+	if (check_mul_overflow(a, b, &bytes))
 		return SIZE_MAX;
 	if (check_add_overflow(bytes, c, &bytes))
 		return SIZE_MAX;
diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index 3995735a878f..cd17ee022072 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -306,7 +306,7 @@ ignore it:
 
 - To skip validation of a file, add
 
-    OBJECT_FILES_NON_STANDARD_filename.o := n
+    OBJECT_FILES_NON_STANDARD_filename.o := y
 
   to the Makefile.
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ac743a1d53ab..7325d89ccad9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -28,6 +28,8 @@
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
 
+#define FAKE_JUMP_OFFSET -1
+
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -568,7 +570,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
 			continue;
 
-		if (insn->ignore)
+		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
 			continue;
 
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
@@ -745,10 +747,10 @@ static int handle_group_alt(struct objtool_file *file,
 		clear_insn_state(&fake_jump->state);
 
 		fake_jump->sec = special_alt->new_sec;
-		fake_jump->offset = -1;
+		fake_jump->offset = FAKE_JUMP_OFFSET;
 		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
 		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
-		fake_jump->ignore = true;
+		fake_jump->func = orig_insn->func;
 	}
 
 	if (!special_alt->new_len) {
@@ -1957,7 +1959,8 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			return 1;
 		}
 
-		func = insn->func ? insn->func->pfunc : NULL;
+		if (insn->func)
+			func = insn->func->pfunc;
 
 		if (func && insn->ignore) {
 			WARN_FUNC("BUG: why am I validating an ignored function?",
