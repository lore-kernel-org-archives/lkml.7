Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBE7C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC49D215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355541;
	bh=Iu7gAt/xIf/ir9J21Ao8/LJXs4C083qHyOe+HTPl+4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZY7lVsvQCtIT+VE3OqfxmY4vnx8gosrUyyFpkRLXbWyY6adxuFlS5zBrpCfpVSius
	 L91CerJLtVV8Nm1jF9HwgSiBiCcaZSNSuM4XwJTXRf08+mCbkTLVwg0UUsylWa+dKm
	 GPalyfa47uJiTNzqm66nGubbaTHCx+Bi1QC7aLVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfKJDMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfKJCnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 003E421848;
        Sun, 10 Nov 2019 02:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353799;
        bh=Iu7gAt/xIf/ir9J21Ao8/LJXs4C083qHyOe+HTPl+4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGiIz0guqgvYNa+tPIBux0T82KSYSIGxg5+FC06vp+jkwKXBMl7Ik0lpitg+aTd/L
         CeZcOo7qbPzGJm3vh7otFJZYt73USU1T977VbgsykQEdC48OMv92aAVgfx0k1BFU9q
         vCnipuj86A0dnGkYHMOnKts05EJv6Q3EGOHwU4Ok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joel Pepper <joel.pepper@rwth-aachen.de>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 098/191] usb: gadget: uvc: configfs: Prevent format changes after linking header
Date:   Sat,  9 Nov 2019 21:38:40 -0500
Message-Id: <20191110024013.29782-98-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
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
index dc4edba95a478..9478a7cdb1433 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -766,6 +766,7 @@ static int uvcg_streaming_header_allow_link(struct config_item *src,
 	format_ptr->fmt = target_fmt;
 	list_add_tail(&format_ptr->entry, &src_hdr->formats);
 	++src_hdr->num_fmt;
+	++target_fmt->linked;
 
 out:
 	mutex_unlock(&opts->lock);
@@ -803,6 +804,8 @@ static void uvcg_streaming_header_drop_link(struct config_item *src,
 			break;
 		}
 
+	--target_fmt->linked;
+
 out:
 	mutex_unlock(&opts->lock);
 	mutex_unlock(su_mutex);
-- 
2.20.1

