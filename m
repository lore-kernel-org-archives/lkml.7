Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1CBC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6077120693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IFe7NC6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfG3SHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:07:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38517 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfG3SHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:07:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI6s783324669
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:06:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI6s783324669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510015;
        bh=IzvdYjuzAzHvkCcwaWbSI0JBAKQdBjDFwWZIhjNUm/k=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=IFe7NC6FYlcDScJH4/mWcew0Y63lhCmBtQMDkFmhS/4CCTl9JlbN7ppSIKI8vDe2P
         T2Jrxl4WUaewXrLu1EXqv2POf0T+9ebBqVWk8o9YAqdWqe+TjIQqc7gH2hncVntGd9
         iKRc+ciykBWw3udLorZgJvtB5S9DZmkrIszP6weYg1n1dEn+0STV0gFB7EZkdtJqZY
         VCDkzCi1019shXJybz/Arfu0ADA3A7YjtO8PhC2kbas6fyDw7axfRtGPGfJG4GWqFj
         ry/Lja0jyexlVrzbql18vmO3wdvgsZNSwr0d4cjdhNMKmRMiunMmU1S+b4af0yULgW
         plwVbwYi6DZhw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI6s533324666;
        Tue, 30 Jul 2019 11:06:54 -0700
Date:   Tue, 30 Jul 2019 11:06:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-km2hmg7hru6u4pawi5fi903q@git.kernel.org>
Cc:     adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        lclaudio@redhat.com, acme@redhat.com, jolsa@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org
Reply-To: lclaudio@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add "sendfile64" alias to the
 "sendfile" syscall
Git-Commit-ID: e4b00e930bf71ef32189716e6cb6b0565592f078
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

Commit-ID:  e4b00e930bf71ef32189716e6cb6b0565592f078
Gitweb:     https://git.kernel.org/tip/e4b00e930bf71ef32189716e6cb6b0565592f078
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:32:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf trace: Add "sendfile64" alias to the "sendfile" syscall

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
