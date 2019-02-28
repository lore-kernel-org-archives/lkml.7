Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E7CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A339B20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367143;
	bh=StXwtmPxJOS7j8ETipIPMsKRvMMzP790ac+h+DbM1P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hIZyY3BfsIFcA8xxLEldqMnDyYuTmYe4O31kig/qY3ww0J5IrcGYYLptu6caYnd9A
	 IUYhSRIQsSRsgQVWt/5iNS+AsH9IZyXWJlY2I5bgCtHj7Q3YdtxDUIaTRSdOAEtmjU
	 4Jz8Kch80PUaXrh0tLvP8yjMBrPdiarxw9Po2czI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbfB1PTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:19:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388829AbfB1PPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:15:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D430F218D9;
        Thu, 28 Feb 2019 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366929;
        bh=StXwtmPxJOS7j8ETipIPMsKRvMMzP790ac+h+DbM1P8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K++GkegBT5LbLp7ph/mdA37s4TUwywQJZxexKbLsUgDBz84XEqM7vtZRjdPwRYUHT
         Q1wwLsPqtqUWl6pQB791JKcA76uMOtzHp6XJiT/Vj8xUmAsIpoNG97z0OWecVWskcM
         kXP/teCQpoRbjMKI/zVpU0VGJj70oNAcDEXODg8I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/19] vsock/virtio: reset connected sockets on device removal
Date:   Thu, 28 Feb 2019 10:15:05 -0500
Message-Id: <20190228151517.12705-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151517.12705-1-sashal@kernel.org>
References: <20190228151517.12705-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 85965487abc540368393a15491e6e7fcd230039d ]

When the virtio transport device disappear, we should reset all
connected sockets in order to inform the users.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 6cbc08d82e7fd..f66a6010ae075 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -541,6 +541,9 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	flush_work(&vsock->event_work);
 	flush_work(&vsock->send_pkt_work);
 
+	/* Reset all connected sockets when the device disappear */
+	vsock_for_each_connected_socket(virtio_vsock_reset_sock);
+
 	vdev->config->reset(vdev);
 
 	mutex_lock(&vsock->rx_lock);
-- 
2.19.1

