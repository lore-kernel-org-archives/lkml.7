Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22D320674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413958;
	bh=XJkddDQE9s/f7qQY0cKrwqiTwysFXGZyfUzENxoinlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EQxl/1qfQ2Bv1GRXdtT0aVh7NG365yFPqN5+TRvWzmQQnCW34BPeG3SaWjg6nG2Vk
	 CpntrckNhzNubzx9SjKNE13h1WN5utF17XMDEm4Rd/xEi3dmuG0m1mqlnDyfh1JO9L
	 O50MLCBAy/Q4JrgMyPj3+TWS4ORJK9JD+yzmri2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfLCW7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:59:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbfLCW7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:59:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D765D20803;
        Tue,  3 Dec 2019 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413953;
        bh=XJkddDQE9s/f7qQY0cKrwqiTwysFXGZyfUzENxoinlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1g/dXJt1wGYip2tvh9p80+Q22wyvprrbmRPrMNqHSNIXu/So9ZFpLPGVO73vLW0Zy
         VFJQ4mN2x7D/giFFDX1/DeHFuN8myOg3A/TIE8PfOwzGqE1qZXGFQ+Q5LuCjl8Fj1m
         1OHDv7rGxMB/l7VyQiKHpt9WhWbJ1OGWIXm9R9gE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 303/321] tcp: exit if nothing to retransmit on RTO timeout
Date:   Tue,  3 Dec 2019 23:36:09 +0100
Message-Id: <20191203223442.911850160@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuchung Cheng <ycheng@google.com>

commit 88f8598d0a302a08380eadefd09b9f5cb1c4c428 upstream.

Previously TCP only warns if its RTO timer fires and the
retransmission queue is empty, but it'll cause null pointer
reference later on. It's better to avoid such catastrophic failure
and simply exit with a warning.

Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/tcp_timer.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -443,10 +443,8 @@ void tcp_retransmit_timer(struct sock *s
 		 */
 		return;
 	}
-	if (!tp->packets_out)
-		goto out;
-
-	WARN_ON(tcp_rtx_queue_empty(sk));
+	if (!tp->packets_out || WARN_ON_ONCE(tcp_rtx_queue_empty(sk)))
+		return;
 
 	tp->tlp_high_seq = 0;
 


