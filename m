Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B6C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E85217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738455;
	bh=t+dt9i0XkcotkLFFiOBjf8HzBorm0ZgOFiq+RG5jY10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lr7Z1FH27ulvq4+JwneVyjrXDiCOy0e4wwSWM051VedFnCUya9Mqf9WbaT5yksnIQ
	 T71JTnB5XN8k5trGtMkpck1tHJaTL6hkH8On8j/r0OcbG08S1wII5IPAu5c6Vb24wC
	 NhgNaPNqKDTCAqa7tRJBbwug1SGVAriZbPHAilfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391498AbfHBJeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390206AbfHBJeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:34:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDAD421773;
        Fri,  2 Aug 2019 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738451;
        bh=t+dt9i0XkcotkLFFiOBjf8HzBorm0ZgOFiq+RG5jY10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVAFoGws6aWrsvSoTFiFsyyC4F5nW3hppDac+GY9puSU/bmNbRH1XWnFqs1T/GWlR
         JWOZcIf61CgjPHF5Lij1O9BHfBcRgX2VzgXVbrxTJPX0Y8fLfoX/vZRBHbT9Yld6G3
         JWOUhqmazt9EbXqqo1XykZ4TORgtM6C/RwUL2TvQ=
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
Subject: [PATCH 4.4 094/158] netrom: hold sock when setting skb->destructor
Date:   Fri,  2 Aug 2019 11:28:35 +0200
Message-Id: <20190802092223.511536567@linuxfoundation.org>
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
@@ -968,6 +968,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 
 	window = skb->data[20];
 
+	sock_hold(make);
 	skb->sk             = make;
 	skb->destructor     = sock_efree;
 	make->sk_state	    = TCP_ESTABLISHED;


