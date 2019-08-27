Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8A4C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156D5217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892456;
	bh=//oeRa0uJ7XUOu2d3wq+iG/HBwqW0QTZBAbPSgQ/FLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OCwvYMO6gaNblNN8/1s5PzsDZvvWOKUWj3oBitHNjkK61Lurzd23OLzVXUlkOhsGa
	 SKTP3TXnqkHzSDJsZ3naMavgd6Na4vGjUM0bJRvwyqrty/S3QjL2LKwZjmXSkY/wbk
	 2Xl8meuqGnpP94Qg4UgtbzC9FJpII/bTKdYabCRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfH0HyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729967AbfH0HyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:54:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB25B206BF;
        Tue, 27 Aug 2019 07:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892444;
        bh=//oeRa0uJ7XUOu2d3wq+iG/HBwqW0QTZBAbPSgQ/FLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqfwGY95pO6MR4xpq+RMnr8wHv0W+TDC8MMOHBILoEqVc/u+5s65TLsqwgSeloCYv
         tCypPfBfWZMx1n7+hJzKXfOSlLbGGI42MY7bH7YIH+k17ZRlEZp25SSp/uhTCw7Zhz
         yN0oErMUDq85pwezzeSOK+xvDVqAx0aD/tlNP5mw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shijie Luo <luoshijie1@huawei.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 15/62] netfilter: ipset: Fix rename concurrency with listing
Date:   Tue, 27 Aug 2019 09:50:20 +0200
Message-Id: <20190827072701.219477127@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6c1f7e2c1b96ab9b09ac97c4df2bd9dc327206f6 ]

Shijie Luo reported that when stress-testing ipset with multiple concurrent
create, rename, flush, list, destroy commands, it can result

ipset <version>: Broken LIST kernel message: missing DATA part!

error messages and broken list results. The problem was the rename operation
was not properly handled with respect of listing. The patch fixes the issue.

Reported-by: Shijie Luo <luoshijie1@huawei.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index a3f1dc7cf5382..dbf17d3596a69 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1128,7 +1128,7 @@ static int ip_set_rename(struct net *net, struct sock *ctnl,
 		return -ENOENT;
 
 	write_lock_bh(&ip_set_ref_lock);
-	if (set->ref != 0) {
+	if (set->ref != 0 || set->ref_netlink != 0) {
 		ret = -IPSET_ERR_REFERENCED;
 		goto out;
 	}
-- 
2.20.1



