Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC097ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB1321835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824412;
	bh=D+SEfww0+B4ZZ7/jBnxcDK2oaMy/NSv+CnJyV1i5tUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lFznVsBHR5RE5+lobIhgRdzgUjWaPVZdHP1gYgzW09ome1wXG8Aw74KvWqqo3NEDR
	 59Gw+mwab/kMAB7IvHQHNNGRX3bdq2HH0j9PPHiXzWARBz2LZKf0Ys/eGLOTAbeNFS
	 QmplMTX6N4JH4bKeHAyy4ux3L12UOU7WGkS0FMok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfJKUGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbfJKUGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:06:49 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3973821D71;
        Fri, 11 Oct 2019 20:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824408;
        bh=D+SEfww0+B4ZZ7/jBnxcDK2oaMy/NSv+CnJyV1i5tUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKHFa4uph5qmC5nap5PPITrnP0DixaFpxWUbk6R5NSzvn7hDSZm2N4gK5AhVDw9wC
         dtY14uKT7J2xzUIm9GdEM7DrbWXljnBqjkly/gz7KAxOkUBARN4jt6eki2W90OZ2x+
         3J52QpJi3DWGWxmKY6vDMxAAxhkybUvQRXaPsupE=
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
Subject: [PATCH 05/69] perf trace: Separate 'struct syscall_fmt' definition from syscall_fmts variable
Date:   Fri, 11 Oct 2019 17:04:55 -0300
Message-Id: <20191011200559.7156-6-acme@kernel.org>
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

As this has all the things needed to format tracepoints events, not just
syscalls, that, after all, are just tracepoints with a set in stone ABI,
i.e. order and number of parameters.

For tracepoints we'll create a

  static struct syscall_fmt tracepoint_fmts[]

array and will fill the ->arg[] entries with the beautifier for each
positional argument and record the name, then, when we need it, we'll
just check that the position has the same name, maybe even type, so that
we can do some check that the tracepoint hasn't changed, if it has, we
can even reorder things.

Keep calling it syscall_fmt but use it as well for tracepoints, do it
this way to minimize changes and reuse what is in place for syscalls,
we'll see.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2x1jgiev13zt4njaanlnne0d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ee330f50b450..cb853434d761 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -702,7 +702,7 @@ struct syscall_arg_fmt {
 	bool	   show_zero;
 };
 
-static struct syscall_fmt {
+struct syscall_fmt {
 	const char *name;
 	const char *alias;
 	struct {
@@ -714,7 +714,9 @@ static struct syscall_fmt {
 	bool	   errpid;
 	bool	   timeout;
 	bool	   hexret;
-} syscall_fmts[] = {
+};
+
+static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
 	{ .name	    = "arch_prctl",
-- 
2.21.0

