Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA82C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F205222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003749;
	bh=ZkEToZ9kZMhEnnK6bd6YMhqCMwF2xVX5AH3G3JiaVE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OfNUAYBlo3k19SL7g5gtKpJaIuqgUfRgmS+rBZkryZCf5eXzLgs+T/kiFB4McFiZ7
	 DA1QQHFcrgnIuLiNHR4BqDAeQq3mniATIzq1gv+QG1NKfNUQ/HhLg2HBxx9WTLNyZ/
	 RxEzeAgbtpctiXOvBkmhkRHbmOf+z7ihvbOa2OUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgABWW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgABWWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:22:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E92420866;
        Thu,  2 Jan 2020 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003745;
        bh=ZkEToZ9kZMhEnnK6bd6YMhqCMwF2xVX5AH3G3JiaVE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SF0gSKeogOt7bXufzaOyif+ieouaLMOdTkEaxIZlzFQtg/FYJVNDIUe9KCy5GNY4t
         WdWtfivsyBNV0lkHbg18DbTacH3KD4907PxDa5iMt03dZdt7ZS/ZwIeG/XzO+talHZ
         5dVvOwzIhdE6eCP/8O/yXTMahNWGFW1PZrvI16Gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 096/114] vhost/vsock: accept only packets with the right dst_cid
Date:   Thu,  2 Jan 2020 23:07:48 +0100
Message-Id: <20200102220038.848209888@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 8a3cc29c316c17de590e3ff8b59f3d6cbfd37b0a ]

When we receive a new packet from the guest, we check if the
src_cid is correct, but we forgot to check the dst_cid.

The host should accept only packets where dst_cid is
equal to the host CID.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vsock.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -436,7 +436,9 @@ static void vhost_vsock_handle_tx_kick(s
 		virtio_transport_deliver_tap_pkt(pkt);
 
 		/* Only accept correctly addressed packets */
-		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid)
+		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid &&
+		    le64_to_cpu(pkt->hdr.dst_cid) ==
+		    vhost_transport_get_local_cid())
 			virtio_transport_recv_pkt(pkt);
 		else
 			virtio_transport_free_pkt(pkt);


