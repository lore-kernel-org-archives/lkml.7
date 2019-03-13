Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CC4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5D021850
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMKInlTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfCMJAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:00:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43667 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfCMJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:00:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id z20so796811ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gFFJDf2YnnW41mbrUGLhQnv9x8YWw9okQzyBd4EYFU=;
        b=jMKInlTbt1kLgeuLKDe1amgKHzJijr6f5OIpO20OyvgkfgsGFPnJBf+y9RYwcTwOWp
         RSMMny0yclfzx9rhkKAM0DE4N2KIqEt+MeGSe+EybjdQ7/um9Aq+qwJ/5Dj5hLXZ9eVz
         wCvKQ2Kdna0pdjPTg49jZt06SR5Img4H2vK36R85kcNZlz0Ea5dTHlt/d+cy9J8yWfpZ
         ZVKB8PHcjom6Wbt/de+T18MQw4P9JQ1WyQ7HyppLQ7ScMyO4hwzhVb2GhNkU9hTw3+K3
         Sm6weatOipRzmxgWAfm5eq/x9cvj2aG474sTl0mo5zi5Gcet+AA/b4KMktKMVL/m4wDm
         8JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gFFJDf2YnnW41mbrUGLhQnv9x8YWw9okQzyBd4EYFU=;
        b=fh2AdtOHxbgpsFv4i4g/qd2tyKGGJBQprq7b/ZpL5xUQdh8BjSpjsp9UiaE6ooXSKU
         YQ7OHPfGC29d3N6KIKXZShPOSxVtFDtxERSv3Ef/2E1Un3OfiIpDRBd7AW7cPM3MbUoQ
         Q0NEUe5K7wvpRPfyn88mqgg03fmubxH8WZs8HnaVByqbh01grOsJeUtShMbIHPD8Tixr
         1VjsMbi0Gn0ukTI+ZuVE9Y06hauqRQHxa9gpPV69+pFyGKuzYP0dPll+MMuwdC5vVRfO
         1LNEL0mKdICM94+2+Chr4DUkrYlfHtSILwORZeHRKqdutbsTygKc6gLcxqtDnvDRrYA5
         H2aw==
X-Gm-Message-State: APjAAAVKL7hrfcPa9DWO9Dv5ZJAFPr3PhgomAGPGntlEIb4CTSUFLsAc
        6p+O7srw4W4QjzJT8mQGce1GPw==
X-Google-Smtp-Source: APXvYqwIXkMGOo68z7kFcseQc3iUz+MeychrjygBb8vF2llh1M8u7cMuBjgZiH7jH8KbVIemdtrL0w==
X-Received: by 2002:a2e:8986:: with SMTP id c6mr543791lji.146.1552467620690;
        Wed, 13 Mar 2019 02:00:20 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u15sm1701986lja.73.2019.03.13.02.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 02:00:19 -0700 (PDT)
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
Subject: [PATCH 3/4] OPP: Update the bandwidth on OPP frequency changes
Date:   Wed, 13 Mar 2019 11:00:09 +0200
Message-Id: <20190313090010.20534-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313090010.20534-1-georgi.djakov@linaro.org>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
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
 drivers/opp/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4b019cecaa07..99e7c4cf6c34 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -781,6 +781,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	}
 
+	if (!ret && !IS_ERR_OR_NULL(opp_table->path) && opp->bandwidth)
+		icc_set_bw(opp_table->path, opp->bandwidth->avg,
+			   opp->bandwidth->peak);
+
 	/* Scaling down? Configure required OPPs after frequency */
 	if (!ret && freq < old_freq) {
 		ret = _set_required_opps(dev, opp_table, opp);
