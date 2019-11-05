Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF5BC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B4F206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d07BWnCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfKEW6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:58:12 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40662 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKEW6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:58:12 -0500
Received: by mail-io1-f68.google.com with SMTP id p6so24684676iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbzRqvc8FvWk5sR5KGdavxWwldxvQh4qHgl2mJoTxrs=;
        b=d07BWnCDYPq9AbOnFZh2cQnq7+WxNalVgk1NTA6PdAf0WHN3tNd9j7t7pDoGQ+hGhu
         LaAnphcRnalev4XUEeyJhexhL9HhsSJ9+mrPtIw4cYe2l/QTd8wotEDPQpAXy4WC/C1E
         S57U277pgztnLd2YvzPT08RDIr+xTsZMDxepI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbzRqvc8FvWk5sR5KGdavxWwldxvQh4qHgl2mJoTxrs=;
        b=JAOl+YlXn/wJBv6qZjpp7WzVa9m3+KNYklVlMtSYvO2fVYLwlS4VUD6QpT34d77pXQ
         6oxmWsxYvxUuREBZxJlJ44qsozjKgw+uJFO3YEKeS861MD6MzXAUFQI+1uVPynkA4h7w
         +ySYNDvqS0oB9sLh1oIZg0NqHBMluesVoprMpl6jCgNHbVnXDue5oO+Scl8pVJALmDtu
         P8Y8575Agf3z8i/N3gYc+ffGoXydl5EnBsumOP5LVTS0C2SwmQaDLblx4ac/4hqdjy5t
         urLYKHkemQVl9+AYziEEoZkgOFwfUgdEcv8xf0USezX5a8I12adywk/JwxuM0PyVzt6K
         I9xg==
X-Gm-Message-State: APjAAAWxrlhviUZTEAw0HrraDEVGQJj1iANLxvYqjLib0usxIdR3Ywen
        CX/U28AdqplVyMdv6g5YwL5iaQ==
X-Google-Smtp-Source: APXvYqx6XmtvqfERYm4mk+w5mZ3zxi4aVxOq3gZEKoAHqSgi4r3FR4hhxOQ8lCOIGxmzgBNdCQ7Gog==
X-Received: by 2002:a5e:9e49:: with SMTP id j9mr31748458ioq.170.1572994691162;
        Tue, 05 Nov 2019 14:58:11 -0800 (PST)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id w75sm3229673ill.78.2019.11.05.14.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:58:10 -0800 (PST)
From:   Raul E Rangel <rrangel@chromium.org>
To:     alexander.deucher@amd.com
Cc:     Raul E Rangel <rrangel@chromium.org>,
        David Airlie <airlied@linux.ie>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Rex Zhu <rex.zhu@amd.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Evan Quan <evan.quan@amd.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amd/powerplay: fix struct init in renoir_print_clk_levels
Date:   Tue,  5 Nov 2019 15:58:02 -0700
Message-Id: <20191105155734.1.If8740b4a5095031f2c00746fbc3224be9849d76b@changeid>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/powerplay/renoir_ppt.c:186:2: error: missing braces
around initializer [-Werror=missing-braces]
  SmuMetrics_t metrics = {0};
    ^

Fixes: 8b8031703bd7 ("drm/amd/powerplay: implement sysfs for getting dpm clock")

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index e62bfba51562..e5283dafc414 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -183,11 +183,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
-	SmuMetrics_t metrics = {0};
+	SmuMetrics_t metrics;
 
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
 
+	memset(&metrics, 0, sizeof(metrics));
+
 	ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 			       (void *)&metrics, false);
 	if (ret)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

