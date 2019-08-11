Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F291EC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97A22085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQpCtMe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHKSjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:39:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39480 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:39:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so12640695wra.6;
        Sun, 11 Aug 2019 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Thd+SnJS94FvgyesMyy8xkGkKId6wz/t2E7VQfVHPsQ=;
        b=hQpCtMe4aKBdXRiIioMwywueTIhJj72eB8yQASJiWao35F/h0dD6onsC7K0t6SESb5
         kNvdwzEdbmVM6I75KL+EfchmH70cGFNsjb5bfRWRe+WAW0DYtpMqCeeKhfExD9o/EkYG
         Flfa84ybQYMOxt1+4XtmegE/fIyDoHjncAR9U2CDo9ZyUxcOSNTYUd6BRwW0Flq0CwyG
         1bRzqts14TO/nsEwIQmn7hKVWncQAhYB4PUt1df3QvhuMdtqJCyjubwfeez6tbccuMVt
         TPmdWTafYme41O6M3Dm64gmKENiR2zROmWtVOif4J5zj0U+CwrgVNyjd6U30yUqfSeYJ
         6S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Thd+SnJS94FvgyesMyy8xkGkKId6wz/t2E7VQfVHPsQ=;
        b=fLfOINKjZsbUDo3XisL+srEvK4jPPd1djaHb7iRAoSHPnfBdusaqOFRRbHJTN74frB
         aGx6FHkpWB7RGeGETqiQ2LqJJ7lJWJuBWKKSpN4ehBJP32hDg5C7QYzKtMy+clLTRc/2
         ozLWekhmW8LF95chx6Szn7vCuYMpsr0rP+9lZAF9W7hF2A8lTqiLQJifkZffUeZ8sVWg
         B6KkkvwvTS7M6xw22yGI49IbdqPt5lrYZ7Ho6MPKzvKkKRsXvGgOU8gHbtlYBHVv+5to
         je8AbF9BzMHuaoc1alH36IEaoU08yziHp2bPvHiOVFF5Y0Ygz/i+X6hIhjDXvDnF4GUp
         wCPQ==
X-Gm-Message-State: APjAAAXkqIHnXSiZt8W9QuR8Tb4Wm2qH/rD5I30INQa1UUNbmSeGY3jj
        Rc+YCRX7fpzRXPqScGhiyLg=
X-Google-Smtp-Source: APXvYqyjVVhbZx0ZteIn9cxOADrr26dnXT6i+8K2IY25Cz3eBvSl2n+pUrQ6NFBjo3SUKD5zw68rHw==
X-Received: by 2002:adf:e912:: with SMTP id f18mr15517298wrm.46.1565548791877;
        Sun, 11 Aug 2019 11:39:51 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id c187sm27793082wmd.39.2019.08.11.11.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 11:39:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/tegra: Turn off and reset hardware across suspend-resume
Date:   Sun, 11 Aug 2019 21:39:32 +0300
Message-Id: <20190811183932.15850-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers core bumps runtime PM refcount during of entering into
suspend to workaround some problem where parent device may become turned
off before its children. In order to disable and reset CRTCs/HDMI/etc
hardware, the runtime PM needs to be "forced" into suspend mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: The SYSTEM_SLEEP_PM_OPS are now set for all of the relevant drivers and
    not only for the DC because turned out that they all should enforce the
    suspending.

 drivers/gpu/drm/tegra/dc.c    | 2 ++
 drivers/gpu/drm/tegra/dpaux.c | 2 ++
 drivers/gpu/drm/tegra/dsi.c   | 2 ++
 drivers/gpu/drm/tegra/hdmi.c  | 2 ++
 drivers/gpu/drm/tegra/hub.c   | 2 ++
 drivers/gpu/drm/tegra/sor.c   | 2 ++
 drivers/gpu/drm/tegra/vic.c   | 2 ++
 7 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 4a75d149e368..6c8f5222d558 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2572,6 +2572,8 @@ static int tegra_dc_resume(struct device *dev)
 
 static const struct dev_pm_ops tegra_dc_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_dc_suspend, tegra_dc_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_dc_driver = {
diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 2d94da225e51..22f80f69ffb8 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -638,6 +638,8 @@ static int tegra_dpaux_resume(struct device *dev)
 
 static const struct dev_pm_ops tegra_dpaux_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_dpaux_suspend, tegra_dpaux_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static const struct of_device_id tegra_dpaux_of_match[] = {
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 2fbfefe9cb42..fd0f8cec8c7e 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1665,6 +1665,8 @@ static int tegra_dsi_resume(struct device *dev)
 
 static const struct dev_pm_ops tegra_dsi_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_dsi_suspend, tegra_dsi_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static const struct of_device_id tegra_dsi_of_match[] = {
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 334c4d7d238b..ef66defac767 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1739,6 +1739,8 @@ static int tegra_hdmi_resume(struct device *dev)
 
 static const struct dev_pm_ops tegra_hdmi_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_hdmi_suspend, tegra_hdmi_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_hdmi_driver = {
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 92f202ec0577..3d33d0360169 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -931,6 +931,8 @@ static int __maybe_unused tegra_display_hub_resume(struct device *dev)
 static const struct dev_pm_ops tegra_display_hub_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_display_hub_suspend,
 			   tegra_display_hub_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static const struct tegra_display_hub_soc tegra186_display_hub = {
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 4ffe3794e6d3..b743193bf0b1 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3572,6 +3572,8 @@ static int tegra_sor_resume(struct device *dev)
 
 static const struct dev_pm_ops tegra_sor_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_sor_suspend, tegra_sor_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_sor_driver = {
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 958548ef69e7..880304a65c5c 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -476,6 +476,8 @@ static int vic_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops vic_pm_ops = {
 	SET_RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_vic_driver = {
-- 
2.22.0

