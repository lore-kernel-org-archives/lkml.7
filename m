Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE44EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED3221929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138303;
	bh=elC6tO4aIwp6jF6mrPbA9cLRM5iux1TRFnjl3Dtnh1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drQBThoiljC1BzMgu9r1PM9cgHLWMZNi/Spcf3mmYubdMtgIplICv6svAdWBRmSpd
	 Au7iD3A1UAetj9rylawUXZkLq3ZUKsy/sjWQuFvQ2P6oLlPeUjeIR20ytQ9ZYcskT5
	 dinmcvvYlZUwmRwDrRgFxMGfeOjcaouugkQSuEw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfDARFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbfDARE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:04:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B109621925;
        Mon,  1 Apr 2019 17:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138298;
        bh=elC6tO4aIwp6jF6mrPbA9cLRM5iux1TRFnjl3Dtnh1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7iLTswtBbfdwV2mpOwl6IOA3Dr3YcK1eg3TSyIVYGjlRFqn+RQnHVG9HXZrX1IWx
         dJ+qMt8H0HO4r7g+HI2aMb6v5h6CK16pbaSaAwDElfiVVgDa+h+mXshfK81vfxQg2C
         N1FvjMGGF6m6npAgWZIFgwshKBij4VtOqg+OLkKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Hugne <erik.hugne@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 025/146] tipc: fix cancellation of topology subscriptions
Date:   Mon,  1 Apr 2019 19:00:37 +0200
Message-Id: <20190401170050.670992708@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Hugne <erik.hugne@gmail.com>

[ Upstream commit 33872d79f5d1cbedaaab79669cc38f16097a9450 ]

When cancelling a subscription, we have to clear the cancel bit in the
request before iterating over any established subscriptions with memcmp.
Otherwise no subscription will ever be found, and it will not be
possible to explicitly unsubscribe individual subscriptions.

Fixes: 8985ecc7c1e0 ("tipc: simplify endianness handling in topology subscriber")
Signed-off-by: Erik Hugne <erik.hugne@gmail.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/topsrv.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -365,6 +365,7 @@ static int tipc_conn_rcv_sub(struct tipc
 	struct tipc_subscription *sub;
 
 	if (tipc_sub_read(s, filter) & TIPC_SUB_CANCEL) {
+		s->filter &= __constant_ntohl(~TIPC_SUB_CANCEL);
 		tipc_conn_delete_sub(con, s);
 		return 0;
 	}


