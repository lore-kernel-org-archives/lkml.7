Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E487C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65842168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 04:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="SCVr5lQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfI3EoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 00:44:21 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:5373 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3EoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 00:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569818661; x=1601354661;
  h=from:to:cc:subject:date:message-id;
  bh=0SNQmcerQGYmCZ9l6DTTbRNgRMFVfVHcLeXs0PBRhRA=;
  b=SCVr5lQsmxv+KusE7JyKzj3H7/vU68Wj8Ff8GlWwPh2YiSK3J0SjjAyh
   Q6wyy0hgaAkCXPOg1Yhy6idZ3/bpshbN4PASYcw6BBCQO1PdvwhPEVvwJ
   BY1C8ZYilOA9s52IuV4jMmMQtWL6jpxpMnSlCYIsQzZOglv+lRqF27JnY
   I4eaUjKtuNIO61YomUaroQsy5RRJEQBK4tSokoZFSvittYOTbehoKOd+A
   RKfdYmUnSpyQjfbZymFTc+3mMbgWhyR+kF0+fA4Y+0Bl0UvFxNvGVOTPz
   ZwjkpAFbXurpqoW1jbd/r6i7N/ZLRYsOrtDWguVsICDj0uohSAVRsJ9cu
   A==;
IronPort-SDR: eAugveUnAzi1AuY2Ss5RUzk31B0yIxYv5247L7srdKsofkI1wfugp89ll+1jaylBXL120v5SD1
 aEKQDHSc+XxfkYdY07DDuE95EyjLBuMyi2zO1NykAX8T+iXJBnOH8u60R2Y3tqTjipbuPB0mb9
 LOKALHGqIwRVP9eWsX5477lGpu3Yz7cyVgCr2uNntPa3iP6JbA49DDShRO0qmPyFu8rIZn0zXg
 dqi6V7TW7JKFcLvU9u0YheJKXzAG+ZhKxY9KflD7TsJ77tMOwzW1kKIYWK080yjudNYkxokpVt
 z/I=
IronPort-PHdr: =?us-ascii?q?9a23=3AKRJB8RWvHBzyzfVCG1J6yBCFWtfV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYx2Gt8tkgFKBZ4jH8fUM07OQ7/m7HzBZqsbc+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLucQanIRuJ6Uxxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipEAoO9dIsPFOsBPeBXr4LguVUAtAa1BQetBOzxzj9Hm2L90ak03u?=
 =?us-ascii?q?g9FA3L2hErEdATv3TOtNj7NLkcX/27wqfLyjvOdO9a1Svn5YTUaB0tve2AUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02SpozkPjKV1vkNs2+G5OdnVeOuim4npBtwojSz2sshhJ?=
 =?us-ascii?q?LEhp8JxVDe7yl23ps6JcChRUN9fNWqE4NQujmEO4dqRs4uWWJltSYgxrEYpJ?=
 =?us-ascii?q?K2czIGxIkjyhPdc/CLbomF7xb5WOqPLzp1hGhpdKy+ihqo80WtxevxXdSu3l?=
 =?us-ascii?q?lQtCpKiNzMu2gI1xzU98eIVONw/lyk2TaTzwDT7fxEIVwsmarbNZEhxrkwm4?=
 =?us-ascii?q?IWsUvZHy/2nFz6jLeSdkk54+So5fnrb7Hkq5OGOI90jQb+MqsqmsOhG+g3Lg?=
 =?us-ascii?q?8OX22D9eS90r3s41H5Ta1UgvEqlqTVqpPXKMQBqqKnHgNY3Zwv5wu7AjqkyN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLej4DPa+g1SjijZry+zaMrDvGZjNM2TMkK37cb?=
 =?us-ascii?q?lj9kFc1RI/zcpD6JJMFrEBPPXzV1f1tNzZCB85LgO1z//kCNpjzIMeX3yAAq?=
 =?us-ascii?q?uCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcvrh84EQbSWJH+ZmPk?=
 =?us-ascii?q?LRNWv+gt4AST9Rlhc1VqrnhEDUAm0bXGq7Q69pvmJzM4mhF4qWA9/1jQ=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FlCQDXh5FdgMXWVdFmHgEGEoFcC4N?=
 =?us-ascii?q?eTBCNHoVxUAEBAQaLJoEJhXqDC4UmgXsBCAEBAQwBAS0CAQGEQIM7IzYHDgI?=
 =?us-ascii?q?DCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjopgzULFhVSVj8BBQE1IjmCRwG?=
 =?us-ascii?q?BdhSfDIEDPIwlM4hcAQkNgUgJAQiBIoc1hFmBEIEHhGGEDYNWgkQEgS8BAQG?=
 =?us-ascii?q?NcIcrlkkBBgKCEBSBeJMHJ4Q5iT2LPwEtiiicawIKBwYPI4E2B4IDTSWBbAq?=
 =?us-ascii?q?BRFAQFIIGji0hM4EIjTKCVAE?=
