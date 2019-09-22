Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A663AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7265D20869
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180020;
	bh=v/u1Iz8T80+S4fVd/NZlnqqp6RZbt6F/93nimMQN/fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ohCCHTUPaTjv5d8ENnherkRz7vbvrqCnWnsltvHRMGIw2CRJ1I+OQoNhg/uClVzfV
	 ql7DyGJ4sZQhLg/ZNK7+onrTPhxNNmnZgko9fezXnAsQD+LiVYqU6JTqUH3uC9YmYy
	 ePvo7vuClyfksxMeZF5lToDvqBOuemkCSCpO47tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437546AbfIVTUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407997AbfIVSye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:54:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08758208C2;
        Sun, 22 Sep 2019 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178473;
        bh=v/u1Iz8T80+S4fVd/NZlnqqp6RZbt6F/93nimMQN/fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=encYF3cy/yZXVW+VcFvwvIWSl8Z2xOeXcN5xcNuKmSz+VqyLQj7Y8mkFtlYkXcS6O
         MSM/Q9xOYffYmRLopaqTAXVXE6u2oswMEOGoi71mmGWWtDp/rzX4YY5B3ahECdlqjk
         H0V9ldckbt84hpNYz3XO2voGJWvj+kScrhS8EFhc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
        syzbot+aac8d0d7205f112045d2@syzkaller.appspotmail.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 012/128] media: hdpvr: Add device num check and handling
Date:   Sun, 22 Sep 2019 14:52:22 -0400
Message-Id: <20190922185418.2158-12-sashal@kernel.org>
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
index 29ac7fc5b039f..46adee95f89d5 100644
--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -275,6 +275,7 @@ static int hdpvr_probe(struct usb_interface *interface,
 #endif
 	size_t buffer_size;
 	int i;
+	int dev_num;
 	int retval = -ENOMEM;
 
 	/* allocate memory for our device state and initialize it */
@@ -372,8 +373,17 @@ static int hdpvr_probe(struct usb_interface *interface,
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

