Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9F6ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDAC214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824546;
	bh=5zResmdL0sezn9UbkJuAcJ2wO/cPq83Bs9/pP+Q23rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tVCJ+EkHHcEDgXePNP6YYviP6W/pKHNV09a4VJmdQuhpsL+SRtnQ2Zmn7GhNp712e
	 yhVpQBB0GJcYcCnAk4SfRpNTn1ycCql5xBawaYgjibcV95fCDHdg5wo0dkPBwHqMIt
	 TMKLr/MJAIYJ77wfU96+c4oDr7y5lq4yJQR6HJF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfJKUJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:03 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67AE821835;
        Fri, 11 Oct 2019 20:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824543;
        bh=5zResmdL0sezn9UbkJuAcJ2wO/cPq83Bs9/pP+Q23rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHGqjsRdKBEYx+UlhOAtGHqJS6af6NjSgKLSwudZaqi6+v229TOYPXAYdYDFQcOJp
         XWozXYbmoHwcmYdZNFPrVRjPN9at7Oi7YD0dc9E6Pq63xJQHX1MZMqWnLh82E+xTKS
         NuQqOSORF1aTE/EyUeBzZZdcLITgq808EUeePAxU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 29/69] perf trace: Allow associating scnprintf routines with well known arg names
Date:   Fri, 11 Oct 2019 17:05:19 -0300
Message-Id: <20191011200559.7156-30-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For instance 'msr' appears in several tracepoints, so we can associate
it with a single scnprintf() routine auto-generated from kernel headers,
as will be done in followup patches.

Start with an empty array of associations.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-89ptht6s5fez82lykuwq1eyb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8303d83cb93c..d52972ca6123 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1479,6 +1479,27 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 	return 0;
 }
 
+static struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+};
+
+static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
+{
+       const struct syscall_arg_fmt *fmt = fmtp;
+       return strcmp(name, fmt->name);
+}
+
+static struct syscall_arg_fmt *
+__syscall_arg_fmt__find_by_name(struct syscall_arg_fmt *fmts, const int nmemb, const char *name)
+{
+       return bsearch(name, fmts, nmemb, sizeof(struct syscall_arg_fmt), syscall_arg_fmt__cmp);
+}
+
+static struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *name)
+{
+       const int nmemb = ARRAY_SIZE(syscall_arg_fmts__by_name);
+       return __syscall_arg_fmt__find_by_name(syscall_arg_fmts__by_name, nmemb, name);
+}
+
 static struct tep_format_field *
 syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
 {
@@ -1518,6 +1539,11 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
+               } else {
+			struct syscall_arg_fmt *fmt = syscall_arg_fmt__find_by_name(field->name);
+
+			if (fmt)
+				arg->scnprintf = fmt->scnprintf;
 		}
 	}
 
-- 
2.21.0

