Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5640C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6723321907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125975;
	bh=5tiR3tiecIhYUMuD+5s/Dm/dHUxdxqZgXjJSPuMDl0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDoCHu79QikD+k7Ua2AOPlUHdH76D9ZqSG4XoE1THxJcBu8lW0bJe/1/YKEHhjrhG
	 dpQzG+NI07UP0zAjjnrMN1Bci0N91v7X6U3RYooHgS8uLz3sK4DVcnJyHZs7BsR8BD
	 Mf1MvtRt0iVX0bOfxFVZVsYPSBkhvexrY3YyU2o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbfDXRMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387733AbfDXRMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:12:50 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02592148D;
        Wed, 24 Apr 2019 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125970;
        bh=5tiR3tiecIhYUMuD+5s/Dm/dHUxdxqZgXjJSPuMDl0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ie8cZoyV9wemXMJkZXBdlZV/QUu2t/nR/MWf/L/A9Be9uOgIm4GX5FS4IpovsbmRd
         CGOvSKm5IZ/Xc+zfw0Nb2+/eJPNq5hYXJUibmupHxvcaxuTm8l6QBcmsn95NyMqOKv
         j39fa0Wynwphhw6pYcDlZ304YgVhB36totEz2D1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+86b5c7c236a22616a72f@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 048/104] sctp: initialize _pad of sockaddr_in before copying to user memory
Date:   Wed, 24 Apr 2019 19:09:05 +0200
Message-Id: <20190424170901.129315576@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 09279e615c81ce55e04835970601ae286e3facbe ]

Syzbot report a kernel-infoleak:

  BUG: KMSAN: kernel-infoleak in _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
  Call Trace:
    _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
    copy_to_user include/linux/uaccess.h:174 [inline]
    sctp_getsockopt_peer_addrs net/sctp/socket.c:5911 [inline]
    sctp_getsockopt+0x1668e/0x17f70 net/sctp/socket.c:7562
    ...
  Uninit was stored to memory at:
    sctp_transport_init net/sctp/transport.c:61 [inline]
    sctp_transport_new+0x16d/0x9a0 net/sctp/transport.c:115
    sctp_assoc_add_peer+0x532/0x1f70 net/sctp/associola.c:637
    sctp_process_param net/sctp/sm_make_chunk.c:2548 [inline]
    sctp_process_init+0x1a1b/0x3ed0 net/sctp/sm_make_chunk.c:2361
    ...
  Bytes 8-15 of 16 are uninitialized

It was caused by that th _pad field (the 8-15 bytes) of a v4 addr (saved in
struct sockaddr_in) wasn't initialized, but directly copied to user memory
in sctp_getsockopt_peer_addrs().

So fix it by calling memset(addr->v4.sin_zero, 0, 8) to initialize _pad of
sockaddr_in before copying it to user memory in sctp_v4_addr_to_user(), as
sctp_v6_addr_to_user() does.

Reported-by: syzbot+86b5c7c236a22616a72f@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Tested-by: Alexander Potapenko <glider@google.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/protocol.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -578,6 +578,7 @@ out:
 static int sctp_v4_addr_to_user(struct sctp_sock *sp, union sctp_addr *addr)
 {
 	/* No address mapping for V4 sockets */
+	memset(addr->v4.sin_zero, 0, sizeof(addr->v4.sin_zero));
 	return sizeof(struct sockaddr_in);
 }
 


