Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E1A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jr5w5w74";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jr5w5w74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCTJtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:49:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:49:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EDA7A60E7A; Wed, 20 Mar 2019 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075379;
        bh=OJALzsWlECZ4X10Xb4pxyAdKOLu5a0A06V+PzDVAsIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jr5w5w74hexB0gSDO9U3LTDJAjSXPHAMo47jw/l/nKf4QUkkI0dzoluwpt9/gPdsi
         8FGpFx8EEK23esGk4vvYBzgyi1X1teVZX7moXHRvssXyNlsrM+X1wENEENz+w/gTdZ
         gKmt2E0WXGg4DX0qg48xThAEOa6ejQnQ8hBx7I8g=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 691C06072E;
        Wed, 20 Mar 2019 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075379;
        bh=OJALzsWlECZ4X10Xb4pxyAdKOLu5a0A06V+PzDVAsIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jr5w5w74hexB0gSDO9U3LTDJAjSXPHAMo47jw/l/nKf4QUkkI0dzoluwpt9/gPdsi
         8FGpFx8EEK23esGk4vvYBzgyi1X1teVZX7moXHRvssXyNlsrM+X1wENEENz+w/gTdZ
         gKmt2E0WXGg4DX0qg48xThAEOa6ejQnQ8hBx7I8g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 691C06072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, dianders@chromium.org, rafael@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
Date:   Wed, 20 Mar 2019 15:19:08 +0530
Message-Id: <20190320094918.20234-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

Doing this allows us to call this API with any rate requested and have
it not need to match in the OPP table. Instead, we'll round the rate up
to the nearest OPP that we see so that we can get the voltage or level
that's required for that OPP. This supports users of OPP that want to
specify the 'fmax' tables of a device instead of every single frequency
that they need. And for devices that required the exact frequency, we
can rely on the clk framework to round the rate to the nearest supported
frequency instead of the OPP framework to do so.

Note that this may affect drivers that don't want the clk framework to
do rounding, but instead want the OPP table to do the rounding for them.
Do we have that case? Should we add some flag to the OPP table to
indicate this and then not have that flag set when there isn't an OPP
table for the device and also introduce a property like 'opp-use-clk' to
tell the table that it should use the clk APIs to round rates instead of
OPP?

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/opp/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0420f7e8ad5b..bc9a7762dd4c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -703,7 +703,7 @@ static int _set_required_opps(struct device *dev,
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	struct opp_table *opp_table;
-	unsigned long freq, old_freq;
+	unsigned long freq, opp_freq, old_freq, old_opp_freq;
 	struct dev_pm_opp *old_opp, *opp;
 	struct clk *clk;
 	int ret;
@@ -742,13 +742,15 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		goto put_opp_table;
 	}
 
-	old_opp = _find_freq_ceil(opp_table, &old_freq);
+	old_opp_freq = old_freq;
+	old_opp = _find_freq_ceil(opp_table, &old_opp_freq);
 	if (IS_ERR(old_opp)) {
 		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
 			__func__, old_freq, PTR_ERR(old_opp));
 	}
 
-	opp = _find_freq_ceil(opp_table, &freq);
+	opp_freq = freq;
+	opp = _find_freq_ceil(opp_table, &opp_freq);
 	if (IS_ERR(opp)) {
 		ret = PTR_ERR(opp);
 		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

