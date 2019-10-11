Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E9C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A0C214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824585;
	bh=I1bEG5HzJHE6e56yQ9YKy7x0nf38bH82mNA9D2wuQtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nMAtRqSc/NkJaMsStGOVx9FMPp+746/vnChLvpEQH4J0TTZjWLNKxcz3dBqvaaKxC
	 60hJhyVvcYEHQ3oizCFo018kdUp5TSzKQJcfGq6BMnvx4LoaZ6DpwiEE27ELrIZcbm
	 N9nsgsqDuOsQiN6ZfCHkHZ/brCY8X2So10/IK1pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfJKUJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:42 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48CD821D71;
        Fri, 11 Oct 2019 20:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824582;
        bh=I1bEG5HzJHE6e56yQ9YKy7x0nf38bH82mNA9D2wuQtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXwTK4+gWSin+fssoTLSDQqq7pGHjdkoDdhIvgV6EZfgoQzaqKLPrcWyIp35DWes3
         5lVhATUXhYxqH9nTqJ9YrIYFMk1kp4djhZFYv0PiysyPt3SHKOZQsjt/6iRxy5cw/b
         5wXsgqC6I9yaXj1d96E391oTjtOrcWG9Uca9wrdY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 36/69] perf trace: Add a strtoul() method to 'struct syscall_arg_fmt'
Date:   Fri, 11 Oct 2019 17:05:26 -0300
Message-Id: <20191011200559.7156-37-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This will go from a string to a number, so that filter expressions can
be constructed with strings and then, before applying the tracepoint
filters (or eBPF, in the future) we can map those strings to numbers.

The first one will be for 'msr' tracepoint arguments, but real quickly
we will be able to reuse all strarrays for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wgqq48agcgr95b8dmn6fygtr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2c1968061b4b..faa5bf4a5a3a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -86,8 +86,12 @@
 # define F_LINUX_SPECIFIC_BASE	1024
 #endif
 
+/*
+ * strtoul: Go from a string to a value, i.e. for msr: MSR_FS_BASE to 0xc0000100
+ */
 struct syscall_arg_fmt {
 	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
+	bool	   (*strtoul)(char *bf, size_t size, struct syscall_arg *arg, u64 *val);
 	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
 	void	   *parm;
 	const char *name;
@@ -1543,8 +1547,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
                } else {
 			struct syscall_arg_fmt *fmt = syscall_arg_fmt__find_by_name(field->name);
 
-			if (fmt)
+			if (fmt) {
 				arg->scnprintf = fmt->scnprintf;
+				arg->strtoul   = fmt->strtoul;
+			}
 		}
 	}
 
-- 
2.21.0

