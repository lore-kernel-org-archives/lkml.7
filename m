Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E600C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1A120B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkc2Y5wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfHERdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:33:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44722 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfHERdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:33:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so39964313pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GegYP27ap/p3G8SBviHV6N7Vu1ERd/zMPfU/qhoNIeM=;
        b=Mkc2Y5wggfORlrTPCazdsbmper2mckVyD1fzbvQlbTLOBW/BQq8jfRuuM5veDF4vGS
         89CNGVXCiXDw5+f4gfZsrLGDurVw0votGH54MQ4P+vkBuSqsBh2oXQai2/EYd8j5kjP7
         zm/DfXKRnnz5ztFVAG16Sjfubr93w6/VvijekvPdKxn/TX2aXaHMcYJgujdS2CycGPMP
         Co58bTxjW3+jbRVvnnildIPPTXXQwOhuihD2I9R/DW+iOGRBVE1+wkaKl71p/JvAy01d
         arZ0H/pjzvRrIomAvJXcbLpRuXrNgn/azP3WHQB2Ac0Um4bmNbJetzCRBw7Otm8ol54p
         7foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GegYP27ap/p3G8SBviHV6N7Vu1ERd/zMPfU/qhoNIeM=;
        b=MHggMUIp2HOzYgwifCDt0M+bmDZ3d48Un68cXMy9ajQbxgNNY4+Q9I2NDdBRqhJmWB
         EOr9eM6LZbdJl7gS/dUyhf4rLizuVKoTKD6JmJimP68tzkHAh/C7jAwLiZ5F/0lSNlkw
         QRv47fFhG+kC+9BYdBfDrLEt8l9CQTG8wpFwdS85x5FrQTgT3W3ccGeeHMrhtNDj9HqY
         MvQmIibUofZXwvYa6RGZe76wP4KOtMHIdqUfeXn4lrXJwccVlBR2X/UZYdVfMY2O/ICj
         Y3DwTW+xY2FJTSpJM9QxfYmmYaFE25YpDTv6kwH3EByTivjLfhXq5667lMjfFfmAqkBC
         kKEA==
X-Gm-Message-State: APjAAAXQ+96436M7eRzhU4vMauAXdkSbdcfqvayuEcSURQTwV9ZymTz6
        dpx+TXI9LOHxSNIqm6dOFUd1Jzh0
X-Google-Smtp-Source: APXvYqxqvm7FgDQ1x++fGRcjQMdeFmTM30hDs1BBABrx91EDQH/aSmG9K1fXdGnpuyOOGnebdinUuA==
X-Received: by 2002:a63:fb14:: with SMTP id o20mr124551233pgh.136.1565026384871;
        Mon, 05 Aug 2019 10:33:04 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id m4sm97624308pgs.71.2019.08.05.10.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:33:04 -0700 (PDT)
Date:   Mon, 5 Aug 2019 23:02:57 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: drm: amd: display: dc: dcn20: Remove redudant condition
Message-ID: <20190805173257.GA4917@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redudant codition "dsc_cfg->dc_dsc_cfg.num_slices_v".

fixes coverity defect 1451853

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index e870caa..42133bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -302,7 +302,7 @@ static bool dsc_prepare_config(struct display_stream_compressor *dsc, const stru
 		    dsc_cfg->dc_dsc_cfg.linebuf_depth == 0)));
 	ASSERT(96 <= dsc_cfg->dc_dsc_cfg.bits_per_pixel && dsc_cfg->dc_dsc_cfg.bits_per_pixel <= 0x3ff); // 6.0 <= bits_per_pixel <= 63.9375
 
-	if (!dsc_cfg->dc_dsc_cfg.num_slices_v || !dsc_cfg->dc_dsc_cfg.num_slices_v ||
+	if (!dsc_cfg->dc_dsc_cfg.num_slices_v ||
 		!(dsc_cfg->dc_dsc_cfg.version_minor == 1 || dsc_cfg->dc_dsc_cfg.version_minor == 2) ||
 		!dsc_cfg->pic_width || !dsc_cfg->pic_height ||
 		!((dsc_cfg->dc_dsc_cfg.version_minor == 1 && // v1.1 line buffer depth range:
-- 
2.7.4

