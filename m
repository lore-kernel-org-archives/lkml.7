Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B023EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845BB20882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989638;
	bh=Xdclqw3Jv3pcbyLbPLFrcWATIcq3Jsa+sNnkLrIJHTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2EZKHTmMuiMXRotXXoecDxi+ur+tJZvxlw8LQhT7s1gfiD6/94ti4pQibKmlJddXp
	 ebB3ZIS5bERwYKY8yOJFxW7+H7AMV5jYDNOdz60sMhM1nfCVQ7NiU0jKp1B5osa9cL
	 An8iQzjwoq1Aum8ym5h+otAUJ+yzWJ3TPpBAdUZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbfITO1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389230AbfITO0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BEC2184C;
        Fri, 20 Sep 2019 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989601;
        bh=Xdclqw3Jv3pcbyLbPLFrcWATIcq3Jsa+sNnkLrIJHTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrzVbWnnUgeUVaOlcVBx2HBXlGOgv98giTnX0Ts+tH14zJCfLMsB3EtXOiTm5Sf5S
         f5/Sf1XgFfMkbR04+YrKsdA7tDKfYOM6ommqEEOCQO/20o9DEqxAQ+pJJapxzw5ISK
         TtOrAvbpL4/iRKAxWmFrPtoUxAT4q8k6YhGEz6YM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 18/31] perf hist: Add missing 'struct branch_stack' forward declaration
Date:   Fri, 20 Sep 2019 11:25:29 -0300
Message-Id: <20190920142542.12047-19-acme@kernel.org>
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

Its needed, was being obtained indirectly, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-srzphk0ehptfn3zqmpkgsi65@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 34803e33dc80..6a186b668303 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -15,6 +15,7 @@ struct addr_location;
 struct map_symbol;
 struct mem_info;
 struct branch_info;
+struct branch_stack;
 struct block_info;
 struct symbol;
 struct ui_progress;
-- 
2.21.0

