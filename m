Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF3D20862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124505;
	bh=NSukmqKx85zf26wnhrsuHIwKRjUlm+nK4EgIzbL9UfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USOaasB00BGF45Kv1/40uSb7VGhQYENEKp5eZphTLkjR7fKyR0NFn7qaQJbuNBvI7
	 P19SWX3gXbXNYyqthr01cDT4PrKeoWdunysjlrsy3FgS8Yef2qW1tA9FL7zfCGrVoH
	 CyU4o4uJCTR/4F8TIWt9dwcUGMWqC6zQg3C9hdkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390149AbfJCRlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731195AbfJCP6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:58:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C749207FF;
        Thu,  3 Oct 2019 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118292;
        bh=NSukmqKx85zf26wnhrsuHIwKRjUlm+nK4EgIzbL9UfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2R3W/Rf8LQFSQawsAHsseL1PPjJAP5ldZSktG3PowwCc/6iL9uGwI810XnjvU/TTj
         A2Bfu+EB0EnewcbsbeBFbc9wA4XsXeCTIJCBqRKlh1igyznXNQwQOf6Ny1BulJLGrq
         Ec4LJ/sGmuPQtpSmVOZ5eJa5UuU5Z2nMjISoLsSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 59/99] media: cpia2_usb: fix memory leaks
Date:   Thu,  3 Oct 2019 17:53:22 +0200
Message-Id: <20191003154325.545969001@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 1c770f0f52dca1a2323c594f01f5ec6f1dddc97f ]

In submit_urbs(), 'cam->sbuf[i].data' is allocated through kmalloc_array().
However, it is not deallocated if the following allocation for urbs fails.
To fix this issue, free 'cam->sbuf[i].data' if usb_alloc_urb() fails.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/cpia2/cpia2_usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/cpia2/cpia2_usb.c b/drivers/media/usb/cpia2/cpia2_usb.c
index 41ea00ac3a873..76b9cb940b871 100644
--- a/drivers/media/usb/cpia2/cpia2_usb.c
+++ b/drivers/media/usb/cpia2/cpia2_usb.c
@@ -665,6 +665,10 @@ static int submit_urbs(struct camera_data *cam)
 			ERR("%s: usb_alloc_urb error!\n", __func__);
 			for (j = 0; j < i; j++)
 				usb_free_urb(cam->sbuf[j].urb);
+			for (j = 0; j < NUM_SBUF; j++) {
+				kfree(cam->sbuf[j].data);
+				cam->sbuf[j].data = NULL;
+			}
 			return -ENOMEM;
 		}
 
-- 
2.20.1



