Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D1EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760BD2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JG7qosCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDDDfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:35:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42264 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDDfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:35:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so613974pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQJCMdAOcoU1qu2khwRxnoxNDPS67R2CoUeniO+PC88=;
        b=JG7qosCgIljTpyMPcpMLIF001Mci7KhIhDxzZNrpV/i1kcDTXgjJ6kbJSb2Dvemp3n
         Ga8GciIaVKWkZBJCrEsTGGKZGocGG4jFQirf7ktsTDhKh3FYLyA80Rs4go2DlpEXZpiz
         RlZmzMcetNrU1fLoBHkNkWsMIBNmljfmvCH3x45TM9DA6sC+/bAV1wSrp+88U28W6TlM
         c3vWSTPz15/4FTtdoodb6FlC95ap7dVUKQp79ClVhkuJj2eZCtGvKB/6HnLirkJTX1z4
         iL1aw6pnDdpmLvbsWmMyD98wNnyKfyVsYgEtVrje+1TPi2y+sVF6RuyD5wVlnJm23Lff
         acuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pQJCMdAOcoU1qu2khwRxnoxNDPS67R2CoUeniO+PC88=;
        b=q8pT9pgp8UmjoZPmKdHla8UjcNQol7/OnXPoCwDlnPdfltOrVRWX3AP/77CFQKMGZ3
         gyajM/sa/xb8jtcWWV1BJGbBUppeud+W2C0Dk8JIS0iYBEXZb1P94cH//quhOqmUVEm/
         j3mDeZH0COPkgi8WPBlai2MFnAu6eP6pKw5roCgW8FRZHH+vACzDQ//gA4glLldnKD99
         4yP9X5wm+IlL2MSBqsR/fuYxiY3Js4IgP9Ov3ErnhA60bi/jBU0rc1+hxKdMKXYqY3xm
         aBjdkpQHbkxbUsNC72NbR9tfRiEEQmuC6xZIiXsmolZEZFS5Mr83pmgVGWQfsuR2hEBp
         N7QA==
X-Gm-Message-State: APjAAAX2UAyhOFa94AUlWWXjZR/+zg/VYkV4UXg7TH0TwlMHfFNK2+lV
        Os87K1y3GPmzw28KX/knE7ymew==
X-Google-Smtp-Source: APXvYqzz4PAAhINMsK1jx9DPuPk/EwTYR29ySmoa8sYofrQHiMdlGJVpaVV97IsDP9S/Oc6Hcr7GzQ==
X-Received: by 2002:a62:458a:: with SMTP id n10mr3321188pfi.136.1554348952475;
        Wed, 03 Apr 2019 20:35:52 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:35:51 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/20] coresight: pmu: Adding ITRACE property to cs_etm PMU
Date:   Wed,  3 Apr 2019 21:35:22 -0600
Message-Id: <20190404033541.14072-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add to the capabilities the ITRACE property so that ITRACE START events
are generated when the PMU is switched on by the core.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 4d5a2b9f9d6a..25ae56e924bb 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -566,7 +566,8 @@ static int __init etm_perf_init(void)
 {
 	int ret;
 
-	etm_pmu.capabilities		= PERF_PMU_CAP_EXCLUSIVE;
+	etm_pmu.capabilities		= (PERF_PMU_CAP_EXCLUSIVE |
+					   PERF_PMU_CAP_ITRACE);
 
 	etm_pmu.attr_groups		= etm_pmu_attr_groups;
 	etm_pmu.task_ctx_nr		= perf_sw_context;
-- 
2.17.1

