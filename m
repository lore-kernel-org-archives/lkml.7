Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F38EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263CB2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2VUKGeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfDOOz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:55:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32974 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfDOOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so15990390ljc.0;
        Mon, 15 Apr 2019 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0m53QvjknqRp3ie0vm6CpfbAyiM0FVU3b4et23ofcuA=;
        b=F2VUKGeQdqeNwP0nOteb8rfuOpQaIP/fnuUKyn2O6Et18CEeZZbN9q3hj9obLt7Ip7
         sjTdcdMe0UNSZ/xP3SSbOG/Fr3Mb6X8VRaiVwA9ANypifyHL3reKiZmUwEtlE55sshhe
         uDvfyoxBm7Q1Ye991Zdu5HeyIphGUUw5xPx9B0nDTqQWpSsKl2KEQcz4pYHlMvy4yEDZ
         MCo8FHdDFpCK/Uomh7Ry+e+0ggO2tB0kVrOARVQVET1ZL6kDp76atbAdBpD9YbKddfF8
         02CV8kmhny1lUXNrqv3kXSLB8iCKXZIiWM2eDvI4NDccXvP6QlvQNRW6pDOSNlEj2I7x
         bZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0m53QvjknqRp3ie0vm6CpfbAyiM0FVU3b4et23ofcuA=;
        b=ER5xjhVBpn4sHS+r1qB5Yb+h7AR0CF6Ep7ULFR59rHyvNf2gHhGPwZ2yWfsUefsI9C
         FrcMQlrVQPyqKRcMay75VKleJn8Feupu1fUo4u3WmNx1thp1R8Lt9QPbK5vdjhLzO1kI
         mJLMx5/7xI8WAS7efTH9Jv2qyr4d/HYm2S8OARuVi1abMN38CJaFg5BHyK/xKes1q6I3
         LuHhMvEYIpiA5tsXIefxa6jxjWasuJoIAXhuC/0XSV8vHBjmDd1m0YhcngAn2yiedwWc
         ATEXDMBGTHu9m4/RsXSU2VAhzxChluBTohUprNb2C0Bpb/vcQmRts8yGy1xnOXUDsraT
         Cwtg==
X-Gm-Message-State: APjAAAVpBB9Vhx6yRnMyGuYpXRi/5qRJ8HneWv4JpWWiA1mKYp7YAiJ/
        xPTnag4pReVUJqksc4Ad7uI=
X-Google-Smtp-Source: APXvYqzpTGE5/TikmNNDpIoscTEm2A9ggE6XFk7D7Ol09PySJOwV+H2gq5rqP1/BbtgyOUZ3DcXWdg==
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr18247204ljc.126.1555340148490;
        Mon, 15 Apr 2019 07:55:48 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 12/19] PM / devfreq: tegra: Avoid inconsistency of current frequency value
Date:   Mon, 15 Apr 2019 17:54:58 +0300
Message-Id: <20190415145505.18397-13-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frequency value potentially could change in-between. It doesn't
cause any real problem at all right now, but that could change in the
future. Hence let's avoid the inconsistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index a668e4fbc874..f1a6f951813a 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -496,13 +496,15 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct tegra_devfreq_device *actmon_dev;
+	unsigned long cur_freq;
 
-	stat->current_frequency = tegra->cur_freq * KHZ;
+	cur_freq = READ_ONCE(tegra->cur_freq);
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
 
 	/* The below are to be used by the other governors */
+	stat->current_frequency = cur_freq * KHZ;
 
 	actmon_dev = &tegra->devices[MCALL];
 
@@ -513,7 +515,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
 
 	/* Number of cycles in a sampling period */
-	stat->total_time = ACTMON_SAMPLING_PERIOD * tegra->cur_freq;
+	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
 
 	stat->busy_time = min(stat->busy_time, stat->total_time);
 
-- 
2.21.0

