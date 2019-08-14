Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2334DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B2A20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803233;
	bh=EHaAD9qiC6h7RKmfVt1UQ+1y1ZhRwFEYxLMl9PI7pG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vYoLnM7hk0BdfudeI4k26fAfwJmRlciii6mVuSLcjRrGpoxdt6SA4qZ1PosNvckFX
	 gILTjHFcGqwnKDz0yI0gx8Jcjj+Ec9WmwU/pEbszh+QIIUxP7qr1cjTPzMMJfcPClW
	 sYdC/pKfLFMYhMicShaBcspw3N3s3xxRxMNTdQ80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfHNRKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730220AbfHNRKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:10:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 432BA208C2;
        Wed, 14 Aug 2019 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802633;
        bh=EHaAD9qiC6h7RKmfVt1UQ+1y1ZhRwFEYxLMl9PI7pG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDwqL2k93OuXskLgEX0IoEF9o6RfLJ6umPeOXedHoshgaIzy0zCauDzgPSwfIWu52
         4jlh5Mc9pZgAXcAKsHuWDI3lqye5DNYQSQRbRyG138TSKKcMNK765zhdUjBVL67HY3
         HPxrD6AmKExALq7wG/ZTi7S9udIbdU+6tyNJaqsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 57/91] perf probe: Avoid calling freeing routine multiple times for same pointer
Date:   Wed, 14 Aug 2019 19:01:20 +0200
Message-Id: <20190814165752.016176295@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 99de91698de1e..0bdb34fee9d81 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -711,6 +711,16 @@ __cmd_probe(int argc, const char **argv)
 
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



