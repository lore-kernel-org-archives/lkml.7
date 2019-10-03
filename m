Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EABFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5AB21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118934;
	bh=VBJNM2vTUgCaLDng6wOKnNX5G5DEU3d89JMapHsEbvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WS0NcEZla7ttYe7aFBNbhTBwbwfhBsN3g2OjG/nLrdiLnzhxmGa9yHASyOntlk7+M
	 dKl0SEYyqIJLPfdxWH70n6N4n7BAOwxyoJ4gxztN39T+FNg5A0XMq7VfUA/8q8DFEB
	 vgaUXJfJmVxAJCV3t6EVLNsP9Sin7R9kiojOC0oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfJCQIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731439AbfJCQIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:08:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFFE20865;
        Thu,  3 Oct 2019 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118930;
        bh=VBJNM2vTUgCaLDng6wOKnNX5G5DEU3d89JMapHsEbvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXsq78dWxITJ3sQVCeqXvoOu63a3NfM6WTCrWqT11T38grg53gfwF4IaO34Psqt5Y
         +JNezUAA+Gw98dy2Hd3dfDLw/GkHdn/Ja9T3NRiuI8qRLr7GDi+fNX4CPsFgk4RxPc
         A2HsB8+IwLQ2xV7aaRuszWW8qb1Lziz9ylvRZ5Jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 062/185] media: i2c: ov5640: Check for devm_gpiod_get_optional() error
Date:   Thu,  3 Oct 2019 17:52:20 +0200
Message-Id: <20191003154451.282144792@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 8791a102ce579346cea9d2f911afef1c1985213c ]

The power down and reset GPIO are optional, but the return value
from devm_gpiod_get_optional() needs to be checked and propagated
in the case of error, so that probe deferral can work.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index acf5c8a55bbd2..69f564b0837a7 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -2261,9 +2261,14 @@ static int ov5640_probe(struct i2c_client *client,
 	/* request optional power down pin */
 	sensor->pwdn_gpio = devm_gpiod_get_optional(dev, "powerdown",
 						    GPIOD_OUT_HIGH);
+	if (IS_ERR(sensor->pwdn_gpio))
+		return PTR_ERR(sensor->pwdn_gpio);
+
 	/* request optional reset pin */
 	sensor->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						     GPIOD_OUT_HIGH);
+	if (IS_ERR(sensor->reset_gpio))
+		return PTR_ERR(sensor->reset_gpio);
 
 	v4l2_i2c_subdev_init(&sensor->sd, client, &ov5640_subdev_ops);
 
-- 
2.20.1



