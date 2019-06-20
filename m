Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15CCC4646C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16D32089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054859;
	bh=Egf73Uthvql39YGQPG2N1+kk+ff3ZyCN98Dwq0WQUj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uASBnL0nAl1eK6omcznrKrblbHryTQIgZEHVorpH5utBcckA2W5+heHSi3Wq369uy
	 tonaAEhD13Xx+uAEMAbsEfNmxWgJBEqu31PTE0OcExSodaclC9wtMvXaRbUVTnLtwt
	 YwQs8Evhe/qujmDARX6iP1v8+8qWiPQ/1z4zlcoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfFTSNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfFTSNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:13:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C5582089C;
        Thu, 20 Jun 2019 18:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054383;
        bh=Egf73Uthvql39YGQPG2N1+kk+ff3ZyCN98Dwq0WQUj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAEh/IOxdRXhR4WskXmnv6fv2kvT62Isp7cE40CUMVrR11yy7ERcX90BjPLl2T5AS
         QNxuarU2qKqFuaJ9epSpX4ft1FBfPbV5Z0P8PgN/rywEgRLRP+6BmD//WWC9uiJ3FC
         OdABTGqHCQV4J5INwymJR5BthLe/X+UcpsmF9g7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steinar H. Gunderson" <steinar+kernel@gunderson.no>,
        Andre Tomt <andre@tomt.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 10/98] net: tls, correctly account for copied bytes with multiple sk_msgs
Date:   Thu, 20 Jun 2019 19:56:37 +0200
Message-Id: <20190620174349.816327593@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 648ee6cea7dde4a5cdf817e5d964fd60b22006a4 ]

tls_sw_do_sendpage needs to return the total number of bytes sent
regardless of how many sk_msgs are allocated. Unfortunately, copied
(the value we return up the stack) is zero'd before each new sk_msg
is allocated so we only return the copied size of the last sk_msg used.

The caller (splice, etc.) of sendpage will then believe only part
of its data was sent and send the missing chunks again. However,
because the data actually was sent the receiver will get multiple
copies of the same data.

To reproduce this do multiple sendfile calls with a length close to
the max record size. This will in turn call splice/sendpage, sendpage
may use multiple sk_msg in this case and then returns the incorrect
number of bytes. This will cause splice to resend creating duplicate
data on the receiver. Andre created a C program that can easily
generate this case so we will push a similar selftest for this to
bpf-next shortly.

The fix is to _not_ zero the copied field so that the total sent
bytes is returned.

Reported-by: Steinar H. Gunderson <steinar+kernel@gunderson.no>
Reported-by: Andre Tomt <andre@tomt.net>
Tested-by: Andre Tomt <andre@tomt.net>
Fixes: d829e9c4112b ("tls: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1128,7 +1128,6 @@ static int tls_sw_do_sendpage(struct soc
 
 		full_record = false;
 		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
-		copied = 0;
 		copy = size;
 		if (copy >= record_room) {
 			copy = record_room;


