Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AB4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE11206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714056;
	bh=uWUGsKf5++BnjiYmQRr1ejbbK4d8tDhLO6rT5Vnf96c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O0Rdm0JaYGqhvi3/AtOL2SbRge7TOw9oqvI3RPkIuCWVTkUY84gRQ1FMfv/7wi3jG
	 oVtgejmyyfbgulBt6SGs3qoOdArX5VxYM5pDVi34mIspQTTfSavHJFl3HacYESYSiW
	 Vk/Obp5SkMrMKRF54bYgXLZD4W5KG5KucGzFqBCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbfC0SJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388618AbfC0SJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECC1217F5;
        Wed, 27 Mar 2019 18:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710185;
        bh=uWUGsKf5++BnjiYmQRr1ejbbK4d8tDhLO6rT5Vnf96c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zhy7U1YXh2gMNvno8MKc+FzoB6pe+sfHZXG/SQb/rhRXJ3Ywo7DLlTkemFZzqIWTv
         ii7tOPDMIfTNKouX0K5iRt+wAFA1HzcKGJrrqikD3TaQ3lIcCe3zZQDRrrnlDY+rYe
         e5OReAJY2PscoDat8n5XeIzQLNkTAtseGEJWSo2o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 241/262] drm: Auto-set allow_fb_modifiers when given modifiers at plane init
Date:   Wed, 27 Mar 2019 14:01:36 -0400
Message-Id: <20190327180158.10245-241-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit 890880ddfdbe256083170866e49c87618b706ac7 ]

When drivers pass non-empty lists of modifiers for initializing their
planes, we can infer that they allow framebuffer modifiers and set the
driver's allow_fb_modifiers mode config element.

In case the allow_fb_modifiers element was not set (some drivers tend
to set them after registering planes), the modifiers will still be
registered but won't be available to userspace unless the flag is set
later. However in that case, the IN_FORMATS blob won't be created.

In order to avoid this case and generally reduce the trouble associated
with the flag, always set allow_fb_modifiers when a non-empty list of
format modifiers is passed at plane init.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190104085610.5829-1-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 5f650d8fc66b..4cfb56893b7f 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -220,6 +220,9 @@ int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
 			format_modifier_count++;
 	}
 
+	if (format_modifier_count)
+		config->allow_fb_modifiers = true;
+
 	plane->modifier_count = format_modifier_count;
 	plane->modifiers = kmalloc_array(format_modifier_count,
 					 sizeof(format_modifiers[0]),
-- 
2.19.1

