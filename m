Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C905C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A3722522
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468751;
	bh=PA4FxnAk4aNpdZ8YIp/EAybWfqD/vW0X7F1oDdtjVRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=llCgOL4uYq6UyIsebNcDrfOL6RylTJm30+CXVKmYOEPAdfrcBKWBnt7rWr5QjygGO
	 aMDbjSoX0f6pdEPsz70CrYkTROEwh3+pfp8A6agX2vvlNxQY8NguJpZNXsAnfPBL5a
	 7RFdbfc6fC9CZ2NCgGHp3HAOpHjEBzX5nM8tRPRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfL0RpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfL0RpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:45:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D990B24653;
        Fri, 27 Dec 2019 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468720;
        bh=PA4FxnAk4aNpdZ8YIp/EAybWfqD/vW0X7F1oDdtjVRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTmrLJS84WQ+YPrO9GRHSju0t2ucBZl0NvJWQbxSGZSGMqoxZLAevGgte7UlIuFV8
         X9+G3UPw287hXDCQ8R2O53iYwrbVT8SZuqZe0fjgxyvs9m2/zV8W1xxYck4Au2QiYY
         ALO9PJVde7s2VSIHn9CTVwR7WjL7mfDdhDGEofOU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Inki Dae <inki.dae@samsung.net>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 74/84] drm/exynos: gsc: add missed component_del
Date:   Fri, 27 Dec 2019 12:43:42 -0500
Message-Id: <20191227174352.6264-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 84c92365b20a44c363b95390ea00dfbdd786f031 ]

The driver forgets to call component_del in remove to match component_add
in probe.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 7ba414b52faa..d71188b982cb 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1292,6 +1292,7 @@ static int gsc_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
+	component_del(dev, &gsc_component_ops);
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 
-- 
2.20.1

