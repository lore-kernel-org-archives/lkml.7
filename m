Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DC2C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7768220657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921564;
	bh=X9ywAzZBUkXSlTEyua4mUfQjXW1QYxM2AGR+Qdlo5C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rQpdkz05V8jLlDlel4pRi0qxnxS2UrJtIewut5XYfXVpmTsGTRAKr4Xwh6lLR8xnn
	 LuMR3tiidLV+54b5a1iNY50tDBf29TtGm6uUYTdu9urCCnb2biBN6r+lJFny5nlEje
	 HPJmq8ReEfjY/2l9tqUIWfyZxvVkGAHVvfJIekrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfEOLPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbfEOLP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:15:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF772084F;
        Wed, 15 May 2019 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918925;
        bh=X9ywAzZBUkXSlTEyua4mUfQjXW1QYxM2AGR+Qdlo5C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwmcQaYADnmpaZL/jGNnjd2YT1Gtn1mQIR+gWYkkIkurCXB7WbcdV0g9pWpHKMGkv
         /kAoCKgY0pOuTBKB+/PJCfCRLnjg7Xr926x1vc9E1uMfqgUPVysM0XT4n6BLloZ8WR
         v6Ypp7kj/fjzIodaNr39nUNMXiVsgN6k2RgYKyac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 29/51] Input: synaptics-rmi4 - fix possible double free
Date:   Wed, 15 May 2019 12:56:04 +0200
Message-Id: <20190515090625.458047030@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.669619870@linuxfoundation.org>
References: <20190515090616.669619870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit bce1a78423961fce676ac65540a31b6ffd179e6d ]

The RMI4 function structure has been released in rmi_register_function
if error occurs. However, it will be released again in the function
rmi_create_function, which may result in a double-free bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/rmi4/rmi_driver.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -772,7 +772,7 @@ static int rmi_create_function(struct rm
 
 	error = rmi_register_function(fn);
 	if (error)
-		goto err_put_fn;
+		return error;
 
 	if (pdt->function_number == 0x01)
 		data->f01_container = fn;
@@ -780,10 +780,6 @@ static int rmi_create_function(struct rm
 	list_add_tail(&fn->node, &data->function_list);
 
 	return RMI_SCAN_CONTINUE;
-
-err_put_fn:
-	put_device(&fn->dev);
-	return error;
 }
 
 int rmi_driver_suspend(struct rmi_device *rmi_dev)


