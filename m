Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402A1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2CF206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639614;
	bh=tQ4EPmHa88YeE+lsAVf8RF8bcxRpc2MVqWookuBRWD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vasO8vIkRg3x6E2SIoVrLTt6RrrVwge0OxrPdNPhZmRRdWJPbxYALJ9RhaF3kT4jy
	 xPsiehsc5nXMVdl/IGTtfKsIbTmMngcBwKGmVBIkSzm9aGgrzH6Cvwjt7hpeVMHkOi
	 YElQPrCoJL+ngK1yifO0UvF5Nza3sJQxFa8rI8k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbfEWT0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391444AbfEWT0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:26:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C2A217D7;
        Thu, 23 May 2019 19:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639611;
        bh=tQ4EPmHa88YeE+lsAVf8RF8bcxRpc2MVqWookuBRWD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdoDIGLUCWe36beGMT9+lr9WQo4crgVo9e87O0cgsabv7KQ1Thd3OOSFRcVXj9pZK
         RRYRgEQWvjvxaJxyY0i+yjyn3nGkP4nd9+GhrGh/pA+wKoYDuvDO/N0Z984f80+6/S
         49c7Tvpi3aOmsqVyNumuuoH1DPMl1avyK+vd8ZMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 012/122] vsock/virtio: free packets during the socket release
Date:   Thu, 23 May 2019 21:05:34 +0200
Message-Id: <20190523181706.599575882@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit ac03046ece2b158ebd204dfc4896fd9f39f0e6c8 ]

When the socket is released, we should free all packets
queued in the per-socket list in order to avoid a memory
leak.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport_common.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -786,12 +786,19 @@ static bool virtio_transport_close(struc
 
 void virtio_transport_release(struct vsock_sock *vsk)
 {
+	struct virtio_vsock_sock *vvs = vsk->trans;
+	struct virtio_vsock_pkt *pkt, *tmp;
 	struct sock *sk = &vsk->sk;
 	bool remove_sock = true;
 
 	lock_sock(sk);
 	if (sk->sk_type == SOCK_STREAM)
 		remove_sock = virtio_transport_close(vsk);
+
+	list_for_each_entry_safe(pkt, tmp, &vvs->rx_queue, list) {
+		list_del(&pkt->list);
+		virtio_transport_free_pkt(pkt);
+	}
 	release_sock(sk);
 
 	if (remove_sock)


