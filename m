Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600AFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DF2206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180324;
	bh=wDcK0SuxOI7PvWtcKRyhb1YAeAPrSWo4zVxce4QENGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J9BzPz+KlJuc7O/VF8XihJ2a+Oz7iEe47DM3R+mz/H/He8GxojsvSjp1vA47Twyt8
	 VZWqLvVDhr6NTLcu+w5q+neFIAnQ/+w69Gq5uX8ePFJ5Tz9eINOovh262Ggy0p4JBY
	 LSLtcmDTJ4hnCNsQAfx2fYiN9F2+OAxwtpH94Mjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfIVTZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407860AbfIVSwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:52:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F57121A4A;
        Sun, 22 Sep 2019 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178338;
        bh=wDcK0SuxOI7PvWtcKRyhb1YAeAPrSWo4zVxce4QENGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdXFrGrhonu3teKbPiap/hAZteAIY2Fq+bNJOBMyI1M5/h/hH7U1O44dPsTAyEatL
         2k7ZHbT+MikBXZgSWBRMrYbLrXIPnp0o/KljitXngQdgz8BmS7iSCVmZgg4AeoMwPY
         NyzDK/nY2J1O0CcOxfMuo/VQ0masEyZ5fWfhKJQk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 100/185] media: dvb-core: fix a memory leak bug
Date:   Sun, 22 Sep 2019 14:47:58 -0400
Message-Id: <20190922184924.32534-100-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit fcd5ce4b3936242e6679875a4d3c3acfc8743e15 ]

In dvb_create_media_entity(), 'dvbdev->entity' is allocated through
kzalloc(). Then, 'dvbdev->pads' is allocated through kcalloc(). However, if
kcalloc() fails, the allocated 'dvbdev->entity' is not deallocated, leading
to a memory leak bug. To fix this issue, free 'dvbdev->entity' before
returning -ENOMEM.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index a3393cd4e584f..7557fbf9d3068 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -339,8 +339,10 @@ static int dvb_create_media_entity(struct dvb_device *dvbdev,
 	if (npads) {
 		dvbdev->pads = kcalloc(npads, sizeof(*dvbdev->pads),
 				       GFP_KERNEL);
-		if (!dvbdev->pads)
+		if (!dvbdev->pads) {
+			kfree(dvbdev->entity);
 			return -ENOMEM;
+		}
 	}
 
 	switch (type) {
-- 
2.20.1

