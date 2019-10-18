Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13552CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FFD20872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437185;
	bh=zR7PEpWo1SHxfPoogzU2Cy0kOuipPdgvp9JuFhSZZqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=egHbFBQoPC4MC3cpwK1k39WkvYEWM0Owmeo6e9gzPbLXwS9w1dQCVv9szAXVFVQfy
	 jjH+kEpuW5HTr+/ha5PITA849jjoi36SbW+HBMeQwyBbPVsblm8NYF2exBuhlX5HFn
	 MEs2YUw31XOd5TvJLb2x8xo2kWi6K0uklD8j/3A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbfJRWG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731935AbfJRWGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:06:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67A1222C2;
        Fri, 18 Oct 2019 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436404;
        bh=zR7PEpWo1SHxfPoogzU2Cy0kOuipPdgvp9JuFhSZZqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkJ+N6qv1OUTZ7A3VnJcZhgXTbDAxXDKiTLUPrv9vmgiBUdb9d4XWyE0qYfgYNzPM
         RLNWAn9ovrcsAONns4AgeqzXo0+BislKncbS9LGhRTX8O//bNAsxOrNyZuxbcHEKTM
         eUqSIUXbYPfyds4XCnRvfK91pNo4n+NNYTcqK8UA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 052/100] libsubcmd: Make _FORTIFY_SOURCE defines dependent on the feature
Date:   Fri, 18 Oct 2019 18:04:37 -0400
Message-Id: <20191018220525.9042-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

[ Upstream commit 4b0b2b096da9d296e0e5668cdfba8613bd6f5bc8 ]

Unconditionally defining _FORTIFY_SOURCE can break tools that don't work
with it, such as memory sanitizers:

  https://github.com/google/sanitizers/wiki/AddressSanitizer#faq

Fixes: 4b6ab94eabe4 ("perf subcmd: Create subcmd library")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20190925195924.152834-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/subcmd/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index ed61fb3a46c08..5b2cd5e58df09 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -20,7 +20,13 @@ MAKEFLAGS += --no-print-directory
 LIBFILE = $(OUTPUT)libsubcmd.a
 
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fPIC
+CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
+
+ifeq ($(DEBUG),0)
+  ifeq ($(feature-fortify-source), 1)
+    CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
+  endif
+endif
 
 ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
-- 
2.20.1

