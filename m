Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3379C4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C1F20869
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179774;
	bh=IlEu+QND5GqugmZVtRKtyvAk+exItV+okO2D3Dg7m6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mOImMZ7Ox+e5q0XglHPGGc/TeJCJNLon80q5/0AxgsKj277/XzX8nDDBRRTnvcRfU
	 yGW0b8e4e8lYZM6uMr5ayKBEiM7MUzKweBjrd7kTuFqJDHIQX2lFLKEHU9uFPROroi
	 Vlb8AN9Kl+HW0S6xPot4OwBSawGEByX/aqDGoZ9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438515AbfIVS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438471AbfIVS4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:56:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9252184D;
        Sun, 22 Sep 2019 18:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178566;
        bh=IlEu+QND5GqugmZVtRKtyvAk+exItV+okO2D3Dg7m6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1oyu0j14ZIa9xNIRj/EVHo0E7tAs4vS3+JmO7UiEZmYVYM5bImXoQj7nX8Rtb42l
         pPJiqtpc2IvrryaIlGN9bm29O4z/793f1hY73xEM4Ry3j7sOFY9DIO1eeO8yeQRKUP
         p2g/ES0izHtrwdUHGDbhnVNymB7B2xT2NBxi2Qvg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 079/128] media: cpia2_usb: fix memory leaks
Date:   Sun, 22 Sep 2019 14:53:29 -0400
Message-Id: <20190922185418.2158-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 1c770f0f52dca1a2323c594f01f5ec6f1dddc97f ]

In submit_urbs(), 'cam->sbuf[i].data' is allocated through kmalloc_array().
However, it is not deallocated if the following allocation for urbs fails.
To fix this issue, free 'cam->sbuf[i].data' if usb_alloc_urb() fails.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/cpia2/cpia2_usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/cpia2/cpia2_usb.c b/drivers/media/usb/cpia2/cpia2_usb.c
index f5b04594e2094..4c191fcd3a7f5 100644
--- a/drivers/media/usb/cpia2/cpia2_usb.c
+++ b/drivers/media/usb/cpia2/cpia2_usb.c
@@ -685,6 +685,10 @@ static int submit_urbs(struct camera_data *cam)
 		if (!urb) {
 			for (j = 0; j < i; j++)
 				usb_free_urb(cam->sbuf[j].urb);
+			for (j = 0; j < NUM_SBUF; j++) {
+				kfree(cam->sbuf[j].data);
+				cam->sbuf[j].data = NULL;
+			}
 			return -ENOMEM;
 		}
 
-- 
2.20.1

