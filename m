Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF85C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031C620866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003752;
	bh=Wsgxuzfmf8MpLBh4cCjlsXtj18cok1RUznmA3pkYYJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FvwpdZpKhOs0mSlJK5ZtukY2jsmGOfvcKRGMby9pXLMUMhGvXcpE1Iwc7R+jtntwH
	 1kIB5fBCxsvFwADuMQr6XdaOS+vOsvrr1DWpT3WtUp1Uzwit7I4sUZ2Sr5oCr9UKSS
	 Rnni9z0HirtwcIcugMWtRuADMZQApZ6qsdRJg1A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgABWWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgABWWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:22:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B2520863;
        Thu,  2 Jan 2020 22:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003742;
        bh=Wsgxuzfmf8MpLBh4cCjlsXtj18cok1RUznmA3pkYYJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVkg/xK3xfXrKH0P9f+IS0Frc9VqqmoKtYs3+4u9QsJBuJ3TJAzkcxGP/fEajwe0/
         RA5FLTtLwJK796aCkPenUWwNXP7wr1FS4aMTlCu8cxyTiRaNIR88QXirgJfiehipbx
         7JF9GS5JNaRuKD2QCYDj7l/ZbUC9HdmOB9tceBvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Antonio Messina <amessina@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 095/114] udp: fix integer overflow while computing available space in sk_rcvbuf
Date:   Thu,  2 Jan 2020 23:07:47 +0100
Message-Id: <20200102220038.721516462@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antonio Messina <amessina@google.com>

[ Upstream commit feed8a4fc9d46c3126fb9fcae0e9248270c6321a ]

When the size of the receive buffer for a socket is close to 2^31 when
computing if we have enough space in the buffer to copy a packet from
the queue to the buffer we might hit an integer overflow.

When an user set net.core.rmem_default to a value close to 2^31 UDP
packets are dropped because of this overflow. This can be visible, for
instance, with failure to resolve hostnames.

This can be fixed by casting sk_rcvbuf (which is an int) to unsigned
int, similarly to how it is done in TCP.

Signed-off-by: Antonio Messina <amessina@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1412,7 +1412,7 @@ int __udp_enqueue_schedule_skb(struct so
 	 * queue contains some other skb
 	 */
 	rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
-	if (rmem > (size + sk->sk_rcvbuf))
+	if (rmem > (size + (unsigned int)sk->sk_rcvbuf))
 		goto uncharge_drop;
 
 	spin_lock(&list->lock);


