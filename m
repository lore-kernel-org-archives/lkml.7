Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2399C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CDC21925
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788367;
	bh=UBO9qQ7Q9bX3p1ZHy4EzyB90nXNRwkoo3UeXBDoltT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V/hqtQ08CYxbaKNYC+zvMRqQJr1T4FPqBK2ndyeYa+FlGPR7XF5bwXysR1GUEPa7a
	 QLc2qTE+QsA0g5MYWmlxRVO1dgTjBQzvnr9pj9V4IJFkcyHLweYedvigFnZwY42dea
	 +3F6ubhOXcPWbdoC2J5NT7o47XOxqn4QYm0sUPkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfIRGcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbfIRGVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:21:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D85C021920;
        Wed, 18 Sep 2019 06:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787691;
        bh=UBO9qQ7Q9bX3p1ZHy4EzyB90nXNRwkoo3UeXBDoltT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iidGJFi/UjkrDvRAjH0zxZXiAGtAJSd9nAGwi8bg1hcpB+DxxZqHsjNCW0Cf6oT+0
         KIXcbLnS5KGhHow8E0P3cTEYhyPwF8PiTnAuYkGc7mM5eRqHlQ6A7wswWIW/7XR/zk
         SFMSkiH3LV0gcbem65Q+mXcYgtajKjc6tnCKHbhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/45] sctp: Fix the link time qualifier of sctp_ctrlsock_exit()
Date:   Wed, 18 Sep 2019 08:18:47 +0200
Message-Id: <20190918061223.787736455@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
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
@@ -1344,7 +1344,7 @@ static int __net_init sctp_ctrlsock_init
 	return status;
 }
 
-static void __net_init sctp_ctrlsock_exit(struct net *net)
+static void __net_exit sctp_ctrlsock_exit(struct net *net)
 {
 	/* Free the control endpoint.  */
 	inet_ctl_sock_destroy(net->sctp.ctl_sock);


