Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85854C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5406B21851
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595736;
	bh=B3CZpFCZfujO0wRU1Z+VFM6p3mkeCatXZXup9oVpGio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O6s7V41U1RLGQrTEiWyZFerK5/Pfljt3rtpzSmJzPT5BjWhAjb3n26WzcSN6yhtpD
	 ePJsk9Z+EbVpp0OerOnM8qziCdW381IgjrpNQG7+2PLxWDcbKjxsTO9hWSQxf9FoNu
	 46LxhisKhuQP+WfQk4NLjRGtPCAPaDHAFZb4FAFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfF0Aff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfF0Afb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:35:31 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A2D72184E;
        Thu, 27 Jun 2019 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595731;
        bh=B3CZpFCZfujO0wRU1Z+VFM6p3mkeCatXZXup9oVpGio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkxuG/47mX08DNMWhf9Rz77pLYSi/UUM2aQuNsGdiPzR2u/OeQ9iMBn7733F50r3S
         Di5O/gLHS3iBtjIirc9EGIR9oSqXgEFU5mDuqgtVZTDHmFnneMng+rC0tebPTFfbfq
         N1EBhDezXSgof7GG61F4ghDfX2nyj1wTc2bKiea4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lin Yi <teroincn@163.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 95/95] net :sunrpc :clnt :Fix xps refcount imbalance on the error path
Date:   Wed, 26 Jun 2019 20:30:20 -0400
Message-Id: <20190627003021.19867-95-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Yi <teroincn@163.com>

[ Upstream commit b96226148491505318228ac52624956bd98f9e0c ]

rpc_clnt_add_xprt take a reference to struct rpc_xprt_switch, but forget
to release it before return, may lead to a memory leak.

Signed-off-by: Lin Yi <teroincn@163.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index ea8d5aed1e2c..b3654d3d346f 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2766,6 +2766,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	xprt = xprt_iter_xprt(&clnt->cl_xpi);
 	if (xps == NULL || xprt == NULL) {
 		rcu_read_unlock();
+		xprt_switch_put(xps);
 		return -EAGAIN;
 	}
 	resvport = xprt->resvport;
-- 
2.20.1

