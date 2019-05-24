Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A014C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFED2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWnMfzRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391788AbfEXRhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:37:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41216 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391362AbfEXRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so800041pgp.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WjG/oYBVCTJ2cGSnVCWqwlxIc3B5k8jAV6xmXnGg2uk=;
        b=DWnMfzRx8uWzIrexmTH6icT77P0bzj4A6Bl6Me/8fyKJ8+Eh3WN52ltUnTzvTw5zRC
         HqrcyTxeWw74Fbnf4SkuWYKwDcySDL0v94ERXknwIAdQeEPQRTsFFy3CDrDfEMrsobFu
         +u6eSxb32WMlbSljrRidcbVprKanMJhy03X3qbq8Oad4e4OzTBhD7CyEW9JdLKtYDhhn
         vdKgLO8Ndg/mEc0nizAxhj4aLYpounInK92BylqJ4S8KAb4IaOEx2GtsMfkVQA54T0sK
         9bb6sTPJaVA4Z6ZIDVcJhHa4666uS8PNjQM4icyA/sRqP7SZb86pbQUM1wNKkcdjxGpW
         XFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WjG/oYBVCTJ2cGSnVCWqwlxIc3B5k8jAV6xmXnGg2uk=;
        b=KycMgtk8SdDUy0c4iV9Qkfx5V/fh1cOSOgbGJUB3mQ6Syn5AYn4nHTgUmeGw7y/WRO
         bwkm+nWPcHW5L59umoiC+WJowttFXAUejMM2QTVvBkE6kgpDGOhVuCfVuAx48rBqV2Ei
         EiJuMesnSrahn+FG2lUYpcAHOsJaP6NdK4ncv/aHLteVHEgZNsJxCEeSZBGRBId3H9tb
         3xpz9vxyJs9QJSdM9nExuugtVD3ZF4Hl2DXFdDrq0F1GzyArFyMekUtvNDTQSCSSM17B
         oUqm58J6CZqJMD4Zfpqyy8R63xsDriCEp6PIpOjmXXmzBbHcc2L6UqZNi+9xD7wqHjiV
         Sl6g==
X-Gm-Message-State: APjAAAVtJmcWQMiLSGvqhnxWaL8QwV1kv38AxMBMGwENFiq2BYRUAZ4j
        a++bO77X4uzO0xlM4uu0tFMz3w==
X-Google-Smtp-Source: APXvYqxF7Gh9lYjg7zMff3L3s+55twJiUlAXjsPmW0fDU2skcjVUANizUZ6SrVSwPuiqOGu0q2pGPg==
X-Received: by 2002:a17:90a:d992:: with SMTP id d18mr10956709pjv.74.1558719313700;
        Fri, 24 May 2019 10:35:13 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:13 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 03/17] perf tools: Configure SWITCH_EVENTS in CPU-wide mode
Date:   Fri, 24 May 2019 11:34:54 -0600
Message-Id: <20190524173508.29044-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ask the perf core to generate an event when processes are swapped in/out of
context.  That way proper action can be taken by the decoding code when
faced with such event.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index be1e4f20affa..cc7f1cd23b14 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -257,6 +257,9 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	ptr->evlist = evlist;
 	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
 
+	if (perf_can_record_switch_events())
+		opts->record_switch_events = true;
+
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->attr.type == cs_etm_pmu->type) {
 			if (cs_etm_evsel) {
-- 
2.17.1

