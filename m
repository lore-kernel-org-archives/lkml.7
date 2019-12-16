Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73ABC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762C1206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521986;
	bh=Bvqqqe3GhN6lFEa5+962rvSDLp9kezccEfUJn96dULY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Merv9iNJP+/Ly0PFLhKgmDqTfEpBV4IsRCzDdF1aBCP2QCF9qj6r8MLKB5yAQfHjQ
	 0zqhPXIl0rtGHtjkCXevypuUWmpeL7Al6556EhUz/ihCuI+JeVmKaI6mPotD8CqxzB
	 WLTkHQRu1Zlb53GGsC8H91oWPPhbn0PKj6zqxQ/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfLPSqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbfLPR4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:56:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD7621582;
        Mon, 16 Dec 2019 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518983;
        bh=Bvqqqe3GhN6lFEa5+962rvSDLp9kezccEfUJn96dULY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWOMT/thXq0QrEemMZUsoqEqSPZEfBtlNQcv792AJmu8pdQZvtmO+OTNi88IJQ2PP
         KGt8ixkjn/+1rsMZBvtdaA0xiFWtYkc0+Ic16Ko9tpUMIaY4GKmReTUeEyhSlHzrhw
         nPDxPTl2qImgJO4URO+NwEzlwMbI29m9nbOAmBJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Pape <ap@ca-pape.de>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 109/267] media: stkwebcam: Bugfix for wrong return values
Date:   Mon, 16 Dec 2019 18:47:15 +0100
Message-Id: <20191216174902.687446834@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Pape <ap@ca-pape.de>

[ Upstream commit 3c28b91380dd1183347d32d87d820818031ebecf ]

usb_control_msg returns in case of a successfully sent message the number
of sent bytes as a positive number. Don't use this value as a return value
for stk_camera_read_reg, as a non-zero return value is used as an error
condition in some cases when stk_camera_read_reg is called.

Signed-off-by: Andreas Pape <ap@ca-pape.de>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/stkwebcam/stk-webcam.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/stkwebcam/stk-webcam.c b/drivers/media/usb/stkwebcam/stk-webcam.c
index a7da1356a36ef..6992e84f8a8bb 100644
--- a/drivers/media/usb/stkwebcam/stk-webcam.c
+++ b/drivers/media/usb/stkwebcam/stk-webcam.c
@@ -164,7 +164,11 @@ int stk_camera_read_reg(struct stk_camera *dev, u16 index, u8 *value)
 		*value = *buf;
 
 	kfree(buf);
-	return ret;
+
+	if (ret < 0)
+		return ret;
+	else
+		return 0;
 }
 
 static int stk_start_stream(struct stk_camera *dev)
-- 
2.20.1



