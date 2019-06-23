Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB63C48BE4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E42620673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkueY8iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfFWRiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:38:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39259 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfFWRiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:38:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id i34so12148053qta.6;
        Sun, 23 Jun 2019 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pU2ySpgeuPIDehUiqqbX8/63SN6HD4vkGtCiMTUdjZo=;
        b=kkueY8ivVKNH+tWI8+mgANJNDQk80xpHteXLuYEKu+lR1WYRUseu4LuAVB74j8fXqW
         Y5zo0vxu/p5xBjvtGK649WCz5M2jPoI6k94WYGaW3yAY0BMF52cvGkRZ0IkQGHuM9e7m
         9Z6fA559SeuiSSw7YCjb0X9vuW6H1T5miQZI0qiL6zEWwu5PqvD3zxmuppBGc5qACIIi
         /8cwmppSsalGvtm2Seork2xRsAcdcWQ3562Y8ObQtIPomQ0dXP7dcb7RwXyT/1VgAZC6
         jSgz1FJmJoR7AX+pmdBVZnDaA4OUwPp+YCc4TYAI3+nuL9cwOo8nTR/k+hcuXxtjJ2sE
         o1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pU2ySpgeuPIDehUiqqbX8/63SN6HD4vkGtCiMTUdjZo=;
        b=EB7ZJxfkCTb437b9aDvkGNCefVzOnneCxkgswcUkB5PkvP+28WYZXfcS6h7F/0533x
         7gjNzToER6AdxMrvwIQE3s1E6SgDGJrg4Z0x36HYvIJ5mfKmkaNP0MisB4c0oiZaBooa
         +1OoE5DWIYCL3FWYyFjvBDMfmPUuTIA7Wa4snuwphORq4Kr0lg/PZ1G1xF99MABd2AuR
         TJg4/qr95VpCcr0vpw3SPamhT/MZzGGdicU8JP/e+//rhnO6rAmSKzi1DeE5aSUmVv7f
         ub4O/FKXmCol5sFXaJXhyIDbvLQehGfkTgsiSjZRMf25ZwsIB9uTXnkva4sgc5IHnMyS
         x3mw==
X-Gm-Message-State: APjAAAW9T+Xwkle4VxXVVy67yxnuA04ddBTbI/sbilrDrFZb5oft/9zg
        bXc2P9uBI6p/OwhvrLjbF4QcrwDw
X-Google-Smtp-Source: APXvYqyTZWTsrXwrIZibYOusfJL78o9yLKMY/cHHOd0dx04WanYQvMb/lt5vUtmyvIHDzHPgAtqQ5w==
X-Received: by 2002:a0c:818f:: with SMTP id 15mr26657878qvd.162.1561311483688;
        Sun, 23 Jun 2019 10:38:03 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id c55sm5342498qtk.53.2019.06.23.10.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 10:38:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] drm/tegra: vic: Use common helpers to attach/detach from IOMMU domain
Date:   Sun, 23 Jun 2019 20:37:43 +0300
Message-Id: <20190623173743.24088-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623173743.24088-1-digetx@gmail.com>
References: <20190623173743.24088-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have helpers for the domain's attachment, let's use them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/vic.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 982ce37ecde1..baa00da780d0 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -36,7 +36,7 @@ struct vic {
 	void __iomem *regs;
 	struct tegra_drm_client client;
 	struct host1x_channel *channel;
-	struct iommu_domain *domain;
+	struct iommu_group *group;
 	struct device *dev;
 	struct clk *clk;
 	struct reset_control *rst;
@@ -183,21 +183,16 @@ static const struct falcon_ops vic_falcon_ops = {
 static int vic_init(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
-	struct iommu_group *group = iommu_group_get(client->dev);
 	struct drm_device *dev = dev_get_drvdata(client->parent);
 	struct tegra_drm *tegra = dev->dev_private;
 	struct vic *vic = to_vic(drm);
 	int err;
 
-	if (group && tegra->domain) {
-		err = iommu_attach_group(tegra->domain, group);
-		if (err < 0) {
-			dev_err(vic->dev, "failed to attach to domain: %d\n",
-				err);
-			return err;
-		}
-
-		vic->domain = tegra->domain;
+	vic->group = host1x_client_iommu_attach(client, false);
+	if (IS_ERR(vic->group)) {
+		err = PTR_ERR(vic->group);
+		dev_err(client->dev, "failed to attach to domain: %d\n", err);
+		return err;
 	}
 
 	vic->channel = host1x_channel_request(client->dev);
@@ -223,8 +218,7 @@ static int vic_init(struct host1x_client *client)
 free_channel:
 	host1x_channel_put(vic->channel);
 detach:
-	if (group && tegra->domain)
-		iommu_detach_group(tegra->domain, group);
+	host1x_client_iommu_detach(client, vic->group, false);
 
 	return err;
 }
@@ -232,7 +226,6 @@ static int vic_init(struct host1x_client *client)
 static int vic_exit(struct host1x_client *client)
 {
 	struct tegra_drm_client *drm = host1x_to_drm_client(client);
-	struct iommu_group *group = iommu_group_get(client->dev);
 	struct drm_device *dev = dev_get_drvdata(client->parent);
 	struct tegra_drm *tegra = dev->dev_private;
 	struct vic *vic = to_vic(drm);
@@ -244,11 +237,7 @@ static int vic_exit(struct host1x_client *client)
 
 	host1x_syncpt_free(client->syncpts[0]);
 	host1x_channel_put(vic->channel);
-
-	if (vic->domain) {
-		iommu_detach_group(vic->domain, group);
-		vic->domain = NULL;
-	}
+	host1x_client_iommu_detach(client, vic->group, false);
 
 	return 0;
 }
-- 
2.22.0

