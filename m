Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8264C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A23214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AHEBEuNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfH0Q3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:29:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45195 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfH0Q3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:29:43 -0400
Received: by mail-io1-f67.google.com with SMTP id t3so47623948ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPfWvcwVfrcY1k8aoUFruMr5YkWe0H+HYKEdtrmh3H8=;
        b=AHEBEuNVjcdNoAW+vvqZ+N3wKuz8LBL2T8s9b7O3ZaBiGh+If49H7yqyqmdkoI/d1+
         3PnFydaJwChLjqnLhjHZqw7gl7m96W6hkpZo2NVMV6HsMTlndtoutmWv5x1Fndh0Hle5
         PL72nVjCIiOB544xh8zFFqp5gKS2S8wtjQUMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPfWvcwVfrcY1k8aoUFruMr5YkWe0H+HYKEdtrmh3H8=;
        b=uBHD82sioq0lHxgv3tyGxwHe1/2YkseqA1lHUgb5lURAmdpfBXv5qpAP5v/4giAr3f
         IvxOElwKQxw5rg00gztiL4yPWOZ10c30yStIFV7JSvmrfjIjQ9EP2mnrUXgiAnEq0EDo
         PJTwsDRh4eguh78N0LOh7PoMzRsjYb7gNA266MifHJG78w6awaPEutEUpV31zhYtOAUM
         4FBDkD1X5wyXltyQttblFrs/RczBxXd7GinpzuUJ7qhJHyMcb15qpaKpA9bO8lakkjTr
         RBiK1+PWP/CzobDQJfoOGZyfYfpXOaxx3GwC6w/443688JbjdraoZMoYPOq2wUN1nTjs
         emaA==
X-Gm-Message-State: APjAAAXxg70yYuWUrGgWpTzSvhP55+N5k32cc/cpF/ipkF+CPtwCZTRw
        4k/9yR2A+RE8mO9fsx60SnMicw==
X-Google-Smtp-Source: APXvYqzdUQDLGPHiqiCzDf92LqsaVidtW1JcW3tvkc0lgAyUdMAr3tJqk4Caezea7fdrzV93W+PxFA==
X-Received: by 2002:a6b:b756:: with SMTP id h83mr32567090iof.147.1566923382513;
        Tue, 27 Aug 2019 09:29:42 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id h9sm14723177ior.9.2019.08.27.09.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 09:29:41 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     amd-gfx@lists.freedesktop.org
Cc:     Raul E Rangel <rrangel@chromium.org>, Leo Li <sunpeng.li@amd.com>,
        David Airlie <airlied@linux.ie>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        hersen wu <hersenxs.wu@amd.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Nikola Cornij <nikola.cornij@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amd/display: fix struct init in update_bounding_box
Date:   Tue, 27 Aug 2019 10:29:24 -0600
Message-Id: <20190827162924.88524-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dcn20_resource.c:2636:9: error: missing braces around initializer [-Werror=missing-braces]
  struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
         ^

Fixes: 7ed4e6352c16f ("drm/amd/display: Add DCN2 HW Sequencer and Resource")

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b949e202d6cb..d8dd99bfa275 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2633,7 +2633,7 @@ static void cap_soc_clocks(
 static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
 		struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
 {
-	struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
+	struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {};
 	int i;
 	int num_calculated_states = 0;
 	int min_dcfclk = 0;
-- 
2.23.0.187.g17f5b7556c-goog

