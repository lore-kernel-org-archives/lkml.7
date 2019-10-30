Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF9CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE9A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450800;
	bh=nd/q3ClEkUlGUFvr5ZowwnzZBh+B2SqzGvQsA+ggPcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YKd8sErQ3XPiSxeLglXs4NIHlUObxJFL5ine6ai5RACf0OnBCXZZ9WnOyn1Z0P3sg
	 0joMO44rVvQWYO+R4pc93jDqsL/uEZsQUVn6UXtKyZmJp0n5nSZ4MaoEOR23GKroTb
	 GuFHzISqJC57+Qy+BQvPWuB2DzzimKewFWQyLFF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfJ3PxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfJ3PxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:53:13 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4302120656;
        Wed, 30 Oct 2019 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450792;
        bh=nd/q3ClEkUlGUFvr5ZowwnzZBh+B2SqzGvQsA+ggPcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZeHukSVEoGk2PUeu3PTZ8Xbnuhr3MA38TK+bMGb53HjHuDI9LbPDrQenDxz5UfQpM
         XijpKCFVUzZ7rCNLwGd0aQ2Zq1eqBe22v0/rS+43JGq1+uQthI3fAMmZmx5WTbTSF2
         0ugQzharyQdNBscMyMKbWEdyVFFgJCR/MuzfntPs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 50/81] perf c2c: Fix memory leak in build_cl_output()
Date:   Wed, 30 Oct 2019 11:48:56 -0400
Message-Id: <20191030154928.9432-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

[ Upstream commit ae199c580da1754a2b051321eeb76d6dacd8707b ]

There is a memory leak problem in the failure paths of
build_cl_output(), so fix it.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/4d3c0178-5482-c313-98e1-f82090d2d456@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-c2c.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e3776f5c2e01a..637e181426587 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2627,6 +2627,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	bool add_sym   = false;
 	bool add_dso   = false;
 	bool add_src   = false;
+	int ret = 0;
 
 	if (!buf)
 		return -ENOMEM;
@@ -2645,7 +2646,8 @@ static int build_cl_output(char *cl_sort, bool no_source)
 			add_dso = true;
 		} else if (strcmp(tok, "offset")) {
 			pr_err("unrecognized sort token: %s\n", tok);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 	}
 
@@ -2668,13 +2670,15 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		add_sym ? "symbol," : "",
 		add_dso ? "dso," : "",
 		add_src ? "cl_srcline," : "",
-		"node") < 0)
-		return -ENOMEM;
+		"node") < 0) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	c2c.show_src = add_src;
-
+err:
 	free(buf);
-	return 0;
+	return ret;
 }
 
 static int setup_coalesce(const char *coalesce, bool no_source)
-- 
2.20.1

