Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A24C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7CF2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D22qwMvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391527AbfEXRfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44711 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391301AbfEXRfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id c5so4434417pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AZrEN/YdY4eKrQn36wY+GaRgnWiV23bSY81bJ8wnh7E=;
        b=D22qwMvxOv68Jbk8yGerAluLOCfagxSd4heu50CTNyczmf41/1BNWjQMJwAiayGx2w
         qna3aSLLtC3xLyupFWvVT7naW+d+e1y5Jb6lFKfizD75fsj9V76HNrx0EFkc59NmO6kS
         AURwwe0cV2bsPjZZTMNQhrO5T3YXKt1KvZq41Hs/XBgPWU4PdtApkKWnl/wGSazNJOgL
         Wq1U7spG/CMFNPo0fFMCCBTYui7aKgYhJG3HsJdYrT2P92gO25WICbl0fmzR1i/oiSjK
         XcsCe9xrrWhkZDqkGbGB++UPBC1yyr7dpNn5+Qt/s2k3zN40BWcdgkPKJsid2aSBYyFs
         6c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AZrEN/YdY4eKrQn36wY+GaRgnWiV23bSY81bJ8wnh7E=;
        b=mh+63u/hw7KYK/jEynp6TOuB5TogfDho47I0NR30hqnbhpVwOAg0htRPPBEhsxOltk
         cUDZ6hlzMMBXhxwWkmZqdyrJyhQz4kwxMa6j+s0Q2VfQXFwjfImGbWomDUBsI27u5FER
         TsWfUIriJLvopOM8ZBh9+Q3ZlxrSzX06WYpHIqvUM1NKFHYAB6sVU95CYyxNgqVhVB0o
         7WpZr3WX92tydEgSXqDMek+heYXw88U5R1p46bI42cKOi5Amag1mQ+pN1MaN5hTtOofV
         idxDiht+djkbimPTNYz1/Fl5JF2d9Q/8/D8UNSiSMd/Am0/NThYph+2mZpbAZOgCbCKh
         8FBA==
X-Gm-Message-State: APjAAAXWmAN2HDHnXEwPEncJu2lCk/pNxb0VBGe1ruNvzQgK93nwEhWQ
        jhImxyjjRhRjnflZScUjz89guw==
X-Google-Smtp-Source: APXvYqwUBzZ6H+lMKMIO13AhW+29cTXVJ5SN2damyrB7ZoRjJtvjkzvqncjxfVou260HauO/dYNT0w==
X-Received: by 2002:a17:902:a70f:: with SMTP id w15mr38056183plq.222.1558719312533;
        Fri, 24 May 2019 10:35:12 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:11 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 02/17] perf tools: Configure timestsamp generation in CPU-wide mode
Date:   Fri, 24 May 2019 11:34:53 -0600
Message-Id: <20190524173508.29044-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When operating in CPU-wide mode tracers need to generate timestamps in
order to correlate the code being traced on one CPU with what is executed
on other CPUs.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 3912f0bf04ed..be1e4f20affa 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -99,6 +99,54 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
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
-- 
2.17.1

