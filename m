Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F1DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5038214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180553;
	bh=u/cx5Fx7ocHi7GpON+az0NLHqlFEw3vSZrk3Gb0TNFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCiMF2DuQAYIlSntyiVo5x/2wJmFWrm49lGL1WsdghcXR9LpooKSkBHrf9/3M/m6H
	 8WJaZrj7n8gfHn+4Ha5lb/PJgEtopBTzPGgZWzHHavXbVyLKyoS+qqkwENQcEsIP6r
	 EcOsanZ1J7erBVB/UOlev2P8yGBlV/C5PU8WcmZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392890AbfIVSuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388582AbfIVSuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:50:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A193521D56;
        Sun, 22 Sep 2019 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178213;
        bh=u/cx5Fx7ocHi7GpON+az0NLHqlFEw3vSZrk3Gb0TNFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8CQUJmipPz4vbrwZFv/BgPoo5HM0HVkeQ9UoDC43OiUa7fWMJ+1qLTxCu13CqsC2
         9GbwUPJIHZNxHy6jI/JYNfc+ygCVZJ2LlU+dOBfko5ynP8CfhKL/KYbOVS91tfQ13V
         oiTJv/pejjJ9B5XuUIbhmHNtk7u1CaDN2+6MlFY8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
        syzbot+aac8d0d7205f112045d2@syzkaller.appspotmail.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 019/185] media: hdpvr: Add device num check and handling
Date:   Sun, 22 Sep 2019 14:46:37 -0400
Message-Id: <20190922184924.32534-19-sashal@kernel.org>
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

From: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>

[ Upstream commit d4a6a9537bc32811486282206ecfb7c53754b74d ]

Add hdpvr device num check and error handling

We need to increment the device count atomically before we checkout a
device to make sure that we do not reach the max count, otherwise we get
out-of-bounds errors as reported by syzbot.

Reported-and-tested-by: syzbot+aac8d0d7205f112045d2@syzkaller.appspotmail.com

Signed-off-by: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/hdpvr/hdpvr-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-core.c b/drivers/media/usb/hdpvr/hdpvr-core.c
index 9b9d894d29bcb..a0905c81d2cb2 100644
--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -271,6 +271,7 @@ static int hdpvr_probe(struct usb_interface *interface,
 #endif
 	size_t buffer_size;
 	int i;
+	int dev_num;
 	int retval = -ENOMEM;
 
 	/* allocate memory for our device state and initialize it */
@@ -368,8 +369,17 @@ static int hdpvr_probe(struct usb_interface *interface,
 	}
 #endif
 
+	dev_num = atomic_inc_return(&dev_nr);
+	if (dev_num >= HDPVR_MAX) {
+		v4l2_err(&dev->v4l2_dev,
+			 "max device number reached, device register failed\n");
+		atomic_dec(&dev_nr);
+		retval = -ENODEV;
+		goto reg_fail;
+	}
+
 	retval = hdpvr_register_videodev(dev, &interface->dev,
-				    video_nr[atomic_inc_return(&dev_nr)]);
+				    video_nr[dev_num]);
 	if (retval < 0) {
 		v4l2_err(&dev->v4l2_dev, "registering videodev failed\n");
 		goto reg_fail;
-- 
2.20.1

