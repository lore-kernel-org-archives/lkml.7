Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3503BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AA3214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665352;
	bh=J6Zp9vw2aOghXwEqEY4sWy9WTHVCUoT+JyG7aFs5tQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POqm/P1vGKmQRk7k/DO1YdBXolencMl5QXkIGo0N12Yeqk2MfGEnOq4QgllOAtVyU
	 JPSLfHELk29MNC81lugEwHtWsD4VhJ6K5aGpJT9ZMboILQ7iHDjV3uH2wXpqSKXy7X
	 9uZIW094BDxwwzkjBWNwIbSkfNlvYoaHqfHN7jQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfJUNkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbfJUNkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE902173B;
        Mon, 21 Oct 2019 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665236;
        bh=J6Zp9vw2aOghXwEqEY4sWy9WTHVCUoT+JyG7aFs5tQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+hdQ7oJ8rn476GKAttXVfcHKvCvb5e+jFCZHIcg6C/x13pVufO5NwL9RoPEK2Jbq
         njox2oKgGSuDPkQFthZ3D4/rw2DmCU4zvJjQarPWdVu1WKLKXJCl0Az5ZyjBU8le0A
         APqYVy7/8vq/3Cgap9u7kd/tP0KG9PkwvfIl8AAU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 36/57] libbeauty: Introduce syscall_arg__strtoul_strarray()
Date:   Mon, 21 Oct 2019 10:38:13 -0300
Message-Id: <20191021133834.25998-37-acme@kernel.org>
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

To go from strarrays strings to its indexes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wta0qvo207z27huib2c4ijxq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 6 ++++++
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3502417dc7f2..0294b17ed510 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -535,6 +535,11 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 #define SCA_STRARRAY syscall_arg__scnprintf_strarray
 
+bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *arg, u64 *ret)
+{
+	return strarray__strtoul(arg->parm, bf, size, ret);
+}
+
 size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return strarray__scnprintf_flags(arg->parm, bf, size, arg->show_string_prefix, arg->val);
@@ -824,6 +829,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 #define STRARRAY(name, array) \
 	  { .scnprintf	= SCA_STRARRAY, \
+	    .strtoul	= STUL_STRARRAY, \
 	    .parm	= &strarray__##array, }
 
 #define STRARRAY_FLAGS(name, array) \
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 232b64d70096..1b8a30e5dcf9 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -122,6 +122,9 @@ unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
 size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAY_FLAGS syscall_arg__scnprintf_strarray_flags
 
+bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
+#define STUL_STRARRAY syscall_arg__strtoul_strarray
+
 size_t syscall_arg__scnprintf_x86_irq_vectors(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_X86_IRQ_VECTORS syscall_arg__scnprintf_x86_irq_vectors
 
-- 
2.21.0

