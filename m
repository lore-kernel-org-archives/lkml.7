Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B073C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAFE206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055189;
	bh=MnLRgpKf8bf7JXa3l3G1EigBR7h3gNLETgMTq6ZJNU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PtRa6+i8SyuqsPccKX6EYca/oGlJLeMZ9lmZ+5+9zEtn3XCb471SriSWe84G6u7dN
	 43nN5rII4nbyNhVQiBIPSmewLiTqxt58wlvHZ9uEnzZEORO9JMHUUohPaa/EnW+FyB
	 Udrrf1TOLnWLGyWjH/oJy5ZTgoV8e9pWtC6yZplE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfFTS01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfFTSGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:06:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B09214AF;
        Thu, 20 Jun 2019 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053976;
        bh=MnLRgpKf8bf7JXa3l3G1EigBR7h3gNLETgMTq6ZJNU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpAdyF6A6kCHAw5k3C9ZxT7TuiAYC4sZ4QLu1bfuERazI28lK0CvaFQGjk1/tEzbI
         U/Y3DyWyqfGNAdzVY3Yf4KZwfyA0OVgSm04BdZkFzrauIOahztSYCtcSQ1O8Xcu/9Y
         SmaFEmKhq7zPOFpiQP3IAeTmeeGr4UzYwWhC0NlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+afb980676c836b4a0afa@syzkaller.appspotmail.com,
        Jeremy Sowden <jeremy@azazel.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 093/117] lapb: fixed leak of control-blocks.
Date:   Thu, 20 Jun 2019 19:57:07 +0200
Message-Id: <20190620174357.550517090@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

[ Upstream commit 6be8e297f9bcea666ea85ac7a6cd9d52d6deaf92 ]

lapb_register calls lapb_create_cb, which initializes the control-
block's ref-count to one, and __lapb_insert_cb, which increments it when
adding the new block to the list of blocks.

lapb_unregister calls __lapb_remove_cb, which decrements the ref-count
when removing control-block from the list of blocks, and calls lapb_put
itself to decrement the ref-count before returning.

However, lapb_unregister also calls __lapb_devtostruct to look up the
right control-block for the given net_device, and __lapb_devtostruct
also bumps the ref-count, which means that when lapb_unregister returns
the ref-count is still 1 and the control-block is leaked.

Call lapb_put after __lapb_devtostruct to fix leak.

Reported-by: syzbot+afb980676c836b4a0afa@syzkaller.appspotmail.com
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/lapb/lapb_iface.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -182,6 +182,7 @@ int lapb_unregister(struct net_device *d
 	lapb = __lapb_devtostruct(dev);
 	if (!lapb)
 		goto out;
+	lapb_put(lapb);
 
 	lapb_stop_t1timer(lapb);
 	lapb_stop_t2timer(lapb);


