Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9537AC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F90925A44
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191370;
	bh=n+u/WguqQF8MlrFw+6RnxXfno7gUgXsBE8I1I+UCr8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vkTfsz7D9S9ZN+zrgwiRYgX1aOfAIcQjJmyq4x55+To4mg9Nt7zSiJVp/VVUa0Voj
	 1D6W/eybMdDPaU3KR3Q9qGBKJnNz5HtfLvHYi1UywpO5jRJrOOk7CjwmT1e00PSgsp
	 rv0qNsrynJhtKSmadpdX3Oy+KQha5CgUCZ6HUiWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbfE3Emt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbfE3DMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:14 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF804244E8;
        Thu, 30 May 2019 03:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185934;
        bh=n+u/WguqQF8MlrFw+6RnxXfno7gUgXsBE8I1I+UCr8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EI6n4uFyNXvq542M58bmYcAZOyzV9fVDq2GvxtyG34qU+n+PUrBv+TUuqHU9JvWni
         dG1J1akWxgNqAsIvS/eMcsBmKQ5l1kt2CYJYwb7md73FHIANqLW/K0lMnYqiwkqige
         +PQRovN2SRYdWS5G61N9bih0QwIygrxU5H4y/9xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 288/405] media: gspca: Kill URBs on USB device disconnect
Date:   Wed, 29 May 2019 20:04:46 -0700
Message-Id: <20190530030555.440542283@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9b9ea7c2b57a0c9c3341fc6db039d1f7971a432e ]

In order to prevent ISOC URBs from being infinitely resubmitted,
the driver's USB disconnect handler must kill all the in-flight URBs.

While here, change the URB packet status message to a debug level,
to avoid spamming the console too much.

This commit fixes a lockup caused by an interrupt storm coming
from the URB completion handler.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/gspca/gspca.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index ac70b36d67b7b..128935f2a217e 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -294,7 +294,7 @@ static void fill_frame(struct gspca_dev *gspca_dev,
 		/* check the packet status and length */
 		st = urb->iso_frame_desc[i].status;
 		if (st) {
-			pr_err("ISOC data error: [%d] len=%d, status=%d\n",
+			gspca_dbg(gspca_dev, D_PACK, "ISOC data error: [%d] len=%d, status=%d\n",
 			       i, len, st);
 			gspca_dev->last_packet_type = DISCARD_PACKET;
 			continue;
@@ -1638,6 +1638,8 @@ void gspca_disconnect(struct usb_interface *intf)
 
 	mutex_lock(&gspca_dev->usb_lock);
 	gspca_dev->present = false;
+	destroy_urbs(gspca_dev);
+	gspca_input_destroy_urb(gspca_dev);
 
 	vb2_queue_error(&gspca_dev->queue);
 
-- 
2.20.1



