Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABDAC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 10:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F2D20637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 10:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzcV8FNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLHKxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 05:53:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42161 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfLHKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 05:53:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so9787008edv.9;
        Sun, 08 Dec 2019 02:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RP445oumAyApvuuzSY5LdqaN1csStiseBJ96Rg6gPzY=;
        b=FzcV8FNtYmwMpIO5ZRZ+YPRdcqZbrZEaM8iT05KkoBBtA4hwIvPRExCm6EQhLvf0/V
         6vxpkRmZfssCaMMnMEL3rXS6onfm4++nKYeJ7D1NOGhAWtQZpLkdKfKzjNE0A2uwkurO
         hSHGuxD863rSL6sAYLmEf1oUo6F1oVgBe5zrhuwVs6nncN/pbr0EFL/+K4f6I3mURkrd
         WkWhK68eEZXqMwS7yc/J0sPi9LDEjDX3zfTa7f6ckm6RAGLHXGxQlwvtPViYAiBeCSmI
         f8P3/JfazNb7BMSYxNG6oJUrjVWO4KOw7PWQvK0/FphAGft8QoNSCK0oR+dMLmBGaqav
         kV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RP445oumAyApvuuzSY5LdqaN1csStiseBJ96Rg6gPzY=;
        b=uXk14T7E7+ZkTs1jGiVHK067xjdxFeNE/HYefxK+e06kgHnd9KhTpRKwcUeQMs4xrI
         T1pFcjiKuc+7FdDn5+WZHT2NO6GBBbj7+h+JCLqrpoHCOjrZSoJylli8XhLp0/DN6PGB
         Df+gKBEITP3Cclve/BqBAtkIGjdWfwvGlmGBk91SJ33Qfu91Yzekjy85GP88LiOQkPqc
         YxiIq7bPp7vA5pFEPMEWewWcXfMVdpVJkoz6HmYBDQ1RP609lkvFfdxfMjsj9TsxWRKX
         buRcccEXRHh/lOFYEiWSIBdNGvp6FMRMhwT4GjlnwTPl4iJUDswgs4y8mebUSciGV8Td
         orlw==
X-Gm-Message-State: APjAAAWmwsvVFoJgm8RoSXYzmgawD7H2xJwa1hDeegdLx4rzha1G8JcK
        8ubbgLTrB5q2s67Ducv7tFOOhTJYeSg=
X-Google-Smtp-Source: APXvYqzKoOx2EKgpyTltHK8dmjzErAfRzYlsPNKZioPwoWXHOiOXc5mrHf/bkUbH3tGhwIA1AuppsQ==
X-Received: by 2002:a17:906:489:: with SMTP id f9mr3125363eja.27.1575802426107;
        Sun, 08 Dec 2019 02:53:46 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4e:6900:458f:723c:bc3a:78f2])
        by smtp.gmail.com with ESMTPSA id y2sm23487eds.24.2019.12.08.02.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 02:53:45 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer@vmware.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] drm/vmwgfx: Replace deprecated PTR_RET
Date:   Sun,  8 Dec 2019 11:53:28 +0100
Message-Id: <20191208105328.15335-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 508108ea2747 ("drm/vmwgfx: Don't refcount command-buffer managed
resource lookups during command buffer validation") slips in use of
deprecated PTR_RET. Use PTR_ERR_OR_ZERO instead.

As the PTR_ERR_OR_ZERO is a bit longer than PTR_RET, we introduce
local variable ret for proper indentation and line-length limits.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master (9455d25f4e3b) and next-20191207
compile-tested on x86_64_defconfig + DRM_VMWGFX=y

 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 934ad7c0c342..73489a45decb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -2377,9 +2377,12 @@ static int vmw_cmd_dx_clear_rendertarget_view(struct vmw_private *dev_priv,
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXClearRenderTargetView) =
 		container_of(header, typeof(*cmd), header);
+	struct vmw_resource *ret;
 
-	return PTR_RET(vmw_view_id_val_add(sw_context, vmw_view_rt,
-					   cmd->body.renderTargetViewId));
+	ret = vmw_view_id_val_add(sw_context, vmw_view_rt,
+				  cmd->body.renderTargetViewId);
+
+	return PTR_ERR_OR_ZERO(ret);
 }
 
 /**
@@ -2396,9 +2399,12 @@ static int vmw_cmd_dx_clear_depthstencil_view(struct vmw_private *dev_priv,
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXClearDepthStencilView) =
 		container_of(header, typeof(*cmd), header);
+	struct vmw_resource *ret;
+
+	ret = vmw_view_id_val_add(sw_context, vmw_view_ds,
+				  cmd->body.depthStencilViewId);
 
-	return PTR_RET(vmw_view_id_val_add(sw_context, vmw_view_ds,
-					   cmd->body.depthStencilViewId));
+	return PTR_ERR_OR_ZERO(ret);
 }
 
 static int vmw_cmd_dx_view_define(struct vmw_private *dev_priv,
@@ -2741,9 +2747,12 @@ static int vmw_cmd_dx_genmips(struct vmw_private *dev_priv,
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXGenMips) =
 		container_of(header, typeof(*cmd), header);
+	struct vmw_resource *ret;
+
+	ret = vmw_view_id_val_add(sw_context, vmw_view_sr,
+				  cmd->body.shaderResourceViewId);
 
-	return PTR_RET(vmw_view_id_val_add(sw_context, vmw_view_sr,
-					   cmd->body.shaderResourceViewId));
+	return PTR_ERR_OR_ZERO(ret);
 }
 
 /**
-- 
2.17.1

