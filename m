Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22D1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69982332B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329281;
	bh=vtqbK9mGtI6as3bH2GSUadV/QkwH6uFxGf2ITP2bEyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OtudPf3JW+lZ4QBxAdEJ+kaNbXGc0b+ptFOGzIATwgDQYtXESJ4v3nny0n4WylnPZ
	 FZNwfivd3b7sAfargLp5hvyLS9YZ5Enai7pG3cFJ7CDuVDeSJROQuInCTcFFkppB1M
	 CbAYrn8cHXtOyOb4toZRWwVG2lsb9GXuZHagbnNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfHTT2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbfHTT17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:27:59 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 500C822DD3;
        Tue, 20 Aug 2019 19:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329279;
        bh=vtqbK9mGtI6as3bH2GSUadV/QkwH6uFxGf2ITP2bEyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upANkQdJDNG0WcYxmBZwDUyHugvLD51buuO/NnA698Wphl6dONAPv4jZZ3f5BvKsx
         e+wjqREzaspvC4Yvfgu4vvw35zE7qBRz44ExjmaInOBVH/ZGCQuUMdasfn6mES+lzP
         7rYbXsk9qucP7EOTPCAr3lB3VLqF0I8j8af6Lop8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 02/17] perf tools: tools/include should come before tools/uapi/include
Date:   Tue, 20 Aug 2019 16:27:18 -0300
Message-Id: <20190820192733.19180-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The next cset will grap const.h copies from the kernel to keep bits.h
in sync as it started to use linux/const.h, that in turn includes
uapi/linux/const.h.

So now we have a file with the same name in tools/include and
tools/uapi/include, and one includes the other, we need to have
tools/include/uapi/ after tools/include/ for this to work, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-qzjqxa1wdrt51kwadyqawnuj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9a06787fedc6..bf8caa7d17f6 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -280,9 +280,9 @@ endif
 INC_FLAGS += -I$(src-perf)/lib/include
 INC_FLAGS += -I$(src-perf)/util/include
 INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
-INC_FLAGS += -I$(srctree)/tools/include/uapi
 INC_FLAGS += -I$(srctree)/tools/include/
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
+INC_FLAGS += -I$(srctree)/tools/include/uapi
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/
 
-- 
2.21.0

