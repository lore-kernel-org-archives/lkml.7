Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B37C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F503217D6
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752489;
	bh=IjqIvHo7BIZWkR766CNyWh/5V9ps71Hqi/K0JM2c/JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Eol8yQxy/H9ul0JeSb+xwXO5gAmTzEc5wh1bDHBP8xEYx3MJNERzKKoLP8GYSZx7
	 svvDylgC3r0jajR2zcTI3Ed2jGJ3rO81YlrwwhugvM7mubOzb6hgDAm40nZvgwplR5
	 yOMxGSrkdi+SzG4/Huzrcb8izuvbRrgWd5PliivY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394561AbfHBN0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394515AbfHBN0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:26:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A53821851;
        Fri,  2 Aug 2019 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752373;
        bh=IjqIvHo7BIZWkR766CNyWh/5V9ps71Hqi/K0JM2c/JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkKHVl8sq6NXPfMZdnp/FzGfNLZvKJMSKAR8CL8wiS8WCfUEM0cN+Vb2VEwDD1YP4
         aDHiUL0SvHiFHYZqiUyZpmCLGnMVvrTmN/94+gtjTWRJ68yuHHUBrl5GMnczFo/0F6
         lmkVqf65KvV0kAuGnHo4xtJRgEZm4md3sDVHrOeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 14/22] perf probe: Avoid calling freeing routine multiple times for same pointer
Date:   Fri,  2 Aug 2019 09:25:38 -0400
Message-Id: <20190802132547.14517-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132547.14517-1-sashal@kernel.org>
References: <20190802132547.14517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit d95daf5accf4a72005daa13fbb1d1bd8709f2861 ]

When perf_add_probe_events() we call cleanup_perf_probe_events() for the
pev pointer it receives, then, as part of handling this failure the main
'perf probe' goes on and calls cleanup_params() and that will again call
cleanup_perf_probe_events()for the same pointer, so just set nevents to
zero when handling the failure of perf_add_probe_events() to avoid the
double free.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x8qgma4g813z96dvtw9w219q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-probe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 9a250c71840e9..2b420e7a92c0c 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -675,6 +675,16 @@ __cmd_probe(int argc, const char **argv, const char *prefix __maybe_unused)
 
 		ret = perf_add_probe_events(params.events, params.nevents);
 		if (ret < 0) {
+
+			/*
+			 * When perf_add_probe_events() fails it calls
+			 * cleanup_perf_probe_events(pevs, npevs), i.e.
+			 * cleanup_perf_probe_events(params.events, params.nevents), which
+			 * will call clear_perf_probe_event(), so set nevents to zero
+			 * to avoid cleanup_params() to call clear_perf_probe_event() again
+			 * on the same pevs.
+			 */
+			params.nevents = 0;
 			pr_err_with_code("  Error: Failed to add events.", ret);
 			return ret;
 		}
-- 
2.20.1

