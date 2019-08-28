Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00710C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CFC206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Prfgnz7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfH1SiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:38:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40423 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfH1SiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:38:05 -0400
Received: by mail-io1-f68.google.com with SMTP id t6so1563043ios.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHcgLtBVTpOTGkvzzyFJrMalfpvT5RoFcnOBKCVmA5U=;
        b=Prfgnz7bfxDp5kmjxjC/BLb48ridESw18bqWlWy5WpdGoMrDZkp/Ty3yA21Va0soPb
         OgE8LcXLLqF/nBbyU/mNa9Aiqv3tcLDZblvAD0rYJ4H/oyzvRTnLRfk2BCMFR/Gs1GPl
         gTGZ/V/78VeoGFu7mHjHQQ2E88PDCxxgrmERk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHcgLtBVTpOTGkvzzyFJrMalfpvT5RoFcnOBKCVmA5U=;
        b=gPall1vLpuIcuBYhbdEeokn8/R3nqB4B40gYY9ufjgDKrt/bMG5iCKXftAviFe+aBz
         YGLg4lFfbJS/tOv0p9t2usPszKPo/XBp11C4p+YgV9bZbWQCep6T2JIBI27adUUwZSyM
         +s8WsiO4ov3AEGy9bd4/wN0kQ8/L2mR1ulCob1oPbMQbnhq0wYpAIAfTN7eT2SKPMYRb
         wGLOuNWAyRT/gOZydk4oKQqUPYF+NDl9AuNRv1PfpV6dqvHTiP6+3obn1XP/DE9qnSC7
         Brvc4XARTmtHbfhfNeY/I3pah0Fuht6UStFZVwxU2baPRygQmybuX1JzjDOq+DC5o4H9
         7eRQ==
X-Gm-Message-State: APjAAAXBGqYsEqZ70EO1n2m6wuozQKlY/wut95gaO4foLiLxvaD+JX6C
        JMrjFaJXtiHdGkjyXWHaWlzQeSCK/wLTjw==
X-Google-Smtp-Source: APXvYqyTJ1bJXyGDWbBc6lK10AP1JqjnjpqqnNcWjg3el8gUSPgtA5J0MKM5o872ZZtIlfFPuskZ7Q==
X-Received: by 2002:a6b:da1a:: with SMTP id x26mr5912882iob.285.1567017484708;
        Wed, 28 Aug 2019 11:38:04 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id s4sm4599667iop.25.2019.08.28.11.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 11:38:04 -0700 (PDT)
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
Subject: [PATCH v2] drm/amd/display: fix struct init in update_bounding_box
Date:   Wed, 28 Aug 2019 12:37:58 -0600
Message-Id: <20190828183758.11553-1-rrangel@chromium.org>
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
So apparently `{}` is a gcc extension. The C standard requires at least
one expression. So {{0}} is correct. I got a lint error about {{0}}
needing a space, so i use `{ {0} }`.

Changes in v2:
- Use { {0} } instead of {}

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b949e202d6cb..8e6433be2252 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2633,7 +2633,7 @@ static void cap_soc_clocks(
 static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
 		struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
 {
-	struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
+	struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = { {0} };
 	int i;
 	int num_calculated_states = 0;
 	int min_dcfclk = 0;
-- 
2.23.0.187.g17f5b7556c-goog

