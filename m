Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC399C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DA1207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wYf8WqEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439527AbfIYPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:21:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43734 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfIYPVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:21:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8PFKv3D020877;
        Wed, 25 Sep 2019 10:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569424857;
        bh=No1VQ/vsriU6toIgX0h2NbXh6rH+rv1qbGaRk8UeiyI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wYf8WqEtGD2kPLtiqdkrq4/T1fHGULgsiINISFiDg/U5Rs+8/1rXC4tcUcZDGQBlE
         xKz1qz1zy/4re3EfLHpScV1QZA38i+A2v/qmxZ16d6gT9VS5s480hExqWZe9YtEixk
         smMcYPYyviYhojticOU9YGr6jMe8XxQNmhkDqsDc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8PFKvu3128775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Sep 2019 10:20:57 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 25
 Sep 2019 10:20:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 25 Sep 2019 10:20:57 -0500
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8PFKssq047659;
        Wed, 25 Sep 2019 10:20:57 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch 3/3] media: ov5640: Make 2592x1944 mode only available at 15 fps
Date:   Wed, 25 Sep 2019 10:23:01 -0500
Message-ID: <20190925152301.21645-4-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925152301.21645-1-bparrot@ti.com>
References: <20190925152301.21645-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sensor data sheet clearly state that 2592x1944 only works at 15 fps
make sure we don't try to miss configure the pll out of acceptable
range.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/i2c/ov5640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index aa56a5a93283..3c9e61f948a5 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1614,6 +1614,11 @@ ov5640_find_mode(struct ov5640_dev *sensor, enum ov5640_frame_rate fr,
 	    !(mode->hact == 640 && mode->vact == 480))
 		return NULL;
 
+	/* 2592x1944 only works at 15fps */
+	if (fr != OV5640_15_FPS &&
+	    (mode->hact == 2592 && mode->vact == 1944))
+		return NULL;
+
 	return mode;
 }
 
-- 
2.17.1

