Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3FD20665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dM2JCKG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfHBSqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:46:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34411 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfHBSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 14:46:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so33989967plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIy8h5wSfDH2K7xzDnBEs97s43/jf77iM8+1t5qbcTA=;
        b=dM2JCKG4ZUdCfNsWMCALyfKMUlMYXJR1Ny3J8w66b56pgCzx9krV9g/X89YcVbqo19
         05Hw1m1UpMW0MmMsBYCojTQBt56r4WJImUvbKsmgjzA/PcpjOl/lII2MX/R4BfBJH5fG
         XEBK2PEP1UZjsjFqxDsMfeIoZ0TIeDfIePL1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIy8h5wSfDH2K7xzDnBEs97s43/jf77iM8+1t5qbcTA=;
        b=Et87EUFWtwb2U7Ini2NKJQNmAq5qZwB6YCT+9lr0WDhMRh1xKoJnh4zp0tDyij+k4m
         LXCpa+5wr54/kOuon7IIJJbMKVkFBUP5ekcHtjajD2e9GEgf4cLAvgOH59xPdnbCQENU
         spT3lMJnSawdimvBnK8GthqivbxejJ+ivj992ry03BWEO9/4xQ8fpMKT0cXX4J3dsLaj
         2NUt3zpMZf7EYibcSfKEzyGIR130ghDFebmP+ldyziaOJVnlazoX4x9Il62JHOpR+9eC
         ICyheD1KjLNdEgTJSy5lFllGFTn0q/dKux3SdPUT9FY3CRHcJGJCO2LJiVTJshuFh2jx
         bHOw==
X-Gm-Message-State: APjAAAU0SxOT9ROHLOt6qWc7/+yIt7WvJ9XPqAEtUH9g+NR5R9DWbGBc
        PwefgDLcQdfs4ekcqiwb+g3P/Q==
X-Google-Smtp-Source: APXvYqyzzypa/BIcIJw4+CL+ZCerUphjYpafPzUroZSN13bv9VpeTF9YJah3URQns8ZT10F1jhisNA==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr126464818plb.316.1564771600984;
        Fri, 02 Aug 2019 11:46:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f19sm112071104pfk.180.2019.08.02.11.46.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 11:46:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        seanpaul@chromium.org
Cc:     linux-rockchip@lists.infradead.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/rockchip: Suspend DP late
Date:   Fri,  2 Aug 2019 11:46:16 -0700
Message-Id: <20190802184616.44822-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit fe64ba5c6323 ("drm/rockchip: Resume DP early") we moved
resume to be early but left suspend at its normal time.  This seems
like it could be OK, but casues problems if a suspend gets interrupted
partway through.  The OS only balances matching suspend/resume levels.
...so if suspend was called then resume will be called.  If suspend
late was called then resume early will be called.  ...but if suspend
was called resume early might not get called.  This leads to an
unbalance in the clock enables / disables.

Lets take the simple fix and just move suspend to be late to match.
This makes the PM core take proper care in keeping things balanced.

Fixes: fe64ba5c6323 ("drm/rockchip: Resume DP early")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 7d7cb57410fc..f38f5e113c6b 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -436,7 +436,7 @@ static int rockchip_dp_resume(struct device *dev)
 
 static const struct dev_pm_ops rockchip_dp_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
-	.suspend = rockchip_dp_suspend,
+	.suspend_late = rockchip_dp_suspend,
 	.resume_early = rockchip_dp_resume,
 #endif
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

