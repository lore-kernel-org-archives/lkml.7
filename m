Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D242C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5044D218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787730;
	bh=nYyGFSB0DeOQ/ndHApSvFwwBR/rmzm1EBgp+JwNpHME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FbGwIBa8OmCBf1ELi3dpVtqq/d+KEh4B5YLXvi7ZmyW6mW3nV8drFNFre7Z/B+b/S
	 2cqBAbj6DtS6hIQCxeEaMEhaydDigx8cFFY0XoYPMVP7V/e9/8rXfEI6lLArSCpI8c
	 Fq4x8apmMu5WVYlLHoPEy4Jk+1bYUuUuMPlMJ/UM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfIRGWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfIRGWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:22:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539D3218AE;
        Wed, 18 Sep 2019 06:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787725;
        bh=nYyGFSB0DeOQ/ndHApSvFwwBR/rmzm1EBgp+JwNpHME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yjO1JZvGY9hOF1sOg0tcq470aqTQlE7nLXBPSZAimrM4D2meA1AHrSCBl+xPWA63W
         Qu1ZuPzsmnY4Nr3hrf/9RWvvNQ5jLj5JrI5wJggP1EyJNgWgowchHOL97/I2dQyCOq
         d+W6tEuTJqsd2jH15RkdyA/St3iTcpNbkQjQ2Oq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 11/50] sctp: Fix the link time qualifier of sctp_ctrlsock_exit()
Date:   Wed, 18 Sep 2019 08:18:54 +0200
Message-Id: <20190918061224.227909382@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061223.116178343@linuxfoundation.org>
References: <20190918061223.116178343@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit b456d72412ca8797234449c25815e82f4e1426c0 ]

The '.exit' functions from 'pernet_operations' structure should be marked
as __net_exit, not __net_init.

Fixes: 8e2d61e0aed2 ("sctp: fix race on protocol/netns initialization")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/protocol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1350,7 +1350,7 @@ static int __net_init sctp_ctrlsock_init
 	return status;
 }
 
-static void __net_init sctp_ctrlsock_exit(struct net *net)
+static void __net_exit sctp_ctrlsock_exit(struct net *net)
 {
 	/* Free the control endpoint.  */
 	inet_ctl_sock_destroy(net->sctp.ctl_sock);


