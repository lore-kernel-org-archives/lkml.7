Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C54C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81C2214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411422;
	bh=2FMpwAh7Q0Eu2rAACiKScSkCbBZq4VNqVxv4WKsXejo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2aR29V4OE6fMR2uV+/OZ7H53sSyQwu9POnbjAtTTxHR6rkR/SSEYbwJqzUkLx35E+
	 12iVVsrJoKY8jNslufsnQp5xkoyuDpWWYFpBCx9UtqFl0/zpYg//M082XdL9jCLKAM
	 LS7QQnnQaVfJ0gziJgaupthHU6zvUKmKO7iBZQ98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfCLRXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbfCLRR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:59 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6699E2171F;
        Tue, 12 Mar 2019 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411078;
        bh=2FMpwAh7Q0Eu2rAACiKScSkCbBZq4VNqVxv4WKsXejo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYA6yZPsa9HFIZQXKLv5yXIaQTF54mAplboENl9HdzzS3L00odnPzNsBsu0LH7Rwy
         7HESsUgBFFtBsKgXXYIG5JaZ/3kFQ/EnzTfPBsHNlhZH8HHiEKeXWnXV9a4a8lq6/6
         uZVXbYQPYRv6YHQhtAeb0qZPsHyvZ06wMpp7KqKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 73/96] vsock/virtio: reset connected sockets on device removal
Date:   Tue, 12 Mar 2019 10:10:31 -0700
Message-Id: <20190312171040.118549532@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 6cbc08d82e7f..f66a6010ae07 100644
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



