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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F33C48BE8
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7118820673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0qExktD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfFWRiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:38:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33569 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfFWRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:38:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so8138873qkc.0;
        Sun, 23 Jun 2019 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Taorv013lx4BF1e9mQ5frJv1zsMiL53dKrJ0Mfj3qx4=;
        b=i0qExktDOvmtUHmy+8LfQWIfsj+7c/KfuWryEMjvL850aOttg1UgB4u3YdMMiw6tUQ
         oUr4Uzh0mo3H0NXiw6CXiEGEqW8wY/v2soaQTvK4xSpUQ8J4AEpCfTotUDFGu6C7+2Qz
         FZRRfFHY50qwNhnwXZzX7GfNq4mSzAbYFAU+If4/4d2zgZwYzAyD5KTykp9ImlnylfYC
         Rs5ShfPEJstSCDPIknItVC/6+brEZJvUNqc7Jd1tKMk3N+zyfXTctTbBp7UezxgMJqX+
         cOSs0iEkUS/vmtde81cuHxxvPItAWeZIg0DsZWbWnOrczrXMVyYyDxdrt17f7umQn5tC
         /UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Taorv013lx4BF1e9mQ5frJv1zsMiL53dKrJ0Mfj3qx4=;
        b=JAP8IbI759o250IEsfGAGEAYxlTOyTAavgidFk2zIdOtRlgy6KzUUA6flHZCu21u3K
         fop4W3U8BDJKWu1aoV0KhH9trEF9pJnJT446Mwkq9rMux03Hc6hHFLU+g7I1hhKVdbjc
         joEMNyv+WZQ1F2QByRH56VCgBdclOSLq1rYMFVQDRXHJ5qgxspuj2PsY66Non4LNUgwa
         cXGYOZXfL1/cYK6LxZKTbZGjWZ1oCx+W8d4SZ9GLxZAD7UgzztA8q2j9N1Gm4BTBJIiD
         gSyZoamdSp1o3lQq+zXMMWak/FwxWIIh5ULcpWv8RAdyp991iewSKzAn36XBYHSt4vPs
         aS3Q==
X-Gm-Message-State: APjAAAXgXyew9BuEh+ew//mHl1wYjjKCsDDYNAZAAOgFupQPwRdzbYEW
        3U6ubDccHyTIj82njSBhmgU=
X-Google-Smtp-Source: APXvYqyxoVySJ+bjh9dacS0w0vip5Vr0BkFtivb56+vWtspFfCp3xLiTPe3jL8pbW162KCckP1ophg==
X-Received: by 2002:a37:8145:: with SMTP id c66mr13276625qkd.459.1561311482169;
        Sun, 23 Jun 2019 10:38:02 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id c55sm5342498qtk.53.2019.06.23.10.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 10:38:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] drm/tegra: Fix 2d and 3d clients detaching from IOMMU domain
Date:   Sun, 23 Jun 2019 20:37:42 +0300
Message-Id: <20190623173743.24088-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623173743.24088-1-digetx@gmail.com>
References: <20190623173743.24088-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should should fire up on the DRM's driver module re-loader because
there won't be enough available domains on older Tegra SoCs.

Cc: stable <stable@vger.kernel.org>
Fixes: 0c407de5ed1a ("drm/tegra: Refactor IOMMU attach/detach")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c   | 4 ++--
 drivers/gpu/drm/tegra/drm.c  | 9 ++++++---
 drivers/gpu/drm/tegra/drm.h  | 3 ++-
 drivers/gpu/drm/tegra/gr2d.c | 4 ++--
 drivers/gpu/drm/tegra/gr3d.c | 4 ++--
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index fa505baaaabc..c1b885444d90 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2388,7 +2388,7 @@ static int tegra_dc_init(struct host1x_client *client)
 	if (!IS_ERR(primary))
 		drm_plane_cleanup(primary);
 
-	host1x_client_iommu_detach(client, dc->group);
+	host1x_client_iommu_detach(client, dc->group, true);
 	host1x_syncpt_free(dc->syncpt);
 
 	return err;
@@ -2412,7 +2412,7 @@ static int tegra_dc_exit(struct host1x_client *client)
 		return err;
 	}
 
-	host1x_client_iommu_detach(client, dc->group);
+	host1x_client_iommu_detach(client, dc->group, true);
 	host1x_syncpt_free(dc->syncpt);
 
 	return 0;
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index d2080bd7d392..f94441457c64 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1120,15 +1120,18 @@ struct iommu_group *host1x_client_iommu_attach(struct host1x_client *client,
 }
 
 void host1x_client_iommu_detach(struct host1x_client *client,
-				struct iommu_group *group)
+				struct iommu_group *group,
+				bool shared)
 {
 	struct drm_device *drm = dev_get_drvdata(client->parent);
 	struct tegra_drm *tegra = drm->dev_private;
 
 	if (group) {
-		if (group == tegra->group) {
+		if (!shared || group == tegra->group) {
 			iommu_detach_group(tegra->domain, group);
-			tegra->group = NULL;
+
+			if (group == tegra->group)
+				tegra->group = NULL;
 		}
 
 		iommu_group_put(group);
diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index 488f36f00bd8..9f1a3d6f3406 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -107,7 +107,8 @@ int tegra_drm_unregister_client(struct tegra_drm *tegra,
 struct iommu_group *host1x_client_iommu_attach(struct host1x_client *client,
 					       bool shared);
 void host1x_client_iommu_detach(struct host1x_client *client,
-				struct iommu_group *group);
+				struct iommu_group *group,
+				bool shared);
 
 int tegra_drm_init(struct tegra_drm *tegra, struct drm_device *drm);
 int tegra_drm_exit(struct tegra_drm *tegra);
diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 673059fd2fcb..c486e0a05c9d 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -69,7 +69,7 @@ static int gr2d_init(struct host1x_client *client)
 	return 0;
 
 detach:
-	host1x_client_iommu_detach(client, gr2d->group);
+	host1x_client_iommu_detach(client, gr2d->group, false);
 free:
 	host1x_syncpt_free(client->syncpts[0]);
 put:
@@ -89,7 +89,7 @@ static int gr2d_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	host1x_client_iommu_detach(client, gr2d->group);
+	host1x_client_iommu_detach(client, gr2d->group, false);
 	host1x_syncpt_free(client->syncpts[0]);
 	host1x_channel_put(gr2d->channel);
 
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 4778ae999668..591bafe455e0 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -79,7 +79,7 @@ static int gr3d_init(struct host1x_client *client)
 	return 0;
 
 detach:
-	host1x_client_iommu_detach(client, gr3d->group);
+	host1x_client_iommu_detach(client, gr3d->group, false);
 free:
 	host1x_syncpt_free(client->syncpts[0]);
 put:
@@ -98,7 +98,7 @@ static int gr3d_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	host1x_client_iommu_detach(client, gr3d->group);
+	host1x_client_iommu_detach(client, gr3d->group, false);
 	host1x_syncpt_free(client->syncpts[0]);
 	host1x_channel_put(gr3d->channel);
 
-- 
2.22.0

