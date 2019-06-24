Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FE3C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146842083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFXFeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:34:07 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:21082 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFXFeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:34:06 -0400
Received: from localhost.localdomain ([86.243.180.47])
        by mwinf5d04 with ME
        id UVZv2000C11lVym03VZwBJ; Mon, 24 Jun 2019 07:34:03 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Jun 2019 07:34:03 +0200
X-ME-IP: 86.243.180.47
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, tuomas.tynkkynen@iki.fi,
        inf.braun@fau.de, tobias.buettner@fau.de, hofrat@osadl.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: bcm2835-camera: Avoid apotential sleep while holding a spin_lock
Date:   Mon, 24 Jun 2019 07:33:51 +0200
Message-Id: <20190624053351.5217-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not allocate memory with GFP_KERNEL when holding a spin_lock, it may
sleep. Use GFP_NOWAIT instead.

Fixes: 950fd867c635 ("staging: bcm2835-camera: Replace open-coded idr with a struct idr.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 16af735af5c3..438d548c6e24 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -186,7 +186,7 @@ get_msg_context(struct vchiq_mmal_instance *instance)
 	 */
 	spin_lock(&instance->context_map_lock);
 	handle = idr_alloc(&instance->context_map, msg_context,
-			   0, 0, GFP_KERNEL);
+			   0, 0, GFP_NOWAIT);
 	spin_unlock(&instance->context_map_lock);
 
 	if (handle < 0) {
-- 
2.20.1

