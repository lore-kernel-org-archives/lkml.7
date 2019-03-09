Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F5CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC51320815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCITrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:47:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCITrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:47:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JkM7J3200265
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:46:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JkKhO3200262;
        Sat, 9 Mar 2019 11:46:20 -0800
Date:   Sat, 9 Mar 2019 11:46:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-21038f2baa05a0550f56f010f609a5c871b6a274@git.kernel.org>
Cc:     namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@redhat.com, songliubraving@fb.com, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, namhyung@kernel.org, acme@redhat.com,
          songliubraving@fb.com, ast@kernel.org, hpa@zytor.com,
          jolsa@kernel.org, peterz@infradead.org, daniel@iogearbox.net,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190226002019.3748539-2-songliubraving@fb.com>
References: <20190226002019.3748539-2-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf, bpf: Consider events with attr.bpf_event as
 side-band events
Git-Commit-ID: 21038f2baa05a0550f56f010f609a5c871b6a274
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

Commit-ID:  21038f2baa05a0550f56f010f609a5c871b6a274
Gitweb:     https://git.kernel.org/tip/21038f2baa05a0550f56f010f609a5c871b6a274
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 25 Feb 2019 16:20:05 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Feb 2019 14:20:35 -0300

perf, bpf: Consider events with attr.bpf_event as side-band events

Events with attr.bpf_event set should be considered as side-band events,
as they carry information about BPF programs.

Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
Link: http://lkml.kernel.org/r/20190226002019.3748539-2-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f59d848171e..dd9698ad3d66 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4238,7 +4238,8 @@ static bool is_sb_event(struct perf_event *event)
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
-	    attr->context_switch)
+	    attr->context_switch ||
+	    attr->bpf_event)
 		return true;
 	return false;
 }
