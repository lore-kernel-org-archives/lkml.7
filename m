Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B528EC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA5B22B48
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003509;
	bh=ZRzUaS7TbHRkip6Y5V7m23bnGrNRf3b6ulStmFnU4HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HrFtIMd67wbkSdKPU/c8kkBp3ZAjXWdoV4KybhcNmIxra+Q59pGLGcBl0ymRm0HXX
	 BSMxcqBaSV+VT6AGKJRmy5ZkcBgrqfjfsT7k+sLu4+c0ncKMU0Rifuo0ZK9N/hhPL/
	 bwxz/ikRYXhkeiOXQEYK82IKJqv74LN8NnjfLHz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgABWS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:18:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgABWSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:18:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A8821582;
        Thu,  2 Jan 2020 22:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003505;
        bh=ZRzUaS7TbHRkip6Y5V7m23bnGrNRf3b6ulStmFnU4HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRYfJjzoLxqB1fED8jOqOgjS49pK67+DX4Iihb1s1J5a05oF/X5u3EKo72Lg/WK2r
         RVm3RxYFbsJtpUDGI1TYFIiZYYHmL7t5XOpQ+Z8WCp/NrbLXSJbMVIrojJaLkb979s
         DD0a/LVTVlvm8pOTKVfv26goh5+hQwzgyi5Le73s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 189/191] vhost/vsock: accept only packets with the right dst_cid
Date:   Thu,  2 Jan 2020 23:07:51 +0100
Message-Id: <20200102215849.847621468@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
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
@@ -437,7 +437,9 @@ static void vhost_vsock_handle_tx_kick(s
 		virtio_transport_deliver_tap_pkt(pkt);
 
 		/* Only accept correctly addressed packets */
-		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid)
+		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid &&
+		    le64_to_cpu(pkt->hdr.dst_cid) ==
+		    vhost_transport_get_local_cid())
 			virtio_transport_recv_pkt(pkt);
 		else
 			virtio_transport_free_pkt(pkt);


