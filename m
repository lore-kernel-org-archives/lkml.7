Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D6FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E6820679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738739;
	bh=won/3C//qnNMfS6DL9yndOAUy2B8vGvUBvsYexyleiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d/MiCNrvE2xGi7ok9SY2EAnl3Z/JA9lrxchwz1JZSNAFkDkvSQwmvwwfFKO520NJC
	 m9uwT3j4QIxXpP7q46pmop0Y1wHe5MCTDv/0iaZcbYhqUNZzeZU5ExDP0F5B8AgWuP
	 Ie7Qpr3CFsIhXMLi9jjmkMN7sr6uj8p/IPpMr6uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390648AbfHBJeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391486AbfHBJeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:34:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B03A21773;
        Fri,  2 Aug 2019 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738448;
        bh=won/3C//qnNMfS6DL9yndOAUy2B8vGvUBvsYexyleiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQCXtxSHmhSOPiDDKx/vzdlIiXVfHQN+uorE5W2vg804FxlaTTMNwrz2Wx9LJSCv8
         dpN/NHGBGKEuclei0xIX+M4LT4BkaqwEVQ54KxZAC7p+gh/Ud9pSCFj/QBss5q9XL8
         Gzp8e2wVLzpitDtpDFtGOCacvPbHJGrqLus77yJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d6636a36d3c34bd88938@syzkaller.appspotmail.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 093/158] netrom: fix a memory leak in nr_rx_frame()
Date:   Fri,  2 Aug 2019 11:28:34 +0200
Message-Id: <20190802092223.339720533@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit c8c8218ec5af5d2598381883acbefbf604e56b5e ]

When the skb is associated with a new sock, just assigning
it to skb->sk is not sufficient, we have to set its destructor
to free the sock properly too.

Reported-by: syzbot+d6636a36d3c34bd88938@syzkaller.appspotmail.com
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netrom/af_netrom.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -870,7 +870,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 	unsigned short frametype, flags, window, timeout;
 	int ret;
 
-	skb->sk = NULL;		/* Initially we don't know who it's for */
+	skb_orphan(skb);
 
 	/*
 	 *	skb->data points to the netrom frame start
@@ -969,6 +969,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 	window = skb->data[20];
 
 	skb->sk             = make;
+	skb->destructor     = sock_efree;
 	make->sk_state	    = TCP_ESTABLISHED;
 
 	/* Fill in his circuit details */


