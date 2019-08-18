Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D604C3A59B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 03:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E98A21019
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 03:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfHRDpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 23:45:49 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41134 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfHRDps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 23:45:48 -0400
Received: by mail-yb1-f196.google.com with SMTP id n7so3255299ybd.8;
        Sat, 17 Aug 2019 20:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w1MBOJKPWwd/x/PvHJlxbST3O7JCpKcUgtndmXHLa3U=;
        b=mmpE+tYcVDzsX1wZpNV/d0uM3yTuDiCuvV9Ymc6F6Hqz9VBC8PE/bKwbziHTddJ8/I
         PoSK5nwkMHOsLuKACiKSBMacJdSjnBrrcNfT4jlaMv7yTr9W9pO++m3pgdUU/rWIEyxH
         /xkg385wYz7rVibfyS9xWoCQhT64Ip1nVSVNZ3Eo6wYzcJjL8La2k6kkRZgsQZRv3hrX
         keEWItJWK66BEouYSsz3CZ+8T4PqFW3+kL5xFarqkhjF9C+By6JjiC+B5uOTVdtLJHLj
         vuCcp2OL9VNPvH/U3Ti56CktyRh1fUVTrgZ8L/cQcSc1ypnJoLLRMcAGHk8A7qrh8kwg
         YODw==
X-Gm-Message-State: APjAAAUH01BK1ApCVK0q1uUg25aU4Bw8t19H6lRH3g58I2udxk8VH5tF
        G/WLltk9IIpWQ9MtV2JwH0M=
X-Google-Smtp-Source: APXvYqya9QoPycBBU+7kZ1Rj/p+6jl2cXHRThkFsYEB2x/U4oy/x4fJvRGKIEgi1b4/k4b0Pg63PDQ==
X-Received: by 2002:a25:7083:: with SMTP id l125mr12641443ybc.449.1566099948013;
        Sat, 17 Aug 2019 20:45:48 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id k11sm3132216ywk.42.2019.08.17.20.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 20:45:46 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kees Cook <keescook@chromium.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: dvb-core: fix a memory leak bug
Date:   Sat, 17 Aug 2019 22:45:40 -0500
Message-Id: <1566099942-2290-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dvb_create_media_entity(), 'dvbdev->entity' is allocated through
kzalloc(). Then, 'dvbdev->pads' is allocated through kcalloc(). However, if
kcalloc() fails, the allocated 'dvbdev->entity' is not deallocated, leading
to a memory leak bug. To fix this issue, free 'dvbdev->entity' before
returning -ENOMEM.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/media/dvb-core/dvbdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index a3393cd..7557fbf 100644
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
2.7.4

