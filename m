Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA061ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3A820872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328213;
	bh=l76HD/Bsr4+V1Z4kh9xGkP+wWjpYLSsdoGEoDtNGCUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ws3EnwjTGPBtCQi98MPIoU+VpdT0JnV6E86gQ/SwYRA0G0GDh2TpqSQ7Qpt38PzmN
	 Q4HlXhigfeuhRGrIOfDFN5yzH04PBzYOL9GggEVxG+I9Kr0tdN2dwpg3oOuHwYTeiP
	 XBBRuEqZKez057Jzd4viAJksR3Vj+9s/3Tibjt0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406209AbfJQQDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfJQQD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48CA222BD;
        Thu, 17 Oct 2019 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328208;
        bh=l76HD/Bsr4+V1Z4kh9xGkP+wWjpYLSsdoGEoDtNGCUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yavlal1CMqeTyhaPhuBjWB1Gag35akk+rsdNuJ3mb1HJhotz40Ow5UVUcDFv3cATP
         +TMxJX6Ob2C+FFc9rWGJsW5WGhPeAyjMfpn59atiPoF+0YyfDLJ+sTrTqapMcHWC3k
         Pcwe84X1KiO4X/RPOfOTafRbXRVBECXE5TrfX1ak=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/11] perf c2c: Fix memory leak in build_cl_output()
Date:   Thu, 17 Oct 2019 13:02:56 -0300
Message-Id: <20191017160301.20888-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

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
---
 tools/perf/builtin-c2c.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3542b6ab9813..e69f44941aad 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2635,6 +2635,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	bool add_sym   = false;
 	bool add_dso   = false;
 	bool add_src   = false;
+	int ret = 0;
 
 	if (!buf)
 		return -ENOMEM;
@@ -2653,7 +2654,8 @@ static int build_cl_output(char *cl_sort, bool no_source)
 			add_dso = true;
 		} else if (strcmp(tok, "offset")) {
 			pr_err("unrecognized sort token: %s\n", tok);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 	}
 
@@ -2676,13 +2678,15 @@ static int build_cl_output(char *cl_sort, bool no_source)
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
2.21.0

