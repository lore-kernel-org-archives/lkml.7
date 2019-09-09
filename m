Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64331C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 04:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357422084D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 04:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPePtxne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfIIEbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 00:31:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34429 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfIIEbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 00:31:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so5996477plr.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 21:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e7eA4TFiax+IpWz4ZBj8yfhtlvkgl3W+E1T6Ih3BFts=;
        b=KPePtxneizbd2oR42TZs5GjLHclye/D8S+i23XA0Fj8s3hqwGfvGHBirF5uxu5j9gW
         a6TGX1XFQbmS4Mvqij4vwJ0fRRFfFQ4sr6acc2omLXGYal4NooqdstYDlrx/XQ3i4eZh
         IKjudpm687JAlftFhifPgIiFXgj9ru1aAHuL2TcnkoQaaca5OyuHIrAPZZ0gDez3+v3A
         X709lmx5toLrLuhyxbwzKvbrKSZNtZQcye4sNriZsU6jau8/jaeXmJFy3uIkWBv+Sjp/
         kjSCwAdgntqhUgsLuAG6ssKq6012TPEUwwMRGV4Hn0iz1g3w9y8gYEk4GBeIbAK6cPH6
         nuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e7eA4TFiax+IpWz4ZBj8yfhtlvkgl3W+E1T6Ih3BFts=;
        b=p9gHPW/5pf/UatkrLgoHU102p1sPySURrE2NjPO74e3549oHSq905Gq7DbgZ2iRkbr
         h9euTU4/A31YFdIjSlu9okuuIPTvKbPldNO9m7xH66Rhtptbv0XZrZQezJOffJssBFA0
         HG1B1+AG8hUr1i6bJRfNYa1I0hi1W6r/mrbYKdEzy0QZL3S0FD2icDX4SMbkkRsOSSWP
         3KSshsAEUdZMFrTkQgmflPV58V5lbJxKQ/MEg1KELsdiMzqXPqlIA1ZKsevHFMx79yfB
         Pzsx/fDNchJE8TTbPw2nrXF+NO5jYPgLCn39wqgATVj3rpzj4HY/S6tDW44pTW8VRzhw
         bE3Q==
X-Gm-Message-State: APjAAAXpfD4fTf3RRBj2xTi442pK692FfLwrAglQgnmYfbbQqqKs7boI
        RXN0o8NgljVeOupnIK8U2W4=
X-Google-Smtp-Source: APXvYqyMflNLQ8szL7leKJSNcJrJy07FtvlAX1V6hB8wspa6yvwGSNIFRsCUH5IFTKfq9I8OvssVPA==
X-Received: by 2002:a17:902:a618:: with SMTP id u24mr20696843plq.342.1568003514746;
        Sun, 08 Sep 2019 21:31:54 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id x8sm13449170pfn.106.2019.09.08.21.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2019 21:31:54 -0700 (PDT)
Date:   Mon, 9 Sep 2019 13:31:48 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     alexander.deucher@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        David1.Zhou@amd.com
Subject: [PATCH] drm/amd/powerplay: Remove unnecessary comparison statement
Message-ID: <20190909043148.GA112744@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

size contain non-negative value since it is declared as uint32_t.
So below statement is always false.
	if (size < 0)

Remove unnecessary comparison.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 12c0e46..3c7c68e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1134,9 +1134,6 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size < 0)
-			return -EINVAL;
-
 		ret = smu_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
 				       (void *)(&activity_monitor), false);
-- 
2.6.2

