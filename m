Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B25C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1B4206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQFRP4vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfG2KOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:14:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34384 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:14:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so27785020pfo.1;
        Mon, 29 Jul 2019 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GbFn4obvpalB5w/Xt+sl4gq+abdT8/92+i83jlpQ9tY=;
        b=gQFRP4vf+DTa2WwHXpt4Vzz8VQ1mleS775ULZE2B3aXf3aBEcV9Jx0nfCMVIyvxFOP
         bkY2b2S9yGzaUBa8Sss1LB/lcYJCotjMPOG9dl/I8RsZQsx2GedGIB/O+UWqoDwfqPm5
         6fWO5gUdTyuKRMdvZW/9Elvgs9M7DwQ2nFmiJPzd/Hf3d5wBXWD7iTZJqlj0Pvt/cJd+
         FfNiAK/hXY41GJSNZEJtyvj5R6UxkIezj54QGU1hEiEAPkciCbh+cCcCrUU+YK5pURYa
         nQrTKYK6QJi/03iZjIPRSP6s/t2DSNGgI2R5kFdT6r+/hqZCKTbu6N1VZYQG7/RDkVgl
         4yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GbFn4obvpalB5w/Xt+sl4gq+abdT8/92+i83jlpQ9tY=;
        b=ZneaCZMFrJNzz8LgSwFj18cw8cnSQZ6t/p3EC3OC1NOdVLqNF3CWbNXCjfirNWQmYP
         GuAYPMwRHR1E2b/Fxh1THLyzKnt5HUL5DE9TUSdjCbDBYgfg7Jv3crJR5M+QPdfpWUG3
         Eehsb6G2CQQa3gWH/fDQhEXLkoQuJYCs7dSQKCFWMng9WW/hXJ7lT7HvgLKk1fHHMy3R
         LVjTjBYLZ1b4LWZU5LHREOV4CUNK8AWTPBAIz+T+ghyjmWVlU3K5SR9WZ/OR3ISVgwu6
         zlETN6TTkT4DhrJaH29MhE597b1ZUSQPqLETX4A9ELBrA5Zz1Mxo2290VW3HzY7LVAMP
         eHeQ==
X-Gm-Message-State: APjAAAXC0AnGiR8uSZroz3OI+hWVs44GOMXOraNV2/eLM2qzIyRTMNyA
        mpwJeZmbL8y8kKiB1zISsZc=
X-Google-Smtp-Source: APXvYqwlmDfFBmYBWfMitNvfMIfBOlhro1Re+rdnGNnZks/VV0r4hw/CNy2brXFn6hvrtul6ImASzQ==
X-Received: by 2002:a62:6d84:: with SMTP id i126mr35016137pfc.129.1564395290695;
        Mon, 29 Jul 2019 03:14:50 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id o129sm32187330pfg.1.2019.07.29.03.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:14:50 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     crope@iki.fi, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: usb: msi2500: Fix a possible null-pointer dereference in msi2500_stop_streaming()
Date:   Mon, 29 Jul 2019 18:14:44 +0800
Message-Id: <20190729101444.2191-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In msi2500_stop_streaming(), there is an if statement on line 870 to
check whether dev->udev is NULL:
    if (dev->udev)

When dev->udev is NULL, it is used on line 877:
    msi2500_ctrl_msg(dev, CMD_STOP_STREAMING, 0)
        usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0), ...)

Thus, a possible null-pointer dereference may occur.

To fix this bug, dev->udev is checked before calling msi2500_ctrl_msg().

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/usb/msi2500/msi2500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 4c9b2a12acfb..a6ecd9bd35f9 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -874,7 +874,7 @@ static void msi2500_stop_streaming(struct vb2_queue *vq)
 
 	/* according to tests, at least 700us delay is required  */
 	msleep(20);
-	if (!msi2500_ctrl_msg(dev, CMD_STOP_STREAMING, 0)) {
+	if (dev->udev && !msi2500_ctrl_msg(dev, CMD_STOP_STREAMING, 0)) {
 		/* sleep USB IF / ADC */
 		msi2500_ctrl_msg(dev, CMD_WREG, 0x01000003);
 	}
-- 
2.17.0

