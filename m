Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FB9C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D50F2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C2mEaCV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfEPVkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:40:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40200 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfEPVkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:40:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so2518112pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVv4kB5Ecy4Nzot5JSmd+w2kmDQzag6YdAwhTawAS+o=;
        b=C2mEaCV5q7RRlPDkTl+jNc69GKmHQGbUzwdCXb4uJuIQRqjiwjE8vEVrEuUybINuD1
         CaXvTTgS7AqB5rKqV9O2SfHGsVPYh/UdIAMeuPT128yOp4EI0fA8af3ZBM+HxlhYaScP
         IQMWJsOKUNzn9FS7aX/h9q0stQ3lFpm6IpUEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVv4kB5Ecy4Nzot5JSmd+w2kmDQzag6YdAwhTawAS+o=;
        b=GqCI32F0GUBYonbGdijdBoRe6S0HW7enUZZKv+y1diQyaNty0KwRsMkzpwQJPzCe49
         wqyaJYnjCSGp4xI2rkdcwCFIbNtKCtmIBd/PE5n99DomUE8NbNND4+6hIZCES9b150NL
         CT0gjYWyB6LEUb7IlXIKPu1ilsse70pYSvWDFliPJVDjuZDCpxEZNBnKYdynr2Z/4NFd
         29UgkkG2QW4Cetwf9hj6o9quEXKVm80KT3byMnqQaRDdlzR+AxE6VX+cBh8TXJ++c2ln
         ZGoF/sMqzlVRcWL4CcKl/v2ZZVkh6gzKwjQJWHBh/cHM8XHuPH+nxRPSnAD+/RNCat7h
         0Vdw==
X-Gm-Message-State: APjAAAV9Tx0fFmmBraVBDvbumLGtTtu1GdUe3/uOk0of26MY5umRw4zo
        m7cBjyzCmoGR9Jrpmw43SDasww==
X-Google-Smtp-Source: APXvYqyP0E6DNadrM+r5JhT3uOu5deldF8xqqkH34aEOJ4KlNc8FJkCV2ERtDfIFBJk2wFdQq4Is2w==
X-Received: by 2002:a63:d343:: with SMTP id u3mr53012185pgi.285.1558042850353;
        Thu, 16 May 2019 14:40:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v4sm13127252pff.45.2019.05.16.14.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:40:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 2/2] drm/rockchip: dw_hdmi: Handle suspend/resume
Date:   Thu, 16 May 2019 14:40:22 -0700
Message-Id: <20190516214022.65220-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190516214022.65220-1-dianders@chromium.org>
References: <20190516214022.65220-1-dianders@chromium.org>
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

Changes in v2:
- Add forgotten static (Laurent)
- No empty stub for suspend (Laurent)

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 4cdc9f86c2e5..beffe44c248a 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -542,11 +542,23 @@ static int dw_hdmi_rockchip_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused dw_hdmi_rockchip_resume(struct device *dev)
+{
+	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
+
+	return dw_hdmi_resume(hdmi->hdmi);
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
2.21.0.1020.gf2820cf01a-goog

