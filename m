Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33834C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8F02054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155140;
	bh=NZBYPz9/upGof+pf+7aPQwh2oUQ15oTbaqLDqA5xc1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hbP6BGv4IRL54xlPmbJpaqcZZDtkuI9v7OUEb2eRzgV9JoZqL+074E0GQuMPkjzrZ
	 WwEkjY4x99tNUU2dRORr3d04/rTEviXkiHbtER8mSEH86K4nwc9OWuop0DkBROUo9r
	 IDeoElvaVEsOb3FkpW5Hn72+oey/u8vbbqzAN18Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389449AbfGZPcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389437AbfGZPcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:32:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC6D22054F;
        Fri, 26 Jul 2019 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155136;
        bh=NZBYPz9/upGof+pf+7aPQwh2oUQ15oTbaqLDqA5xc1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1ftNZ1FuC6cFKjiV0+ZfMfCIhahfFrWW9ZZik3WQwXCeAgBC7KFhLOIS9TUNK1GJ
         f3mP0OHWrO8HjMUu3ibBGlZ2J7xLJ2rZK+ntM/dGZagbTtFHKFwFtV4tniLz2HcIDb
         G9lYfs8SXeJ1dql7kBNsETm7UW8g2vmpI/H7UyzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Wei <albin_yang@163.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 15/50] nfc: fix potential illegal memory access
Date:   Fri, 26 Jul 2019 17:24:50 +0200
Message-Id: <20190726152302.126128177@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152300.760439618@linuxfoundation.org>
References: <20190726152300.760439618@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Wei <albin_yang@163.com>

[ Upstream commit dd006fc434e107ef90f7de0db9907cbc1c521645 ]

The frags_q is not properly initialized, it may result in illegal memory
access when conn_info is NULL.
The "goto free_exit" should be replaced by "goto exit".

Signed-off-by: Yang Wei <albin_yang@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/nci/data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -119,7 +119,7 @@ static int nci_queue_tx_data_frags(struc
 	conn_info = nci_get_conn_info_by_conn_id(ndev, conn_id);
 	if (!conn_info) {
 		rc = -EPROTO;
-		goto free_exit;
+		goto exit;
 	}
 
 	__skb_queue_head_init(&frags_q);


