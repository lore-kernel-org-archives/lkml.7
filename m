Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E75C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8642084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808246;
	bh=d2mTeE6/W5Y+yspPvCj7GvzA+9wDsj8e6RZ5oB4wEu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SuvoGR8HgNnsO9Uxk9blfVzFHPFr6NT7VuHBp6XPyXu0Jrv+sIl9PFQyYfyTlDeMw
	 Y0jISnXVpK3KK8hYYd6CQEPIIgAXiyG9mZB9OYvQzDSACtCaY+fszrk2bmvtiKJyAq
	 lhubHQZEhWE7iH5oY8TyT1rjnYX4RX9ALyvVpIYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfHNSoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfHNSoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:44:04 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3492F2064A;
        Wed, 14 Aug 2019 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808243;
        bh=d2mTeE6/W5Y+yspPvCj7GvzA+9wDsj8e6RZ5oB4wEu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTvpXiCo/+2u1FV9/qmNAQ2DrvQ6zNOpxnPMJfQtARyM2J/537cdya5ejWkBnpomH
         JZOITWEG/686RjBbk1661dlvwY4VoZrgbssquBeRdXDY/5bDQE1nQxxgWDV1DjW5GN
         DKBYbjOrfrQcIblyU2tGPiRODbjUTQksEyfe01co=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>
Subject: [PATCH 14/28] perf tools: Add NO_LIBCAP=1 to the minimal build test
Date:   Wed, 14 Aug 2019 15:40:37 -0300
Message-Id: <20190814184051.3125-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need to add these so that we test building without all selectable
features.

Acked-by: Igor Lubashev <ilubashe@akamai.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-eknnvp22elznj0cl5a39hc4v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 5363a12a8b9b..70c48475896d 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -108,6 +108,7 @@ make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
 make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
+make_minimal        += NO_LIBCAP=1
 
 # $(run) contains all available tests
 run := make_pure
-- 
2.21.0

