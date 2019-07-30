Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC8EC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A0F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455465;
	bh=tNgl+N1cZwYoTXese7OSyin6FDdVbZ5sHB9DbVQ/nZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Px14Qdey5vclOVDvbCxB0jgo2F7E4BzwcitNBN+3zrAr/sCqrS3CFwHKM3X6TAcL9
	 m5a8jj1aCTh2nwx/QRGyssuMsoFm+8rp4T3gknL9XTSE5UljVoLCUK9l9P48dItgTe
	 SoYR/SmiHGBZZHtVF1oAzp1oZpahwYpG/ZYJ/vQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfG3C5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731837AbfG3C5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:57:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDB3120578;
        Tue, 30 Jul 2019 02:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455461;
        bh=tNgl+N1cZwYoTXese7OSyin6FDdVbZ5sHB9DbVQ/nZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjARo96+LfRm0A3cxKKxcBX/MZFN1bB/gu2qORkOp6QKHmc7k1iLQMcWi24GPpalF
         14DkjEwdfVsiO0iTQIket70Un+UHm6oKWs/UBiOHb8dCx8oErca38aMTQlhm7/Ctfy
         YabSIdNEwOWGttgiE8IUFn2pznQpyuathtI2Itcg=
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
Subject: [PATCH 027/107] perf trace: Add "sendfile64" alias to the "sendfile" syscall
Date:   Mon, 29 Jul 2019 23:54:50 -0300
Message-Id: <20190730025610.22603-28-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
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

