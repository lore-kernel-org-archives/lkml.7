Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353C4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F375D21726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121838;
	bh=0Qz9b1PrcTQAjJEL1MWBec8n2srSklgE6KjDAFiqyqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xnvqVO5JqBvKoyBzOT5usgkJ5vA6FBjqKQFZoE7sbEYz42ak0vYc5WBhktK887Sq6
	 VaEpdqNAHwd+Wy31cWRegzAil8+OxkMUs8bHShrEvf1KPvbASflLZLwS3MBfpamdS1
	 YQ1BPtp3xy2EPIoy04jCyc4h1WF8PSCCmFykkIfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfEQThR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729467AbfEQThO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:14 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA53021744;
        Fri, 17 May 2019 19:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121834;
        bh=0Qz9b1PrcTQAjJEL1MWBec8n2srSklgE6KjDAFiqyqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWwt+D87rTIgokwRp/pKIJLVMNr2KzlA9Va1vwTA9uoJETq2K0ZLIbcnYQWnLwEQ1
         B6sRD+zFZ2/hkEDY/bQ0V5XS+ow9GWGjQNKigB20MkFYHWmwUH6nI2nIMKvTXJ/OJ6
         zif/rUwH8C/B373aCpxXgqQ5S/UnPaqoZQ7mJ2Hw=
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
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 11/73] perf parse-regs: Improve error output when faced with unknown register name
Date:   Fri, 17 May 2019 16:35:09 -0300
Message-Id: <20190517193611.4974-12-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add quotes around the register name and suggest using 'perf record -I?'
to get the list of available registers.

Before:

  # perf record -Idi,xmm20,xmm1
  Warning:
  unknown register xmm20, check man page

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use -I ? to list register names
  #
  # perf record -Idi,xmm20,xmm1
  Warning:
  unknown register "xmm20", check man page or run "perf record -I?"

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use -I ? to list register names
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/n/tip-9a9hyuum8c0oggg86xd3sxc5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-regs-options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index e6599e290f46..9cb187a20fe2 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -48,8 +48,7 @@ parse_regs(const struct option *opt, const char *str, int unset)
 					break;
 			}
 			if (!r->name) {
-				ui__warning("unknown register %s,"
-					    " check man page\n", s);
+				ui__warning("Unknown register \"%s\", check man page or run \"perf record -I?\"\n", s);
 				goto error;
 			}
 
-- 
2.20.1

