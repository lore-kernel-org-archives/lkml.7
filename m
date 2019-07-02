Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2620AC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35D221841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034506;
	bh=Jr8tGrAxIKCYJdVwkl+TXOArqBDDZZP2yA/eyBGvEJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uutmDmowMlw/eLM2iDTgaRlwJeDivlRp1I0OiwAZ/nG87Fz0qr9DqqmjX9eDqoi/1
	 NOwGtn6MWhuMfdBfphnTxLPypN6JJRT/mW2OgVMWCShSZdJm/OjifpveogV+ldKq94
	 5G8kYsXYWdHfmpUnnn6jalpBXB/u0dd6gftJtzaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfGBC2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfGBC2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEE521721;
        Tue,  2 Jul 2019 02:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034502;
        bh=Jr8tGrAxIKCYJdVwkl+TXOArqBDDZZP2yA/eyBGvEJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izxHPHmS54O6Pwe4XOLFxWzbZ1YXMnDyHHwef7xfQ65KOed1gFUeJ6/KII3MLJBqm
         3gbjF+gM5TYj9ciLnCBp5Miqt6Dh1S3jK7TbAqXZ/wOuul2nZXzr1XyAn8+GTe4pKy
         BEw0kQt3yXPWnkKtnbJv/oY3kHzuv2uyAlc+KRhw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 36/43] perf tools: Drop strxfrchar(), use strreplace() equivalent from kernel
Date:   Mon,  1 Jul 2019 23:26:09 -0300
Message-Id: <20190702022616.1259-37-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in behaviour intended, just reducing the codebase and using
something available in tools/lib/.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-oyi6zif3810nwi4uu85odnhv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c     |  3 ++-
 tools/perf/util/string.c  | 18 ------------------
 tools/perf/util/string2.h |  1 -
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1fb18292c2d3..c7fde04400f7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/bug.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/types.h>
@@ -394,7 +395,7 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 				return -ENOMEM;
 		}
 
-		strxfrchar(m->name, '-', '_');
+		strreplace(m->name, '-', '_');
 	}
 
 	return 0;
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 93a5340424df..9b7fbb0cbecd 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -300,24 +300,6 @@ int strtailcmp(const char *s1, const char *s2)
 	return 0;
 }
 
-/**
- * strxfrchar - Locate and replace character in @s
- * @s:    The string to be searched/changed.
- * @from: Source character to be replaced.
- * @to:   Destination character.
- *
- * Return pointer to the changed string.
- */
-char *strxfrchar(char *s, char from, char to)
-{
-	char *p = s;
-
-	while ((p = strchr(p, from)) != NULL)
-		*p++ = to;
-
-	return s;
-}
-
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
 {
 	/*
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 6da835ad8f5b..2696c3fcd780 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -21,7 +21,6 @@ static inline bool strisglob(const char *str)
 	return strpbrk(str, "*?[") != NULL;
 }
 int strtailcmp(const char *s1, const char *s2);
-char *strxfrchar(char *s, char from, char to);
 
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
 
-- 
2.20.1

