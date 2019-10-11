Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B90CECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D9921835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824483;
	bh=JuVKacXKBl3G9RS9C5F3Duooaodg5fgwdn/sCeGFhkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=erPELVMxoSTtTwpJrs0oFunqeOdyvkSwucj+sRf95dBqmtMLm//xRy4WrjeFKqxyo
	 nEfstmMRkV2cfPGzVqZwVlgjFAcPURa8D6NQQyfE34EgoP9Szs32+vvBafQArhzMEd
	 yZfIlsKyJAhMAzLnHlc9JlyJZ0e/iQenjuA/UMhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfJKUIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfJKUIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:01 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1C321D7D;
        Fri, 11 Oct 2019 20:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824480;
        bh=JuVKacXKBl3G9RS9C5F3Duooaodg5fgwdn/sCeGFhkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfIxToIq5c9qQgyI8dth67pw9MxIk5QnejTWSjFckwUrCkFpT+9nxyzAD0lfnoOsB
         DUgaPncOx8ekWKe9sL6TqPHpn3LVorfdn8yHVUs6mjoFJuIeTcgBPvxIf1CMXlJh67
         XZKrPG967NX1+P43XxHtgXxrWgzw0PnYpfuqUkQM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/69] perf script: Allow --time with --reltime
Date:   Fri, 11 Oct 2019 17:05:07 -0300
Message-Id: <20191011200559.7156-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The original --reltime patch forbid --time with --reltime.

But it turns out --time doesn't really care about --reltime, because the
relative time is only used at final output, while the time filtering
always works earlier on absolute time.

So just remove the check and allow combining the two options.

Fixes: 90b10f47c0ee ("perf script: Support relative time")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191002164642.1719-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 67be8d31afab..1c797a948ada 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3605,11 +3605,6 @@ int cmd_script(int argc, const char **argv)
 		}
 	}
 
-	if (script.time_str && reltime) {
-		fprintf(stderr, "Don't combine --reltime with --time\n");
-		return -1;
-	}
-
 	if (itrace_synth_opts.callchain &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
-- 
2.21.0

