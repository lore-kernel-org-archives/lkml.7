Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E702146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nm92Gdpm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YeSyNfwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCTJuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:50:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51064 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfCTJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:50:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 526B4613A3; Wed, 20 Mar 2019 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075406;
        bh=MJQt3iSoG7Hb5v8EXTLAvfULjqQjr1k8J9tx/gTgULw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nm92Gdpm1fHv5U/7r6mKwW8HQ8Xqm2TBGh+EJ6bbk+hze9YafBoPCIUNkYLsSXGDY
         kNU2Sn4NuvHQ+9aZwdoawHyKvie4OqoNRuG8QENYcDAAuuteD7XkQOHLrM3gowEVYd
         6EXAEgd2lKmvdVOo4kkk7TexypYFxDZznnXUWxL8=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F8CA61340;
        Wed, 20 Mar 2019 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075404;
        bh=MJQt3iSoG7Hb5v8EXTLAvfULjqQjr1k8J9tx/gTgULw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YeSyNfwEUlfv7n6eWpm60/VqPdycTGpUtAcitQX+BOnl3+mI8NXU3b4iekkn5q7HQ
         t0Nm2IqT0SAMPv6Iaz/TU4DLK3wTXNz+wNOl0Ta0F/bNhA8UsjmfgW3vzL/C6cZuja
         miH1EAx8MHkcdr1kv5PEwL84/ZB6BBYRUXo2nzrE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F8CA61340
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
Subject: [RFC v2 07/11] scsi: ufs: Add support for specifying OPP tables in DT
Date:   Wed, 20 Mar 2019 15:19:14 +0530
Message-Id: <20190320094918.20234-8-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms like qualcomms sdm845 SoC have a need to set
a performance state of a power domain for UFS along with
setting the clock rate. Add support for passing this freq/perf state
tuple from DT as an OPP table. Modify the driver to read the OPP
table and register with OPP layer.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index ffa9e58680b4..2b260e83874a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -913,6 +913,16 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 	if (ret)
 		return ret;
 
+	if (hba->virt_devs) {
+		struct dev_pm_opp *opp;
+		unsigned long freq = scale_up ? INT_MAX: 0;
+		if (scale_up)
+			opp = dev_pm_opp_find_freq_floor(hba->dev, &freq);
+		else
+			opp = dev_pm_opp_find_freq_ceil(hba->dev, &freq);
+		dev_pm_opp_set_rate(hba->dev, dev_pm_opp_get_freq(opp));
+	}
+
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk)) {
 			if (scale_up && clki->max_freq) {
@@ -1318,6 +1328,7 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 	struct list_head *clk_list = &hba->clk_list_head;
 	struct ufs_clk_info *clki;
 	struct devfreq *devfreq;
+	struct device *virt_dev;
 	int ret;
 
 	/* Skip devfreq if we don't have any clocks in the list */
@@ -1325,8 +1336,14 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 		return 0;
 
 	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	dev_pm_opp_add(hba->dev, clki->min_freq, 0);
-	dev_pm_opp_add(hba->dev, clki->max_freq, 0);
+
+	if (dev_pm_opp_of_add_table(hba->dev)) {
+		dev_pm_opp_add(hba->dev, clki->min_freq, 0);
+		dev_pm_opp_add(hba->dev, clki->max_freq, 0);
+	} else {
+		virt_dev = hba->virt_devs[hba->num_virt_devs -1];
+		dev_pm_opp_set_genpd_virt_dev(hba->dev, virt_dev, 0);
+	}
 
 	devfreq = devfreq_add_device(hba->dev,
 			&ufs_devfreq_profile,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

