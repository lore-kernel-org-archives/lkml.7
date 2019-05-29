Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E73EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6563C20883
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137049;
	bh=IQX/X9mHT0+/ptjruMQyG2V+KJR5hVZ2FACinDVI12w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oe6Jnx9vC530rbQTfDi3evS48djhUR/TRau4EyNhbQYpO1VCbob0Cka+IWxVjCyq8
	 EmegAOkNyvcDyY7a8zAg+2B/K9dYTSrBFxo8i8QEXLlyOKvg3RMeXiXtARoQgUm0w2
	 5uTGyOaR/6MGfHmfGCdv3x3GNtfOgfwhn+1GaYJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfE2Nh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfE2Nh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:37:26 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3ACE21E6A;
        Wed, 29 May 2019 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137046;
        bh=IQX/X9mHT0+/ptjruMQyG2V+KJR5hVZ2FACinDVI12w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0RgXwADhEsJByzhmSwrLnIBv+pt1ngywWANgWeCrJDGdFrbPWKhaAL7AAX2YmQFcb
         4rAv3Q6Gu5urPSYJFtsfV9ZTkghFZKtV3wHQrjOBwGyG45ZTm2COvGogR8iKDUJ5Ve
         AbBw1R2JSw7o8EuNp38kCyDuMc+SNtxHwyWVYpL4=
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
Subject: [PATCH 15/41] perf trace: Introduce syscall_arg__scnprintf_strarray_flags
Date:   Wed, 29 May 2019 10:35:39 -0300
Message-Id: <20190529133605.21118-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that one can just define a strarray and process it as a set of flags,
similar to syscall_arg__scnprintf_strarray() with plain arrays.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-nnt25wkpkow2w0yefhi6sb7q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 5 +++++
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 87b6dd3c33f5..16bb8c04c689 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -403,6 +403,11 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 #define SCA_STRARRAY syscall_arg__scnprintf_strarray
 
+size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	return strarray__scnprintf_flags(arg->parm, bf, size, arg->show_string_prefix, arg->val);
+}
+
 size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
 	size_t printed;
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 90c1ee708dc9..ad874e0beba5 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -108,6 +108,9 @@ struct syscall_arg {
 
 unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
 
+size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_STRARRAY_FLAGS syscall_arg__scnprintf_strarray_flags
+
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
 
-- 
2.20.1

