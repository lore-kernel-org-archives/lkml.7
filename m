Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD8C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321D92070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120743;
	bh=s0xutKlkCj+UQ8hTmA20iOU0UaH/rpwjtQ7opHQnesI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IsYm7pQn6sT1XyQR2gYqY2VVdQ+t2L+ws0VkxdDAyg1PGEYYeNRsCNF9P4i/EZ98w
	 kTiHIU+xv9IZ6rGnEoZW9928gZIrrp+B89dst3qzOcQk9aFnH95wZqFRwj0HrgSxBq
	 7UowInVVXfFwrCtRoFgWX95ij2mUtotRqZV4fKNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404755AbfJCQjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403971AbfJCQjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:39:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F57F2086A;
        Thu,  3 Oct 2019 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120739;
        bh=s0xutKlkCj+UQ8hTmA20iOU0UaH/rpwjtQ7opHQnesI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFfpE5K+E1GR8TLW4F8c1oDF1CLT7ulQTZO8DJgMhfto7TZhq2dfSfQC5+vfxRtNS
         yrD1NcpmWI+2Tq4PYZa6btVq1Fst4R2BMweDbGyuVobj2qhADlq4zUJI2lhiD4Ucmy
         c73r3b9+O0/jwID/UsuoALgnbexUPE1g+ZlnxA0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fae39afd2101a17ec624@syzkaller.appspotmail.com,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 020/344] net/rds: Check laddr_check before calling it
Date:   Thu,  3 Oct 2019 17:49:45 +0200
Message-Id: <20191003154542.073432324@linuxfoundation.org>
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

From: Ka-Cheong Poon <ka-cheong.poon@oracle.com>

[ Upstream commit 05733434ee9ae6548723a808647248583e347cca ]

In rds_bind(), laddr_check is called without checking if it is NULL or
not.  And rs_transport should be reset if rds_add_bound() fails.

Fixes: c5c1a030a7db ("net/rds: An rds_sock is added too early to the hash table")
Reported-by: syzbot+fae39afd2101a17ec624@syzkaller.appspotmail.com
Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/bind.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -244,7 +244,8 @@ int rds_bind(struct socket *sock, struct
 	 */
 	if (rs->rs_transport) {
 		trans = rs->rs_transport;
-		if (trans->laddr_check(sock_net(sock->sk),
+		if (!trans->laddr_check ||
+		    trans->laddr_check(sock_net(sock->sk),
 				       binding_addr, scope_id) != 0) {
 			ret = -ENOPROTOOPT;
 			goto out;
@@ -263,6 +264,8 @@ int rds_bind(struct socket *sock, struct
 
 	sock_set_flag(sk, SOCK_RCU_FREE);
 	ret = rds_add_bound(rs, binding_addr, &port, scope_id);
+	if (ret)
+		rs->rs_transport = NULL;
 
 out:
 	release_sock(sk);


