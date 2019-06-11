Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE92CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24A3204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="br92qJdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436531AbfFKUpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:45:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44154 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436506AbfFKUpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:45:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so8152798pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dF0WnaGr98RkhLcmLgoIGl3DfMfT3YTnuXvqgzRmPU0=;
        b=br92qJdRfDtRJUO37iHSmLbRXiDvajUeTM2tW0f2IxX0hCoBDt7Q0J7/dVIrEb91Ww
         UB67hQTp9W9hra48minpZIvZbVUniezaBw8jzEPVJTfPs00fOSIt1AXDJwErRb+WbGfZ
         uzsl/dexSkVOSYbRvNfJwkQKk4YvysvZnyv9S9xOBgTJHbW44q4QwZ8rFykTBMUoLt8I
         6zZtSj8xZ9AiRUkAe1Ddx6ScyUOZcctM0cGEM2zAGf+udiyJLzoBLHm4i5RApqpQDW2b
         dfnk7K9/N3nEb6uK6E2umLqKDcchvGTlSC/U7OZG4jNpw4zOjLTu+REzhYujD4fg4cXo
         4OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dF0WnaGr98RkhLcmLgoIGl3DfMfT3YTnuXvqgzRmPU0=;
        b=QNPJy7gBpPoHlj+eMLPw71z9PO3f/PKWyud5G0m4Wc0wVqP52N7y99YvwuD1KfORHA
         KlE+WVHYVOBv4tiOHcWlEjUzhSGzuaoVSpp7vHAqJWaV7vYuFMZajeOHelxfRbhsZgds
         eybJ5IgKsO26Hvo7OzurQ7jzViFK1hjMWXtcqI+AyEwFhoI+rWQniLQhAsevrhFFIIcY
         c+NlWHjfKi/an9fk3R005RuAhakMnWfhOg2tAEF4zjcYScVzohPFTvtok9Lfg3CXB5ry
         wcVPp/JFEn6yrmUPLTPvWDH4dMalyBwhNFrcr4+hkYibwNjXJIa5sAcsMCZbRSJwWTZN
         3Dvw==
X-Gm-Message-State: APjAAAWVlLpVpesaH5gkEtbdlEaVcSOc0V+PNK8YURpTiskl4WfmEHR+
        VRQ/2yLJfH/FP7IERbwjaZDxtg==
X-Google-Smtp-Source: APXvYqybZEjkm8mWlNFliMajIXJ9xzxAmMas+gJR4YUUP6P2W/dJietSrRwTZoQWfUKbpk63L+hUGQ==
X-Received: by 2002:a17:90a:b908:: with SMTP id p8mr28760708pjr.94.1560285929914;
        Tue, 11 Jun 2019 13:45:29 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f186sm20391683pfb.5.2019.06.11.13.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 13:45:29 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: cs-etm: Optimize option setup for CPU-wide sessions
Date:   Tue, 11 Jun 2019 14:45:28 -0600
Message-Id: <20190611204528.20093-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call function cs_etm_set_option() once with all relevant options set rather
than multiple times to avoid going through the list of CPU more than once.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 279c69caef91..c6f1ab5499b5 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -162,20 +162,19 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 		    !cpu_map__has(online_cpus, i))
 			continue;
 
-		switch (option) {
-		case ETM_OPT_CTXTID:
+		if (option & ETM_OPT_CTXTID) {
 			err = cs_etm_set_context_id(itr, evsel, i);
 			if (err)
 				goto out;
-			break;
-		case ETM_OPT_TS:
+		}
+		if (option & ETM_OPT_TS) {
 			err = cs_etm_set_timestamp(itr, evsel, i);
 			if (err)
 				goto out;
-			break;
-		default:
-			goto out;
 		}
+		if (option & ~(ETM_OPT_CTXTID | ETM_OPT_TS))
+			/* Nothing else is currently supported */
+			goto out;
 	}
 
 	err = 0;
@@ -398,11 +397,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!cpu_map__empty(cpus)) {
 		perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
 
-		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
-		if (err)
-			goto out;
-
-		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS);
+		err = cs_etm_set_option(itr, cs_etm_evsel,
+					ETM_OPT_CTXTID | ETM_OPT_TS);
 		if (err)
 			goto out;
 	}
-- 
2.11.0

