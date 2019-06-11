Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8821C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8519A21871
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279845;
	bh=SZRrh7eYJdiLpE2mdYvaFfwmH7fjdeMwlt2d0ROLKRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6kpjhSOnz9sV0m8nJDpyyQOn3HO+Tv/bMJ/1r8Qg61DfKTcnZy/MGsyxaLviPslj
	 EjAkAtsAIKCXDV12W7I9dA1Mx3UJy+A2+A1bkiS96XdyDDHqGZ6Tr/zbkZZtrlOUF5
	 b4TKAkqnSuYg/iL08mM2ThDa7PpBi8nHZAjlkA0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405936AbfFKTEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405486AbfFKTED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3951D21852;
        Tue, 11 Jun 2019 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279842;
        bh=SZRrh7eYJdiLpE2mdYvaFfwmH7fjdeMwlt2d0ROLKRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2YjCx7Ip2PSwX6sBMEtlzY7NaQoWGQOkJ7dWYRf4Jyg5PfAdPSuk1py610NJGDvv7
         ptQcmjRYu6bOJsFruhBtZjuLsYp+ZY5uItDRXhTu53v4Gtc1OFX5kCBOQKOI+8svht
         mKG89biq3pesyoAeZI2wKe8fNONRtbVpp6y9ReN0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 65/85] perf report: Set perf time interval in itrace_synth_ops
Date:   Tue, 11 Jun 2019 15:58:51 -0300
Message-Id: <20190611185911.11645-66-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Instruction trace decoders can optimize output based on what time
intervals will be filtered, so pass that information in
itrace_synth_ops.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1ca533f06a4c..91c40808380d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1428,6 +1428,10 @@ int cmd_report(int argc, const char **argv)
 						  &report.range_num);
 		if (ret < 0)
 			goto error;
+
+		itrace_synth_opts__set_time_range(&itrace_synth_opts,
+						  report.ptime_range,
+						  report.range_num);
 	}
 
 	if (session->tevent.pevent &&
@@ -1449,8 +1453,10 @@ int cmd_report(int argc, const char **argv)
 		ret = 0;
 
 error:
-	if (report.ptime_range)
+	if (report.ptime_range) {
+		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
 		zfree(&report.ptime_range);
+	}
 	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 	return ret;
-- 
2.20.1

