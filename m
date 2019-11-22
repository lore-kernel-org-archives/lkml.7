Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58463C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3195B20707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419013;
	bh=mktJUJG+D5qRijgSuyvrIPcvNzAZZljrj2EAqWnisME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0vEkZGJN/IWLrIZZTua4pGj8lE9PG+KNlS75DOpjaBEktyQ7eYUBDayHfzjLlpnYB
	 VoZj5IK/5DPNModWrCnD+Uiw8pX7/ZJU9UBR03YjTV5iDpW3q9+Njfim+Rp/b38ASC
	 dteNBrqafU5rRhCvW9RXf2PXd8o4X48Ef4oaNKzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfKVKgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbfKVKgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:36:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7FF720717;
        Fri, 22 Nov 2019 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419009;
        bh=mktJUJG+D5qRijgSuyvrIPcvNzAZZljrj2EAqWnisME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=raNUulwF0OGfz16kyZwI2KOSM8SqRmFaYyd4Y3TbAWEi2SdFfFjll/vH5x+q7cGvM
         +Xjy74n4o7yd+WRJsHs7EUxT7asgazyC2Ch8+wQQcfOCI6hRADimW/BXYtZTlp8mfn
         ovXG/X6xHqS4ocqAkJCjHio1E5+jm3yMbLjVuB18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Pepper <joel.pepper@rwth-aachen.de>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 082/159] usb: gadget: uvc: configfs: Prevent format changes after linking header
Date:   Fri, 22 Nov 2019 11:27:53 +0100
Message-Id: <20191122100804.783442598@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



