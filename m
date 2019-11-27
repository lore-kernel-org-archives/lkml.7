Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E279FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA23C21556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889836;
	bh=+x+XccsgLC72FddcFcYE+icmwrl+wXBNOtor5imuc/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J4nOUkhT9m4b39sSnXsE/W+noBe1yfEv5mZEZAzMC1GLTkgj/nxe2hibzfG5ZAR2D
	 SpcKh0mO4YCvGdTQWFo4vkjIKhBjVWc+RX+lmnvqd1oFTE79nbBwrXXNxwPjAu21pr
	 kOBM9NVmnqEAK/fFXTe8WWpW6D0X2oe0r+1LeqD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbfK0VXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732097AbfK0VD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:03:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5602086A;
        Wed, 27 Nov 2019 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888636;
        bh=+x+XccsgLC72FddcFcYE+icmwrl+wXBNOtor5imuc/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecsfsJghBuvtV2TD1FklRfqcD952aqs5rXZ2vmlKiBpzG303RgFeeLWrBEFOLdg+2
         VIYd8nMuZFooz6uUIDRgWz4lS0zuiae4dGEGGfQiYZK5fR2SmUjtDjsVZPUXLNov/K
         FzDlXc1I/eCtKB0jPnoyDZx/hlrFhzOU/C3Dreyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 211/306] media: ov13858: Check for possible null pointer
Date:   Wed, 27 Nov 2019 21:31:01 +0100
Message-Id: <20191127203130.540872040@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>

[ Upstream commit 35629182eb8f931b0de6ed38c0efac58e922c801 ]

Check for possible null pointer to avoid crash.

Signed-off-by: Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov13858.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov13858.c b/drivers/media/i2c/ov13858.c
index 0e7a85c4996c7..afd66d243403b 100644
--- a/drivers/media/i2c/ov13858.c
+++ b/drivers/media/i2c/ov13858.c
@@ -1612,7 +1612,8 @@ static int ov13858_init_controls(struct ov13858 *ov13858)
 				OV13858_NUM_OF_LINK_FREQS - 1,
 				0,
 				link_freq_menu_items);
-	ov13858->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	if (ov13858->link_freq)
+		ov13858->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	pixel_rate_max = link_freq_to_pixel_rate(link_freq_menu_items[0]);
 	pixel_rate_min = link_freq_to_pixel_rate(link_freq_menu_items[1]);
@@ -1635,7 +1636,8 @@ static int ov13858_init_controls(struct ov13858 *ov13858)
 	ov13858->hblank = v4l2_ctrl_new_std(
 				ctrl_hdlr, &ov13858_ctrl_ops, V4L2_CID_HBLANK,
 				hblank, hblank, 1, hblank);
-	ov13858->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	if (ov13858->hblank)
+		ov13858->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	exposure_max = mode->vts_def - 8;
 	ov13858->exposure = v4l2_ctrl_new_std(
-- 
2.20.1



