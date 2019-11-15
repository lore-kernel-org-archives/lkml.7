Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6082720815
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qZU2Vvoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKOU24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 15:28:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45908 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfKOU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:28:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id 30so12115154qtz.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 12:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=8aU7kUzVAhFuhOReMRZOycjdku8AonlGhKN+nWQwEcs=;
        b=qZU2VvoePDQU3eLe9JKJNqFAfB6pW3vjODUXmQjo5SCY7s9as6Atutaf8UcbhFaGgY
         Bu6LjtDhVcOcB7+VlD0P5hvopbPa5sGsHiH8NCBG3ekUeXRRcFTDTbHuF/KZuIEC8Dj7
         ZQDpjg5kMUyglXyF3nev5ZvParg60xLU4HqVXi+QnRARSn1FyQ1s+o58po9pA+73n2c8
         IemBxZOx1v5MVGR9qr2oIRE/WjtMHXUQ7Ezj18paTbv+ZRAJoP6y67vbtn1fFz7Jddec
         noZa8y0x5ctJYNQB+qk8+8Wn+s8mvR3kzY3vCpcr6fwP2cF2JnR7LkMTiRVJ7qGTpRIB
         Wkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=8aU7kUzVAhFuhOReMRZOycjdku8AonlGhKN+nWQwEcs=;
        b=nDEB6aVGCgU+am4qHLQBeYi14O4YKkBo48rA6DrHHKzH70gAc8+GhdWEgWOr6WZDyv
         33BMdRVjyaABQj8UFoFq9NiTMGkpurxFG0AEtciw7D6SX7Z5zTyLXBgUcq5ZFAPgYrx2
         DUFefERoddIG465DJ4R/PBwC57peBsyOAnCEro6k09xPANR9loqcWzm3F5/jV2wZdwAy
         wNJad2csCkG8s44g47jRklaPEZkr3qbdzeQyqwyaLcEBU3hwRKvTRIA1R52Xgz1gxIlS
         s0Io80bus7mDalHLiJ/res8BriF17Q/idl4mNugWXfbq5lHM6ua+yNpjTvAaioa+q36s
         YMzA==
X-Gm-Message-State: APjAAAXV9VndoZhCconqnWwaDYoxVlrq6RPnp9cXW2RQkbp+1pzpBjn8
        0fFFCTDmPRg4Ffrt4OUL7ROJ77OYzo0=
X-Google-Smtp-Source: APXvYqzI8Ckyh+jWt6BICzxL5QtcDOjHJG1ESKe4plJopAuswGrSFa6kLgilOaxCBdmbk2Afh+Acqg==
X-Received: by 2002:ac8:1b85:: with SMTP id z5mr15773962qtj.308.1573849734811;
        Fri, 15 Nov 2019 12:28:54 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t16sm4583601qkm.73.2019.11.15.12.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 12:28:54 -0800 (PST)
Message-ID: <1573849732.5937.136.camel@lca.pw>
Subject: powerpc ftrace broken due to "manual merge of the ftrace tree with
 the arm64 tree"
From:   Qian Cai <cai@lca.pw>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 15 Nov 2019 15:28:52 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# echo function >/sys/kernel/debug/tracing/current_tracer

It hangs forever with today's linux-next on powerpc. Reverted the conflict fix
[1] as below fixes the issue.

[1] https://lore.kernel.org/linux-next/20191115135357.10386fac@canb.auug.org.au/

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
generic/vmlinux.lds.h
index 7d0d03a03d4d..a92222f79b53 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -136,29 +136,20 @@
 #endif
 
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
-/*
- * The ftrace call sites are logged to a section whose name depends on the
- * compiler option used. A given kernel image will only use one, AKA
- * FTRACE_CALLSITE_SECTION. We capture all of them here to avoid header
- * dependencies for FTRACE_CALLSITE_SECTION's definition.
- */
-/*
- * Need to also make ftrace_graph_stub point to ftrace_stub
- * so that the same stub location may have different protocols
- * and not mess up with C verifiers.
- */
-#define MCOUNT_REC()	. = ALIGN(8);				\
+#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
+#define MCOUNT_REC()	. = ALIGN(8)				\
 			__start_mcount_loc = .;			\
-			KEEP(*(__mcount_loc))			\
 			KEEP(*(__patchable_function_entries))	\
 			__stop_mcount_loc = .;			\
 			ftrace_graph_stub = ftrace_stub;
 #else
-# ifdef CONFIG_FUNCTION_TRACER
-#  define MCOUNT_REC()	ftrace_graph_stub = ftrace_stub;
-# else
-#  define MCOUNT_REC()
-# endif
+#define MCOUNT_REC()	. = ALIGN(8);				\
+			__start_mcount_loc = .;			\
+			KEEP(*(__mcount_loc))			\
+			__stop_mcount_loc = .;
+#endif
+#else
+#define MCOUNT_REC()
 #endif
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
