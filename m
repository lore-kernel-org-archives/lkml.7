Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20569C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB13D206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207476;
	bh=OosPjHvwTCDcCL493e4pcMMUYIpLbbZEJQKoS+xNTRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qyPHuIv923AZK/yJGUY3OFqv3wWxuHI8HbEq6IZUfwP9oIHzFLgvqjbQ6NeHPT26
	 19GhDHXn7PmNejbje5V0qUOgnBo4i+xtlscKcK97WaLoginUcf8BxHdAgDzp2VZ7ht
	 8SCxvgFEeBTdlcOU3PBw4cqZDyMl6EMrbZnN5cbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfEGFhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfEGFhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:37:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F1D20578;
        Tue,  7 May 2019 05:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207469;
        bh=OosPjHvwTCDcCL493e4pcMMUYIpLbbZEJQKoS+xNTRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0b80PQtlz1LgUVNGgAUawItZ99Og40NFctscFIDLAz7uFB2eM755ATBHDmN/Ukcf
         izQpboEN8EqDp5ysc8OUeH0I9LRGd7RgJXjNQfgjugpXl/Sm5nEzCVOdbaOJURgWIK
         5ngbHef/wYdzQ6S4i119052BjyZtOmF+L90ilcd4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 60/81] Input: synaptics-rmi4 - fix possible double free
Date:   Tue,  7 May 2019 01:35:31 -0400
Message-Id: <20190507053554.30848-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit bce1a78423961fce676ac65540a31b6ffd179e6d ]

The RMI4 function structure has been released in rmi_register_function
if error occurs. However, it will be released again in the function
rmi_create_function, which may result in a double-free bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/rmi4/rmi_driver.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index fc3ab93b7aea..7fb358f96195 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -860,7 +860,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 
 	error = rmi_register_function(fn);
 	if (error)
-		goto err_put_fn;
+		return error;
 
 	if (pdt->function_number == 0x01)
 		data->f01_container = fn;
@@ -870,10 +870,6 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	list_add_tail(&fn->node, &data->function_list);
 
 	return RMI_SCAN_CONTINUE;
-
-err_put_fn:
-	put_device(&fn->dev);
-	return error;
 }
 
 void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake)
-- 
2.20.1

