Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872EACA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0C6217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904382;
	bh=zR7PEpWo1SHxfPoogzU2Cy0kOuipPdgvp9JuFhSZZqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RDCceubEw0cLxnqHVmZ4tVCObg81i3Fn+/d7pUICoQ4C0plYhV65KLQNOjYY3xTJW
	 PB9EvRNMTtD5fWomdB2+ADkqbnX1RuQf+7ToCE9PoXAtaJiL0ut0ZRxoHNkhUlsQsl
	 OoI7XyhASvt85Pcpad3h8FsW1RDq3RnhntiycYrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfKDVxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730218AbfKDVw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:52:59 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B06217F5;
        Mon,  4 Nov 2019 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904378;
        bh=zR7PEpWo1SHxfPoogzU2Cy0kOuipPdgvp9JuFhSZZqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLBsbJfudfBThYPVdf6iU/l+0++ClkC1wpVfffTPbqref2CQS6Czkn39E9u6Sz6+U
         y2sDx99ZGFDAkIXRrerBl4ixnKrYnR3qauiPaos1WUoB9kZx0tlICZGUhhufdqQ8ES
         MntQhR9UYM+CVxoEtsU3o/SOHo8V4MYLwDr1G8RU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 26/95] libsubcmd: Make _FORTIFY_SOURCE defines dependent on the feature
Date:   Mon,  4 Nov 2019 22:44:24 +0100
Message-Id: <20191104212054.986327729@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



