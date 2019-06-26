Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F91C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E312146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561538751;
	bh=m+r8WZn0JHNESip98hh0zbj8d9dUzzzsVYLBLHsf/5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sa3vyzpkat5ctEJivEvXHBLKfFke38aU80VWt5CaAw3ZySm0jSUAeVcOggXv5AfXF
	 oQwc5RKW7L17KNwsOjX6VzkPp5xWIPm+x+V8myCMNNUvPPdzoP8VDqEq1Nl8OLwyir
	 wRJXysgX7MS2fXEs7MLvuoIE5ryYmCy/nSw72Fj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfFZIpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfFZIpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:45:49 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F30208E3;
        Wed, 26 Jun 2019 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561538749;
        bh=m+r8WZn0JHNESip98hh0zbj8d9dUzzzsVYLBLHsf/5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBolewu2FJlE249SQz1bC/bW9zxyfNo9J/fZWCSfn3PDZM94kzrdpWCw9avCWu+Nz
         dbtiHakDeNtUPRV0q2bh2gOJ7wPV3tdW45NWl31EHVnSVv8U98YMIFuN0EM2P9YokJ
         yoa3Fgh/RIxu94YUfnaPwQ7YmduCRsbRS2ONNoVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Christoph Paasch <cpaasch@apple.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 1/1] tcp: refine memory limit test in tcp_fragment()
Date:   Wed, 26 Jun 2019 16:45:21 +0800
Message-Id: <20190626083606.343066126@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626083606.248422423@linuxfoundation.org>
References: <20190626083606.248422423@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit b6653b3629e5b88202be3c9abc44713973f5c4b4 upstream.

tcp_fragment() might be called for skbs in the write queue.

Memory limits might have been exceeded because tcp_sendmsg() only
checks limits at full skb (64KB) boundaries.

Therefore, we need to make sure tcp_fragment() wont punish applications
that might have setup very low SO_SNDBUF values.

Fixes: f070ef2ac667 ("tcp: tcp_fragment() should apply sane memory limits")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Christoph Paasch <cpaasch@apple.com>
Tested-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/tcp_output.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1274,7 +1274,7 @@ int tcp_fragment(struct sock *sk, struct
 	if (nsize < 0)
 		nsize = 0;
 
-	if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
+	if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf + 0x20000)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
 		return -ENOMEM;
 	}


