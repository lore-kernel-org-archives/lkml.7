Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC30C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699C921901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817370;
	bh=tNgl+N1cZwYoTXese7OSyin6FDdVbZ5sHB9DbVQ/nZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iibcavQMt6HMUOsQ4Z9yaSsMFnb0WM7/V/whYGZ7BOqiPYT0RtG/Xc1T/f6RpBXXW
	 lddHEeorcM6TNNBaov186l71FdqmGVN3UHOsdFCByAHQ8ZKzKsbLM6Y+y5GgGhEMNR
	 vxkP0ZPcgHOgqJCdcfl98bgva6/mQPWpwUtMs2Is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbfGVRms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfGVRmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:42:45 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27982190D;
        Mon, 22 Jul 2019 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817365;
        bh=tNgl+N1cZwYoTXese7OSyin6FDdVbZ5sHB9DbVQ/nZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BM1cakgQyyNnKUVUKrjsjvWrmzFUds4/IMilmWJlMwjHxm3C+oXQo4W5SznizkV28
         26EyBSItXKvfTi6A/es8aLWc69a9BDBYVO6xmuWZyv8Wq3MW9QCRUiqkvChf7KkJs9
         5QiQ1oPciPhvP9EosYwl87vKURnrKpuvWKnuh+xI=
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
Subject: [PATCH 34/37] perf trace: Add "sendfile64" alias to the "sendfile" syscall
Date:   Mon, 22 Jul 2019 14:38:36 -0300
Message-Id: <20190722173839.22898-35-acme@kernel.org>
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

We were looking in tracefs for:

  /sys/kernel/debug/tracing/events/syscalls/sys_enter_sendfile/format when

what is there is just

  /sys/kernel/debug/tracing/events/syscalls/sys_enter_sendfile/format

Its the same id, 40 in x86_64, so just add an alias and let the existing
logic take care of that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-km2hmg7hru6u4pawi5fi903q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 200fbe33d5de..ca28c48f812e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -895,6 +895,7 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_SECCOMP_OP,	   /* op */ },
 		   [1] = { .scnprintf = SCA_SECCOMP_FLAGS, /* flags */ }, }, },
 	{ .name	    = "select", .timeout = true, },
+	{ .name	    = "sendfile", .alias = "sendfile64", },
 	{ .name	    = "sendmmsg",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "sendmsg",
-- 
2.21.0

