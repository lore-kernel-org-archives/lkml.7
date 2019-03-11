Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1056CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19D720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gDWb1CiP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="das9v3vY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfCKKH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:07:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfCKKH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:07:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 801FB61A8B; Mon, 11 Mar 2019 10:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552298875;
        bh=ZXuDXx5vm5dKU06DRLzLdanZL3vAsQ2wV2uqPqiv4ow=;
        h=From:To:Cc:Subject:Date:From;
        b=gDWb1CiPJjZ3MbY2kaK4KLWM8Gdl9k+agkbh4yqbpAw3geb8mpEw5MwDnFDAe+BGo
         kQV8FMUTkAz8rsswk2SIXuGSAIEaz8PNA/3uARl6Ea3/gUc/40kDv1SexoIzhVyqWq
         mHdhisZpiELNnarVR8EN160P8Q0IpKIpA+yFcz8k=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDE5C61A8B;
        Mon, 11 Mar 2019 10:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552298874;
        bh=ZXuDXx5vm5dKU06DRLzLdanZL3vAsQ2wV2uqPqiv4ow=;
        h=From:To:Cc:Subject:Date:From;
        b=das9v3vYsfFz57R7HAFAE+S/RNT8TufPphjVliBMfpkZcCzjXstskkMm7L9wllu1c
         zKZjDPd+mj3+slUkoqL0goLmXIvgq0lzpmYBdN9A+z8GafptakKLyAcqhuKW8AyLV4
         oWmuzHn76pDT4MXSwF1x5bNS8V4pybTJd2G3w1ms=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDE5C61A8B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc:     cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5] PM / devfreq: Restart previous governor if new governor fails to start
Date:   Mon, 11 Mar 2019 15:36:30 +0530
Message-Id: <20190311100630.12952-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

If the new governor fails to start, switch back to old governor so that the
devfreq state is not left in some weird limbo.

[Mjungjoo: assume fatal on revert failure and set df->governor to NULL]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
V5:
* assume fatal on revert failure and set df->governor to NULL

V4:
* Removed prev_governor check.

V3:
* Fix NULL deref for real this time.
* Addressed some style preferences.

V2:
* Fixed typo in commit text
* Fixed potential NULL deref

 drivers/devfreq/devfreq.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 428a1de81008..37490235ec34 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1124,7 +1124,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	int ret;
 	char str_governor[DEVFREQ_NAME_LEN + 1];
-	struct devfreq_governor *governor;
+	const struct devfreq_governor *governor, *prev_governor;
 
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
@@ -1153,12 +1153,24 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 			goto out;
 		}
 	}
+	prev_governor = df->governor;
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
-	if (ret)
+	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, df->governor->name, ret);
+		df->governor = prev_governor;
+		strncpy(df->governor_name, prev_governor->name,
+			DEVFREQ_NAME_LEN);
+		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+		if (ret) {
+			dev_warn(dev,
+				 "%s: reverting to Governor %s failed (%d)\n",
+				 __func__, df->governor_name, ret);
+			df->governor = NULL;
+		}
+	}
 out:
 	mutex_unlock(&devfreq_list_lock);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

