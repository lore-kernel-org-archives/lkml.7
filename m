Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5E7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77224215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887160;
	bh=j6CA8H90Oqea5Y+5FqbiK5sFUNSLb0xxZbJYSv/r/3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sq+VXU7t6vYQ9dl/MRKt4ykuDW3mEOjBbVTju9et/TnovemVUoyaKtlAtNeD45qZi
	 8YorEhwS9+FSWZTIZ38iQW2FzE2+5mW8vlETFZK5mfEjFUa3GxPQX4u0EhSUrfOkHn
	 InN8E6TeEQJolPqdxgx9WELZonEPGmflNp3vCado=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfK0UjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:39:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfK0UjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:39:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2D9215A5;
        Wed, 27 Nov 2019 20:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887157;
        bh=j6CA8H90Oqea5Y+5FqbiK5sFUNSLb0xxZbJYSv/r/3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5mKVn4gktZzvlkrrpKz9C7GMYOWgxorI9g+ZcMrhVTYyERCFiPPBtzyH2CG35B0t
         +pKaKDmQ49YnDfwlhs1R8WmAIf2gFocTMaUvkM6PGmlzv/+q1KP5ELvyHMgmN6F5T3
         5X7KRYgTkn7lafT9rx8qLKDsye/o33LJ4cyVamis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 119/132] virtio_console: fix uninitialized variable use
Date:   Wed, 27 Nov 2019 21:31:50 +0100
Message-Id: <20191127203032.434658701@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@redhat.com>

[ Upstream commit 2055997f983c6db7b5c3940ce5f8f822657d5bc3 ]

We try to disable callbacks on c_ivq even without multiport
even though that vq is not initialized in this configuration.

Fixes: c743d09dbd01 ("virtio: console: Disable callbacks for virtqueues at start of S4 freeze")
Suggested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/virtio_console.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c5b89f6b0145e..1b002e1391f0a 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2197,14 +2197,16 @@ static int virtcons_freeze(struct virtio_device *vdev)
 
 	vdev->config->reset(vdev);
 
-	virtqueue_disable_cb(portdev->c_ivq);
+	if (use_multiport(portdev))
+		virtqueue_disable_cb(portdev->c_ivq);
 	cancel_work_sync(&portdev->control_work);
 	cancel_work_sync(&portdev->config_work);
 	/*
 	 * Once more: if control_work_handler() was running, it would
 	 * enable the cb as the last step.
 	 */
-	virtqueue_disable_cb(portdev->c_ivq);
+	if (use_multiport(portdev))
+		virtqueue_disable_cb(portdev->c_ivq);
 	remove_controlq_data(portdev);
 
 	list_for_each_entry(port, &portdev->ports, list) {
-- 
2.20.1



