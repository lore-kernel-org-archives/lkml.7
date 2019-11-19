Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4AEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82222231C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lmcoumEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfKSOmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:42:06 -0500
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:41600 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728197AbfKSOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:42:02 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 147B1C2579;
        Tue, 19 Nov 2019 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1574174521; bh=ZWkYMPU199Ha5+2VkQ3merzs8RQFTg9Z2C7vXwrjAQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmcoumEql73Gt7gufxFUVndk5tPFqX+lygXfzwoBF5sAlyK34XuAUEuniDepeeIVX
         se9xf6g76XsP52MNWxZWbGeabdePfaS8rRIXFg7y6f+xOo+8+U/bplGUkA5NS0wvLQ
         q/2l6tqvtnxvOeahJQRx4v8JzCIUD18otbF0ul8ytbgJzBFEMNzsVkwao4ALij3A2W
         zmIPiHfjY/yBmhfsjGJYq+7MDjjASlo4wO62jiz0ooKt6oP9e0BkhVMpVII4bPSRNl
         hyP+EYYL6Y9uU5pmN59lohBQfUR8oP7s9PkTBhKjI7dyXtfRzxW6BYcC4HDusPsNZs
         9Zj28YXRD1l1w==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4EED4A006A;
        Tue, 19 Nov 2019 14:41:54 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 4/4] DRM: ARC: PGU: add ARGB8888 format to supported format list
Date:   Tue, 19 Nov 2019 17:41:47 +0300
Message-Id: <20191119144147.8022-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119144147.8022-1-Eugeniy.Paltsev@synopsys.com>
References: <20191119144147.8022-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we ignore first 8 bit of 32 bit pixel value we can add ARGB8888
format as alias of XRGB8888.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/arc/arcpgu_crtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/arcpgu_crtc.c
index 980e00180e6f..8ae1e1f97a73 100644
--- a/drivers/gpu/drm/arc/arcpgu_crtc.c
+++ b/drivers/gpu/drm/arc/arcpgu_crtc.c
@@ -23,6 +23,7 @@
 static const u32 arc_pgu_supported_formats[] = {
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
 };
 
 static void arc_pgu_set_pxl_fmt(struct drm_crtc *crtc)
-- 
2.21.0

