Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDF1CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E636206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572080452;
	bh=TTeC5dkY/xGibziIZ7ir38T33Av+wlrCMVM1pELYOK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0zbFbZAvZCFwcksXE9u+XmjjjQUVoNm9pwCGnfLuH+vESL8PzYvgG/Mjr4KdSygO1
	 H30ww1LTwNkF3/vquFjT2R2qAFcLvb6zRbhdbqs350zPSUuefv40isEnu0okTZQegF
	 zBygUnzRj2J6XlFAabS3GjHwctoyEXJ0PieReQEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfJZJAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJZJAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:00:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF1F0206DD;
        Sat, 26 Oct 2019 09:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572080450;
        bh=TTeC5dkY/xGibziIZ7ir38T33Av+wlrCMVM1pELYOK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pN4yE7pVNPBdD7pcdqYyslvkl+zuf5/VenctocxoJzxdQ9RWvfAekC7owCVjZcCbC
         h+5K6vHfW9xDaYAMOBrGAcBM2NAlPgOR6wbBF5zUAJVJoFt6yfRzYjrwZxreG4p84e
         AY0+ySqAq0z8LvM/mAIQnyPZG9HoHpuVSCEI2vF0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH V2 3/6] perf/probe: Fix to probe an inline function which has no entry pc
Date:   Sat, 26 Oct 2019 18:00:46 +0900
Message-Id: <157208044617.16551.12792136172655985350.stgit@devnote2>
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

Fix perf probe to probe an inlne function which has no entry pc
or low pc but only has ranges attribute.

This seems very rare case, but I could find a few examples, as
same as probe_point_search_cb(), use die_entrypc() to get the
entry address in probe_point_inline_cb() too.

Without this patch,
  # perf probe -D __amd_put_nb_event_constraints
  Failed to get entry address of __amd_put_nb_event_constraints.
  Probe point '__amd_put_nb_event_constraints' not found.
    Error: Failed to add events.

With this patch,
  # perf probe -D __amd_put_nb_event_constraints
  p:probe/__amd_put_nb_event_constraints _text+34059

Fixes: 4ea42b181434 ("perf: Add perf probe subcommand, a kprobe-event setup helper")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 71633f55f045..2fa932bcf960 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -930,7 +930,7 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
 		ret = find_probe_point_lazy(in_die, pf);
 	else {
 		/* Get probe address */
-		if (dwarf_entrypc(in_die, &addr) != 0) {
+		if (die_entrypc(in_die, &addr) != 0) {
 			pr_warning("Failed to get entry address of %s.\n",
 				   dwarf_diename(in_die));
 			return -ENOENT;

