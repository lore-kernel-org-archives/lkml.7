Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800CCC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F232084D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpOUYI75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfGTJls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 05:41:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33990 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfGTJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 05:41:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so16816214plt.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=v9WJAAUd0FYraGl+snmlWnmJuO7F9Zl0Mgve+vMvnZA=;
        b=hpOUYI75Ff0kT6f5LWZckHorQyUE/qBZQk05mz8fM9KFggOf0aX+0BotFS6YgyIVV1
         WkI3UVqsFE2v7UswouCjImkLB12z/GjYvCA3ytZ9ShybxPMcl3PFS/BZItRetj9IKitb
         xJCRzXYjc4J35MXy9LnLmzBu94cGYHYHadVZXJm2Jp5DL36Le7McpDmV2w53q+LFxggp
         N4Hcq88Zx35vUSA1vxwAGQKVBFRbJXpcheHBhRJTs2iCUaihWJ2E/jaRftkyBU/Nb/TQ
         g+Nu7UwIOa3tW6w6ffGZl8TbMKap+nPagwCjFjSaMoT5JGHZFhoUdKIllXQ9xGrNvOtV
         hPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v9WJAAUd0FYraGl+snmlWnmJuO7F9Zl0Mgve+vMvnZA=;
        b=iT2E8LCboYTdYR7xAFXdo1DeISROMpqUpxzTgCvpMkOkmAPmYhvlZLIdJ1kNpoK3KX
         cVc85NGC73Z/4CbYA6uevdg172BR7pnFodFWs8Wnr0celyKjwgx2vl8Yb9yuytM7Du1s
         F9NEuYXr4gs/s0NU+tqMcMQlT6hmxkrZZH/zcm58YmsUTzh1XtDk63CqXUJw+j5uwKPF
         B1b4Sa0QMZDBU1U1nb/+LWiJP4cTgjfK2kOLOFl1J/ZYu1rhPOJ2zd0FP4USbAvYsYv4
         PpqM8GKQHRteulTSpYqSZFiALpSYJpbSRnUm/iXCLBXoclO6p8Kk9NfKXr2PD5b38k7L
         5mRw==
X-Gm-Message-State: APjAAAX2WpXxb86ikqz5sf0wsTl/SzJt9p0mMzASZBSfGPCOo5OZiQ2m
        s6gry88gy8yQKe5mY+JA89Q=
X-Google-Smtp-Source: APXvYqw3UoZCQMxWk8eyzoHXCIxh7CTNleokJnNO+C/FPlZNpmnY1CrGqFOczaL/O2kl7U4dmn+wyw==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr52291700pla.33.1563615707072;
        Sat, 20 Jul 2019 02:41:47 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id j5sm28233886pgp.59.2019.07.20.02.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 02:41:46 -0700 (PDT)
Date:   Sat, 20 Jul 2019 15:11:38 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        hersen wu <hersenxs.wu@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: Remove multiple occurrence of asic_setup
Message-ID: <20190720094138.GA14101@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by coccicheck
drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c:1306:52-53:
asic_setup: first occurrence line 1309, second occurrence line 1337

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index e32ae9d..c29f527 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1306,7 +1306,6 @@ static int smu10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uin
 static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.backend_init = smu10_hwmgr_backend_init,
 	.backend_fini = smu10_hwmgr_backend_fini,
-	.asic_setup = NULL,
 	.apply_state_adjust_rules = smu10_apply_state_adjust_rules,
 	.force_dpm_level = smu10_dpm_force_dpm_level,
 	.get_power_state_size = smu10_get_power_state_size,
-- 
2.7.4

