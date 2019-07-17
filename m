Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BBEC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A088208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ku2Rmwb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfGQXHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:07:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43901 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfGQXHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:07:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN6uGU1725937
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:06:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN6uGU1725937
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404817;
        bh=p4khU32OS/SGsB9YVVqTTkE9ITavTAoe/NLXnAteaPc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ku2Rmwb7llk3atGHTHDhs4Phae6LgP/HxaoePjueNOeY6rojkW4jiUjV9rQOUI0Uv
         8GC790FzU8X0GqXaRL8JsVwAQtY3rniJBqwhCeVvw367K9ZU5v8BuoVPN+34fCy21V
         1zISMPdPUds7Ctlyi69MMxeMx2XScpmL1QWNIhcvAL+gQhWXz/8uypmA8wTxe65Zyw
         XfF5b+KtfqqSvUrJ8c4MDpF4PSf1xjB7dydd8r2SopLpDAfxMRvz8p9Z2LGX9t8qfI
         zw+onkwDB6WL3h8sKQiu7Sffe2VIpnC53sngiW9mro42I/tss4vHouYUh6NqwxPE7z
         hxK5+OYcHUl4g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN6u971725934;
        Wed, 17 Jul 2019 16:06:56 -0700
Date:   Wed, 17 Jul 2019 16:06:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-6285bd151b95aa28d6de9b8b9249702681f059d2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com,
        acme@redhat.com, yuehaibing@huawei.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, hpa@zytor.com, namhyung@kernel.org
Reply-To: hpa@zytor.com, namhyung@kernel.org, mathieu.poirier@linaro.org,
          suzuki.poulose@arm.com, peterz@infradead.org, tglx@linutronix.de,
          yuehaibing@huawei.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
          acme@redhat.com
In-Reply-To: <20190321023122.21332-3-yuehaibing@huawei.com>
References: <20190321023122.21332-3-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cs-etm: Return errcode in
 cs_etm__process_auxtrace_info()
Git-Commit-ID: 6285bd151b95aa28d6de9b8b9249702681f059d2
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

Commit-ID:  6285bd151b95aa28d6de9b8b9249702681f059d2
Gitweb:     https://git.kernel.org/tip/6285bd151b95aa28d6de9b8b9249702681f059d2
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Thu, 21 Mar 2019 10:31:22 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 11 Jul 2019 12:45:02 -0300

perf cs-etm: Return errcode in cs_etm__process_auxtrace_info()

The 'err' variable is set in the error path, but it's not returned to
callers.  Don't always return -EINVAL, return err.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
Link: http://lkml.kernel.org/r/20190321023122.21332-3-yuehaibing@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2e9f5bc45550..3d1c34fc4d68 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2517,8 +2517,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	session->auxtrace = &etm->auxtrace;
 
 	etm->unknown_thread = thread__new(999999999, 999999999);
-	if (!etm->unknown_thread)
+	if (!etm->unknown_thread) {
+		err = -ENOMEM;
 		goto err_free_queues;
+	}
 
 	/*
 	 * Initialize list node so that at thread__zput() we can avoid
@@ -2530,8 +2532,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
-	if (thread__init_map_groups(etm->unknown_thread, etm->machine))
+	if (thread__init_map_groups(etm->unknown_thread, etm->machine)) {
+		err = -ENOMEM;
 		goto err_delete_thread;
+	}
 
 	if (dump_trace) {
 		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
@@ -2575,5 +2579,5 @@ err_free_traceid_list:
 err_free_hdr:
 	zfree(&hdr);
 
-	return -EINVAL;
+	return err;
 }
