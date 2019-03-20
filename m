Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AB6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AC12184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XYdQaKD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfCTHSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:18:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41461 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfCTHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:18:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so1244580pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mtcq9S/v2Tl+uFG8ivjTYFKQCKpz3W6EmGjpkEFJ4cs=;
        b=XYdQaKD62Uc3PQvaYbXUSYqA2iBDHwnMF01B+WOLaYLLPBHWiQJg4xzKyrbgIGFBe2
         i47kGXU41UWimuGRsqohqhOxUkxxvS8fogJIlYFrQJcRDFe4NMrtglvEp741k2g971pM
         qAOMXPFerplhpCOtQ8pFwOcjrXNXTDhrMGj+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mtcq9S/v2Tl+uFG8ivjTYFKQCKpz3W6EmGjpkEFJ4cs=;
        b=REOfpHgUqZwHyHxEq6L92a5aCNs5CKeQpuaMkE211wO/lGzYB0SPv07LFxGt2apHkY
         2Xwk835gMVBza4pvjCuZpNHylSAtoUzJs6l3Q3zkmgBvI+6vqaoCrAQ0MvahQ5PDljqc
         Adc37bs703Hm7cjbEgfZ55h7tab71MFe3BhVehWIa+0HLZjNOCbYFNyk4ffdgrGh8P0k
         iMJwh7Jkb/ooYBc+xN4PjPcu7j6lIMpdvFcsw+bMgoukw0CwDDB2h+y2pl1rRjCPw2AF
         UQ1niavvd1lzLhOdzWOjRPSH1RgCGqvPI9N1WUFxJ/w+Pum3Ac8woXh26Uer5wdXsw5I
         ZExw==
X-Gm-Message-State: APjAAAUhdK1PLLuzkpTSk7YaFdhzW6T0TwKnTk0Ag4zbr7BiwKNLt8eG
        IwFHceRqRjc5G/NhrUlssm5aYg==
X-Google-Smtp-Source: APXvYqws1Wq1zw3UK9tB1eJ1pU0nnhICoChdQWRZmcqeRsBI33N++GPHTDNKRmme1nTLPHv5LaPGkw==
X-Received: by 2002:a63:c204:: with SMTP id b4mr5897712pgd.335.1553066310716;
        Wed, 20 Mar 2019 00:18:30 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id l184sm1579803pfc.41.2019.03.20.00.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 00:18:30 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu/drm: mediatek: call mtk_dsi_stop() after mtk_drm_crtc_atomic_disable()
Date:   Wed, 20 Mar 2019 15:18:25 +0800
Message-Id: <20190320071825.20268-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disable(), which needs
ovl irq for drm_crtc_wait_one_vblank(), since after mtk_dsi_stop() is called,
ovl irq will be disabled. If drm_crtc_wait_one_vblank() is called after last
irq, it will timeout with this message: "vblank wait timed out on crtc 0". This
happens sometimes when turning off the screen.

In drm_atomic_helper.c#disable_outputs(),
the calling sequence when turning off the screen is:

1. mtk_dsi_encoder_disable()
     --> mtk_output_dsi_disable()
       --> mtk_dsi_stop();  // sometimes make vblank timeout in atomic_disable
       --> mtk_dsi_poweroff();
2. mtk_drm_crtc_atomic_disable()
     --> drm_crtc_wait_one_vblank();
     ...
       --> mtk_dsi_ddp_stop()
         --> mtk_dsi_poweroff();

mtk_dsi_poweroff() has reference count design, change to make mtk_dsi_stop()
called in mtk_dsi_poweroff() when refcount is 0.

Fixes: 0707632b5bac ("drm/mediatek: update DSI sub driver flow for sending commands to panel")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
change log:
v1->v2:
 * update commit message.
 * call mtk_dsi_stop() in mtk_dsi_poweroff() when refcount is 0.
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b00eb2d2e086..e152f37af57d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -630,6 +630,8 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 	if (--dsi->refcount != 0)
 		return;
 
+	mtk_dsi_stop(dsi);
+
 	if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
 		if (dsi->panel) {
 			if (drm_panel_unprepare(dsi->panel)) {
@@ -696,7 +698,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
 		}
 	}
 
-	mtk_dsi_stop(dsi);
 	mtk_dsi_poweroff(dsi);
 
 	dsi->enabled = false;
@@ -1178,6 +1179,8 @@ static int mtk_dsi_remove(struct platform_device *pdev)
 	struct mtk_dsi *dsi = platform_get_drvdata(pdev);
 
 	mtk_output_dsi_disable(dsi);
+	mtk_dsi_stop(dsi);
+	mtk_dsi_poweroff(dsi);
 	component_del(&pdev->dev, &mtk_dsi_component_ops);
 
 	return 0;
-- 
2.20.1

