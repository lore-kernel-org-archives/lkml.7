Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0687DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AD22085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153511;
	bh=dzxy8kBIvfQifHvGvvtKttTSsparh5xInh7f2n9OBX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sOwgqsTz8SSY+kPqDcAYAwz0q65jGkdyoI8aoru7hPRvMr3Xrl6LUG5ySSZYW7LtU
	 TwQ2T/AmYVY4z6lIv6PxO8B74/6FC5WxzpGbzAPnIpBBEgRzjq86l24wo3dab512He
	 HELTtr+OqD0xaIwE/G8TitZdfxxPPtUEvWv3JD9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfKGTFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbfKGTFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:05:09 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022FA218AE;
        Thu,  7 Nov 2019 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153508;
        bh=dzxy8kBIvfQifHvGvvtKttTSsparh5xInh7f2n9OBX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQ6w8aF8tCRkhoPVAK2fcYndBmIGxWF8B/QALl4wYhvov5ug0PZKv8YJeZiRarR5v
         hYUkGQV9UJw3rKfIFfHcjWTJxsyg/OeNETUeicR9rsXw+CTRMYqIO/6XNtfq+ng0M7
         eeUn9XdCpYeKDTyd8Dp0gStY12MuQ2Ck/taSs0lg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <James.Clark@arm.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, nd <nd@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/63] libsubcmd: Use -O0 with DEBUG=1
Date:   Thu,  7 Nov 2019 15:59:41 -0300
Message-Id: <20191107190011.23924-34-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Clark <James.Clark@arm.com>

When a 'make DEBUG=1' build is done, the command parser is still built
with -O6 and is hard to step through, fix it making it use -O0 in that
case.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: nd <nd@arm.com>
Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 352c6062deba..1c777a72bb39 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -27,7 +27,9 @@ ifeq ($(DEBUG),0)
   endif
 endif
 
-ifeq ($(CC_NO_CLANG), 0)
+ifeq ($(DEBUG),1)
+  CFLAGS += -O0
+else ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
 else
   CFLAGS += -O6
-- 
2.21.0

