Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E36C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709AD222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118212;
	bh=Z5K104AeOyNdbPg+AtmXlyXO1njHendpyh/MCwlZFf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i6+mWU8GfPZVV3dneBRuxcLICCN+whLsCJif8Cd1exeqO0C1WYN23GWx+xWiyyc8b
	 LRh3Ogb5tLjtmn8RbTY5YAUqU+6GgV5rfX05M3krdPgOZA0iOjQCW/smECbNHCD3ge
	 ilugwnBPH4aXgcXA8QB9ucO8U78fd+9OYBd8hU5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfJCP4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730765AbfJCP4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:56:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4EB2222BE;
        Thu,  3 Oct 2019 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118208;
        bh=Z5K104AeOyNdbPg+AtmXlyXO1njHendpyh/MCwlZFf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/qjaqGCPVNy5a1YDO5Gd2HimRq3JMegvfRuqKzGYqCGo2eJ2gkPhRoY5Gwt58AJX
         zgxtfG12C+M4zamTjoeAND54SxRSbf8ZaXYYylBaoByN0eXNlpJaAUf3wFszLImTnj
         H7olOOYm3M5/CsM1vJnY0PNjvVSZEDWNHC9FS0mI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ori Nimron <orinimron123@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 28/99] mISDN: enforce CAP_NET_RAW for raw sockets
Date:   Thu,  3 Oct 2019 17:52:51 +0200
Message-Id: <20191003154308.059086207@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
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
@@ -763,6 +763,8 @@ base_sock_create(struct net *net, struct
 
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
+	if (!capable(CAP_NET_RAW))
+		return -EPERM;
 
 	sk = sk_alloc(net, PF_ISDN, GFP_KERNEL, &mISDN_proto, kern);
 	if (!sk)


