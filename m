Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31811C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062F3206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RfBzMby9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfG3SBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:01:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbfG3SBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:01:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI0tlK3321947
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:00:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI0tlK3321947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509656;
        bh=F0+fg0ZoBFiLmYhegdnFfq5+f4yhxRapIxQV2+dg18I=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=RfBzMby9MT1fqQ90oJsMx9mJx3jswoWF3W0y8bpT3VQ8OZiO7vkkl9Rlcet/LvpIa
         aPsRwRR08v/3VDlKAWmjLV07TyfCSFt2kj4e5miM4qYFFhItbz3ZvPuKwaSFbTXpF3
         OeFOU+1tdaXI3b6YZmop4sTzBjdsVqPlNl5zL/9Z0EPNV7akmjE+E3cRCe25APobzK
         2rzuG7q8AIg1RSx48fIhKYjzOkj/0joeaiB9wuGnD/pBfnL98Q3ZbM9OfAacejcKKJ
         RvdxeMslCqH+ELeQgLHaurrtKDGB4G8XJ4nKL/l5/5k7W0FahFVVWSsOzyPp4EotGr
         EMB+fcGClR+Fg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI0sSE3321944;
        Tue, 30 Jul 2019 11:00:54 -0700
Date:   Tue, 30 Jul 2019 11:00:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-h9drpb7ail808d2mh4n7tla4@git.kernel.org>
Cc:     namhyung@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
        hpa@zytor.com, lclaudio@redhat.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: namhyung@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
          hpa@zytor.com, lclaudio@redhat.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Do not try to use the
 fd->pathname beautifier for bind/connect fd arg
Git-Commit-ID: ef969ca64d04161ccbde2aaf8b0767f91a6d32ff
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ef969ca64d04161ccbde2aaf8b0767f91a6d32ff
Gitweb:     https://git.kernel.org/tip/ef969ca64d04161ccbde2aaf8b0767f91a6d32ff
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 17:21:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace beauty: Do not try to use the fd->pathname beautifier for bind/connect fd arg

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
