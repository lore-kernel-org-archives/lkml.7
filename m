Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC16C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691132053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419427;
	bh=B5URgfaTe+t9l8CMVHfSaNqLrRqPX2HS2H0hr5sPhAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VGdFJGTkpnyTx5dF5vWvthQ1hQNL33YCIhkk6ImfO1kkG97+8k6Xhq4LP3iXl0E8z
	 1IeVrYDTmZ9FXahIq6mJm++2T5+Q2C9KGAVo4Jlv5n4v/BU0mbtOncYQ4OA2sNmGOq
	 mgFeQZ+sYvMQrCDGYIXFDYk/Sttqel247nzL7hV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390200AbfGRDK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390108AbfGRDKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:10:15 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E03021871;
        Thu, 18 Jul 2019 03:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419414;
        bh=B5URgfaTe+t9l8CMVHfSaNqLrRqPX2HS2H0hr5sPhAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfV3wO8UOfZsb41kNKK2yj4kvWkLOuIiWSO7K8TR3v/GGUslsk/lwTfhCKYfu85XG
         ilfvyUofvirIvIYVsNOyQ4n0ZGu4yIuELKZ6oMpSBndlc3PwFjWQovxhgUL+TTwQQH
         S4rw5EghdZtqt3vl0AkEMf4B8WerzF206wWUc9No=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Yi <teroincn@163.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 39/80] net :sunrpc :clnt :Fix xps refcount imbalance on the error path
Date:   Thu, 18 Jul 2019 12:01:30 +0900
Message-Id: <20190718030101.666672827@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 6d118357d9dc..9259529e0412 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2706,6 +2706,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	xprt = xprt_iter_xprt(&clnt->cl_xpi);
 	if (xps == NULL || xprt == NULL) {
 		rcu_read_unlock();
+		xprt_switch_put(xps);
 		return -EAGAIN;
 	}
 	resvport = xprt->resvport;
-- 
2.20.1



