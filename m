Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC05C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E851421019
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354605;
	bh=rYpbs0dKw7NuXQPuiS1JlwOkFwEBEGYINd5c/qDq/JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ThYDwyW104Vv0krHOPXJyGhzBHR2Jepn0R7bY7YK+ofE9PbwE1LQd10T5L1wPrVBe
	 NklgWI8xEKPsgjiD+vAet0tWICMwn+ltlc3Pg1ZDN95vQxbsJZ6HLI+S1mZtQtTQ2g
	 J+OzIdbV3vSVtAJ4skBaXJjeTVQedu3xmIEjjEt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfKJC4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbfKJCtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:49:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7C822595;
        Sun, 10 Nov 2019 02:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354184;
        bh=rYpbs0dKw7NuXQPuiS1JlwOkFwEBEGYINd5c/qDq/JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wOdY7priKmOwnQsCIxsz7B3RGXOtXrVCNR0FGfoRpe49GkA/1QPtLweJYuLqP29u
         8M/FgNKjcWLdVvrKo2Y9v3JrTpaag895fpC84+3GpCeA/BeZoQznogCa+KTg+S8LWP
         bvWjnoBjafZDIvn+hEs7rzGvyNCrhSq/LqCjHe7M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 33/66] usb: gadget: uvc: configfs: Drop leaked references to config items
Date:   Sat,  9 Nov 2019 21:48:12 -0500
Message-Id: <20191110024846.32598-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 86f3daed59bceb4fa7981d85e89f63ebbae1d561 ]

Some of the .allow_link() and .drop_link() operations implementations
call config_group_find_item() and then leak the reference to the
returned item. Fix this by dropping those references where needed.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_configfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index d7dcd39fe12cb..3803dda54666b 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -543,6 +543,7 @@ static int uvcg_control_class_allow_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
@@ -584,6 +585,7 @@ static int uvcg_control_class_drop_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
@@ -2047,6 +2049,7 @@ static int uvcg_streaming_class_allow_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
@@ -2091,6 +2094,7 @@ static int uvcg_streaming_class_drop_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
-- 
2.20.1

