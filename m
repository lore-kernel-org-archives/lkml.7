Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805AA20650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbfJOOLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:11:31 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49522 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731977AbfJOOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:11:30 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKNXp-0004MO-H9; Tue, 15 Oct 2019 15:11:25 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKNXp-0000KZ-2h; Tue, 15 Oct 2019 15:11:25 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/hwmon: fix use of integer as a pointer
Date:   Tue, 15 Oct 2019 15:11:23 +0100
Message-Id: <20191015141123.1226-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The special_groups[] in nouveau_hwmon_init() is an
array of pointers, so use NULL instead of '0' as
the initialiser.

Fixes the following sparse warning:

drivers/gpu/drm/nouveau/nouveau_hwmon.c:744:29: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index d445c6f3fece..1c3104d20571 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -741,7 +741,7 @@ nouveau_hwmon_init(struct drm_device *dev)
 			special_groups[i++] = &pwm_fan_sensor_group;
 	}
 
-	special_groups[i] = 0;
+	special_groups[i] = NULL;
 	hwmon_dev = hwmon_device_register_with_info(dev->dev, "nouveau", dev,
 							&nouveau_chip_info,
 							special_groups);
-- 
2.23.0

