Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB76C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B32922581
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354208;
	bh=SWnbQ6ESsCx2svhKme4+smyFG/NDFa640/NUKAqdQIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PvcOpGNTLkxK/43anwUKZgSpQNJVMSEnwPxXyFqa39TUmwP7/YmF6XLtbeaY/1Myn
	 2sGSWrgIhgkSfuVU9NsNoRADM8qp1q/3Y1tS0lrB28/6WQMi7hmrGjlWhbnRY1vtp5
	 U46O/TPZsfUpuWnSd/LRKT/m6TNhmbi7qmeTDwwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfKJCuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbfKJCtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:49:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C40225AE;
        Sun, 10 Nov 2019 02:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354185;
        bh=SWnbQ6ESsCx2svhKme4+smyFG/NDFa640/NUKAqdQIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3ixPP4BTK7FkESH9MsA+O3Jf4z4MpJXNr4aGksBpQWVG6+Qi4iIWYvmGNsTbotrC
         uMX64K4QZiKjKW67NEom3uqVGXZuRpUXNJtiHlQ3KEKgTU7y8gsMhQcbvEQ/AslKTN
         jEX2k04WMamh28TjII+5oJScdzWABZ3U5cLmkCgc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joel Pepper <joel.pepper@rwth-aachen.de>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 34/66] usb: gadget: uvc: configfs: Prevent format changes after linking header
Date:   Sat,  9 Nov 2019 21:48:13 -0500
Message-Id: <20191110024846.32598-34-sashal@kernel.org>
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
index 3803dda54666b..3d843e14447bb 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -772,6 +772,7 @@ static int uvcg_streaming_header_allow_link(struct config_item *src,
 	format_ptr->fmt = target_fmt;
 	list_add_tail(&format_ptr->entry, &src_hdr->formats);
 	++src_hdr->num_fmt;
+	++target_fmt->linked;
 
 out:
 	mutex_unlock(&opts->lock);
@@ -810,6 +811,8 @@ static int uvcg_streaming_header_drop_link(struct config_item *src,
 			break;
 		}
 
+	--target_fmt->linked;
+
 out:
 	mutex_unlock(&opts->lock);
 	mutex_unlock(su_mutex);
-- 
2.20.1

