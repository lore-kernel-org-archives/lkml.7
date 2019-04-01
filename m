Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1465B2192D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138344;
	bh=wkhjzxR087HnuXa5OTmPKxehOyJvrC6EJ8dOyD+aNNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BjLWeSs5BNsCi8NpXiagpcYPyCdBjFzQ/WRKTvuE5Re/snJLKBOM0QiPXYugsH0+/
	 3x93t8+fBhXfShPwiSDnS0jb5qz4584I0gmU9h5EBIaP8uVUDTIFFn1bRU1wJrz3dN
	 Hb1wV4rIdspKUv7gDquk+hLPHuap+X3gcYu0h+BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfDARFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDARFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169B121929;
        Mon,  1 Apr 2019 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138339;
        bh=wkhjzxR087HnuXa5OTmPKxehOyJvrC6EJ8dOyD+aNNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+SpQV2euzCTPevn6Tunu6kyfXKG6iQZM957AE6nbyQltypTW011KXLJOso9GOtCJ
         lWrWhHwaCFQVArfeOflJjPtnH6lI6DznFgAtgXIoUDm1gh3Pp3iszVffjgOPHIByn7
         Iimxq880XMrOJnlWGmER6g2H3JyQqO0zbk3hkzIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 036/146] tun: add a missing rcu_read_unlock() in error path
Date:   Mon,  1 Apr 2019 19:00:48 +0200
Message-Id: <20190401170051.554507067@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 9180bb4f046064dfa4541488102703b402bb04e1 upstream.

In my latest patch I missed one rcu_read_unlock(), in case
device is down.

Fixes: 4477138fa0ae ("tun: properly test for IFF_UP")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/tun.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1960,6 +1960,7 @@ drop:
 	rcu_read_lock();
 	if (unlikely(!(tun->dev->flags & IFF_UP))) {
 		err = -EIO;
+		rcu_read_unlock();
 		goto drop;
 	}
 


