Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B373BC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897EB22DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308581;
	bh=vQSIWtLX/ZSUMHhJihrr+VUZjUJuJ72xye3zPrDepdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xt6WysrXZMVUU9+wv+NkDCvrm4J7PHH4O5qx3N5IIt1IZAnilp+AJ72nXlAd2ltfh
	 S3zMiofJhZYSJ/OWY+FZBp7ppKpbPYYnH0qOxJnQOsV8zcBrmE941etuB1se32kfvy
	 1xvYzixDDMw4zfu7KQQnT7c20sesIEEHzuDVxDIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfHTNnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729639AbfHTNms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:42:48 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ADE32087E;
        Tue, 20 Aug 2019 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308567;
        bh=vQSIWtLX/ZSUMHhJihrr+VUZjUJuJ72xye3zPrDepdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yr6ceUFfk0ZOpklj2BLvvNpni8QG94038GpKUfUgcLn4i9/0laiTcvlx6mBppvYzW
         5kQ9j6F/Vcd6dR00jBCXFRjouxgXrAEafxQ1vafwiOwrxxoxtwJtgfr/TtODN587JA
         IYWCjZ/pp6w7edjKxmj2IuVFjVyIHxufC9M1Ar9w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 24/27] drm/ast: Fixed reboot test may cause system hanged
Date:   Tue, 20 Aug 2019 09:42:10 -0400
Message-Id: <20190820134213.11279-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134213.11279-1-sashal@kernel.org>
References: <20190820134213.11279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Y.C. Chen" <yc_chen@aspeedtech.com>

[ Upstream commit 05b439711f6ff8700e8660f97a1179650778b9cb ]

There is another thread still access standard VGA I/O while loading drm driver.
Disable standard VGA I/O decode to avoid this issue.

Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1523410059-18415-1-git-send-email-yc_chen@aspeedtech.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_main.c | 5 ++++-
 drivers/gpu/drm/ast/ast_mode.c | 2 +-
 drivers/gpu/drm/ast/ast_post.c | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 373700c05a00f..224fa1ef87ff9 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -131,8 +131,8 @@ static int ast_detect_chip(struct drm_device *dev, bool *need_post)
 
 
 	/* Enable extended register access */
-	ast_enable_mmio(dev);
 	ast_open_key(ast);
+	ast_enable_mmio(dev);
 
 	/* Find out whether P2A works or whether to use device-tree */
 	ast_detect_config_mode(dev, &scu_rev);
@@ -576,6 +576,9 @@ void ast_driver_unload(struct drm_device *dev)
 {
 	struct ast_private *ast = dev->dev_private;
 
+	/* enable standard VGA decode */
+	ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa1, 0x04);
+
 	ast_release_firmware(dev);
 	kfree(ast->dp501_fw_addr);
 	ast_mode_fini(dev);
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 8bb355d5d43d8..9d92d2d2fcfc7 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -600,7 +600,7 @@ static int ast_crtc_mode_set(struct drm_crtc *crtc,
 		return -EINVAL;
 	ast_open_key(ast);
 
-	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xa1, 0xff, 0x04);
+	ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa1, 0x06);
 
 	ast_set_std_reg(crtc, adjusted_mode, &vbios_mode);
 	ast_set_crtc_reg(crtc, adjusted_mode, &vbios_mode);
diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index f7d421359d564..c1d1ac51d1c20 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -46,7 +46,7 @@ void ast_enable_mmio(struct drm_device *dev)
 {
 	struct ast_private *ast = dev->dev_private;
 
-	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xa1, 0xff, 0x04);
+	ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa1, 0x06);
 }
 
 
-- 
2.20.1

