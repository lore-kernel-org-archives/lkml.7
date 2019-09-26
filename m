Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E55C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53B921D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1V+3mtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfIZQY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:24:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36720 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfIZQY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:24:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so3264766wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nru33jX5uOHTAnOwLDnlw05X11ddri3AYOGkrr2Jgw=;
        b=V1V+3mtP4Mr4m1w6tfMRbEe9Ot6If7Ve01XI2YG4LZeIr9POGflhogI5MiaFDd+OTC
         gb8KPbGdy7b/A35QAk4fvXuCzB/GnS3FL9lkD0hlAe6PEzNZx4SpDwynLfg7+NPHmlMt
         ZN7IRg8XP3Ln2EO9I4oLGYs6OjlH2hDIxZEZZD8f3COYXFxmpjYDstW5vNK3G8sJA2X9
         ARQ5J8yGrbqaxrI8A5HmRdJDuZqX3dAfsuPBC0V+ws5m5a2ph9pO41VUHFAAv9H/gY3a
         qVbYreAXZVhNLlQUp2UGxcrvyxqemO0mWdozn0/WEv/124DO4O2TNRv+Rcpr5cYfPZVU
         EWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nru33jX5uOHTAnOwLDnlw05X11ddri3AYOGkrr2Jgw=;
        b=R5mNG5ufPERp+/QHXjNbbQjaZeBDITYLdObuRPO22HTyuLpBeRkUxOsUcD8p9ws/IO
         fkhhEUPCc4HBaxmGnSo2uOOkY6lpbzYKumlBv6OSLc5zCQCK41h1AYFL3f1+s7wadw9p
         /SNWiG+0JyUUhQg5eHQKMvfg5ezgXAYiFwQMnVddt0352+cE23eCXXKCmFWuD6h9dC+6
         oRT4f6WsE93IJ1Yjb9crzFn3d2JafviSwf1iQ4S+XmDzaBFyI7pae4txTFxgXtdEite+
         Pc6Fj6Nw9COPqggm+YXni7q4McGwak93dgn+pc2rVWsuMGJ8p8G4FbT1YPKu2lPs3q2a
         wbRA==
X-Gm-Message-State: APjAAAVMWbfU5uOZQ+6KtXVo0uhQQVc8j3sZvpO2Rm9FwmkQyrJ1SBK9
        f+YEeF8M43KRGNsqhtthCNg=
X-Google-Smtp-Source: APXvYqwaeWWyc+5+I6rQCqh8o9AxGdr9DXIEJ1q4zyd710j8awNFMljewcJbtzhvMqUo+yVe/31u8Q==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr3688226wme.41.1569515094418;
        Thu, 26 Sep 2019 09:24:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id t6sm5820701wmf.8.2019.09.26.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 09:24:53 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        David Bolvansky <david.bolvansky@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] tracing: Fix clang -Wint-in-bool-context warnings in IF_ASSIGN macro
Date:   Thu, 26 Sep 2019 09:22:59 -0700
Message-Id: <20190926162258.466321-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925172915.576755-1-natechancellor@gmail.com>
References: <20190925172915.576755-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After r372664 in clang, the IF_ASSIGN macro causes a couple hundred
warnings along the lines of:

kernel/trace/trace_output.c:1331:2: warning: converting the enum
constant to a boolean [-Wint-in-bool-context]
kernel/trace/trace.h:409:3: note: expanded from macro
'trace_assign_type'
                IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,
                ^
kernel/trace/trace.h:371:14: note: expanded from macro 'IF_ASSIGN'
                WARN_ON(id && (entry)->type != id);     \
                           ^
264 warnings generated.

This warning can catch issues with constructs like:

    if (state == A || B)

where the developer really meant:

    if (state == A || state == B)

This is currently the only occurrence of the warning in the kernel
tree across defconfig, allyesconfig, allmodconfig for arm32, arm64,
and x86_64. Add the implicit '!= 0' to the WARN_ON statement to fix
the warnings and find potential issues in the future.

Link: https://github.com/llvm/llvm-project/commit/28b38c277a2941e9e891b2db30652cfd962f070b
Link: https://github.com/ClangBuiltLinux/linux/issues/686
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Update commit message to give context behind the warning and explain
  this is currently the only occurrence of this warning in the tree.
* Add Nick's Reviewed-by tag.

 kernel/trace/trace.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 26b0a08f3c7d..f801d154ff6a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -365,11 +365,11 @@ static inline struct trace_array *top_trace_array(void)
 	__builtin_types_compatible_p(typeof(var), type *)
 
 #undef IF_ASSIGN
-#define IF_ASSIGN(var, entry, etype, id)		\
-	if (FTRACE_CMP_TYPE(var, etype)) {		\
-		var = (typeof(var))(entry);		\
-		WARN_ON(id && (entry)->type != id);	\
-		break;					\
+#define IF_ASSIGN(var, entry, etype, id)			\
+	if (FTRACE_CMP_TYPE(var, etype)) {			\
+		var = (typeof(var))(entry);			\
+		WARN_ON(id != 0 && (entry)->type != id);	\
+		break;						\
 	}
 
 /* Will cause compile errors if type is not found. */
-- 
2.23.0

