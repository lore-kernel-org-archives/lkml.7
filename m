Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82AECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B043021D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571993209;
	bh=6eWq3hv5VBg/qQEOMb6GcenvkecaJOsTfWAIxPa5bMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fa6auhpM8HMfaT7mK+7F+RNGsYUXiBgi+nBvEcL/EtObJJCegSK0EyX0tF9mQ8Fsj
	 kCzrszO1DqE9FPsogW1/OeLsddsXsWRnFdDIo9LIs8b+xxOzwLNyQZMhjZ1Tyvdwoy
	 lfEUhTPz7o0zbepR1QkL12+hRkhacy6jI3gXYxME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408527AbfJYIqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408483AbfJYIqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:46:47 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A95222D1;
        Fri, 25 Oct 2019 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571993206;
        bh=6eWq3hv5VBg/qQEOMb6GcenvkecaJOsTfWAIxPa5bMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fr8QSHijtFDJra6WXf8X2CQoAfup6fRiFePEigP85khudssvKMgCUL55BYv3udMuC
         2zNRNSYEu7HQ/885zgAfJftQOEdpaX61/2nXWXjtpfAgPDvriGpEjsP9nrA9vARXYq
         Y78AP1dl2pNdIu1Yz20d1QrKbdgeP9Zu9QSKZLfA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 3/6] perf/probe: Fix to probe an inline function which has no entry pc
Date:   Fri, 25 Oct 2019 17:46:43 +0900
Message-Id: <157199320336.8075.16189530425277588587.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157199317547.8075.1010940983970397945.stgit@devnote2>
References: <157199317547.8075.1010940983970397945.stgit@devnote2>
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
  # tools/perf/perf probe -D __amd_put_nb_event_constraints
  Failed to get entry address of __amd_put_nb_event_constraints.
  Probe point '__amd_put_nb_event_constraints' not found.
    Error: Failed to add events.

With this patch,
  # tools/perf/perf probe -D __amd_put_nb_event_constraints
  p:probe/__amd_put_nb_event_constraints amd_put_event_constraints+43

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

