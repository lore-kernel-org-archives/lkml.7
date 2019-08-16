Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECC5C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FB22171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986673;
	bh=mYHM5SYmZvM8wXHedadHXYlb8ztSWyF0bcoIOEc3qDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OSuO7yF51j5mgt73QApn42E/zQ9VdFK/yXilOCIPEOOyupvwJ5TDYYr08/RGOIj8k
	 3zy7XwdsJ39WwJN+riXZ4HGterTIkcXzn4BczTiEBSMhcKrBmofzNWOzrL1DTLHjXh
	 IwQx5nKCMZ1kmmAw8NXzJcCcQXhjXdqjW8Csi008=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfHPURw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfHPURv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:17:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2B221743;
        Fri, 16 Aug 2019 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986670;
        bh=mYHM5SYmZvM8wXHedadHXYlb8ztSWyF0bcoIOEc3qDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjRlJ15JJuxIAdGraKekNoHQ3EblDcIYa5tPSso2ybql3c/rHyNVMUAcTU+BsXHtv
         iBmDBtlcrTKLW1lnfAQ0WEWynGrt+cNJw3t0n09Nh++QPR/Dr2nPhfTmrkdNhrzq+y
         /FPhofM0Fsqwh4ilzXu5FWg1+rnMeptviv0rEgSo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        William Cohen <wcohen@redhat.com>
Subject: [PATCH 10/17] perf evswitch: Move enoent error message printing to separate function
Date:   Fri, 16 Aug 2019 17:16:46 -0300
Message-Id: <20190816201653.19332-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Allows adding hints there, will be done in followup patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-1kvrdi7weuz3hxycwvarcu6v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evswitch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
index b57b5f0816f5..71daed615a2c 100644
--- a/tools/perf/util/evswitch.c
+++ b/tools/perf/util/evswitch.c
@@ -31,12 +31,17 @@ bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
 	return false;
 }
 
+static int evswitch__fprintf_enoent(FILE *fp, const char *evtype, const char *evname)
+{
+	return fprintf(fp, "ERROR: switch-%s event not found (%s)\n", evtype, evname);
+}
+
 int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
 {
 	if (evswitch->on_name) {
 		evswitch->on = perf_evlist__find_evsel_by_str(evlist, evswitch->on_name);
 		if (evswitch->on == NULL) {
-			fprintf(fp, "switch-on event not found (%s)\n", evswitch->on_name);
+			evswitch__fprintf_enoent(fp, "on", evswitch->on_name);
 			return -ENOENT;
 		}
 		evswitch->discarding = true;
@@ -45,7 +50,7 @@ int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
 	if (evswitch->off_name) {
 		evswitch->off = perf_evlist__find_evsel_by_str(evlist, evswitch->off_name);
 		if (evswitch->off == NULL) {
-			fprintf(fp, "switch-off event not found (%s)\n", evswitch->off_name);
+			evswitch__fprintf_enoent(fp, "off", evswitch->off_name);
 			return -ENOENT;
 		}
 	}
-- 
2.21.0

