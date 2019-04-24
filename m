Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50701C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9372192D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126359;
	bh=evnLSChIstEjmXuYnv/uCVyHAD2LOd9UMq5k+PhQU/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AGH8CfJQynF/Czt63nSw597IlfhCgzFA8IIgXWT/DaamJE+cRE65yAkz73JT7Eanf
	 usjdvI9JkWDK59q+t+3t+qDARKWHpz8ZTdcF78tKJEkYFznaYu0bP8IFH6Mooku/nH
	 k0+kc+ydduaCJfanjcW8qHJDmzF/wUAmVnNpUjzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbfDXRTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388945AbfDXRTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:14 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B5321908;
        Wed, 24 Apr 2019 17:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126353;
        bh=evnLSChIstEjmXuYnv/uCVyHAD2LOd9UMq5k+PhQU/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTGUubLToknx2fWXiwQ4Ta/2LXFrQAl9UYs+HKc9BX6MEj8zin3kDi2RMsCfkklLR
         7BT+Isc6QOdY400hqK/1xwESqbMYqrSrzaYRPyB+3g9hFUqqQZu8ahAc0fRZp8Edfl
         8ynlh5TRy6HZZD1PxQ2JcC0Hd5Q72lV5BEckguL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+86b5c7c236a22616a72f@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 082/168] sctp: initialize _pad of sockaddr_in before copying to user memory
Date:   Wed, 24 Apr 2019 19:08:46 +0200
Message-Id: <20190424170928.695052288@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
@@ -598,6 +598,7 @@ out:
 static int sctp_v4_addr_to_user(struct sctp_sock *sp, union sctp_addr *addr)
 {
 	/* No address mapping for V4 sockets */
+	memset(addr->v4.sin_zero, 0, sizeof(addr->v4.sin_zero));
 	return sizeof(struct sockaddr_in);
 }
 


