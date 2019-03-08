Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B06C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CA420661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050347;
	bh=wXtnDlmG7Um42lhzaCFdvajnDjGxnAWXXtu48nTFsj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDM4wf75V4NcN2uXLM1Q2lIOPhwN2p/i8w3TuV8xerlHLBFwxHyBN8xb2DZDg2YTc
	 xSfBdas0+337A0cXZBHl7VHA60YRnX8FC7lSuI/lpeLdOPEJGVnpHaYqNKARrPmdEe
	 g5jp/a0chHie/+inJtdnNz5k8z7iRRR1Mcx0O+Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfCHNFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfCHM4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:56:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 678122085A;
        Fri,  8 Mar 2019 12:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049772;
        bh=wXtnDlmG7Um42lhzaCFdvajnDjGxnAWXXtu48nTFsj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGk0ZuTVxCzzeavJuj5H8XDZFP4129nWT/2YBsQ9zli5PB9sKgfKCQp1Uq5oMNWlJ
         XK7mVKLdQCu8ToqyoMGq0xEOD5qt1/k9aForMrpsBTHeRaaDt7XrU5nZbLIwxCkOdn
         EhH99ChssnuPH+LDYWESuLB2yB7U4HYNt6cnXNOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Buslov <vladbu@mellanox.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 59/76] net: sched: act_tunnel_key: fix NULL pointer dereference during init
Date:   Fri,  8 Mar 2019 13:50:11 +0100
Message-Id: <20190308124916.887822280@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@mellanox.com>

[ Upstream commit a3df633a3c92bb96b06552c3f828d7c267774379 ]

Metadata pointer is only initialized for action TCA_TUNNEL_KEY_ACT_SET, but
it is unconditionally dereferenced in tunnel_key_init() error handler.
Verify that metadata pointer is not NULL before dereferencing it in
tunnel_key_init error handling code.

Fixes: ee28bb56ac5b ("net/sched: fix memory leak in act_tunnel_key_init()")
Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_tunnel_key.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -377,7 +377,8 @@ static int tunnel_key_init(struct net *n
 	return ret;
 
 release_tun_meta:
-	dst_release(&metadata->dst);
+	if (metadata)
+		dst_release(&metadata->dst);
 
 err_out:
 	if (exists)


