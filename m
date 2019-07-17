Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A9C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CE5208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e8BS8AGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfGQXHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:07:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36831 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfGQXHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:07:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN6EhB1725865
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:06:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN6EhB1725865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404775;
        bh=wl5h2MMEfIUe1oRZWA6zrlKk4aCsHL+SmTxC6UOhKAE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=e8BS8AGf0rhRi3kOzGgvkk2sBSVCCOB3ZBWEsGK31NzOVSDdryICqCKVDgSjJI5no
         aOfbhH4HvzvK8zMbXxFUFuFcuoAfnSoZAbvW4yj8DIudIIyJSfcYkZ89cGhu0kPDR2
         SxCTAQyGfCeVATKkvdNHhn4kHph+EJxTMgzN8HorRKVmhrcuBQIoWPA5H5uLMJfHIg
         J481BmO5FA52T65rU+jqOAiCwEzcPtnlI5HhTSrHOOX1/fSyDuQn/4iuq9oDqvus/O
         HEgnDB+WMIHO5ze2GTfp3WhUnCDeAzckELIUSXZQCBkz+4N7r+AWQBTDMBzKWzt4tz
         o/bNsBGxtUYew==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN6Ddj1725857;
        Wed, 17 Jul 2019 16:06:13 -0700
Date:   Wed, 17 Jul 2019 16:06:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-edc82a99437a93c36b0ae18eb6daac0097fc6bd3@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        yuehaibing@huawei.com, acme@redhat.com, jolsa@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mathieu.poirier@linaro.org,
          namhyung@kernel.org, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
          acme@redhat.com, yuehaibing@huawei.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com
In-Reply-To: <20190321023122.21332-2-yuehaibing@huawei.com>
References: <20190321023122.21332-2-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cs-etm: Remove errnoeous ERR_PTR() usage in
 cs_etm__process_auxtrace_info
Git-Commit-ID: edc82a99437a93c36b0ae18eb6daac0097fc6bd3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  edc82a99437a93c36b0ae18eb6daac0097fc6bd3
Gitweb:     https://git.kernel.org/tip/edc82a99437a93c36b0ae18eb6daac0097fc6bd3
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Thu, 21 Mar 2019 10:31:21 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 11 Jul 2019 12:42:46 -0300

perf cs-etm: Remove errnoeous ERR_PTR() usage in cs_etm__process_auxtrace_info

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
 
