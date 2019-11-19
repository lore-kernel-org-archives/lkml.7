Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10735C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB076208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141443;
	bh=T4y2+RPPIQ0AhjT0SFGYuLVy+d3OoveBh8f7VqZlUIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PvR7izbjoORlf74tuK3gs0nFg0oz+voZFoosyX1LJI5G0hXy4zTBBE+LN587OG9WH
	 BxXqrMcpYgnWBQwmop2u9MEHcZ9cN83C7R/yqudJ09c0uMzs7eV/vFk9mpveh+O/qB
	 vDz2v1buRhld/GLC4dbTvOP5wbZstWaI4Ailvn+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfKSFam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbfKSFal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:30:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46975208C3;
        Tue, 19 Nov 2019 05:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141439;
        bh=T4y2+RPPIQ0AhjT0SFGYuLVy+d3OoveBh8f7VqZlUIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbfzN3H9vpfAoKWUwuBiDX9RCm3j9329ozUtLRfmFQ7lpQJjf9/yYi540atIttB+i
         4zomJ0ar2NOPDTpvPRrEv3VpfFPLoxfgIb6bl103r31NNV7ww4hG93TOSaH54ZklvF
         qHsXQBvpIvz2m4zyUUGHVx6wr8BiIT9vy5Zry1vU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 161/422] IB/hfi1: Missing return value in error path for user sdma
Date:   Tue, 19 Nov 2019 06:15:58 +0100
Message-Id: <20191119051408.924527264@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

[ Upstream commit 2bf4b33f83dfe521c4c7c407b6b150aeec04d69c ]

If the set_txreq_header_agh() function returns an error, the exit path
is chosen.

In this path, the code fails to set the return value.  This will cause
the caller to not realize an error has occurred.

Set the return value correctly in the error path.

Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/user_sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index cbff746d9e9de..684a298e15037 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -856,8 +856,10 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, unsigned maxpkts)
 
 				changes = set_txreq_header_ahg(req, tx,
 							       datalen);
-				if (changes < 0)
+				if (changes < 0) {
+					ret = changes;
 					goto free_tx;
+				}
 			}
 		} else {
 			ret = sdma_txinit(&tx->txreq, 0, sizeof(req->hdr) +
-- 
2.20.1



