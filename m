Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE4BC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFC8216C4
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994411;
	bh=SODLOIdn9sI8wnlrPYxT8P0mdlJbHUjtV6JnXpCdjGU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lhdXffV8nTXq7OyyInujsdgC46vkEHCiF6dF83mZZ/91htIi91Tyd6UjcTmQhLBJh
	 4ZREz+c2PFc/GFt8orf6ak7UEnYOZdwfLWc3ahUS0+IcTB0GmwirVXGQasOGuYkLGp
	 HhE7HQ15JL7sP8ITgvdHLsyWpx4sF1Jwi62+cbKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfFHLqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbfFHLqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:46:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F24214AF;
        Sat,  8 Jun 2019 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994408;
        bh=SODLOIdn9sI8wnlrPYxT8P0mdlJbHUjtV6JnXpCdjGU=;
        h=From:To:Cc:Subject:Date:From;
        b=zJsJ4KfVeDuxRb+iCEQjwV2KK3hv/J9VOGhE2uQtN3nd6W8FSRGfVJSn4OBjuawgs
         QzY0AC+h7ufZBBuMoDBPZSwP9ADqdxjNLvZtX6HcHjYnVTiRla0cYIKt9/+2DOTQhu
         ZIfcaZWU2YZu1T8rlgOZVJe3/VlkuO5OanOsHvmI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 01/31] Staging: vc04_services: Fix a couple error codes
Date:   Sat,  8 Jun 2019 07:46:12 -0400
Message-Id: <20190608114646.9415-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ca4e4efbefbbdde0a7bb3023ea08d491f4daf9b9 ]

These are accidentally returning positive EINVAL instead of negative
-EINVAL.  Some of the callers treat positive values as success.

Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/vc04_services/bcm2835-camera/controls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index 77a5d6f4e1eb..8a242f609d3b 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -579,7 +579,7 @@ static int ctrl_set_image_effect(struct bm2835_mmal_dev *dev,
 				dev->colourfx.enable ? "true" : "false",
 				dev->colourfx.u, dev->colourfx.v,
 				ret, (ret == 0 ? 0 : -EINVAL));
-	return (ret == 0 ? 0 : EINVAL);
+	return (ret == 0 ? 0 : -EINVAL);
 }
 
 static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
@@ -603,7 +603,7 @@ static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
 		 "%s: After: mmal_ctrl:%p ctrl id:0x%x ctrl val:%d ret %d(%d)\n",
 			__func__, mmal_ctrl, ctrl->id, ctrl->val, ret,
 			(ret == 0 ? 0 : -EINVAL));
-	return (ret == 0 ? 0 : EINVAL);
+	return (ret == 0 ? 0 : -EINVAL);
 }
 
 static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
-- 
2.20.1

