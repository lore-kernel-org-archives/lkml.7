Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC8BC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BE920720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S3tVQZXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgAHFYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:24:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36713 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgAHFYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:24:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so982569pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 21:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLPzDvqsyKjpMgl6ZY+ZEjymtgHHsFzBQXHTW4eiM1M=;
        b=S3tVQZXgAvZAvGKT4jucRDlF/M0TWOh+3V7E9ZFoKg0xoIXSRxIr5TYGLCUnvTfS9N
         f+oKg6lg9u0QxJzV+FId6ptqevsKmNbYDMNZJ9DJAVLRY/8KFELoCSNhdge1SKfgY0Xy
         AuK7NrZkfWLHM89vkHp0eJTBqDJW+EynagsuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLPzDvqsyKjpMgl6ZY+ZEjymtgHHsFzBQXHTW4eiM1M=;
        b=cKz8nGtWliLnXi6tqarM+D2p9B3s/i9mRqMYlw7zAOCWkqg6XHYWBJRGEVLczfbo7N
         QZkJuCUepNrRtl8ov/Rzg8B89q+KscV9FuCYjiWeLgUleW19V3P3MG5tke/RHVS4vzes
         YReoYhJXtTB5Wf3101IhHPAC/Iv5x80JJb/Xki/fybDMAHMEcC7qdfNDfprKMlM6Ohks
         KxOQHw9sH/Tyif7JryniYE4EOF6+1zbHcgSGvWNNentRVtgvPJ30lI1Sf2JW8BoRcfYL
         HATPN4AVKW0w6jyWu5CPmrDj/8Q1ge/FWnZ8jnUSkvbqzssqfw4tL4JyVgjSSG18vD1x
         jDAQ==
X-Gm-Message-State: APjAAAVCeELjOHXqqRvBXmsMXH5g86vBGQRhEUD3s/D8IJ9FwgCaxGAu
        nFR/0ieQE6Ki9AlzlXVeg8ZpYg==
X-Google-Smtp-Source: APXvYqzoefkOYFH4FXTTMbYJDxtsQiuVsYfMMaYxsSll0XpoVzmSh/ccdl9HE7eeGAdfYbzMduo/6Q==
X-Received: by 2002:a63:ed56:: with SMTP id m22mr3334545pgk.261.1578461055680;
        Tue, 07 Jan 2020 21:24:15 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id n24sm387505pff.12.2020.01.07.21.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 21:24:15 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v2 7/7, RFC]: drm/panfrost: devfreq: Add support for 2 regulators
Date:   Wed,  8 Jan 2020 13:23:37 +0800
Message-Id: <20200108052337.65916-8-drinkcat@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200108052337.65916-1-drinkcat@chromium.org>
References: <20200108052337.65916-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Bifrost GPU on MT8183 uses 2 regulators (core and SRAM) for
devfreq, and provides OPP table with 2 sets of voltages.

TODO: This is incomplete as we'll need add support for setting
a pair of voltages as well.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 18 ++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h  |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbfccb..5eb0effded7eb09 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -79,6 +79,22 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
 
+	/* If we have 2 regulator, we need an OPP table with 2 voltages. */
+	if (pfdev->regulator_sram) {
+		const char * const reg_names[] = { "mali", "sram" };
+
+		pfdev->devfreq.dev_opp_table =
+			dev_pm_opp_set_regulators(dev,
+					reg_names, ARRAY_SIZE(reg_names));
+		if (IS_ERR(pfdev->devfreq.dev_opp_table)) {
+			ret = PTR_ERR(pfdev->devfreq.dev_opp_table);
+			pfdev->devfreq.dev_opp_table = NULL;
+			dev_err(dev,
+				"Failed to init devfreq opp table: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret == -ENODEV) /* Optional, continue without devfreq */
 		return 0;
@@ -119,6 +135,8 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 	if (pfdev->devfreq.cooling)
 		devfreq_cooling_unregister(pfdev->devfreq.cooling);
 	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+	if (pfdev->devfreq.dev_opp_table)
+		dev_pm_opp_put_regulators(pfdev->devfreq.dev_opp_table);
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 92d471676fc7823..581da3fe5df8b17 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -91,10 +91,12 @@ struct panfrost_device {
 	struct {
 		struct devfreq *devfreq;
 		struct thermal_cooling_device *cooling;
+		struct opp_table *dev_opp_table;
 		ktime_t busy_time;
 		ktime_t idle_time;
 		ktime_t time_last_update;
 		atomic_t busy_count;
+		struct panfrost_devfreq_slot slot[NUM_JOB_SLOTS];
 	} devfreq;
 };
 
-- 
2.24.1.735.g03f4e72817-goog

