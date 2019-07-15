Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EC7C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B70220693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225264;
	bh=njW0bB1LOwlsjkJq3l6wKORuSwdcELkmmTcNsV37EB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=StzjhF+hjwdriP3q8zGK8oAPkPgf4r+NGIEVZGvfUM4Y6NwwfW164MNBDUDE57OS9
	 SarWZLN+GIP/BVSu29idnWISMK4EfY1uF6ET7ovRdaaY9ZjMXgflCDfasSbZqiONFI
	 s0RRV1um7VZqrH+qx5tg1f7W0HpigqMCqWfRlVXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfGOVOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfGOVOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:14:22 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3AB20665;
        Mon, 15 Jul 2019 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225261;
        bh=njW0bB1LOwlsjkJq3l6wKORuSwdcELkmmTcNsV37EB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1mSZYFK5WSO+eBV1AXjSMPlXe3f9G1xVTSpAdyKImqwH8yxwXwboLiioFoUWpcYRT
         2N4IfAKCn+D5xbBxRi80oZPfWaFaJXGTqVumMeNrfgJpHrwwgHKfO68Ufkf6JYhXyv
         xtb63FWRM1B0dIJjJVVF8Eun3BTRHDA9sXDCyiT0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/28] perf cs-etm: Remove errnoeous ERR_PTR() usage in cs_etm__process_auxtrace_info
Date:   Mon, 15 Jul 2019 18:11:57 -0300
Message-Id: <20190715211200.10984-26-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

intlist__findnew() doesn't uses ERR_PTR() as a return mechanism
so its callers shouldn't try to extract the error using PTR_ERR(
ret) from intlist__findnew(), make cs_etm__process_auxtrace_info
return -ENOMEM instead.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
Link: http://lkml.kernel.org/r/20190321023122.21332-2-yuehaibing@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 67b88b599a53..2e9f5bc45550 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2460,7 +2460,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 		/* Something went wrong, no need to continue */
 		if (!inode) {
-			err = PTR_ERR(inode);
+			err = -ENOMEM;
 			goto err_free_metadata;
 		}
 
-- 
2.21.0

