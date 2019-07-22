Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76593C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0AB2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817307;
	bh=gGs15WMTHsgUPcMGOUU9aQw8Ax29+/dXYlwVm9OtoVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PfUE0iW1/b5LR03XaA/E/eBRGF0GQvnHkDDXUotWWvQFaA8vd+wNF6vz9r9yJ94bY
	 VABSY4A30diuKBKn5K7ZQxpt0D2OMxXBnbYGy9iQ2aoQkD/wdO/fdbnbLSPIZrpFkJ
	 iE7aFMJC3UHiH6Xg9V70iyu86zxcvuANtrsz3/jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbfGVRlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfGVRlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:41:45 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D042221E70;
        Mon, 22 Jul 2019 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817304;
        bh=gGs15WMTHsgUPcMGOUU9aQw8Ax29+/dXYlwVm9OtoVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RuT5BozP7lrAlctPojb4QEoEdq7PL/NRrHoBGKqOhkTHT0FHgghUnJa60axPgWmfQ
         U9dTZ8mTyhjT8wY/PZeyjkSLI93MjUhGL6orhAmRWLoLBZXh50m257MIRnE8vwVA0V
         5Qy9ohGjJCpT9skoYS+gCt8pv8BPIqgGjaS4E3wQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 24/37] perf trace beauty: Do not try to use the fd->pathname beautifier for bind/connect fd arg
Date:   Mon, 22 Jul 2019 14:38:26 -0300
Message-Id: <20190722173839.22898-25-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Doesn't make sense and also we now beautify the sockaddr, which provides
enough info:

  # trace -e close,socket,connec* ssh www.bla.com
  <SNIP>
  close(5)                                = 0
  socket(PF_INET, SOCK_DGRAM|CLOEXEC|NONBLOCK, IPPROTO_IP) = 5
  connect(5, { .family: PF_INET, port: 53, addr: 192.168.44.1 }, 16) = 0
  close(5)                                = 0
  socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 5
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-h9drpb7ail808d2mh4n7tla4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 94c33bb573c1..010aa9e9a561 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -710,7 +710,8 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_X86_ARCH_PRCTL_CODE, /* code */ },
 		   [1] = { .scnprintf = SCA_PTR, /* arg2 */ }, }, },
 	{ .name	    = "bind",
-	  .arg = { [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ }, }, },
+	  .arg = { [0] = { .scnprintf = SCA_INT, /* fd */ },
+		   [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ }, }, },
 	{ .name	    = "bpf",
 	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
@@ -726,7 +727,8 @@ static struct syscall_fmt {
 	{ .name	    = "close",
 	  .arg = { [0] = { .scnprintf = SCA_CLOSE_FD, /* fd */ }, }, },
 	{ .name	    = "connect",
-	  .arg = { [1] = { .scnprintf = SCA_SOCKADDR, /* servaddr */ },
+	  .arg = { [0] = { .scnprintf = SCA_INT, /* fd */ },
+		   [1] = { .scnprintf = SCA_SOCKADDR, /* servaddr */ },
 		   [2] = { .scnprintf = SCA_INT, /* addrlen */ }, }, },
 	{ .name	    = "epoll_ctl",
 	  .arg = { [1] = STRARRAY(op, epoll_ctl_ops), }, },
-- 
2.21.0

