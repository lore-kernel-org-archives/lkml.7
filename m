Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E387C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06F421655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138901;
	bh=KV6UX53In4jwl+sZZBkp4ypbXQlUCCFyq9XRAOPKwR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZAXMdqmuQovdQjpxMQUmxbdcnQiUoXqAYxtbD2f+J+zeX6NriI6NOySkZVM+Ja1L
	 dCd5amUgJObNw6ZLunJ90rEf/kU6Pwi1hM12wHPlcfROUMo11qJDEos44Uw0BJL5rb
	 oGBLNO/KHsiIZrTFC0x0WhvOCUXbGLk5B1xBlXiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFURlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfFURlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:41:39 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBF321530;
        Fri, 21 Jun 2019 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138898;
        bh=KV6UX53In4jwl+sZZBkp4ypbXQlUCCFyq9XRAOPKwR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rF4ukSfGXdvkm6S/jW7nOUgpsldLSKo7GFolV2XO032rw1TvZXfgqb42242Ihwsuc
         zr1pD1L9P0/cmgYYVUlzELA1Uk/E2XTTSRFmO3Onj7sSbomgplZVQO0PFg9OrdTOFK
         tiJo3uHZ9jEQwNyqAwIfkS1lahKgn0G/1g095628=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 25/25] tools build: Fix the zstd test in the test-all.c common case feature test
Date:   Fri, 21 Jun 2019 14:38:31 -0300
Message-Id: <20190621173831.13780-26-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were renanimg 'main' to 'main_zstd' but then using 'main_libzstd();'
in the main() for test-all.c, causing this:

  $ cat /tmp/build/perf/feature/test-all.make.output
  test-all.c: In function ‘main’:
  test-all.c:236:2: error: implicit declaration of function ‘main_test_libzstd’; did you mean ‘main_test_zstd’? [-Werror=implicit-function-declaration]
    main_test_libzstd();
    ^~~~~~~~~~~~~~~~~
    main_test_zstd
  cc1: all warnings being treated as errors
  $

I.e. what was supposed to be the fast path feature test was _always_
failing, duh, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Fixes: 3b1c5d965971 ("tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines")
Link: https://lkml.kernel.org/n/tip-ma4abk0utroiw4mwpmvnjlru@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 3b3d5d72124a..88145e8cde1a 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -186,7 +186,7 @@
 # include "test-disassembler-four-args.c"
 #undef main
 
-#define main main_test_zstd
+#define main main_test_libzstd
 # include "test-libzstd.c"
 #undef main
 
-- 
2.20.1

