Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC147C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9843B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BY2+6jqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfFQTVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:21:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51485 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:21:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJKro83560486
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:20:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJKro83560486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799254;
        bh=KA5D41dpDaw8lXCMv2MsVclwjNxtdAVn+2wXzflv/Nc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BY2+6jqa8AVw1+3swP9iM+kKIxd4HcfbI3xoyUUr0Em5FGyY1ZUIX+2CCc1hmsN3+
         0QJKds6b//UcbDpUEuy++fpPO8hO0OpML2Ta8WFt42qmp3xchM9yDQz81m8DWMYXf2
         qF1jZNI45TpMo/0aHqanrOFyn5eVhxTLZNaII13ihbw5X3lH95r4h4zcBZRDDyn/75
         lYAE7w/Piu9vdnKv1FVLzUwKtL2BRQhBw/e0jXSqtB03x6ft3RgQamDLJImBIJLCn2
         72wiVtY4PjWwq97vPZMDgydnZho+yMTN3ny0hISnwtd/LsJVQQNSlOhobsVK+IoGCw
         Vvft0nuQX+ZYQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJKrAb3560483;
        Mon, 17 Jun 2019 12:20:53 -0700
Date:   Mon, 17 Jun 2019 12:20:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-1c839a5a4061bf4554430037b04a115efc9dd8a1@git.kernel.org>
Cc:     peterz@infradead.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, mathieu.poirier@linaro.org,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com
Reply-To: jolsa@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          suzuki.poulose@arm.com, peterz@infradead.org, hpa@zytor.com,
          mathieu.poirier@linaro.org, namhyung@kernel.org,
          leo.yan@linaro.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, acme@redhat.com
In-Reply-To: <20190524173508.29044-3-mathieu.poirier@linaro.org>
References: <20190524173508.29044-3-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Configure timestamp generation in
 CPU-wide mode
Git-Commit-ID: 1c839a5a4061bf4554430037b04a115efc9dd8a1
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

Commit-ID:  1c839a5a4061bf4554430037b04a115efc9dd8a1
Gitweb:     https://git.kernel.org/tip/1c839a5a4061bf4554430037b04a115efc9dd8a1
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:34:53 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:01 -0300

perf cs-etm: Configure timestamp generation in CPU-wide mode

When operating in CPU-wide mode tracers need to generate timestamps in
order to correlate the code being traced on one CPU with what is executed
on other CPUs.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-3-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 3912f0bf04ed..be1e4f20affa 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -99,6 +99,54 @@ out:
 	return err;
 }
 
+static int cs_etm_set_timestamp(struct auxtrace_record *itr,
+				struct perf_evsel *evsel, int cpu)
+{
+	struct cs_etm_recording *ptr;
+	struct perf_pmu *cs_etm_pmu;
+	char path[PATH_MAX];
+	int err = -EINVAL;
+	u32 val;
+
+	ptr = container_of(itr, struct cs_etm_recording, itr);
+	cs_etm_pmu = ptr->cs_etm_pmu;
+
+	if (!cs_etm_is_etmv4(itr, cpu))
+		goto out;
+
+	/* Get a handle on TRCIRD0 */
+	snprintf(path, PATH_MAX, "cpu%d/%s",
+		 cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
+	err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
+
+	/* There was a problem reading the file, bailing out */
+	if (err != 1) {
+		pr_err("%s: can't read file %s\n",
+		       CORESIGHT_ETM_PMU_NAME, path);
+		goto out;
+	}
+
+	/*
+	 * TRCIDR0.TSSIZE, bit [28-24], indicates whether global timestamping
+	 * is supported:
+	 *  0b00000 Global timestamping is not implemented
+	 *  0b00110 Implementation supports a maximum timestamp of 48bits.
+	 *  0b01000 Implementation supports a maximum timestamp of 64bits.
+	 */
+	val &= GENMASK(28, 24);
+	if (!val) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* All good, let the kernel know */
+	evsel->attr.config |= (1 << ETM_OPT_TS);
+	err = 0;
+
+out:
+	return err;
+}
+
 static int cs_etm_set_option(struct auxtrace_record *itr,
 			     struct perf_evsel *evsel, u32 option)
 {
@@ -118,6 +166,11 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 			if (err)
 				goto out;
 			break;
+		case ETM_OPT_TS:
+			err = cs_etm_set_timestamp(itr, evsel, i);
+			if (err)
+				goto out;
+			break;
 		default:
 			goto out;
 		}
@@ -343,6 +396,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
 		if (err)
 			goto out;
+
+		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS);
+		if (err)
+			goto out;
 	}
 
 	/* Add dummy event to keep tracking */
