Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C30AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC9520833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482876;
	bh=UJx54vdG3tFb4q1AmYj1EaZK+XwrpJW+5MD9xgrC2a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mRvhmjsgektebTcWnmnMEzvR2XIfNPuDhYt/PAxeOQ3DMr/CNtNGlA0YkEPWhYC+T
	 okQuK//ADwNjNMbGUV/4uf1hHcKQ+j1v26gNAU+KbLd6Dd49/6OHCcjJGFokrlO5Ge
	 oRht7lGFKCIzToOk8wqAigYHtXO7bdI2rTE469mY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfLDSHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbfLDSHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:07:52 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3998D206DF;
        Wed,  4 Dec 2019 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482871;
        bh=UJx54vdG3tFb4q1AmYj1EaZK+XwrpJW+5MD9xgrC2a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcOTcM8Kl+1HYgt2SN8qqd05rQdywD6bpJf7v3P6N/XKaCfe1VI/2YJbk9T7glXLt
         OPy5Lh8ECNGVVu8+HhgJPkjKik86hj/8x+rU12vOFHDah0ITN7BEbzjFMjxKMv0pWS
         L70oXvtYrJbw3cQABxV8rmWcSYsZJwaSUf1kLr/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.14 168/209] media: atmel: atmel-isc: fix INIT_WORK misplacement
Date:   Wed,  4 Dec 2019 18:56:20 +0100
Message-Id: <20191204175335.047586485@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

commit 79199002db5c571e335131856b3ff057ffd9f3c0 upstream.

In case the completion function failes, unbind will be called
which will call cancel_work for awb_work.
This will trigger a WARN message from the workqueue.
To avoid this, move the INIT_WORK call at the start of the completion
function. This way the work is always initialized, which corresponds
to the 'always canceled' unbind code.

Fixes: 93d4a26c3d ("[media] atmel-isc: add the isc pipeline function")

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/atmel/atmel-isc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -1555,6 +1555,8 @@ static int isc_async_complete(struct v4l
 	struct vb2_queue *q = &isc->vb2_vidq;
 	int ret;
 
+	INIT_WORK(&isc->awb_work, isc_awb_work);
+
 	ret = v4l2_device_register_subdev_nodes(&isc->v4l2_dev);
 	if (ret < 0) {
 		v4l2_err(&isc->v4l2_dev, "Failed to register subdev nodes\n");
@@ -1614,8 +1616,6 @@ static int isc_async_complete(struct v4l
 		return ret;
 	}
 
-	INIT_WORK(&isc->awb_work, isc_awb_work);
-
 	/* Register video device */
 	strlcpy(vdev->name, ATMEL_ISC_NAME, sizeof(vdev->name));
 	vdev->release		= video_device_release_empty;


