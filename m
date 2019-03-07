Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58EDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E930208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980716;
	bh=trIEVRVxM1QCf+iC13wk9xStN/dUDGdlC1xp+S4G8bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yM6STba/BOA3x/u/2W38Zi5b8DfCTXeMf33LdX/ufFgwTf2kud4MXkMVp9XjIAg3F
	 JQD56FfcUnQFznXs6yW0Kun+NZNFyW6Iod44h0udk7Gx58DRx8kGZHMHS+TZ0YE8f2
	 LCIPlMW7f8Sn17yRv1k3STdWFj9d4ClbcErpP6TQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfCGRpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfCGRpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:12 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F34CD20851;
        Thu,  7 Mar 2019 17:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980712;
        bh=trIEVRVxM1QCf+iC13wk9xStN/dUDGdlC1xp+S4G8bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdeeT5kWJamEW06REGcRFNhgD2Mm/cILJitcQB436cdDgxC++PgjOJsbMXtPkaqY+
         xW2PyyM89H95sAKAXj+HfEnm8NZKJ83kvWfaVDHMFqHylltV2WKKzQnjUv8p14tqyD
         Otm5GMmzTJ6NdLmL4xqpHZGj+LuX16K85fxROoQg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 06/35] perf auxtrace: Improve address filter error message when there is no DSO
Date:   Thu,  7 Mar 2019 14:44:04 -0300
Message-Id: <20190307174433.28819-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The message does not indicate the possibility that the symbol is not
found because the file does not exist.

Before:

  $ perf record -e intel_pt//u --filter 'filter strcmp / strcpy @ foo ' ls
  Symbol 'strcmp' not found.
  Note that symbols must be functions.
  Failed to parse address filter: 'filter strcmp / strcpy @ foo '
  Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
  Where multiple filters are separated by space or comma.

After:

  $ perf record -e intel_pt//u --filter 'filter strcmp / strcpy @ foo ' ls
  File 'foo' not found or has no symbols.
  Symbol 'strcmp' not found.
  Note that symbols must be functions.
  Failed to parse address filter: 'filter strcmp / strcpy @ foo '
  Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
  Where multiple filters are separated by space or comma.

Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-dvngzxd0jkplzw1ary69dilb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 267e54df511b..fb76b6b232d4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1918,7 +1918,8 @@ static struct dso *load_dso(const char *name)
 	if (!map)
 		return NULL;
 
-	map__load(map);
+	if (map__load(map) < 0)
+		pr_err("File '%s' not found or has no symbols.\n", name);
 
 	dso = dso__get(map->dso);
 
-- 
2.20.1

