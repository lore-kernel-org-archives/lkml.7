Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73095C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496D0205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054807;
	bh=hphFwK1hIXpMMA+3jCTMhQvVE8F9g39oGFKILzNNueY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2QWYaAnyBJ/qn/KcIKNcE8Iba8PPQZ6tPyJ0xLwNLeQoZdGBLF00D5jPv7z6HNKd4
	 FdMiLD66F/5YyRADKoJT/qCIQp9NB93bhHnXfCgjLumtZS5sVtVeOtjVci0KXpZVpL
	 Hsy8S/6eA09CFmxzBxUDYfgiLuTlhJAE9GPUmPS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfFTSOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbfFTSOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:14:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE632084E;
        Thu, 20 Jun 2019 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054449;
        bh=hphFwK1hIXpMMA+3jCTMhQvVE8F9g39oGFKILzNNueY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHTEGzEUppL3XWdCg6xquvr3Z4+G5bHDuK0V0IPf6TQKfXlVebfi+GpvZUSInoJzN
         QL0B31C46ahhk6Pk2qMk1f4VPBWv0LhZIbn0TWhqFNVTw7J3RpfPzeVByfNJNLHPvp
         LDaFXvIpUBqoMbTE0EOGgy9k6yAxaSzW2UmHZ1oA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Barber <smbarber@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 15/98] vsock/virtio: set SOCK_DONE on peer shutdown
Date:   Thu, 20 Jun 2019 19:56:42 +0200
Message-Id: <20190620174349.990590950@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Barber <smbarber@chromium.org>

[ Upstream commit 42f5cda5eaf4396a939ae9bb43bb8d1d09c1b15c ]

Set the SOCK_DONE flag to match the TCP_CLOSING state when a peer has
shut down and there is nothing left to read.

This fixes the following bug:
1) Peer sends SHUTDOWN(RDWR).
2) Socket enters TCP_CLOSING but SOCK_DONE is not set.
3) read() returns -ENOTCONN until close() is called, then returns 0.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport_common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -871,8 +871,10 @@ virtio_transport_recv_connected(struct s
 		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
 			vsk->peer_shutdown |= SEND_SHUTDOWN;
 		if (vsk->peer_shutdown == SHUTDOWN_MASK &&
-		    vsock_stream_has_data(vsk) <= 0)
+		    vsock_stream_has_data(vsk) <= 0) {
+			sock_set_flag(sk, SOCK_DONE);
 			sk->sk_state = TCP_CLOSING;
+		}
 		if (le32_to_cpu(pkt->hdr.flags))
 			sk->sk_state_change(sk);
 		break;


