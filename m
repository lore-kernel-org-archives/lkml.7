Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE33AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC828218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmWnkmaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfDWXVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42562 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfDWXVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so8245944pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PJpt961AUotkx92U9UhQ+Xu1suFDY3Q+xFz+vrGcjE4=;
        b=AmWnkmaLsdXPfYTFhHB5uW5qtrJ6UY93Uhapl8moRr/XyDxKUfPDiduErIL0PZSlXT
         jZSnCoKEVWH8f7Saj0aer4vXinxRi6YUL5ddDdh9ABXRAXWaUDnRhqI4m23CWENhK4tv
         ZtrL69sGTtL5esCcVyl1Emz05kbVxAIoAeHY6NDAPZJeFpirI0MTqF2RRmrBYxt6YRRy
         hsr0wbgZxAudSHehCPOOkKXwvtZyL58jBvvylzmCb962pVnepYpM/QzX4vfxT7+wjpuo
         SC80FeVylBl4aAQ4+GMHOd+V98/28MyE3Qtxdg6McYZzC8nHucF0ilLQ9w9P5wUYx4pj
         8UeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PJpt961AUotkx92U9UhQ+Xu1suFDY3Q+xFz+vrGcjE4=;
        b=ARyUXMwZyKT8SrXwWlopgC3ZCI33StkeNflXh/XTN2GvlkHGbf36/0G0EdHeDSlVF1
         /A+nSq9zELjkTHGitK9rSblNgu0YEPMBAd8mgV4iFnQ+rkM9tA9qy99fjRHMIZDXAAiY
         M1rMybL6tey1TnJ8QvpNGfSvZ3zHkOeBn4GDBK4eG7QMMpqma3MeXzBbSa7pdG4xR9Y+
         QYVUYtc4KHcSD1ExKXiAKfThbPCs6CdOEnPQw2C1s05+ZgrBZn3CiOLU/iv83klOPpOF
         Qm+ivWYohB+LODV8UqEKSYzLTHAubNRWHhlVnzM98MC/bsrUzKaAV++xwG8z36++C3bH
         Qs0Q==
X-Gm-Message-State: APjAAAVUJXaZFGHORsTnmaHgb3hnNRUWuc4m8vvLxTqFsfKX0M9l5hU3
        h8VlNgMHiNNS1wwDLA6FwgQ7wknSsww=
X-Google-Smtp-Source: APXvYqyUlIaK+U1ReA6lItnW8fmKebrGKmYIDisAG1J6wlj/1UzHFWPbBZCESsA8GvKTEPWg6fbcpg==
X-Received: by 2002:a65:5202:: with SMTP id o2mr27247072pgp.402.1556061664628;
        Tue, 23 Apr 2019 16:21:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:03 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: [PATCH 03/25] drm: kirin: Remove unreachable return
Date:   Tue, 23 Apr 2019 16:20:34 -0700
Message-Id: <1556061656-1733-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'return 0' in kirin_drm_platform_probe() is unreachable
code, so remove it.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Suggested by: Xu YiPing <xuyiping@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 7cb7c04..c9297d6 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -212,8 +212,6 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
 	of_node_put(remote);
 
 	return component_master_add_with_match(dev, &kirin_drm_ops, match);
-
-	return 0;
 }
 
 static int kirin_drm_platform_remove(struct platform_device *pdev)
-- 
2.7.4

