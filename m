Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0832DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08E721473
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996834;
	bh=UBvHPaQgIdgKfR0wa7tm2/SxmKb4dsvvEt/XAplS+1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TgOYnGT1WX7q+HLU6SDZViJNWfn9hTu5WltDiQm502cy01ELIhOtACsmFdHyVZnpv
	 As9ubZWk+Ua7a5tFuyV4HmoFt6dYr1Q+0rLcI+XO1l25aPoge5ABBrJYVqOcwIGNJ6
	 jE26mn2yp8vpr6yzDy6ceGjRfEkj6XrfLphUIkk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfE0Wke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfE0Wkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:40:32 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA6D120859;
        Mon, 27 May 2019 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996832;
        bh=UBvHPaQgIdgKfR0wa7tm2/SxmKb4dsvvEt/XAplS+1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqQ4R01MZpItoXKIxVYkXOJQ9PTfdAADbCbcCY+bbtL4GaSK/xiaEKbg7eN+cmYIH
         3J84rHLlZ7TzkWQOiZTFxfnnHpNimBmFmnqLsZT84xII/8gxZgd2WqmkjwRaYw/an0
         RjA5qB/egBINNkHfE1lM8rgNmyNwkahoCFYjyBYc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 34/44] perf test vmlinux-kallsyms: Ignore aliases to _etext when searching on kallsyms
Date:   Mon, 27 May 2019 19:37:20 -0300
Message-Id: <20190527223730.11474-35-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need to search for aliases for the symbol that marks the end of the
kernel text segment, the following patch will make such symbols not to
be found when searching in the kallsyms maps causing this test to fail.

So as a prep patch to avoid breaking bisection, ignore such symbols.

Tested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lkml.kernel.org/n/tip-qfwuih8cvmk9doh7k5k244eq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 7691980b7df1..f101576d1c72 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -161,9 +161,16 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
 				continue;
 			}
-		} else
+		} else if (mem_start == kallsyms.vmlinux_map->end) {
+			/*
+			 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
+			 * such as __indirect_thunk_end.
+			 */
+			continue;
+		} else {
 			pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
 				 mem_start, sym->name);
+		}
 
 		err = -1;
 	}
-- 
2.20.1

