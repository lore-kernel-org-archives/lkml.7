Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00E7C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9408022C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154988;
	bh=RKnKnKG/+cDM3cd5oH+xfA8DQFxCi72IyRWljnhk0Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AwyyeODyfEegXRFdzvhFxxHajRoBmCojepi4T59ZUc2JDSMDz6/Jivv2F1MYmAfsj
	 o1XDLl8EV+/hskuBukroDEG9s3q11BJDbMHGYJ02gHPuqSuYk+1CSPiaEYsalL0ime
	 ly3qcb2ag7Ocg+L+nLHgZIrrA0eW3JOuDcK2sYlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbfGZP3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbfGZP3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:29:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4588B22CBF;
        Fri, 26 Jul 2019 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154980;
        bh=RKnKnKG/+cDM3cd5oH+xfA8DQFxCi72IyRWljnhk0Zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wo3jTqmpnmq32geOFIesnLFkwxupG3+4OZGGiPz4Siv8xDOo6q1+hHtURk2vJy3Xc
         9nTiQ+SE0Nt8rnk1VWNPM5alQBK6M4WGQnsaUO78R+nz9fuTyenIztwnTGJJniMMrL
         n9nP4/XNmxahGbtpofxWrxBHpIqvW3Dr2GUBpCpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Christoph Paasch <cpaasch@apple.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 25/62] tcp: Reset bytes_acked and bytes_received when disconnecting
Date:   Fri, 26 Jul 2019 17:24:37 +0200
Message-Id: <20190726152304.355430129@linuxfoundation.org>
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

From: Christoph Paasch <cpaasch@apple.com>

[ Upstream commit e858faf556d4e14c750ba1e8852783c6f9520a0e ]

If an app is playing tricks to reuse a socket via tcp_disconnect(),
bytes_acked/received needs to be reset to 0. Otherwise tcp_info will
report the sum of the current and the old connection..

Cc: Eric Dumazet <edumazet@google.com>
Fixes: 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info")
Fixes: bdd1f9edacb5 ("tcp: add tcpi_bytes_received to tcp_info")
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2630,6 +2630,8 @@ int tcp_disconnect(struct sock *sk, int
 	tcp_saved_syn_free(tp);
 	tp->compressed_ack = 0;
 	tp->bytes_sent = 0;
+	tp->bytes_acked = 0;
+	tp->bytes_received = 0;
 	tp->bytes_retrans = 0;
 	tp->duplicate_sack[0].start_seq = 0;
 	tp->duplicate_sack[0].end_seq = 0;


