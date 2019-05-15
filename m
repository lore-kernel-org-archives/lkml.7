Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D723C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1043920843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920001;
	bh=iajolfmDkExgkErxz/VgBj8MRe1bH0OyF4BKtvzNiw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rvx7C1pLBqp9l7c6F30jknf1QmsIfY8Z6mpYW3TNwSExX8vLkpJ8TeV/LLjcu78C9
	 hU2PPukWkXzdnqXRIsG3XYdw89Fr3nl/ymnls41cmV3+gbK6I3/4Mu22fCxwTffHfw
	 vo/jNGESMscuGhs2x+xPYVcJ7V0EQKYyL6ev14v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733181AbfEOLdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732868AbfEOLdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:33:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F5A020843;
        Wed, 15 May 2019 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919997;
        bh=iajolfmDkExgkErxz/VgBj8MRe1bH0OyF4BKtvzNiw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLvaoS0T80G/BAK+aHXgUXKDGkY+IEsB780BtDbQqCtaSpsb0KdNhelvze9oHpBS+
         SUJy7/bs9xxBZYVN1AD77wbPj/KW8y/+GDXHVpOMX9uFcQGziGtFFlZkAKhmDKD2Yo
         3S4sLyI+bH/TVuz8d25bKIbjvK3sdVCpnAj7wkPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 32/46] tuntap: fix dividing by zero in ebpf queue selection
Date:   Wed, 15 May 2019 12:56:56 +0200
Message-Id: <20190515090626.573484348@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit a35d310f03a692bf4798eb309a1950a06a150620 ]

We need check if tun->numqueues is zero (e.g for the persist device)
before trying to use it for modular arithmetic.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: 96f84061620c6("tun: add eBPF based queue selection method")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -596,13 +596,18 @@ static u16 tun_automq_select_queue(struc
 static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 {
 	struct tun_prog *prog;
+	u32 numqueues;
 	u16 ret = 0;
 
+	numqueues = READ_ONCE(tun->numqueues);
+	if (!numqueues)
+		return 0;
+
 	prog = rcu_dereference(tun->steering_prog);
 	if (prog)
 		ret = bpf_prog_run_clear_cb(prog->prog, skb);
 
-	return ret % tun->numqueues;
+	return ret % numqueues;
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,


