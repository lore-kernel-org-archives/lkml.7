Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201ADCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A20206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572080443;
	bh=veUi3FbnlpamMLvZP76xF7QFYyCcCUmujemZI1DyKE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=roCiLlxpGCPElDBp4vmMVCc9uVHBrW6wQqD3RIwX2SnS72gCRo+FiCw/fUta10p5n
	 sDIPs2iQ78k+DXsEyaOGIfTRVKhAv/9yQYDHrv4cwxsODrQT3+59JUoVMXICV6j3lF
	 MyGbOXOT6ZorFRreqwYp+UPidqtjVtnc0LDv+d3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJZJAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJZJAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:00:41 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987A0206DD;
        Sat, 26 Oct 2019 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572080440;
        bh=veUi3FbnlpamMLvZP76xF7QFYyCcCUmujemZI1DyKE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1/YU5/j2FD4Amb/48MU33axTHiM5XxOIc6c+7ntpFglXYptYL+N/LWfZKK4NHdSK
         wZ5X7akIq/FY2eGWk3Yt7fejN2zlk2tbegV01UcLeQZZEnvpNE+QXdlfKOKAajaeCI
         7cyutnCscXXHfstP8bd1BYXUATRPIyy0nw0KlBIo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH V2 2/6] perf/probe: Fix to probe a function which has no entry pc
Date:   Sat, 26 Oct 2019 18:00:37 +0900
Message-Id: <157208043728.16551.14171894276497201932.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157208041894.16551.2733647209130045685.stgit@devnote2>
References: <157208041894.16551.2733647209130045685.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix perf probe to probe a function which has no entry pc or
low pc but only has ranges attribute.

probe_point_search_cb() uses dwarf_entrypc() to get the
probe address, but that doesn't work for the function DIE
which has only ranges attribute. Use die_entrypc() instead.

Without this fix,
  # perf probe -D clear_tasks_mm_cpumask:0
  Probe point 'clear_tasks_mm_cpumask' not found.
    Error: Failed to add events.

With this,
  # perf probe -D clear_tasks_mm_cpumask:0
  p:probe/clear_tasks_mm_cpumask _text+632816

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Fixes: e1ecbbc3fa83 ("perf probe: Fix to handle optimized not-inlined functions")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2b6513e5725c..71633f55f045 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -982,7 +982,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
 		param->retval = find_probe_point_by_line(pf);
 	} else if (die_is_func_instance(sp_die)) {
 		/* Instances always have the entry address */
-		dwarf_entrypc(sp_die, &pf->addr);
+		die_entrypc(sp_die, &pf->addr);
 		/* But in some case the entry address is 0 */
 		if (pf->addr == 0) {
 			pr_debug("%s has no entry PC. Skipped\n",

