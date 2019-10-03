Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA8FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE022133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119475;
	bh=vJKFOdMHhMYIRmfZn3Kky3KbozDQMjZPWqMyn6/4Bbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jMerhSjYtXIzlpismCxI6jTm+rP13yCdxEeTuyo9Lp6pLXNA+wGzABNmmBuf+jb+7
	 D7IZYtRNosdsJSliJtXo0ls16NEQM0ob8n70mxs67xLASgKj9vSt2CsognUYg+yMbH
	 sI+K1BSCh91wmCNq+SZRO9CqQ908KjJ8G6FvEoFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbfJCQRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389315AbfJCQRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:17:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 881F12133F;
        Thu,  3 Oct 2019 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119466;
        bh=vJKFOdMHhMYIRmfZn3Kky3KbozDQMjZPWqMyn6/4Bbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gaw6vlqFAk8cNrLL9gxLzABoQwD/QELfSyKXLUGROjgBHWOLWdOWR+++cnPfBlFOJ
         w1iO0BZ7S1U4wyrFIieRRB0Il3or+8Kifm9QHAsBF6krMm7+lbUDnJndSl/LUpQyqp
         hSsNR3cpXBHcl0mYEwh0lrA1UQTGM7fApu6ACax8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/211] media: i2c: ov5640: Check for devm_gpiod_get_optional() error
Date:   Thu,  3 Oct 2019 17:51:42 +0200
Message-Id: <20191003154455.341506213@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
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
index d5c0ffc55d46a..a3bbef682fb8e 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -2787,9 +2787,14 @@ static int ov5640_probe(struct i2c_client *client,
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



