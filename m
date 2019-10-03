Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EC5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1140207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118494;
	bh=OKvm+ifNl4ftEgJiaFbzOEy9YzPA0oY2ohBxg2c6p5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iGZtRdVzW/o81wgvHjuHByV1w4Ql4okKaLoX2dWaVBZPMuDZxagWtA2SIcEWsfCoH
	 aeo/1W5+D9hd7JQop9LzumkPeqjC5PPfxZAxa1rR25lxi1Ero695nk8Uc5F+dwLWol
	 eUdOD6LfYsuY7WudP8a7YloXZ5HaxXYXCRTbNQfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfJCQBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731814AbfJCQBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:01:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166C5207FF;
        Thu,  3 Oct 2019 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118490;
        bh=OKvm+ifNl4ftEgJiaFbzOEy9YzPA0oY2ohBxg2c6p5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwIuVzgB/dZZlqxhM+JrHDILGB1t0fCU7kYboVUltIT9KX7AQhn4u+hmqE07yQmSF
         fVBQAye3ZoRcY/clgSr5v0XMGeJQ2oTtWOegVGXZYTcSIBJvrL17w3kr6MG+S+UOc1
         PIHCqIvLlKOT7zq2ed3CRnt3t5JsyrTsehPxPDZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takeshi Misawa <jeliantsurux@gmail.com>,
        Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+d9c8bf24e56416d7ce2c@syzkaller.appspotmail.com
Subject: [PATCH 4.9 029/129] ppp: Fix memory leak in ppp_write
Date:   Thu,  3 Oct 2019 17:52:32 +0200
Message-Id: <20191003154332.533793119@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Misawa <jeliantsurux@gmail.com>

[ Upstream commit 4c247de564f1ff614d11b3bb5313fb70d7b9598b ]

When ppp is closing, __ppp_xmit_process() failed to enqueue skb
and skb allocated in ppp_write() is leaked.

syzbot reported :
BUG: memory leak
unreferenced object 0xffff88812a17bc00 (size 224):
  comm "syz-executor673", pid 6952, jiffies 4294942888 (age 13.040s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d110fff9>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
    [<00000000d110fff9>] slab_post_alloc_hook mm/slab.h:522 [inline]
    [<00000000d110fff9>] slab_alloc_node mm/slab.c:3262 [inline]
    [<00000000d110fff9>] kmem_cache_alloc_node+0x163/0x2f0 mm/slab.c:3574
    [<000000002d616113>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:197
    [<000000000167fc45>] alloc_skb include/linux/skbuff.h:1055 [inline]
    [<000000000167fc45>] ppp_write+0x48/0x120 drivers/net/ppp/ppp_generic.c:502
    [<000000009ab42c0b>] __vfs_write+0x43/0xa0 fs/read_write.c:494
    [<00000000086b2e22>] vfs_write fs/read_write.c:558 [inline]
    [<00000000086b2e22>] vfs_write+0xee/0x210 fs/read_write.c:542
    [<00000000a2b70ef9>] ksys_write+0x7c/0x130 fs/read_write.c:611
    [<00000000ce5e0fdd>] __do_sys_write fs/read_write.c:623 [inline]
    [<00000000ce5e0fdd>] __se_sys_write fs/read_write.c:620 [inline]
    [<00000000ce5e0fdd>] __x64_sys_write+0x1e/0x30 fs/read_write.c:620
    [<00000000d9d7b370>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:296
    [<0000000006e6d506>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by freeing skb, if ppp is closing.

Fixes: 6d066734e9f0 ("ppp: avoid loop in xmit recursion detection code")
Reported-and-tested-by: syzbot+d9c8bf24e56416d7ce2c@syzkaller.appspotmail.com
Signed-off-by: Takeshi Misawa <jeliantsurux@gmail.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Tested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/ppp_generic.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1432,6 +1432,8 @@ static void __ppp_xmit_process(struct pp
 			netif_wake_queue(ppp->dev);
 		else
 			netif_stop_queue(ppp->dev);
+	} else {
+		kfree_skb(skb);
 	}
 	ppp_xmit_unlock(ppp);
 }


