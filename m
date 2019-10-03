Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA87C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8054020830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120879;
	bh=TVLXiu/Wu0XFZ4nGnunWANHINoWqCjOOWL8M5FUu7eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kWhaCNZg/qMJpClkZsNuWWT5MccKo7T2vBu7ZCsi57wDkF549XJyrc7sdSohfCoFM
	 2cf+rTZVRdWTAD4tAH2FGvDRV+GxxZYms+xttB9/Yl8+GncZVHgMMtCL4un80qGSER
	 lsaHOJG1Q+1Uln6enf0orGZwQcA7rT2lr5Wbelhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405015AbfJCQlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392502AbfJCQlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:41:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4521B207FF;
        Thu,  3 Oct 2019 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120870;
        bh=TVLXiu/Wu0XFZ4nGnunWANHINoWqCjOOWL8M5FUu7eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZ1C2YJaVkSDj+CMYSIKNG43PQ4jqOeICLKbjOT1/ZlNa216KHyZuxUnzMR+DndKL
         Iinf3YPtnjJ5rEnVYkk0Y3AY3PjZqsbiERlPHBgf3FXxZtgSs8PcCS4xHOllpieFSf
         DaTLFfv+hbJrGT2F6zCQFGnx4pSWHJu5mgrDKhis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ori Nimron <orinimron123@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 033/344] mISDN: enforce CAP_NET_RAW for raw sockets
Date:   Thu,  3 Oct 2019 17:49:58 +0200
Message-Id: <20191003154543.345992136@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ori Nimron <orinimron123@gmail.com>

[ Upstream commit b91ee4aa2a2199ba4d4650706c272985a5a32d80 ]

When creating a raw AF_ISDN socket, CAP_NET_RAW needs to be checked
first.

Signed-off-by: Ori Nimron <orinimron123@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/mISDN/socket.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -754,6 +754,8 @@ base_sock_create(struct net *net, struct
 
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
+	if (!capable(CAP_NET_RAW))
+		return -EPERM;
 
 	sk = sk_alloc(net, PF_ISDN, GFP_KERNEL, &mISDN_proto, kern);
 	if (!sk)


