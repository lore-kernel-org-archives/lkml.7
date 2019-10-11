Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC645C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FAD214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824396;
	bh=OHBNbX10bKKwrCvE393nsaHjXnENeS8KG+cFTrix2x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aoIF9quWhOvPz3jILvL3briT0f19hOdNvXDvprDO5bAPbhbJtQMeWsNwAJmKA0srB
	 zuU1PXwlFzIybDgB+Aq4O++siR1dh17H7BZPwQOCdE3XzAMropyeuiZYPI71LkDd/c
	 reIWk8wEkbX+0x2fn08v282HpXmqYhldsNXdYuCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfJKUGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbfJKUGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:06:34 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A0F21835;
        Fri, 11 Oct 2019 20:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824393;
        bh=OHBNbX10bKKwrCvE393nsaHjXnENeS8KG+cFTrix2x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFM6wBbU/qnvsjegbEj5UD9z2gNdAc7zPlMRr1rAixxOGbzO0feLS8ZaP/bejkeoH
         dSwqEK/jjsIN5eyVNPPXDfpH7cqswUiuO/7ZXHlUD/Km0iq7Kd0oreQlvT291Qf9kK
         U7Xv5jDirY6YbJez5i+0wOGBf1S9qBHW8RiJ4BYE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 02/69] perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine
Date:   Fri, 11 Oct 2019 17:04:52 -0300
Message-Id: <20191011200559.7156-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just read it so that later on the per arch init routine can use it,
e.g. x86__annotate_init().

When using a perf.data file this is obtained from a header that was put
there by 'perf record', and then it may be for another machine, another
arch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4t4n3o8l8s0tc2b1pq53hyr4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1f60124eb19b..611d03030abc 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1560,6 +1560,17 @@ int cmd_top(int argc, const char **argv)
 	status = perf_config(perf_top_config, &top);
 	if (status)
 		return status;
+	/*
+	 * Since the per arch annotation init routine may need the cpuid, read
+	 * it here, since we are not getting this from the perf.data header.
+	 */
+	status = perf_env__read_cpuid(&perf_env);
+	if (status) {
+		pr_err("Couldn't read the cpuid for this machine: %s\n",
+		       str_error_r(errno, errbuf, sizeof(errbuf)));
+		goto out_delete_evlist;
+	}
+	top.evlist->env = &perf_env;
 
 	argc = parse_options(argc, argv, options, top_usage, 0);
 	if (argc)
-- 
2.21.0

