Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F3C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199F420856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfGYTkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:40:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfGYTkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:40:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7815A3086262;
        Thu, 25 Jul 2019 19:40:17 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF28620CE;
        Thu, 25 Jul 2019 19:40:14 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau: Fix missing elses in g94_i2c_aux_xfer
Date:   Thu, 25 Jul 2019 15:40:00 -0400
Message-Id: <20190725194005.16572-2-lyude@redhat.com>
In-Reply-To: <20190725194005.16572-1-lyude@redhat.com>
References: <20190725194005.16572-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 25 Jul 2019 19:40:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks rather unintentional!

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
index c8ab1b5741a3..9bc9eac08789 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
@@ -138,9 +138,9 @@ g94_i2c_aux_xfer(struct nvkm_i2c_aux *obj, bool retry,
 		if ((stat & 0x000f0000) == 0x00080000 ||
 		    (stat & 0x000f0000) == 0x00020000)
 			ret = 1;
-		if ((stat & 0x00000100))
+		else if ((stat & 0x00000100))
 			ret = -ETIMEDOUT;
-		if ((stat & 0x00000e00))
+		else if ((stat & 0x00000e00))
 			ret = -EIO;
 
 		AUX_TRACE(&aux->base, "%02d %08x %08x", retries, ctrl, stat);
-- 
2.21.0

