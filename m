Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA9AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658562173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566789465;
	bh=1MgpH1r23u2tqpsRDhiOww76XSTOfo2+LJaAlGqRg44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dASYuOFcjIpJ+37zndxZhNV7QipcCWtns638z4R54kWHQokjuYmfag11LY5YNSM6h
	 bYIr/p7je6TIVQKaDp6ySqFXUDLAzQg6hNa6ShP4opbHqfQLCZylQzjttstu/4ZG5c
	 JvngjM+2IAVy9TxJqnHYMk8bs3BuROFwetzn6ZLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfHZDRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 23:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfHZDRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:17:43 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19562168B;
        Mon, 26 Aug 2019 03:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789462;
        bh=1MgpH1r23u2tqpsRDhiOww76XSTOfo2+LJaAlGqRg44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zaXDSbi+ox96xhO+enb6+FyW0JgXbUv/q9TK5OX23mUY4QpkElBk/cXC27VH7vYVf
         RzJL/bmO8P70DmL5emCXieC+1JmaG7s/2SrvORkwT5FrYa8UuDIakmLHJt/oJGec45
         99i9dgUyMrLHFoagWS0qJq6+rMHbyrDJOCwK0cdk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 10/19] tracing: Add NULL trace-array check in print_synth_event()
Date:   Mon, 26 Aug 2019 12:17:36 +0900
Message-Id: <156678945659.21459.15789978012125587066.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156678933823.21459.4100380582025186209.stgit@devnote2>
References: <156678933823.21459.4100380582025186209.stgit@devnote2>
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

