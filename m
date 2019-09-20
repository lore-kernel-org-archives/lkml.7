Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF72C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F342086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989703;
	bh=/0iyHNcbMoxxci1l9/vd5LKP750yRWtHIsGXZyGBAuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M9TWKN1vktStdiDVqzfE4jkMMKVnF1HsCCc+TAZx10bNKVdSuO45CKwMx5taD/QRx
	 sV8o4XusRHxgSuJl0rAGDS+nhZH+8RZscsdhwx2iM+PjkqHzaGHz2DN+XYPQu1YoNm
	 T5G3UT/4oDI0j2xYVbX1NyCe20UuZTdKzcyCpCJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389558AbfITO1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388936AbfITO0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD6D21A4A;
        Fri, 20 Sep 2019 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989576;
        bh=/0iyHNcbMoxxci1l9/vd5LKP750yRWtHIsGXZyGBAuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1NMhSDabIhOCpTDnkNGBj7MU8z9t/bQaFiBnY7KhKf+zi9UGoEQuFBIv79w069Yq
         CfD7hy5r1DEI2CZFLV+7dWoUitEoiII0OhodKXF1/x6DLJWNhCnEK4u2M29u1+tPqO
         mZraI+dpnEiBlo3sPefvt96nlsSscie6Sj9tHRDc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/31] perf debug: No need to include ui/util.h
Date:   Fri, 20 Sep 2019 11:25:19 -0300
Message-Id: <20190920142542.12047-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Nothing from that file is used in util/debug.h, it is only needed in
some places that get it indirectly via including util/debug.h, remove
that entanglement.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hn9v4jdova2nt018fqsjyzun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/scripts.c | 1 +
 tools/perf/ui/gtk/setup.c        | 3 ++-
 tools/perf/util/debug.h          | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 586a21acc13d..3b81075b8da8 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -2,6 +2,7 @@
 #include "../../builtin.h"
 #include "../../perf.h"
 #include "../../util/util.h"
+#include "../util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
 #include "../../util/symbol.h"
diff --git a/tools/perf/ui/gtk/setup.c b/tools/perf/ui/gtk/setup.c
index 1a2616b97b5c..f5eee4d66873 100644
--- a/tools/perf/ui/gtk/setup.c
+++ b/tools/perf/ui/gtk/setup.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "gtk.h"
-#include "../../util/debug.h"
+#include <linux/compiler.h>
+#include "../util.h"
 
 extern struct perf_error_ops perf_gtk_eops;
 
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index b2deee987ffa..d25ae1c4cee9 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -3,9 +3,9 @@
 #ifndef __PERF_DEBUG_H
 #define __PERF_DEBUG_H
 
+#include <stdarg.h>
 #include <stdbool.h>
 #include <linux/compiler.h>
-#include "../ui/util.h"
 
 extern int verbose;
 extern bool quiet, dump_trace;
-- 
2.21.0

