Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FF2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F99F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mOB8HFsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfH0J6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:58:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42309 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfH0J6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:58:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so18121359wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbdxbxYZcKVLdPE0Y/8WQgSXBgDUmbVqM2Rjtf0OVOI=;
        b=mOB8HFsHRuuCRYt9Kp+g2Vrx/KvyTnWXGglzhl804o2JfqJ/QDMeTgZoO+Ued+xtAJ
         TsIhTzlWDYZdbIWQcdYRQomzPGGDcnNvhXxY5ncQKWOpnCKWoaRWuZ8Vg/I7othlgGnc
         8UMoMLp1R1rWbJ9ya7spTIgvhPMIs0kwWyOxJYppM3Hc2stPXW/gJiRVeOGl9ICcfVOr
         JnOpENKyJyp37NeDesmyZP6FSvgqpY+YBz/ld3SmFp0pMHPad2BWgChIlhkMP3+ugTgm
         VyxwniLooNR/upSBilO/t4y9/bdbW2v+nwtyLjrOKOBljWrmUnAuJRfc+sCrxF07LpAq
         VulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbdxbxYZcKVLdPE0Y/8WQgSXBgDUmbVqM2Rjtf0OVOI=;
        b=eZ3Fe1Fg5ij4XnwG1azXBUEZ1ACgG/AvEYHT1ZAmhJif1amn84gBins35DgVNE/w46
         hrM1BITv4qqqNRrTViOJKSJzowQQU5Sp6/FDOm2sG2rQ+8q2Gr5GQuX5Cn1LB5Ylwk+q
         lW7GErgGt/dzil7MTEsdkTPVlFDOngTZDcj1g91edVX8C7P5gZSrUMFH1wHulYZxJ06j
         zE4z9SsQfinzyIoQaLS2SL2Nr4dhv5fYfoNS+c5L+IZPjRYno7lF72HPlQ4cG+vIvxiW
         3yXj/tjmeKM5/EmknI45kgcYMf2SHV8E3pVImbZQ0zfeTBxEeYMPWOdFqSzoqskFvVxO
         p44Q==
X-Gm-Message-State: APjAAAWKOtSytL7iyXAAn/Yhmu0wmtZ0VYM6Hs4oMgS3wApajLXkaSKt
        mI2eEYB+SgFcYjjhLMTxnMMe5w==
X-Google-Smtp-Source: APXvYqzlJBCTaG+pE4o2jLBqQI6zVkgZsqDDyXOyYdI2n3XJFdcBqkqNW7xzsAxTdeooMlTarCQ78Q==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr2484026wrt.34.1566899910193;
        Tue, 27 Aug 2019 02:58:30 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m6sm10862084wrq.95.2019.08.27.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:58:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] drm/meson: add resume/suspend hooks
Date:   Tue, 27 Aug 2019 11:58:25 +0200
Message-Id: <20190827095825.21015-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827095825.21015-1-narmstrong@baylibre.com>
References: <20190827095825.21015-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the suspend and resume hooks to:
- save and disable the entire DRM driver on suspend
- re-init the entire VPU subsystem on resume, to recover CRTC and pixel
generator functionnal usage after DDR suspend, then recover DRM driver
state

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 2310c96fff46..dc573ffd1f4c 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -361,6 +361,33 @@ static const struct component_master_ops meson_drv_master_ops = {
 	.unbind	= meson_drv_unbind,
 };
 
+static int __maybe_unused meson_drv_pm_suspend(struct device *dev)
+{
+	struct meson_drm *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return 0;
+
+	return drm_mode_config_helper_suspend(priv->drm);
+}
+
+static int __maybe_unused meson_drv_pm_resume(struct device *dev)
+{
+	struct meson_drm *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return 0;
+
+	meson_vpu_init(priv);
+	meson_venc_init(priv);
+	meson_vpp_init(priv);
+	meson_viu_init(priv);
+
+	drm_mode_config_helper_resume(priv->drm);
+
+	return 0;
+}
+
 static int compare_of(struct device *dev, void *data)
 {
 	DRM_DEBUG_DRIVER("Comparing of node %pOF with %pOF\n",
@@ -452,11 +479,16 @@ static const struct of_device_id dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dt_match);
 
+static const struct dev_pm_ops meson_drv_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(meson_drv_pm_suspend, meson_drv_pm_resume)
+};
+
 static struct platform_driver meson_drm_platform_driver = {
 	.probe      = meson_drv_probe,
 	.driver     = {
 		.name	= "meson-drm",
 		.of_match_table = dt_match,
+		.pm = &meson_drv_pm_ops,
 	},
 };
 
-- 
2.22.0

