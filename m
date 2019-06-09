Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DA9C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431062083D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098737;
	bh=uU1kXwXG1oCL2aC9YDl3NCCE28IjcN/JXSLj40MqnAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J7vMioz1PHQJjYBHyTt26Jjk1tsCIxr3p1hUGMhB1XJ/Qmz8qj6+QX0JD4mScLYO6
	 tXXKf/e+fROKRZXU3itaTiDygqkmgHHrKElYp/H3e+YvyqoyxX8An/zgi7dwlKr/5X
	 GTmt4ntnSyYksgfta5zK4c5j3Njrbu7UgwoMkMJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfFIQpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbfFIQpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:45:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE122083D;
        Sun,  9 Jun 2019 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098734;
        bh=uU1kXwXG1oCL2aC9YDl3NCCE28IjcN/JXSLj40MqnAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XU0jX0CbKl1XcydQech+OssDtQWlsJJBzb/x+cP30FAF5L6erb61+LMOm4Ux+GQlG
         GGFQ5j26aaek9iPUGHXxo4rbunqnq+7F7rxMP6nfuBLEa015JutfMajpiOVEGUVavM
         dsCW+hsHbtcdP1UjrZURgEUgKylIzww9CUl2xzH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 5.1 09/70] packet: unconditionally free po->rollover
Date:   Sun,  9 Jun 2019 18:41:20 +0200
Message-Id: <20190609164128.000227333@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit afa0925c6fcc6a8f610e996ca09bc3215048033c ]

Rollover used to use a complex RCU mechanism for assignment, which had
a race condition. The below patch fixed the bug and greatly simplified
the logic.

The feature depends on fanout, but the state is private to the socket.
Fanout_release returns f only when the last member leaves and the
fanout struct is to be freed.

Destroy rollover unconditionally, regardless of fanout state.

Fixes: 57f015f5eccf2 ("packet: fix crash in fanout_demux_rollover()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Diagnosed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3016,8 +3016,8 @@ static int packet_release(struct socket
 
 	synchronize_net();
 
+	kfree(po->rollover);
 	if (f) {
-		kfree(po->rollover);
 		fanout_release_data(f);
 		kfree(f);
 	}


