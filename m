Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FB6C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2649220862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjLdOQG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfEYRyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:54:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46772 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfEYRyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:54:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so2337769pfm.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DEpuhQuBsGwiHo827HWHBFzX5NQZPFzzYlkuA72/SiA=;
        b=WjLdOQG9mrCp0ELu/bt3O7UbVIAvTh0Vx7MQoek6qs57GO34xUppozMYwVWZmRFIwT
         G5iGj3R3oNgfcluvs8nU/wSndGgci99HUZxy8+HkvbtYyDpHGCjuEebjCP8qncM+xKgF
         xDW+dw2o1phUBlNvLqik6tZMYK3B0ORF6g/NFvFJXgMaUFZLv28GTtjhPmeLLgE5LMPd
         iDFiFUGCrEY4iSjXKSJ4lDquw57Dp30z62mB0tFiefEICYvHXaw6SiOaMuBwmtwrBO0U
         19B1NlFFf50I5VPVxRePkMRGabg3CBp0upUgpaqdsP6qxFPRjA9RmRLaWx+pW1mBFOY7
         F6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DEpuhQuBsGwiHo827HWHBFzX5NQZPFzzYlkuA72/SiA=;
        b=rah3e8td220NleXCHEQcbmW/XP5M/Bm+hFpnZPqGzXIYL8c7EZPfVM1Iki4t1FZeBa
         VM3rCqvx80FwGuHql3AlGarVybeMTIVe3rpNE4MDOVl9exiPmggDrDAsggWT0Ep4qKQd
         Gh+elpZjCjiwvrJvZZkZe3imQV2qMpyjP1Bsfxi542fRuHY87MkDQSLWKb8TbtLMvvCX
         RoIW6b5m29p5E+63j/lkJ6jCzbHqOZ9tp0D1kADyhwd+Lfgu33BnYeayb1wPvVS+FKHx
         tPyGKAcAe5HGxIZkfhQDJBwOtiFokIaXyx2NSGcNnEfWVaOkGz2BoQ5KGO0EF5xeeSyi
         Xf+w==
X-Gm-Message-State: APjAAAVnQ8oW2Hu/SNNcAA9E89dG+/37sXDdsu7WLA1x1UKDxqDT1P3/
        JN/RZkwymHtyPmo+9+u8udE=
X-Google-Smtp-Source: APXvYqzAWlK2XPpvnHqjfejsJLvRg/XDSSsH8LlOZKQ8J+6/TfVO6G+fL/q7U6zjHi3hCRZ4ZIuOLQ==
X-Received: by 2002:a63:2f47:: with SMTP id v68mr28837402pgv.251.1558806871591;
        Sat, 25 May 2019 10:54:31 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id p90sm16977127pfa.18.2019.05.25.10.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:54:29 -0700 (PDT)
Date:   Sat, 25 May 2019 23:24:23 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Charlene Liu <charlene.liu@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Ken Chalmers <ken.chalmers@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix  possible condition with no effect (if
 == else)
Message-ID: <20190525175423.GA27834@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

./drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c:1364:3-5: WARNING:
possible condition with no effect (if == else)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index f3aa7b5..0706ced 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -1361,13 +1361,7 @@ static void calculate_bandwidth(
 	/*if stutter and dram clock state change are gated before cursor then the cursor latency hiding does not limit stutter or dram clock state change*/
 	for (i = 0; i <= maximum_number_of_surfaces - 1; i++) {
 		if (data->enable[i]) {
-			if (dceip->graphics_lb_nodownscaling_multi_line_prefetching == 1) {
-				data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
-			}
-			else {
-				/*maximum_latency_hiding(i) = minimum_latency_hiding(i) + 1 / vsr(i) * h_total(i) / pixel_rate(i) + 0.5 * total_dmifmc_urgent_latency*/
-				data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
-			}
+			data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
 			data->maximum_latency_hiding_with_cursor[i] = bw_min2(data->maximum_latency_hiding[i], data->cursor_latency_hiding[i]);
 		}
 	}
-- 
2.7.4

