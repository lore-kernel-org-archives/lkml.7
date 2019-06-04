Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E200C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0A207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TVOLIvqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFDUmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:42:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47082 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFDUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:42:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so13371262pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NL5DPTKKMNZWvD7Hnx1KIRpy/8nRGAMXIh44aNGHSaY=;
        b=TVOLIvqXNvIKZDyIwK8wpLxqIpKlUqfTCiUrsEkG21UZPFVpKJ6u/ERmqbwBnZ100J
         MXZP+S/ZMqjo48TC2q466d1DX8mhAZ31orqtTrnRjWiiiEZT++FMmvnf+4CFvTY0hdRh
         jRJliijhyE9rK1ULJ56hNMxT1YaXl3L8Q43wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NL5DPTKKMNZWvD7Hnx1KIRpy/8nRGAMXIh44aNGHSaY=;
        b=rraWdk24X7UNNNlR3WRYzHJ5xLnTz9GAoY80Nrg1OWpgdw13OIF+cUORoODGupyu34
         8PEUN0f7m8jNKU8v9P+yV9LnOUTR3TqFOaXl1mG8Cvuh6w6ZOEpaW9CQdudbzjo9uuF9
         c1eMnpCmAS4djFQv1qC3Y60iaGKJeLOnmNCIbsPj8N0WNkLdj3yYq/gRkwHTqwVsbiiE
         DxEbtIGvCUczKcHI84zW6IlMlooRaMusytAV6Pyu5RZ64YS3C2pZgcdGRADIW6+bpA0s
         D01XPk0hTAqIFiU4187RUbPAqwykatglJLKgMKLrPTw8k6/ag+ZrqWSLSgkDyD1gZWXF
         4gdA==
X-Gm-Message-State: APjAAAWJ5VJjSDuSb5Chzuw4DR0n9F/S+0KEv+sn3NNz8a/+FdDh6+Ye
        +M1YL0AedPfofaQ/UvYy0ugLdw==
X-Google-Smtp-Source: APXvYqy6yGca0NfMnlay8Iio+11gDCTu9XCNqkdRwwop7IybVxYxXjJ3nlJNPRuR6O5jg/ll53xR3w==
X-Received: by 2002:a63:2bd1:: with SMTP id r200mr633202pgr.202.1559680952939;
        Tue, 04 Jun 2019 13:42:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m5sm11553616pgn.59.2019.06.04.13.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 13:42:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 2/2] drm/rockchip: dw_hdmi: Handle suspend/resume
Date:   Tue,  4 Jun 2019 13:42:07 -0700
Message-Id: <20190604204207.168085-2-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190604204207.168085-1-dianders@chromium.org>
References: <20190604204207.168085-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Rockchip rk3288-based Chromebooks when you do a suspend/resume
cycle:

1. You lose the ability to detect an HDMI device being plugged in.

2. If you're using the i2c bus built in to dw_hdmi then it stops
working.

Let's call the core dw-hdmi's suspend/resume functions to restore
things.

NOTE: in downstream Chrome OS (based on kernel 3.14) we used the
"late/early" versions of suspend/resume because we found that the VOP
was sometimes resuming before dw_hdmi and then calling into us before
we were fully resumed.  For now I have gone back to the normal
suspend/resume because I can't reproduce the problems.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- dw_hdmi_resume() is now a void function (Laurent)

Changes in v2:
- Add forgotten static (Laurent)
- No empty stub for suspend (Laurent)

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 4cdc9f86c2e5..7bb0f922b303 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -542,11 +542,25 @@ static int dw_hdmi_rockchip_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused dw_hdmi_rockchip_resume(struct device *dev)
+{
+	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
+
+	dw_hdmi_resume(hdmi->hdmi);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dw_hdmi_rockchip_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, dw_hdmi_rockchip_resume)
+};
+
 struct platform_driver dw_hdmi_rockchip_pltfm_driver = {
 	.probe  = dw_hdmi_rockchip_probe,
 	.remove = dw_hdmi_rockchip_remove,
 	.driver = {
 		.name = "dwhdmi-rockchip",
+		.pm = &dw_hdmi_rockchip_pm,
 		.of_match_table = dw_hdmi_rockchip_dt_ids,
 	},
 };
-- 
2.22.0.rc1.311.g5d7573a151-goog

