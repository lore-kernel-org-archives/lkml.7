Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD68C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA20D229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996525;
	bh=AK88lnAWtiOF8BVEKikipS86b/I1pCkr0V2WQxkNltI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNzP3tKtmm53RjwxTGDq2JnRP4EvPNeYgyZOvNYqVrOzdLRcTlNEqukZDt+wyxOM9
	 p0czTGvwMS0k1/AdYMPqUIMbIWWTIesK8LeA1jOuf+JS37XxEGp7VX6+/E63ATmgtB
	 72Kq5lgg/JNEt+RQ+HdFwtcu1lDwe0uzAaqm5Rco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfGXT2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbfGXT2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:28:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C109218EA;
        Wed, 24 Jul 2019 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996519;
        bh=AK88lnAWtiOF8BVEKikipS86b/I1pCkr0V2WQxkNltI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3j5SkP0CiowF0KA9GmzRmIGKf/CN5u+h85Nyq4XajUmxWex7FwhU1UrPRjvISCKA
         AsUvK9JM0thwBVYNUj2N37oQu/4L1z5ghU+XdNp2rK2bcVb5H8xLJl0ZG5DIq34DxA
         SY9xEyXNGCMpCyt9licxUpzhBBqc7UilIlvNkZjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        syzbot+2e1ef9188251d9cc7944@syzkaller.appspotmail.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 084/413] media: uvcvideo: Fix access to uninitialized fields on probe error
Date:   Wed, 24 Jul 2019 21:16:15 +0200
Message-Id: <20190724191741.127170543@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 11a087f484bf15ff65f0a9f277aa5a61fd07ed2a ]

We need to check whether this work we are canceling actually is
initialized.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: syzbot+2e1ef9188251d9cc7944@syzkaller.appspotmail.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 26163a5bde7d..e399b9fad757 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2345,7 +2345,9 @@ void uvc_ctrl_cleanup_device(struct uvc_device *dev)
 	struct uvc_entity *entity;
 	unsigned int i;
 
-	cancel_work_sync(&dev->async_ctrl.work);
+	/* Can be uninitialized if we are aborting on probe error. */
+	if (dev->async_ctrl.work.func)
+		cancel_work_sync(&dev->async_ctrl.work);
 
 	/* Free controls and control mappings for all entities. */
 	list_for_each_entry(entity, &dev->entities, list) {
-- 
2.20.1



