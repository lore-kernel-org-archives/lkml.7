Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E369C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC6C20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SzQP3Mkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgAGXGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:06:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgAGXGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:06:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so1435765wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 15:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXJ/0vyPOcylwX7dQ7AqYqzbWcm6Xny6nu2+z0FOmf4=;
        b=SzQP3MkkW9JiVVLB0Q5AWl9ynYczk1eWo56lKzhjHMYAgL4dqVwYVe+d4zLq7IGG+E
         6sjyRLDJcEljD4GDsoPqvuOXsfPBIXaZlV/7JQOkyCuXehAwjJhNybHUYy5Z5vlzNnDZ
         ojm8VASMXfBBnvdvuzRV37VlFgzD5KE4fzvicM94upMV58FI4Iz7SwtNdHRMPFmsse7V
         TAIL1Kz1SjxRxXsrpRd8sbRc/pyYzPY08UVCol5DeDNVgOzhjeB1iuSUkO+ZbVO0xDl8
         rT/WVhULD1GLl7l7FXJord3q/+308mnMIkdoHgox2+tnRgVZhARDTbdy+O32aBsGmQQM
         Mkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXJ/0vyPOcylwX7dQ7AqYqzbWcm6Xny6nu2+z0FOmf4=;
        b=Kv4jdtyPYyaZWW9YMGgYvQ7T5nmlKPOpIvnyUo4uZ6Qd1GOti1dztulM+Y2yerVIxa
         ZFOH02yL2Xv0BLr7M5nTYYwUZ03IEKC6bIiFZoCPYlk27XxaiO3LxlK7p4iyXAbgUdE3
         aSExQSuFIvZ8U3xCO9fI0mHKWGOT4kX7f4v5pnSqWoeNTtB2jngm9IrYm9Gxn3+eV6nN
         5+agq/2lILJ7NdOfLDG1F7xj9ryUlPLZwP2IeAn/qz+M9mqmspgh2Eylnp0buAh+j4OT
         KoYPMD0Hbe45MbBhre9XANyNASvtxqQNWCOFVEptUtelKupFr+VE41Isl0OcBQBb0mm/
         s+lQ==
X-Gm-Message-State: APjAAAWAprYox+1wLFYbRw/CuU476SyCNqQbOP3kRFtci1oKr9NM6XJB
        H41QHFwnQiYvrHWOe814leHKJZKHEbg=
X-Google-Smtp-Source: APXvYqyTpkD+YLeAxyWAoG8+IkEVG2zuH4q7SHZOXRueqxuzGo3+htimrqNb87QNSjKXFAZDdhKYXw==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr1253219wrq.137.1578438411229;
        Tue, 07 Jan 2020 15:06:51 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id g21sm1335912wmh.17.2020.01.07.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:06:50 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        robin.murphy@arm.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFT v1 3/3] drm/panfrost: Use the mali-supply regulator for control again
Date:   Wed,  8 Jan 2020 00:06:26 +0100
Message-Id: <20200107230626.885451-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
References: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_set_rate() needs a reference to the regulator which should be
updated when updating the GPU frequency. The name of the regulator has
to be passed at initialization-time using dev_pm_opp_set_regulators().
Add the call to dev_pm_opp_set_regulators() so dev_pm_opp_set_rate()
will update the GPU regulator when updating the frequency (just like
we did this manually before when we open-coded dev_pm_opp_set_rate()).

Fixes: 221bc77914cbcc ("drm/panfrost: Use generic code for devfreq")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 22 ++++++++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 170f6c8c9651..4f7999c7b44c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -74,6 +74,7 @@ static struct devfreq_dev_profile panfrost_devfreq_profile = {
 int panfrost_devfreq_init(struct panfrost_device *pfdev)
 {
 	int ret;
+	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
 	unsigned long cur_freq;
 	struct device *dev = &pfdev->pdev->dev;
@@ -84,9 +85,24 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		/* Optional, continue without devfreq */
 		return 0;
 
+	opp_table = dev_pm_opp_set_regulators(dev,
+					      (const char *[]){ "mali" },
+					      1);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+
+		/* Continue if the optional regulator is missing */
+		if (ret != -ENODEV)
+			return ret;
+	} else {
+		pfdev->devfreq.regulators_opp_table = opp_table;
+	}
+
 	ret = dev_pm_opp_of_add_table(dev);
-	if (ret)
+	if (ret) {
+		dev_pm_opp_put_regulators(pfdev->devfreq.regulators_opp_table);
 		return ret;
+	}
 
 	panfrost_devfreq_reset(pfdev);
 
@@ -95,6 +111,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
 	if (IS_ERR(opp)) {
 		dev_pm_opp_of_remove_table(dev);
+		dev_pm_opp_put_regulators(pfdev->devfreq.regulators_opp_table);
 		return PTR_ERR(opp);
 	}
 
@@ -106,6 +123,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	if (IS_ERR(devfreq)) {
 		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
 		dev_pm_opp_of_remove_table(dev);
+		dev_pm_opp_put_regulators(pfdev->devfreq.regulators_opp_table);
 		return PTR_ERR(devfreq);
 	}
 	pfdev->devfreq.devfreq = devfreq;
@@ -124,6 +142,8 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 	if (pfdev->devfreq.cooling)
 		devfreq_cooling_unregister(pfdev->devfreq.cooling);
 	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+	if (pfdev->devfreq.regulators_opp_table)
+		dev_pm_opp_put_regulators(pfdev->devfreq.regulators_opp_table);
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 06713811b92c..4878b239e301 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -85,6 +85,7 @@ struct panfrost_device {
 
 	struct {
 		struct devfreq *devfreq;
+		struct opp_table *regulators_opp_table;
 		struct thermal_cooling_device *cooling;
 		ktime_t busy_time;
 		ktime_t idle_time;
-- 
2.24.1

