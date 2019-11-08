Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F81C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874BE22516
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239594;
	bh=kQUuXibv8QS6TvbhT84UpCgvgdJC5JMLRc2/g0gyjrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O25ZxALmP/evWvicR4YIDcmbINrF/DbO7w0R7C/MXe8QVE3e+xjOUqmeh1V2d8BZ2
	 1QXWGFQ+z5d10E7Tz5K3J+RbEW6FdKwckxTpnIHQWmRtLdNOkebMCmeod7ILG7aOba
	 0S1w/SCM3BaOO2slFg2v5v3MYIHr/GBDHHG1g35k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbfKHS7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389190AbfKHS7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:59:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A63322516;
        Fri,  8 Nov 2019 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239589;
        bh=kQUuXibv8QS6TvbhT84UpCgvgdJC5JMLRc2/g0gyjrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxoKAyUEsCTL3W9yq+m4sUqcB5+j7Nb3Gr3ECEqjq1LMtWlPJ9HsSgrqegtEFqo6A
         aO/N6cJjJWlSVZEWNptocxbJaRqhIh1yhPAOwtDY6w0CyvhG5YWoStTwwNeAzcG+jA
         mhTM3vpaaVkwD5Lv7HKWcWX+Dc1guxinEv+I3JtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunfeng Ye <yeyunfeng@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 13/62] perf c2c: Fix memory leak in build_cl_output()
Date:   Fri,  8 Nov 2019 19:50:01 +0100
Message-Id: <20191108174731.690864760@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 32e64a8a6443f..bec7a2f1fb4dc 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2454,6 +2454,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	bool add_sym   = false;
 	bool add_dso   = false;
 	bool add_src   = false;
+	int ret = 0;
 
 	if (!buf)
 		return -ENOMEM;
@@ -2472,7 +2473,8 @@ static int build_cl_output(char *cl_sort, bool no_source)
 			add_dso = true;
 		} else if (strcmp(tok, "offset")) {
 			pr_err("unrecognized sort token: %s\n", tok);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 	}
 
@@ -2495,13 +2497,15 @@ static int build_cl_output(char *cl_sort, bool no_source)
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



