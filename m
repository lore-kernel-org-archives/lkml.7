Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D3C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE4021019
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354339;
	bh=Z3B7D3+uaqNDpRyp+ET37rUjXSdTsGggSNaeoRrbI+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PAuV4Zs7SSGWLwZy/7dDie4S0hbD9bPXvY29RaaMNDG/bpq0GbV8WtLOotu7HLpdv
	 xHDeLkWdQaAV/qpzMarjshr+SYgI/uNqojQs1bB12OLQ2ycsCi8RqhRgXkw6Z7m/S9
	 6eQuoS3EcGgLVA90dTRuagB2SPME+B4jGQu5ohuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfKJCvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbfKJCvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:51:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C466229EF;
        Sun, 10 Nov 2019 02:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354284;
        bh=Z3B7D3+uaqNDpRyp+ET37rUjXSdTsGggSNaeoRrbI+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8a7ETxo40f5PTqGP3e3l2gHqBcAo67VPVW8F7tfpF0Tm+oaC6lz9R/YeO8QqMg4N
         DbNLOzLJmKMSSLC5FTZfsbd0nw0CEal+oQoBi4zrajrlk5Ur7SoYB8imc6ZZUzG+Cl
         m582Ll+gUpTasbyyafAeQQoi03FTGhcbJa0p9r0Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 26/40] usb: gadget: uvc: configfs: Drop leaked references to config items
Date:   Sat,  9 Nov 2019 21:50:18 -0500
Message-Id: <20191110025032.827-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110025032.827-1-sashal@kernel.org>
References: <20191110025032.827-1-sashal@kernel.org>
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
index 01656f1c6d650..74df80a25b469 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -564,6 +564,7 @@ static int uvcg_control_class_allow_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
@@ -605,6 +606,7 @@ static int uvcg_control_class_drop_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
@@ -2087,6 +2089,7 @@ static int uvcg_streaming_class_allow_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
@@ -2131,6 +2134,7 @@ static int uvcg_streaming_class_drop_link(struct config_item *src,
 unlock:
 	mutex_unlock(&opts->lock);
 out:
+	config_item_put(header);
 	mutex_unlock(su_mutex);
 	return ret;
 }
-- 
2.20.1

