Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52333C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D3E216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562598943;
	bh=gecknaLnpxJAkcz09//PUVx/i0m8/5EUXaITOfUOD1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xgnPsxye/smryml+grvphJMBGTx+V9bh+kURhcaKZSBCGJJ69c6MwIkxFfkYS6TXy
	 stqtELmYP8ROEXW+u22wFDcIJ1NlflS3s7NLxljuo2xsyVJoWv56pokHoCh9DxatcI
	 JsXJSh8rKicY1LETeOjLkvYCqFNK4gdBBhuao8AI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfGHPPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732370AbfGHPPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:15:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADAC4216E3;
        Mon,  8 Jul 2019 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562598936;
        bh=gecknaLnpxJAkcz09//PUVx/i0m8/5EUXaITOfUOD1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUbuHdEqul2Ayrn57K1uUUGbv8TftxwrD0w71YO1qNQg5vCyzPKvSIz1bxXHJDeVS
         gXlUimtWtWuD9NYjB4zkvApTDtFM/iVhNpPmCwVAqV8QmC2laSW1a9Ycfu/o0aiRQs
         BD4qlVPCxYfjSuB1KGbbEshIj4bJnZ09ZTXG4lnw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.4 22/73] can: purge socket error queue on sock destruct
Date:   Mon,  8 Jul 2019 17:12:32 +0200
Message-Id: <20190708150521.526939612@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

commit fd704bd5ee749d560e86c4f1fd2ef486d8abf7cf upstream.

CAN supports software tx timestamps as of the below commit. Purge
any queued timestamp packets on socket destroy.

Fixes: 51f31cabe3ce ("ip: support for TX timestamps on UDP and RAW sockets")
Reported-by: syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/can/af_can.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -113,6 +113,7 @@ EXPORT_SYMBOL(can_ioctl);
 static void can_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge(&sk->sk_error_queue);
 }
 
 static const struct can_proto *can_get_proto(int protocol)


