Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D73C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E011721744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641464;
	bh=Z5tRASnyDGkVhdf4+Zzm0/UlGnprXXAliUORBedtkMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1x5XbYmxk4CozkmIEc3BONWtFDX3wZdQhOTpXFcvIS699eaaiwYsFh37BD0R5tuTu
	 MR9ey9nc/BokVZEmc3rxxco4avvFf6SFQrwv7KU/5RK48ARi6J8mKEd6qqcMQg/BUs
	 OkxU3bGGIdeFUJ8Oe0rlc7SgNGooaTwPEBPsVgJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfL2RoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730666AbfL2RoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:44:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0749208C4;
        Sun, 29 Dec 2019 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641459;
        bh=Z5tRASnyDGkVhdf4+Zzm0/UlGnprXXAliUORBedtkMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEv2X8FgahPm8PkiiQAuMID9WV4CeCRgtSuo3qenYw+s7mNLDCarpN1HjjWzQfium
         AmGYYRYXBXnYEE/NftuzKJmJSIbFJ/kqRfyOerfb5jrADsq57wKxLOMhNTDK5CGe3k
         udm/6ULbc/2bXE/FOLLiLw4EtQFVJoRYF+E5BTDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 075/434] media: cedrus: fill in bus_info for media device
Date:   Sun, 29 Dec 2019 18:22:08 +0100
Message-Id: <20191229172706.617231808@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit ae0688f659adb17ae6ae5710c886b20b5406e5c4 ]

Fixes this compliance warning:

$ v4l2-compliance -m0
v4l2-compliance SHA: b514d615166bdc0901a4c71261b87db31e89f464, 32 bits

Compliance test for cedrus device /dev/media0:

Media Driver Info:
        Driver name      : cedrus
        Model            : cedrus
        Serial           :
        Bus info         :
        Media version    : 5.3.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 5.3.0

Required ioctls:
                warn: v4l2-test-media.cpp(51): empty bus_info
        test MEDIA_IOC_DEVICE_INFO: OK

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 2d3ea8b74dfd..3439f6ad6338 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -357,6 +357,8 @@ static int cedrus_probe(struct platform_device *pdev)
 
 	dev->mdev.dev = &pdev->dev;
 	strscpy(dev->mdev.model, CEDRUS_NAME, sizeof(dev->mdev.model));
+	strscpy(dev->mdev.bus_info, "platform:" CEDRUS_NAME,
+		sizeof(dev->mdev.bus_info));
 
 	media_device_init(&dev->mdev);
 	dev->mdev.ops = &cedrus_m2m_media_ops;
-- 
2.20.1



