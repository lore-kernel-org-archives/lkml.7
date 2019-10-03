Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B0FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0315222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TUR8ASlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfJCUZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:25:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46371 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJCUZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:25:01 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so8507183ioo.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3XwYxtYv4u2VULB5wvau7aH9hnk7qDjisfwQ8sIR5E=;
        b=TUR8ASlw5kv/DytT8vmytYwx7NgMRTSkXxwMls+ZHrUgtvJKK0/pQxhmPQ0it+ePNl
         wq2EyWN6itrpDWeG2mPioyEPKViwPoAPYfktvbEkKdpH3bU8mhYNwSqopyPxycNhDb34
         YBxiCVINfBpqPJKmV5tvLDAOtGzX3NPGH5s14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3XwYxtYv4u2VULB5wvau7aH9hnk7qDjisfwQ8sIR5E=;
        b=Ex99EwLiEgC0J2HttGl5NFDTsaYETIqx5co82JDeK9EzrWLZriQ6sVWlpzvl6fiXk4
         iTldvJ5GVAE/x6eJLo8yyBFcjzl4dngP0UlOdFCdPeSaDXyHTXNUYr64uCQRGJEKk9CK
         Gm1Q7/KEdkVb8hnlL3FwcJNN+hBINKF/AY4ePCOBqriglujNg0jxztBWqrKErUzyBRYf
         CUWivEZBqmiwzFRt1i0nnGUuCNZsXoWcWBqbqHud/vJ5L5V7F0CffZZr2laHsFJpU8ju
         YneUGncXLagBmh3gO3Ls2uZuGxe9yBqixXUuyDvLU20oSCRDQP1ds9eZu0qsZbGf2Vgz
         dCPQ==
X-Gm-Message-State: APjAAAUsP+fwJ1nTByBcEEEdc7RDBltpgYSA7Xn0F1GPywEx+qyZfIVC
        13obJBq6sQSVDvx6qjhIHlPXzX91/JI=
X-Google-Smtp-Source: APXvYqy1RUsllzXjE6tWBFhX9aZH9FfJHLIuYdqCi4+7xWP+iF2L6HHoUUbG/VbVrQ+S2JS9O2IYPg==
X-Received: by 2002:a02:7009:: with SMTP id f9mr11116753jac.81.1570134300572;
        Thu, 03 Oct 2019 13:25:00 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id u124sm1407859ioe.63.2019.10.03.13.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:24:59 -0700 (PDT)
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
Subject: [PATCH v3] drm/amd/display: fix struct init in update_bounding_box
Date:   Thu,  3 Oct 2019 14:24:44 -0600
Message-Id: <20191003142423.v3.1.I5c52c59b731fe266252588ab2b32c0e3d4d808f1@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
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

Changes in v3:
- Use memset

Changes in v2:
- Use {{0}} instead of {}

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b949e202d6cb7..f72c26ae41def 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2633,7 +2633,7 @@ static void cap_soc_clocks(
 static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
 		struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
 {
-	struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
+	struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES];
 	int i;
 	int num_calculated_states = 0;
 	int min_dcfclk = 0;
@@ -2641,6 +2641,8 @@ static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_
 	if (num_states == 0)
 		return;
 
+	memset(calculated_states, 0, sizeof(calculated_states));
+
 	if (dc->bb_overrides.min_dcfclk_mhz > 0)
 		min_dcfclk = dc->bb_overrides.min_dcfclk_mhz;
 	else
-- 
2.23.0.444.g18eeb5a265-goog

