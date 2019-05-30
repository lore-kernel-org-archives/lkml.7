Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E1C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94BF24923
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187551;
	bh=qktqclC8CUNFS+QMgcn1eVaCPnx95DfSItL9pLqdykw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z8aqzxOvtt5hChywS6FQxDuqC1XArPZQ5e5siJ0t1E/ukQQo3dn660gOUDFjIWX4j
	 oSBn0842Gu1n3isO8vUtI+/RwAx8hcZSdRtfkJ2qn2wGc7tvlapkaImo65sEdOziNU
	 VkVFsswXOEB2Biu6nI8HO6iJqlrSSbIpFTCwRG00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbfE3DWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730768AbfE3DQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:41 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D8DA24615;
        Thu, 30 May 2019 03:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186201;
        bh=qktqclC8CUNFS+QMgcn1eVaCPnx95DfSItL9pLqdykw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kb0PPyox63m3JgFC7fTIxJ9ew74TkMoowgDffRuhiPYXEGB8PnQiyEZC9ARFZ3x/S
         81jNSlMzvaVtNiextlFmDxIc6TuVubtcf5ouueTePJFgWLFXIwNiyeMtoq+H9IqpCW
         XEA9czTo5JlHsIzIDwHZo4/rjCrZNDaKpMDU8160=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 037/276] media: vivid: use vfree() instead of kfree() for dev->bitmap_cap
Date:   Wed, 29 May 2019 20:03:15 -0700
Message-Id: <20190530030526.556157459@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

commit dad7e270ba712ba1c99cd2d91018af6044447a06 upstream.

syzkaller reported crashes on kfree() called from
vivid_vid_cap_s_selection(). This looks like a simple typo, as
dev->bitmap_cap is allocated with vzalloc() throughout the file.

Fixes: ef834f7836ec0 ("[media] vivid: add the video capture and output
parts")

Signed-off-by: Alexander Potapenko <glider@google.com>
Reported-by: Syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-vid-cap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/vivid/vivid-vid-cap.c
+++ b/drivers/media/platform/vivid/vivid-vid-cap.c
@@ -992,7 +992,7 @@ int vivid_vid_cap_s_selection(struct fil
 		v4l2_rect_map_inside(&s->r, &dev->fmt_cap_rect);
 		if (dev->bitmap_cap && (compose->width != s->r.width ||
 					compose->height != s->r.height)) {
-			kfree(dev->bitmap_cap);
+			vfree(dev->bitmap_cap);
 			dev->bitmap_cap = NULL;
 		}
 		*compose = s->r;


