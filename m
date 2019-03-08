Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E93C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56FF2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049727;
	bh=WuN4myv/MmAWxUToWiKQL4wuNanrB2+QB1PM0n4EMgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LygU3RL8TTjwFhdX++N8zIvIkU9x/JxHA8OROzav6v7QGNlW8aoIvnYnhuWUI1bSc
	 FKBbjevg4HoV10qqBQsaX3Zro0SPSz0j861XCwPDke42mw8f6tiuBepszEd5MBaq9g
	 nZJEFjolD36s/DLtIgLN+3IGEgSURqy0bC3XnWE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCHMz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfCHMzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B543208E4;
        Fri,  8 Mar 2019 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049719;
        bh=WuN4myv/MmAWxUToWiKQL4wuNanrB2+QB1PM0n4EMgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ienCSLim2QcYRVElGmLArzt5mUF/trNJ8ZOHfA8iixWTJt71B6OQie/nj42A2BG4d
         eSeTnQrD4hTdH7+902n/Np8AapbTT/AyR4xqeTHaFRWhMcfH+3clzGBy+sNpw/wb7i
         Uqy5gGmeRpKpGYMJ5F/nYvKqkIi27gtcVHOuzjfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 43/76] net: socket: set sock->sk to NULL after calling proto_ops::release()
Date:   Fri,  8 Mar 2019 13:49:55 +0100
Message-Id: <20190308124916.341416395@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit ff7b11aa481f682e0e9711abfeb7d03f5cd612bf ]

Commit 9060cb719e61 ("net: crypto set sk to NULL when af_alg_release.")
fixed a use-after-free in sockfs_setattr() when an AF_ALG socket is
closed concurrently with fchownat().  However, it ignored that many
other proto_ops::release() methods don't set sock->sk to NULL and
therefore allow the same use-after-free:

    - base_sock_release
    - bnep_sock_release
    - cmtp_sock_release
    - data_sock_release
    - dn_release
    - hci_sock_release
    - hidp_sock_release
    - iucv_sock_release
    - l2cap_sock_release
    - llcp_sock_release
    - llc_ui_release
    - rawsock_release
    - rfcomm_sock_release
    - sco_sock_release
    - svc_release
    - vcc_release
    - x25_release

Rather than fixing all these and relying on every socket type to get
this right forever, just make __sock_release() set sock->sk to NULL
itself after calling proto_ops::release().

Reproducer that produces the KASAN splat when any of these socket types
are configured into the kernel:

    #include <pthread.h>
    #include <stdlib.h>
    #include <sys/socket.h>
    #include <unistd.h>

    pthread_t t;
    volatile int fd;

    void *close_thread(void *arg)
    {
        for (;;) {
            usleep(rand() % 100);
            close(fd);
        }
    }

    int main()
    {
        pthread_create(&t, NULL, close_thread, NULL);
        for (;;) {
            fd = socket(rand() % 50, rand() % 11, 0);
            fchownat(fd, "", 1000, 1000, 0x1000);
            close(fd);
        }
    }

Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/socket.c
+++ b/net/socket.c
@@ -577,6 +577,7 @@ static void __sock_release(struct socket
 		if (inode)
 			inode_lock(inode);
 		sock->ops->release(sock);
+		sock->sk = NULL;
 		if (inode)
 			inode_unlock(inode);
 		sock->ops = NULL;


