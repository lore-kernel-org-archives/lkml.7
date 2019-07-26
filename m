Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A22FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5533218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155017;
	bh=68b9tyJ/KEnKnueCpYzHNa+diWF1/PGhoVHcbhTV4WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a957F+zf4YzH1q7UkJ1xIspzlZ/EahOqYsTylrVlo7Q00oN6XnJRKGF4hPVeqFo8B
	 qtAMOWZAy+lFDhvWZlI4aVGX3kS1k7vIpRWUapU2DoSkUJl7QB/K/pOxq/LYzV6i7i
	 o7HeDf90mrDP4mPGfkojql2BTNBbiM8lOb1dQdSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389045AbfGZPaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389027AbfGZPaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CD2205F4;
        Fri, 26 Jul 2019 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155011;
        bh=68b9tyJ/KEnKnueCpYzHNa+diWF1/PGhoVHcbhTV4WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ck4qF5ZiwWWk9im8gXviTD+ceN+1Hubq/ozYxq4FB91iifAdFjmpDXkBlFftziQvp
         VMBYOfgore/A9mPqgwNyWMV8BNG+pHl0TURcGtVCVKhzUzgBqqQK3tKyFK1ZH4baJT
         Uho/rIurG4oDVWLw/7aN2IdNpXVf6nNYBNj/tBhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+622bdabb128acc33427d@syzkaller.appspotmail.com,
        syzbot+6eaef7158b19e3fec3a0@syzkaller.appspotmail.com,
        syzbot+9399c158fcc09b21d0d2@syzkaller.appspotmail.com,
        syzbot+a34e5f3d0300163f0c87@syzkaller.appspotmail.com
Subject: [PATCH 5.1 35/62] netrom: hold sock when setting skb->destructor
Date:   Fri, 26 Jul 2019 17:24:47 +0200
Message-Id: <20190726152305.619535986@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 4638faac032756f7eab5524be7be56bee77e426b ]

sock_efree() releases the sock refcnt, if we don't hold this refcnt
when setting skb->destructor to it, the refcnt would not be balanced.
This leads to several bug reports from syzbot.

I have checked other users of sock_efree(), all of them hold the
sock refcnt.

Fixes: c8c8218ec5af ("netrom: fix a memory leak in nr_rx_frame()")
Reported-and-tested-by: <syzbot+622bdabb128acc33427d@syzkaller.appspotmail.com>
Reported-and-tested-by: <syzbot+6eaef7158b19e3fec3a0@syzkaller.appspotmail.com>
Reported-and-tested-by: <syzbot+9399c158fcc09b21d0d2@syzkaller.appspotmail.com>
Reported-and-tested-by: <syzbot+a34e5f3d0300163f0c87@syzkaller.appspotmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netrom/af_netrom.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -970,6 +970,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 
 	window = skb->data[20];
 
+	sock_hold(make);
 	skb->sk             = make;
 	skb->destructor     = sock_efree;
 	make->sk_state	    = TCP_ESTABLISHED;


