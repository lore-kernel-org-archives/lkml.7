Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB42BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A817421916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194346;
	bh=VcHFAOYI9OjElkDxR8cyISHZdXRUtgUqWVu30zl3QSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dNg9DkhRAAO+6Rz/xsIRjCOaFa8o0uag3JgeS1BXw72m4nuuT5bw7fAEoxa/pSERN
	 6ov+yAQSJ16KLc6/TVE/iCpJ/GIqi3L8AObnbKWt5jmJvFgvyZIgNBjFa2pLj1Pj9I
	 ZJc12nuy2g+ZBFVgTvL5z4jPC/uuEh/kt0l3VfAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfCUSwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbfCUSwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:52:23 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B0AC21929;
        Thu, 21 Mar 2019 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194342;
        bh=VcHFAOYI9OjElkDxR8cyISHZdXRUtgUqWVu30zl3QSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0fRmkyoLjsTolhziI5IwLP7ikwBaFfk/fGpf4yG4Hc+c5A79xaipg4q7P0DEtuVl
         vciewg4RdvrIV9itWtnzBXIyI/EdocapdRlHI5f5aM8TZZHoGEMPIp78BEeGeNp2sL
         NYAo7U7Ex6D3lIbDkJQnHipiGC7+5hIYgW+yYitk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/44] perf stat: Improve scaling
Date:   Thu, 21 Mar 2019 15:51:06 -0300
Message-Id: <20190321185142.11441-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The multiplexing scaling in perf stat mysteriously adds 0.5 to the
value. This dates back to the original perf tool. Other scaling code
doesn't use that strange convention. Remove the extra 0.5.

Before:

$ perf stat -e 'cycles,cycles,cycles,cycles,cycles,cycles' grep -rq foo

 Performance counter stats for 'grep -rq foo':

         6,403,580      cycles                                                        (81.62%)
         6,404,341      cycles                                                        (81.64%)
         6,402,983      cycles                                                        (81.62%)
         6,399,941      cycles                                                        (81.63%)
         6,399,451      cycles                                                        (81.62%)
         6,436,105      cycles                                                        (91.87%)

       0.005843799 seconds time elapsed

       0.002905000 seconds user
       0.002902000 seconds sys

After:

$ perf stat -e 'cycles,cycles,cycles,cycles,cycles,cycles' grep -rq foo

 Performance counter stats for 'grep -rq foo':

         6,422,704      cycles                                                        (81.68%)
         6,401,842      cycles                                                        (81.68%)
         6,398,432      cycles                                                        (81.68%)
         6,397,098      cycles                                                        (81.68%)
         6,396,074      cycles                                                        (81.67%)
         6,434,980      cycles                                                        (91.62%)

       0.005884437 seconds time elapsed

       0.003580000 seconds user
       0.002356000 seconds sys

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20190314225002.30108-10-andi@firstfloor.org
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 53ec40cacd4b..16f02b83b23f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1342,7 +1342,7 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 			count->val = 0;
 		} else if (count->run < count->ena) {
 			scaled = 1;
-			count->val = (u64)((double) count->val * count->ena / count->run + 0.5);
+			count->val = (u64)((double) count->val * count->ena / count->run);
 		}
 	}
 
-- 
2.20.1

