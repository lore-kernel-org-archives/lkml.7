Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC36C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FD921850
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034428;
	bh=EPJ8c8Rd20a7PBgWznLzMOaOtWeQXpdPSQ956ka5xus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z+z+JOEdgCaDIRVflC6JuoDVqr+wL8BRv3iNtMZ9taZISjRTZlALIumzWVeoSSiv1
	 es1jwd3l32MEOF5bRN1go9MDQQizeq6JwujZmG3/8JAYd4VWpoFrLhcrnroCV2ytGj
	 t4p/DZ3u+l1gVrjS9xUcnvRVsbadAIF7sgjoPmB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfGBC1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfGBC1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C396F2183F;
        Tue,  2 Jul 2019 02:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034425;
        bh=EPJ8c8Rd20a7PBgWznLzMOaOtWeQXpdPSQ956ka5xus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLtZ0qXVOQyj0hWoeB/VUXH5suPe/c51NNuKvkj49bECip0uKVEp31YYw3d/c1Vs0
         U0JcJ4C1ln0nyBVklH4RAvdaUabkQdxpuOepvb4K9TqgPV5O55NOXYkRrDuSZv9Lar
         hbQduIzr6LqePIvAG/MWUNXHkezvfZtJ5EmYfRG4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 13/43] perf ui stdio: No need to use 'spaces' to left align
Date:   Mon,  1 Jul 2019 23:25:46 -0300
Message-Id: <20190702022616.1259-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We can just use the 'field width' for the %s used to print the
alignment, this way we'll get the same result without requiring having a
variable with just lots of space chars.

No way to do that for the dots tho, we still need that variable filled
with dot chars.

  # perf report --stdio --hierarchy > before
  # perf report --stdio --hierarchy > after
  # diff before after
  #

I.e. it continues as:

  # perf report --stdio --hierarchy | head -15
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 107  of event 'cycles'
  # Event count (approx.): 31378313
  #
  #       Overhead  Command / Shared Object / Symbol
  # ..............  ............................................
  #
      80.13%        swapper
         72.29%        [kernel.vmlinux]
            49.85%        [k] intel_idle
             9.05%        [k] tick_nohz_next_event
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9s1dxik37waveor7c84hqti2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/stdio/hist.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index a60f2993d390..4c97e3cdf173 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -566,10 +566,14 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 static int print_hierarchy_indent(const char *sep, int indent,
 				  const char *line, FILE *fp)
 {
+	int width;
+
 	if (sep != NULL || indent < 2)
 		return 0;
 
-	return fprintf(fp, "%-.*s", (indent - 2) * HIERARCHY_INDENT, line);
+	width = (indent - 2) * HIERARCHY_INDENT;
+
+	return fprintf(fp, "%-*.*s", width, width, line);
 }
 
 static int hists__fprintf_hierarchy_headers(struct hists *hists,
@@ -587,7 +591,7 @@ static int hists__fprintf_hierarchy_headers(struct hists *hists,
 	indent = hists->nr_hpp_node;
 
 	/* preserve max indent depth for column headers */
-	print_hierarchy_indent(sep, indent, spaces, fp);
+	print_hierarchy_indent(sep, indent, " ", fp);
 
 	/* the first hpp_list_node is for overhead columns */
 	fmt_node = list_first_entry(&hists->hpp_formats,
@@ -816,7 +820,7 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		if (!h->leaf && !hist_entry__has_hierarchy_children(h, min_pcnt)) {
 			int depth = hists->nr_hpp_node + h->depth + 1;
 
-			print_hierarchy_indent(sep, depth, spaces, fp);
+			print_hierarchy_indent(sep, depth, " ", fp);
 			fprintf(fp, "%*sno entry >= %.2f%%\n", indent, "", min_pcnt);
 
 			if (max_rows && ++nr_rows >= max_rows)
-- 
2.20.1

