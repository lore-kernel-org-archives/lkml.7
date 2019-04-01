Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6754C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B620663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141903;
	bh=aVDAKpKMtYU6XDXnAuO6ah9ym975p3qTie7u45JKtXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ezGY5XDFgHc5uiY5Io582iZTwJQNn53iD41clfCunhLkOQzjTgNbJWSkV9ZZrPxdC
	 TOym/yemHDyVztZXY5z31tY7dWtnVmr3hS3kV7GaEGYCFPqudYpSCC29kGcm0pCBvh
	 zepYtGotm7uKlxKNZ8l2qmF76T0RauIHdQSvvi+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfDARNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbfDARNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FEF21929;
        Mon,  1 Apr 2019 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138799;
        bh=aVDAKpKMtYU6XDXnAuO6ah9ym975p3qTie7u45JKtXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNOA4/Hcs/Yt/BKm8xi5tm4Jjv8wb3PIdvEv65XM6o5UylGlbePpFUm663JBfhzr6
         9M5KFhoAxlyuPA4sfUqQ7+lpO3pdayAhWC1v7iL6+KG7knlnuiPS/n5PKAL2Mk/H0r
         JStDfhxm4LMOt96EfiT4NwgqmpjBSYm4oVFIkLow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Hugne <erik.hugne@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 024/134] tipc: fix cancellation of topology subscriptions
Date:   Mon,  1 Apr 2019 19:01:00 +0200
Message-Id: <20190401170046.816167363@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -371,6 +371,7 @@ static int tipc_conn_rcv_sub(struct tipc
 	struct tipc_subscription *sub;
 
 	if (tipc_sub_read(s, filter) & TIPC_SUB_CANCEL) {
+		s->filter &= __constant_ntohl(~TIPC_SUB_CANCEL);
 		tipc_conn_delete_sub(con, s);
 		return 0;
 	}


