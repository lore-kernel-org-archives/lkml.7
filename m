Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD33C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 20:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6C206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 20:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt88ScDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfLaUxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 15:53:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33043 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLaUxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 15:53:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so35978837edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 12:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=NxVPnp1vgRmjH7L7kENjVVXZ5KNtEIGxlFIHfBLkDO0=;
        b=Gt88ScDFSWLyoxvwTcRbq/5RlwwcCXcfGvg/V8/xg1HspxXhgUgOTDJHotVZbkGEUa
         hRKxkFOtZ6FPJ8HmLF2h7/oxLvn/+rTsGl5YJbjSlqpFlDPoOke5h56RrKl12GepViuz
         SlAtu/m7n/+ZlgvIgYDNk1SRN8raTca+hfNKWHyg5n1l8K6zY2rCCI4ykQ7V20XWcdo4
         Pq1yUdjXqPNYwWWFmUFUGIOPkFsuvrXE3RlmTnkt47TfUJ/c+4B0bpqe05u6eVjmTn39
         t0RcCciVUWjgJp9feY1rGp7whMb4RCRRg+rLRBWj0huSpYNMa2YWfMCw8HGJdjT1wvZN
         j61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=NxVPnp1vgRmjH7L7kENjVVXZ5KNtEIGxlFIHfBLkDO0=;
        b=t0I7sjnuxchQ5d4O2MQt9EaufqibY+fwYRgi7luDLaL6uSKhc3AuPuBrPsCFnEz6Pb
         RhdZgjqK9u1VBE9DlG+GJmY57lYWmIc1iPAgcyPxN3IWo36W3G3SWA9gJ7PFKXJXswW3
         B6Hmt7X5gDQlGP5+OOCHZwURldk7+T4GTY7bgHx1I/wbs36/BtA1RcPXfpKFdYQuM2cS
         4WTd/6dWLmij8iNmkNeHHcd1MXAlW2jOf/pza7GwioLJJy9+xcX5sTDVoNwj4j0Vwscf
         BWulov4fR2OrZ3cL7xjcFhnTpeyqDwKRb1nKOUA3EMXIoqjoHJz2UykLZS+2pZBA4pCE
         C7bw==
X-Gm-Message-State: APjAAAVX2zgDBBK60+tOW20SCyh7VSWEkUm/qt6LcQwDulbz6r5iQL4p
        e5IKYPxujsCAv5f1Xj3gikNY2fqu+Rkaow==
X-Google-Smtp-Source: APXvYqxxUopZ/8pdt6GG0GgS0PFcwFypu8zzOhpDLyQ5fvLYLnMBZmjcdQphbEQIDVYCAE0DxMeoOA==
X-Received: by 2002:a50:fb0b:: with SMTP id d11mr78494047edq.252.1577825630876;
        Tue, 31 Dec 2019 12:53:50 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id y25sm6367432ejj.68.2019.12.31.12.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 12:53:50 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: declare constants as unsigned long.
Date:   Tue, 31 Dec 2019 23:53:45 +0300
Message-Id: <20191231205345.32615-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly declare constants are unsigned long to address the following
sparse warnings:
warning: constant is so big it is long

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c
index ac87a3b6b7c9..506b358fcdb6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c
@@ -655,7 +655,7 @@ gf100_ram_new_(const struct nvkm_ram_func *func,
 
 static const struct nvkm_ram_func
 gf100_ram = {
-	.upper = 0x0200000000,
+	.upper = 0x0200000000UL,
 	.probe_fbp = gf100_ram_probe_fbp,
 	.probe_fbp_amount = gf100_ram_probe_fbp_amount,
 	.probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c
index 70a06e3cd55a..3bc39895bbce 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf108.c
@@ -43,7 +43,7 @@ gf108_ram_probe_fbp_amount(const struct nvkm_ram_func *func, u32 fbpao,
 
 static const struct nvkm_ram_func
 gf108_ram = {
-	.upper = 0x0200000000,
+	.upper = 0x0200000000UL,
 	.probe_fbp = gf100_ram_probe_fbp,
 	.probe_fbp_amount = gf108_ram_probe_fbp_amount,
 	.probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
index 456aed1f2a02..d01f32c0956a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
@@ -1698,7 +1698,7 @@ gk104_ram_new_(const struct nvkm_ram_func *func, struct nvkm_fb *fb,
 
 static const struct nvkm_ram_func
 gk104_ram = {
-	.upper = 0x0200000000,
+	.upper = 0x0200000000UL,
 	.probe_fbp = gf100_ram_probe_fbp,
 	.probe_fbp_amount = gf108_ram_probe_fbp_amount,
 	.probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c
index 27c68e3f9772..e24ac664eb15 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm107.c
@@ -33,7 +33,7 @@ gm107_ram_probe_fbp(const struct nvkm_ram_func *func,
 
 static const struct nvkm_ram_func
 gm107_ram = {
-	.upper = 0x1000000000,
+	.upper = 0x1000000000UL,
 	.probe_fbp = gm107_ram_probe_fbp,
 	.probe_fbp_amount = gf108_ram_probe_fbp_amount,
 	.probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c
index 6b0cac1fe7b4..17994cbda54b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgm200.c
@@ -48,7 +48,7 @@ gm200_ram_probe_fbp_amount(const struct nvkm_ram_func *func, u32 fbpao,
 
 static const struct nvkm_ram_func
 gm200_ram = {
-	.upper = 0x1000000000,
+	.upper = 0x1000000000UL,
 	.probe_fbp = gm107_ram_probe_fbp,
 	.probe_fbp_amount = gm200_ram_probe_fbp_amount,
 	.probe_fbpa_amount = gf100_ram_probe_fbpa_amount,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
index adb62a6beb63..7a07a6ed4578 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
@@ -79,7 +79,7 @@ gp100_ram_probe_fbpa(struct nvkm_device *device, int fbpa)
 
 static const struct nvkm_ram_func
 gp100_ram = {
-	.upper = 0x1000000000,
+	.upper = 0x1000000000UL,
 	.probe_fbp = gm107_ram_probe_fbp,
 	.probe_fbp_amount = gm200_ram_probe_fbp_amount,
 	.probe_fbpa_amount = gp100_ram_probe_fbpa,
-- 
2.17.1

