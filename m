Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF727C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75582086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989632;
	bh=qvXJ90tJylYCsBOERQGWydRfCaR9OwjlrfaVKluMhfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M2/RozI5B2ZrF6alW33ZwXY2SOARQLCODzeasXIlKHlGxzNN6iEO8cyjGKJs8yO42
	 1gy/JePOd0KqFYqEDumT9NOjRJlRYcj1zUlW9Hu7AK24v26wt08t5KPyHpn2jsOl+k
	 eCoEvsOlqnm/DK5PS4LF0E9D7uSgOl5++Y72hgXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbfITO1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389010AbfITO0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A972184C;
        Fri, 20 Sep 2019 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989583;
        bh=qvXJ90tJylYCsBOERQGWydRfCaR9OwjlrfaVKluMhfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVJ2Hk58RjdcAtqfaPTVVDanh+MGdn124jCsozHBpNo/QX3HgqY3Kwxq6seoUIOIO
         YFsey+I2bXB/xVU8KVTpKLkM+K1wmrwmwrmf+Kz7ZAAZE4+8YEBb5MLYnMFyodYuge
         k49+CVd1VCvrvatp77zfHUhLCZ5zYUcZUTp+kNqc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/31] perf probe: Add missing build-id.h header.
Date:   Fri, 20 Sep 2019 11:25:22 -0300
Message-Id: <20190920142542.12047-12-acme@kernel.org>
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

It uses things defined in that header and was getting it only
indirectly, thru dso.h, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7u3sf4j5huhi3mqa1q77524b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index d13db55a2feb..b659466ea498 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -16,6 +16,7 @@
 #include "strlist.h"
 #include "strfilter.h"
 #include "debug.h"
+#include "build-id.h"
 #include "dso.h"
 #include "color.h"
 #include "symbol.h"
-- 
2.21.0

