Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B10BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6381F206D9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575574364;
	bh=8cd4bvbz9sQNlYIOKnGt9W2gIx0OgdJAbY687uV3Ffs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BfEOZsq7VNkUZxYLp+5jMkv4v8+wMTKelWlRnhYvxR7z9x1YYEShdODVwJdZSDFvH
	 jYvD1ZL3WBK106IvmU3EjczJfMtwy1e0RE92iXKs+cXj5+2hzjiKqO9jKbyjJ0L3ip
	 fH9Xltwr90uZL9RYInVxeg/oX9/V+3HMoi+Jn13A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfLETcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLETcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:32:41 -0500
Received: from quaco.ghostprotocols.net (179-240-141-74.3g.claro.net.br [179.240.141.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954612464D;
        Thu,  5 Dec 2019 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575574361;
        bh=8cd4bvbz9sQNlYIOKnGt9W2gIx0OgdJAbY687uV3Ffs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwBhfAI3Rhx3lPy/fxyU6HjWHQHbz1bn56ImdjohEKtYtyQWIfV9nsDW+Lq05VfxH
         vyBMuchSfFtTA4MojYHfeNuNDc0bqxK/68yPfiGLCvY2EddH62MDfbPcQR5sLE3/jR
         /sK49wVF7V0yNfoWcaK8RLN35sbU1E4QxHxYisdk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/6] perf report: Make -F more strict like -s
Date:   Thu,  5 Dec 2019 16:32:20 -0300
Message-Id: <20191205193224.24629-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Currently -F allows branch-mode / mem-mode fields with -F even
when perf report is not running in that mode. Don't allow that.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191114132213.5419-3-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 106d795574ba..9fcba2872130 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2959,6 +2959,9 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
 		if (strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
+		if (sort__mode != SORT_MODE__MEMORY)
+			return -EINVAL;
+
 		return __sort_dimension__add_output(list, sd);
 	}
 
@@ -2968,6 +2971,9 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
 		if (strncasecmp(tok, sd->name, strlen(tok)))
 			continue;
 
+		if (sort__mode != SORT_MODE__BRANCH)
+			return -EINVAL;
+
 		return __sort_dimension__add_output(list, sd);
 	}
 
-- 
2.21.0

