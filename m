Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF6CC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87542205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419597;
	bh=E0xi42Eh5/Ioz/m8D7xajaM986ayxJaaFoUc0OL7jto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vYHLUrti/PSEKmkmKnyF/jrsRlWhsdVz4+4SGzzXnCfLl6lfhzXN8QYWVRutGFptO
	 Kw9hd8PhuwFUTPDvluaNYy/UKRfzb0e9H7v0ikn+eRLR4xax4KHnoNMOdoGrz/GDcS
	 Ya5QtCvaNlEMncxKZ6LfMvW8/9AM37S8Z6dezlPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391620AbfGRDNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391606AbfGRDNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:13:11 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D148620818;
        Thu, 18 Jul 2019 03:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419591;
        bh=E0xi42Eh5/Ioz/m8D7xajaM986ayxJaaFoUc0OL7jto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ViaVbCnvx28dmvoIuYygSGlYSDP4pedfDsKJINupi6QqnvSgPNKMlEkne0x6W9Hqi
         gD/e3O0YuHvdP9ldboPATYm1cGAJaUueB9MaOeYnBcYgZp2f57AKglu3qUtXrAw3nr
         ZxzGv94dBZSQaAI5FPPN9WmNr/3caWCsvYBo/uYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Yi <teroincn@163.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 21/54] net :sunrpc :clnt :Fix xps refcount imbalance on the error path
Date:   Thu, 18 Jul 2019 12:01:51 +0900
Message-Id: <20190718030050.991306165@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
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
index 244eac1bd648..de18a463ac96 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2718,6 +2718,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	xprt = xprt_iter_xprt(&clnt->cl_xpi);
 	if (xps == NULL || xprt == NULL) {
 		rcu_read_unlock();
+		xprt_switch_put(xps);
 		return -EAGAIN;
 	}
 	resvport = xprt->resvport;
-- 
2.20.1