X-IPAS-Result: =?us-ascii?q?A2FlCQDXh5FdgMXWVdFmHgEGEoFcC4NeTBCNHoVxUAEBA?=
 =?us-ascii?q?QaLJoEJhXqDC4UmgXsBCAEBAQwBAS0CAQGEQIM7IzYHDgIDCQEBBQEBAQEBB?=
 =?us-ascii?q?QQBAQIQAQEJDQkIJ4VCgjopgzULFhVSVj8BBQE1IjmCRwGBdhSfDIEDPIwlM?=
 =?us-ascii?q?4hcAQkNgUgJAQiBIoc1hFmBEIEHhGGEDYNWgkQEgS8BAQGNcIcrlkkBBgKCE?=
 =?us-ascii?q?BSBeJMHJ4Q5iT2LPwEtiiicawIKBwYPI4E2B4IDTSWBbAqBRFAQFIIGji0hM?=
 =?us-ascii?q?4EIjTKCVAE?=
X-IronPort-AV: E=Sophos;i="5.64,565,1559545200"; 
   d="scan'208";a="10941842"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2019 21:44:20 -0700
Received: by mail-pl1-f197.google.com with SMTP id y2so4525633plk.19
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 21:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fhKI7ppyFFBgJ00SzX1cYxWJFEQpwUkMWFBN7vg0cLU=;
        b=PSoa8BJYsE1dtrr/mV8hr9DmV/swgweo90dMSYDrnFf6Y3sZNKDzYPnBeoGk+7ZTno
         g7V/RiMUVHQapriotPkCwp7wLlTukYXU8TYkGRGZ4lWA4zXBQQgSykQAtw/ssk9ncAS1
         i119n+LZhCcW1x4L/AwzIZKBi6Z5Nw9WWYgZoq3zXE6ee2O40HKjgLDTOxAvJODwfo/R
         bC3LgH68KNIwn8cuLltGQGY/h2RlagPg7AKlMfJvyuuEBLA5aV5OicbLerA8pnj+cb84
         r+LaJjlMWK0jcb0ZjR/0Yvvg1E/xrCHl3fRot4bjdYL9fxuIkIqORwgH9iy9/KglLJHI
         enQQ==
X-Gm-Message-State: APjAAAV7GYGcjWMr5f/h9fPXgQBb3ZwULjSiorGvFWOZl7U9fzsH8Qm+
        7egT7+ZOkPDhgw/fT3gtWLmHKRdvsS6aQU5UwzBe4tc4ZPjI0gZkD89YQ3A1v8WEBhY7PnROFfI
        cXpZ+zaXWMTBQw1H95RyGEhXc6A==
X-Received: by 2002:a17:90b:f11:: with SMTP id br17mr24362021pjb.80.1569818659823;
        Sun, 29 Sep 2019 21:44:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBGNdeHonBgOxOoWJY4fFbB5KZPHMDaJknbxcnGpOV7mPBU4cMLjphMacZjFe9cDo/ydTknQ==
X-Received: by 2002:a17:90b:f11:: with SMTP id br17mr24362001pjb.80.1569818659475;
        Sun, 29 Sep 2019 21:44:19 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id dw19sm13079001pjb.27.2019.09.29.21.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 21:44:18 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: sii902x: Variable status in sii902x_connector_detect() could be uninitialized if regmap_read() fails
Date:   Sun, 29 Sep 2019 21:45:02 -0700
Message-Id: <20190930044502.18734-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function sii902x_connector_detect(), variable "status" could be
initialized if regmap_read() fails. However, "status" is used to
decide the return value, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/gpu/drm/bridge/sii902x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 38f75ac580df..afce64f51ff2 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -246,7 +246,7 @@ static enum drm_connector_status
 sii902x_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct sii902x *sii902x = connector_to_sii902x(connector);
-	unsigned int status;
+	unsigned int status = 0;
 
 	mutex_lock(&sii902x->mutex);
 
-- 
2.17.1

