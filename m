Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC6BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1ED215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561133946;
	bh=1MgpH1r23u2tqpsRDhiOww76XSTOfo2+LJaAlGqRg44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UgS64ZL/MbDuTxo8hEKQWnj2MLtNYxwixS+5IB76ORZDmqWog34xr6dDE02uAlbmB
	 KiO4Tti0wg32yU3/VW76M1SmAnf+qpDOcq6gmNh+1yJjA7uqdpp7KyFlVLYsIlJh2v
	 CmbL1oc0r6qGjaIFP6pFkvV6rl3sfIkFFbCNDEGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfFUQTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUQTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:19:04 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32FA21530;
        Fri, 21 Jun 2019 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133943;
        bh=1MgpH1r23u2tqpsRDhiOww76XSTOfo2+LJaAlGqRg44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jIaip59d0XEbC9lKt7bAvix2iQxBf1gTCWTGaCVnZ7AHw0XfPO9s/u5J6+L4u90C
         sZKd+kYirS9cDgmq9938+9e/gRAKuWqMLDE+MfWlJFTX4YYnVVfMChHp3igmOR1amw
         UsAdO5Qrn35dCCWS6gVOLgR4SJihQq5yvSdhw+lU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 06/11] tracing: Add NULL trace-array check in print_synth_event()
Date:   Sat, 22 Jun 2019 01:18:59 +0900
Message-Id: <156113393962.28344.13340382995505046307.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156113387975.28344.16009584175308192243.stgit@devnote2>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NULL trace-array check in print_synth_event(), because
if we enable tp_printk option, iter->tr can be NULL.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a7f447195143..db973928e580 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -822,7 +822,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		fmt = synth_field_fmt(se->fields[i]->type);
 
 		/* parameter types */
-		if (tr->trace_flags & TRACE_ITER_VERBOSE)
+		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
 			trace_seq_printf(s, "%s ", fmt);
 
 		snprintf(print_fmt, sizeof(print_fmt), "%%s=%s%%s", fmt);

