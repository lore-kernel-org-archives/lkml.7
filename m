Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09EBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75983214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665297;
	bh=Lw3YWvueKJz9oTDD8qjg6QZ/jcLn2EWre7eZ2Jv8myw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nqgYQEBpG7i6TBMG/YPl6KEz97VYNBA04BQ4ilBtE+AuVBlmvhHBVB13NafgUGhvf
	 ZfPbzF5/ekQBQIV6LutmO9MZkrXSV30Hg2+YrgqugF0pUPkIcRJO9kUaWsbU9AnlLh
	 O2ZK+0BSMsUdEVkQkaqw/jqSWu5OH//W3ErCKzA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfJUNlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbfJUNle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A3D21783;
        Mon, 21 Oct 2019 13:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665293;
        bh=Lw3YWvueKJz9oTDD8qjg6QZ/jcLn2EWre7eZ2Jv8myw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPNmvqA2leDHavpATsTEdx57TVsTbx/9RZlN3zTzobB/umnBV8SaEMFJWHfP6Apkw
         +LYvTje9bTL7k5ej5LPPSc2juQYqUYVxKjVPYzgML9fktY5z4OGoGP+dYkJ1siuInV
         /iAf2nN5wlp52FCp+gbb3pF04bKnEEVck2xhyhno=
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
Subject: [PATCH 52/57] libbeauty: Introduce syscall_arg__strtoul_strarrays()
Date:   Mon, 21 Oct 2019 10:38:29 -0300
Message-Id: <20191021133834.25998-53-acme@kernel.org>
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

To allow going from string to integer for 'struct strarrays'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-b1ia3xzcy72hv0u4m168fcd0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 5 +++++
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0e7fc7cc42d9..265ea876f00b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -540,6 +540,11 @@ bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *ar
 	return strarray__strtoul(arg->parm, bf, size, ret);
 }
 
+bool syscall_arg__strtoul_strarrays(char *bf, size_t size, struct syscall_arg *arg, u64 *ret)
+{
+	return strarrays__strtoul(arg->parm, bf, size, ret);
+}
+
 size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return strarray__scnprintf_flags(arg->parm, bf, size, arg->show_string_prefix, arg->val);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 1b8a30e5dcf9..10801660a71f 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -125,6 +125,9 @@ size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct sysca
 bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
 #define STUL_STRARRAY syscall_arg__strtoul_strarray
 
+bool syscall_arg__strtoul_strarrays(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
+#define STUL_STRARRAYS syscall_arg__strtoul_strarrays
+
 size_t syscall_arg__scnprintf_x86_irq_vectors(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_X86_IRQ_VECTORS syscall_arg__scnprintf_x86_irq_vectors
 
-- 
2.21.0

