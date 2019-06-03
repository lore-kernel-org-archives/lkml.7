Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5116C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7460C27E2B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553025;
	bh=wKCZQfloSpRZsgtcJU3MXzB5pE5c7tabPFKee3XowaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LSdN1Gpyby0IY5PfJ12NWXMAbvgwvoEr5Yzzm1TO9xA3pSY08YWHAQdGrr0ew93h6
	 P7O9u2qomCnCr64zt1cSFsQM8sPJruOvOffNl0bOr1GJroW1KlROBWoc+AyNtERUC4
	 VlgXm1w516esDR1Y7vuFmsAYmnytOX7OT5RdwS0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfFCJKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfFCJKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:10:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65B9427E29;
        Mon,  3 Jun 2019 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553022;
        bh=wKCZQfloSpRZsgtcJU3MXzB5pE5c7tabPFKee3XowaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nROb5jCzzzQzFIYt1B3B7TZ28EiWT1a0C5SLuYufEftzFu7gccfte0xyAq/mntwQR
         AOjGTLu9bC7YM+Joy5BorErv2UyiRZiZK09WBmYKRy/hrrNvj8i7HwCFnXhFF4lu2J
         uryWmECuC0/9jl977U4zGMmkuDnCCg7JZxCm9h4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 25/32] net/tls: dont ignore netdev notifications if no TLS features
Date:   Mon,  3 Jun 2019 11:08:19 +0200
Message-Id: <20190603090315.254419938@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090308.472021390@linuxfoundation.org>
References: <20190603090308.472021390@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit c3f4a6c39cf269a40d45f813c05fa830318ad875 ]

On device surprise removal path (the notifier) we can't
bail just because the features are disabled.  They may
have been enabled during the lifetime of the device.
This bug leads to leaking netdev references and
use-after-frees if there are active connections while
device features are cleared.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_device.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -974,7 +974,8 @@ static int tls_dev_event(struct notifier
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (!(dev->features & (NETIF_F_HW_TLS_RX | NETIF_F_HW_TLS_TX)))
+	if (!dev->tlsdev_ops &&
+	    !(dev->features & (NETIF_F_HW_TLS_RX | NETIF_F_HW_TLS_TX)))
 		return NOTIFY_DONE;
 
 	switch (event) {


