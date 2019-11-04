Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE0CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81129214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z04j7Z2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfKDSNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35745 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfKDSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:12:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id d13so12853950pfq.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=my27JHtSw35YmWWmHWoHmAi4DXJc+0VoUXAKN5Q83qQ=;
        b=z04j7Z2+8CJTt3LDDdW0VKHsNjM427ulg1Fso6sALQXW8v87GYdFumTZ7klLVibxEO
         u3G+y2NH9jFQMLEt7KsjCEQA4m8ae69T56BnjtQLjDD6o24drb+6r7tkLlJcCvxPI6o8
         VnUTGyZhug8t2LgkcTeeOZ+M1/3nFrEg0G7+1G2edZVz0UCTAWywDjC5fb79COINfgmo
         qAoLnJx3CQxoKGvRs8t9dFVwThrdoa7bRgJ2rAoZzuqiYu7izvP0JuLduGhaDzKWWMzG
         8swo521Or6HZH3IbMWHAfwHUsrf5P3Lj9OdeSbipMpLXruapJlUzqDlhg8qLeRWdY/l9
         4jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=my27JHtSw35YmWWmHWoHmAi4DXJc+0VoUXAKN5Q83qQ=;
        b=D323UOt1ctWQVOzLzY7yGArA2rjcM4eS8EAJybNzSL8VBOePTdE914K/REv1WK+o23
         UQMZS5ozQTnPOHp4Ij753zdp5Ncpzbr87OMEqQcPdIQDpwO0SLaaRlU0rlJ7DO4C4XZs
         wKLnhIqzNqjmIxWuKNXKhac2CWmhZ2M9QKa1pq6m6m8i3WuU88rHNZkaMxg/NRKeF6gd
         BiZ9x3pNE77JnNDs16mmz/mlY1sDbnwIS1tbHsudPoFLsBI12MGrKoUy4x0k3fgWgSfk
         3DCOsT357nELT8xubl9lWZ2dJ6OLqIAwmjQPJ5e4v39Hs55dFimzfjl+So6hbDBdhZTu
         fcFQ==
X-Gm-Message-State: APjAAAUHG4jII0hQCSx2BP88UmttcLfyYq1oN3BmlwuwG+Fs3ol7UJzi
        +gY//V6/5MIvVcUq0L+C7rsrHg==
X-Google-Smtp-Source: APXvYqwo6ERMAn9zzRRE/QsRWRmEKPu9o64wDRqd4Qw4QjXDW1OS3VHmDK3JNfLpL1n1ZEaivL39Dg==
X-Received: by 2002:a63:1e08:: with SMTP id e8mr10948373pge.336.1572891178635;
        Mon, 04 Nov 2019 10:12:58 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:12:58 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] coresight: etm4x: Fix input validation for sysfs.
Date:   Mon,  4 Nov 2019 11:12:42 -0700
Message-Id: <20191104181251.26732-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

A number of issues are fixed relating to sysfs input validation:-

1) bb_ctrl_store() - incorrect compare of bit select field to absolute
value. Reworked per ETMv4 specification.
2) seq_event_store() - incorrect mask value - register has two
event values.
3) cyc_threshold_store() - must mask with max before checking min
otherwise wrapped values can set illegal value below min.
4) res_ctrl_store() - update to mask off all res0 bits.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Mike Leach <mike.leach@linaro.org>
Fixes: a77de2637c9eb ("coresight: etm4x: moving sysFS entries to a dedicated file")
Cc: stable <stable@vger.kernel.org> # 4.9+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index b6984be0c515..cc8156318018 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -652,10 +652,13 @@ static ssize_t cyc_threshold_store(struct device *dev,
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
+
+	/* mask off max threshold before checking min value */
+	val &= ETM_CYC_THRESHOLD_MASK;
 	if (val < drvdata->ccitmin)
 		return -EINVAL;
 
-	config->ccctlr = val & ETM_CYC_THRESHOLD_MASK;
+	config->ccctlr = val;
 	return size;
 }
 static DEVICE_ATTR_RW(cyc_threshold);
@@ -686,14 +689,16 @@ static ssize_t bb_ctrl_store(struct device *dev,
 		return -EINVAL;
 	if (!drvdata->nr_addr_cmp)
 		return -EINVAL;
+
 	/*
-	 * Bit[7:0] selects which address range comparator is used for
-	 * branch broadcast control.
+	 * Bit[8] controls include(1) / exclude(0), bits[0-7] select
+	 * individual range comparators. If include then at least 1
+	 * range must be selected.
 	 */
-	if (BMVAL(val, 0, 7) > drvdata->nr_addr_cmp)
+	if ((val & BIT(8)) && (BMVAL(val, 0, 7) == 0))
 		return -EINVAL;
 
-	config->bb_ctrl = val;
+	config->bb_ctrl = val & GENMASK(8, 0);
 	return size;
 }
 static DEVICE_ATTR_RW(bb_ctrl);
@@ -1324,8 +1329,8 @@ static ssize_t seq_event_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->seq_idx;
-	/* RST, bits[7:0] */
-	config->seq_ctrl[idx] = val & 0xFF;
+	/* Seq control has two masks B[15:8] F[7:0] */
+	config->seq_ctrl[idx] = val & 0xFFFF;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1580,7 +1585,7 @@ static ssize_t res_ctrl_store(struct device *dev,
 	if (idx % 2 != 0)
 		/* PAIRINV, bit[21] */
 		val &= ~BIT(21);
-	config->res_ctrl[idx] = val;
+	config->res_ctrl[idx] = val & GENMASK(21, 0);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
-- 
2.17.1

