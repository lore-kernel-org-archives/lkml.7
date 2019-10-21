Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04305CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD332053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665306;
	bh=HYlKT32t3KHzCTnNns6lZoAke8Jbm1AQj1rHDeYyTXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IS7uxmMHo5s55W2BRPEQuviFue2M8zUA/ax/2PcZ9XnvxLI3VbJsgS7NS9mEg/l1z
	 1IjHl5KUpqwLyeV6Gd6HnCxKrR7MwiNCjqZdHXauC3eSmqggI//AV5Np4Vo0UaeOWF
	 byEu8zG4rU0vTEzBoreE88e5gepan+upoSrFgipc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfJUNlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbfJUNln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BADE120679;
        Mon, 21 Oct 2019 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665302;
        bh=HYlKT32t3KHzCTnNns6lZoAke8Jbm1AQj1rHDeYyTXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExtrWvVtiJEJ2QbyWYJ7+y1c7IIBUl2EG9ZTyzlcD8Z67kp0mfApnxzOP8s1u9c20
         Tb2ixC7h+tvuQLmwotN55x9vRcAnMcuGRKSlAnvKvFF53R/OpWciQiBuvjUQetQWIE
         TTKAkrL9VZh+ueRUebdL/OEXRN5HAdyOX3LIz+2s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 55/57] libbeauty: Introduce strarray__strtoul_flags()
Date:   Mon, 21 Oct 2019 10:38:32 -0300
Message-Id: <20191021133834.25998-56-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Counterpart of strarray__scnprintf_flags(), i.e. from a expression like:

   # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|FIXED|DENYWRITE"

I.e. that "flags==PRIVATE|FIXED|DENYWRITE", turn that into

   # perf trace -e syscalls:sys_enter_mmap --filter=0x812

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8xst3zrqqogax7fmfzwymvbl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 45 +++++++++++++++++++++++++++++++-
 tools/perf/trace/beauty/beauty.h |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 72ef3b395504..73c5c14b52eb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -586,6 +586,49 @@ bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret)
 	return false;
 }
 
+bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *ret)
+{
+	u64 val = 0;
+	char *tok = bf, *sep, *end;
+
+	*ret = 0;
+
+	while (size != 0) {
+		int toklen = size;
+
+		sep = memchr(tok, '|', size);
+		if (sep != NULL) {
+			size -= sep - tok + 1;
+
+			end = sep - 1;
+			while (end > tok && isspace(*end))
+				--end;
+
+			toklen = end - tok + 1;
+		}
+
+		while (isspace(*tok))
+			++tok;
+
+		if (isalpha(*tok) || *tok == '_') {
+			if (!strarray__strtoul(sa, tok, toklen, &val))
+				return false;
+		} else {
+			bool is_hexa = tok[0] == 0 && (tok[1] = 'x' || tok[1] == 'X');
+
+			val = strtoul(tok, NULL, is_hexa ? 16 : 0);
+		}
+
+		*ret |= (1 << (val - 1));
+
+		if (sep == NULL)
+			break;
+		tok = sep + 1;
+	}
+
+	return true;
+}
+
 bool strarrays__strtoul(struct strarrays *sas, char *bf, size_t size, u64 *ret)
 {
 	int i;
@@ -3676,7 +3719,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 			}
 
 		right_end = right + 1;
-		while (isalnum(*right_end) || *right_end == '_')
+		while (isalnum(*right_end) || *right_end == '_' || *right_end == '|')
 			++right_end;
 
 		if (isalpha(*right)) {
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 10801660a71f..e12b2228b892 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -32,6 +32,7 @@ size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, co
 size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, bool show_prefix, unsigned long flags);
 
 bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret);
+bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *ret);
 
 struct trace;
 struct thread;
-- 
2.21.0

