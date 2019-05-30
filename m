Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C015C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF3825242
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189740;
	bh=C1aHfw0Q7zVSrkpSO8pPer+mYBC/MxfNZLuffaxO7RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f4UMkGf3OJz74lF6rI4OTET7DsPmgS2tIJYtLUGqqd4nBJDFXMIFlj+TWxfB2+b4q
	 KYb5o7qy40EL2pNouF7ChZQOGGekY/IS+TWlfdz9trFYDOQ3rDGxVZQUMW0rh2eXfB
	 2SKyS6gXeiNLKamKa8eZtUN+VLj1YsGQClQXaAuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfE3EPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbfE3DP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:59 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1378C245A9;
        Thu, 30 May 2019 03:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186159;
        bh=C1aHfw0Q7zVSrkpSO8pPer+mYBC/MxfNZLuffaxO7RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRjAo5HJFjSHcYPQ+fnVffBaEr5Jm+csQl7qeW+hyIfDkhOKChXJbuuxgyt+O4vjJ
         raz9JTB6+0OtpcdHk3STyaa/uo9OyfpYBsVYg8EbPkUsD4bgwOex5Zj326J608Y3O9
         POpIvscMV4U6XiG7cntYVEpXEPBYNRJkSQkQe1YM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 308/346] media: vimc: zero the media_device on probe
Date:   Wed, 29 May 2019 20:06:21 -0700
Message-Id: <20190530030556.437436593@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f74267b51cb36321f777807b2e04ca02167ecc08 ]

The media_device is part of a static global vimc_device struct.
The media framework expects this to be zeroed before it is
used, however, since this is a global this is not the case if
vimc is unbound and then bound again.

So call memset to ensure any left-over values are cleared.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vimc/vimc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/vimc/vimc-core.c b/drivers/media/platform/vimc/vimc-core.c
index ce809d2e3d537..64eb424c15ab9 100644
--- a/drivers/media/platform/vimc/vimc-core.c
+++ b/drivers/media/platform/vimc/vimc-core.c
@@ -303,6 +303,8 @@ static int vimc_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "probe");
 
+	memset(&vimc->mdev, 0, sizeof(vimc->mdev));
+
 	/* Create platform_device for each entity in the topology*/
 	vimc->subdevs = devm_kcalloc(&vimc->pdev.dev, vimc->pipe_cfg->num_ents,
 				     sizeof(*vimc->subdevs), GFP_KERNEL);
-- 
2.20.1



