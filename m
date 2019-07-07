Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A567FC48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AC12070D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRgYyof6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfGGWgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:36:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45780 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfGGWfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:35:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so11844995qkj.12;
        Sun, 07 Jul 2019 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eow1dYYoeoJ54xsm/mKUN81QYFx7NbA89068qq2m7Xg=;
        b=XRgYyof6EP8K76c++/0kueiahPl68p2Mk2DeCe8oTgkt11a53ivcXbrLTAGUeLE6Xs
         2ZihkeVuAprXBTPo7Rvtb8/ZVB9W3YbSxRDTGOQLbHyIGo7W8lZ1KcB9Fwm5Kv9AIeoQ
         ca5HqIjKqaKiJf5Sixwo221pz0s6QIXnIAvbY+mBnMV2NIzMsvFFk/GJKDUVSzIIfMKT
         K6tRHiTE2mptsSEriD+bWdPOYpUSy8qlfUl1qzpRM1ASgX9Uytfa0yJfyveTxH3NLifR
         C/69W2c42f9ceri2LqGS6jZMHYmINSI03VFi4EKf37sIjaYBu8ZfXywNPmyxyP408se4
         p9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eow1dYYoeoJ54xsm/mKUN81QYFx7NbA89068qq2m7Xg=;
        b=JU+eK0GOp7c/wJ4h28yNzrLZO9YI8kBU0yQYhmqDaRJcZxYv1DD+SezLk4H1FM073t
         LZVx+liVBsPFiHP0S8LY9ARGif3d1G1kGkokaxf3tkJW+jyK8QTeNtM3XHOGDhLtQ58E
         v1ooLLH3ulLo/lH0OJqkjojV8NdXI/UdRIaW/vThvGNgF+kMmj11xqLqusT0hZ2peEL+
         KiG3w2Rbj9PIBeEUi0V7St8yNhapV1PLHuk666DV5+s+WRA62G3dzi4ZZt968WEvfOPu
         oOe7FdZY/hqbtB94TPUtyX4cofy/bDa9+ovQ63ArBYyvtV1G7lo66OmGuNIwdzcg/Bha
         xtYw==
X-Gm-Message-State: APjAAAUOM3Rd3el7iZ3rcMD+tWXc/Jm9HBoIMjwNIE4HU1UUN+rPa+aQ
        wpTPJt7u9pMhPzRsSKTwigc=
X-Google-Smtp-Source: APXvYqyxIK3rl89DrlYf/JwcY1qeTKWCI6KkyfRW5mfxQKGSaerYcBq3Wu2n5nQlr7wdHBdtOr18zA==
X-Received: by 2002:a37:be85:: with SMTP id o127mr12008405qkf.194.1562538924676;
        Sun, 07 Jul 2019 15:35:24 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/24] PM / devfreq: tegra30: Don't enable consecutive-down interrupt on startup
Date:   Mon,  8 Jul 2019 01:32:49 +0300
Message-Id: <20190707223303.6755-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The consecutive-down event tells that we should perform frequency
de-boosting, but boosting is in a reset state on start and hence the
event won't do anything useful for us and it will be just a dummy
interrupt request.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 32fe95458ee7..878c9396bb8c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -558,7 +558,6 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
 		<< ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_NUM_SHIFT;
 	val |= ACTMON_DEV_CTRL_AVG_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_AVG_BELOW_WMARK_EN;
-	val |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
 	val |= ACTMON_DEV_CTRL_ENB;
 
-- 
2.22.0

