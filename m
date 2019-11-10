Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCECC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C18B206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354306;
	bh=mktJUJG+D5qRijgSuyvrIPcvNzAZZljrj2EAqWnisME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LocIxiVvFU8CFsrUcMsWLVNW/vGc+VPva4+4+wlB0rbxfrVWImuyYYaojvkVcf8kC
	 445y/ORhqZa6c8TD1J0KWxJKw5646H53PoU3XsRQpm4c1EjcZkcK/zp+TPmjdO5lS1
	 SQ2ubIcDVOAq+PPs9kW5KdfX/JdMz+d++rFnY6u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfKJCvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:51:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfKJCvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:51:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32DF225AD;
        Sun, 10 Nov 2019 02:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354285;
        bh=mktJUJG+D5qRijgSuyvrIPcvNzAZZljrj2EAqWnisME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pe9JaCpcEZ3lnSG3QTongRXiLW0m+SeLzdEjUqm4ZoXZt8mZD5jq/WbnSu95JVrjc
         3O+VXmnalzAzUnSEksQAU3YoWNIA+wCFE4ywOz9NbhqVGYokA4h9p6c0xuCvVM52Ww
         dYCgC/0YRICxYM75kGckvQ2hNdtR9WCkdp/2MfdE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joel Pepper <joel.pepper@rwth-aachen.de>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 27/40] usb: gadget: uvc: configfs: Prevent format changes after linking header
Date:   Sat,  9 Nov 2019 21:50:19 -0500
Message-Id: <20191110025032.827-27-sashal@kernel.org>
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

From: Joel Pepper <joel.pepper@rwth-aachen.de>

[ Upstream commit cb2200f7af8341aaf0c6abd7ba37e4c667c41639 ]

While checks are in place to avoid attributes and children of a format
being manipulated after the format is linked into the streaming header,
the linked flag was never actually set, invalidating the protections.
Update the flag as appropriate in the header link calls.

Signed-off-by: Joel Pepper <joel.pepper@rwth-aachen.de>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_configfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 74df80a25b469..a49ff1f5c0f93 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -807,6 +807,7 @@ static int uvcg_streaming_header_allow_link(struct config_item *src,
 	format_ptr->fmt = target_fmt;
 	list_add_tail(&format_ptr->entry, &src_hdr->formats);
 	++src_hdr->num_fmt;
+	++target_fmt->linked;
 
 out:
 	mutex_unlock(&opts->lock);
@@ -845,6 +846,8 @@ static int uvcg_streaming_header_drop_link(struct config_item *src,
 			break;
 		}
 
+	--target_fmt->linked;
+
 out:
 	mutex_unlock(&opts->lock);
 	mutex_unlock(su_mutex);
-- 
2.20.1

