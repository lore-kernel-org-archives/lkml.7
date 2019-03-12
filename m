Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4663CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A382214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411929;
	bh=5+RvZRg+twuCm7+/7nwgWDa3pLJdbcJetyVDMtVzcZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QDDw40zpHLBik8NT7IJhDH0uBfhXKvDHyJieNZ1OJVGyAQtV0MzhJb3rpdnSL0j44
	 jtQkoM7nKM9CEVrf4BZwTyVraRADtGqATo5v0kSAi4OA0PUjMyDf2sHYjQNRuTo+YU
	 lw/WoF7WdpAlkR1WAb1408ojjr2oNcWHngDrnh+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfCLRcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbfCLRRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:06 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80EC02171F;
        Tue, 12 Mar 2019 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411025;
        bh=5+RvZRg+twuCm7+/7nwgWDa3pLJdbcJetyVDMtVzcZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gd1rRI6uVv0LvPo/GMDF3xoJS0ORJxJvp0iZQOhDaGg17kcR6xS86yTSKQUSA/QaA
         v9GNsy3iIGUMh8RmBcXAJcklBwBL0kpthqGqwKf/6ZEZ5VOhPbL8GE/la/Rlz76DW5
         6Fh8GesocrGCHPPsvneqpNNafGXcyKWnwGxXKTs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 106/135] vsock/virtio: reset connected sockets on device removal
Date:   Tue, 12 Mar 2019 10:09:13 -0700
Message-Id: <20190312170350.954960181@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 8cdf6ddec9b7..2ff751eba037 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -634,6 +634,9 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	flush_work(&vsock->event_work);
 	flush_work(&vsock->send_pkt_work);
 
+	/* Reset all connected sockets when the device disappear */
+	vsock_for_each_connected_socket(virtio_vsock_reset_sock);
+
 	vdev->config->reset(vdev);
 
 	mutex_lock(&vsock->rx_lock);
-- 
2.19.1



