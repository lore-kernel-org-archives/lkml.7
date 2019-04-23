Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6527AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FF220685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHmFr0Ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfDWN2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:28:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39685 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfDWN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:28:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so13518769ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPf6o+4Fx6BNBg9gjLd55OiV879tfPNqQcVlMqs6y0g=;
        b=jHmFr0Ji3NPCs6KScyG5QEgqkd/ZNlX5zGr23YkTpGO2to5XJsMw+hLNB1ZuPWG0g8
         wiShsf0tLLH/TtyfTemrRboVDLC56NOsDUPkb5xH3oufJ4oNE64DyhfI/BW3RHF2jz7a
         yuoIcNqZrrcVzG/ulGq+Lx3VilqGfm2VLptYSwEiCbmVqiuXJCeQ8T25URw4xMo1D0gv
         ErRGrCLMoMJ2qD9B8QPBJh1IBMfijYAGqSAJqWTEyDfDVDr1PL2RnT7EwEhRb5nM89YM
         DWJ9gWe6C1ZRe5cB+GCy/GJniYisxNZifkud7+fxxQ2ZNwNH/f3s415udFVd9qqjieBC
         wwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPf6o+4Fx6BNBg9gjLd55OiV879tfPNqQcVlMqs6y0g=;
        b=GVNtVgeve1f/mgcBIDEczDwNpmX0KrNCeAFLYlLx/5L29aKJygmyIsn87iNzW4AqcH
         VuMT7Kfe9/eDBpSpLUxvRn0rjaMhNqdjGdx6PkywVdmJkdeo3nXU+Rzl5xkPccQs1eGn
         Y5cf4NfPTLoU3+qPKtA2oTnZ6zYMj9SU+P6G620SdIUjAWfzEouC9DUdJ39pmh65kMRF
         eCw0NSgJobCJbjTqxqGBfDTTNV53EJDwcfsYnhWge9Yo/s2nmGJdcyYGiOp2gVaAqXfo
         bp8PWW7Kl0wj0CrQfdV7R6SipgW9Hz9credB48jhvzDKF5+yKQtpktTh3/lmKBN88hlc
         M9ew==
X-Gm-Message-State: APjAAAWm4+zFPB/NFggETuIE0TvXe+zxDfGQ+lwUfOTULXwsr2f6sGhV
        rphZJrMTt1SCjglBOckOQnd9BQ==
X-Google-Smtp-Source: APXvYqxJBaGcY+Di1m9z+nyzZSyjRVq/y3HxdVMb8Y8nJx9/QbBtvSZgIZcPmYZ+R+o4V12dtvM85Q==
X-Received: by 2002:a2e:998d:: with SMTP id w13mr13886812lji.110.1556026115286;
        Tue, 23 Apr 2019 06:28:35 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y206sm4617107lfc.72.2019.04.23.06.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:28:34 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 4/5] OPP: Update the bandwidth on OPP frequency changes
Date:   Tue, 23 Apr 2019 16:28:22 +0300
Message-Id: <20190423132823.7915-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423132823.7915-1-georgi.djakov@linaro.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the OPP bandwidth values are populated, we want to switch also the
interconnect bandwidth in addition to frequency and voltage.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/opp/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 97ee39ecdebd..91d1c2abfb3e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -707,7 +707,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	unsigned long freq, old_freq;
 	struct dev_pm_opp *old_opp, *opp;
 	struct clk *clk;
-	int ret;
+	int ret, i;
 
 	if (unlikely(!target_freq)) {
 		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
@@ -780,6 +780,13 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		ret = _generic_set_opp_clk_only(dev, clk, freq);
 	}
 
+	if (!ret && !IS_ERR_OR_NULL(opp_table->paths)) {
+		for (i = 0; i < opp_table->path_count; i++) {
+			icc_set_bw(opp_table->paths[i], opp->bandwidth[i].avg,
+				   opp->bandwidth[i].peak);
+		}
+	}
+
 	/* Scaling down? Configure required OPPs after frequency */
 	if (!ret && freq < old_freq) {
 		ret = _set_required_opps(dev, opp_table, opp);
