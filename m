Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D67A21872
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665211;
	bh=jSbasVdSNnjbokTJDgydguQOw7vmTu3n6iH+J/nADqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pTWW9uGoqn7QBpOthD1vqIapZmwS/TrgPcYV3xJIUPFJbo9RrvODIHVS3ZO83frUI
	 NtfWC44M8y52nJodOXwASg05yVOV8V5ZYyjPOivWLbrOaW0DICk7Ep9W2A4Vxk2UOd
	 CT35HCB+S6g7cQE/XmWTULjaUDx/XpR8IyqCW6bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfJUNkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbfJUNkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7C6217D7;
        Mon, 21 Oct 2019 13:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665207;
        bh=jSbasVdSNnjbokTJDgydguQOw7vmTu3n6iH+J/nADqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/qI4sd8FoLYJWCITK3MmznmNVX7cYzs/VOeWaROiP8PuYCdxmdQfibusla38LCig
         fQFiCLNWQDrR/rbtAAWhdUMfbfWRRkGPWuPYbR1j7si/ZL6om8yIKb8PggDcNBPv5m
         W2znXLAeRn4kSwctMauSBLH6WC/8vJwQao1RLg5M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 26/57] libbeauty: Add a strarray__scnprintf_suffix() method
Date:   Mon, 21 Oct 2019 10:38:03 -0300
Message-Id: <20191021133834.25998-27-acme@kernel.org>
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

In some cases, like with x86 IRQ vectors, the common part in names is at
the end, so a suffix, add a scnprintf function for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-agxbj6es2ke3rehwt4gkdw23@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 14 ++++++++++++++
 tools/perf/trace/beauty/beauty.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 907eaf316f5b..58bbe85d4166 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -423,6 +423,20 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	({ struct syscall_tp *fields = evsel->priv; \
 	   fields->name.pointer(&fields->name, sample); })
 
+size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_suffix, int val)
+{
+	int idx = val - sa->offset;
+
+	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL) {
+		size_t printed = scnprintf(bf, size, intfmt, val);
+		if (show_suffix)
+			printed += scnprintf(bf + printed, size - printed, " /* %s??? */", sa->prefix);
+		return printed;
+	}
+
+	return scnprintf(bf, size, "%s%s", sa->entries[idx], show_suffix ? sa->prefix : "");
+}
+
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
 	int idx = val - sa->offset;
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 0dee0cf4fda8..165f56b456be 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -28,6 +28,7 @@ struct strarray {
 }
 
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_prefix, int val);
+size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_suffix, int val);
 size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, bool show_prefix, unsigned long flags);
 
 bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret);
-- 
2.21.0

