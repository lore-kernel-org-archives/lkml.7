Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AABD2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414691;
	bh=gmkqITVE8PGJGuEhaWc9mN+E4wkFS7wTkN2DS9OIQpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l4Ctg9dtdh2dMxT6N/WJQN9LtvpXhw5LoA9ze7z6IMPFdiYge/mXbYiYB74kdOnvb
	 Zk+bgej2zzvKMc4S1TpbOtlj9Z6t4JGCaYRmefyDOWr8dNp0garRFmbSsJNpdWrwgv
	 mjjlEgsDteZ6Q8hgxotuIxSX1HMGbAj6Bv0uOxYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfLCXLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbfLCWlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:41:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77892080F;
        Tue,  3 Dec 2019 22:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412870;
        bh=gmkqITVE8PGJGuEhaWc9mN+E4wkFS7wTkN2DS9OIQpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zj/mtU4sxdkPtF8WoZkZCwCCw0eWzMiQqAQ7y4z/ELHwlt0o5LX89BAeeKfBUNJFR
         4pMhlQBOuyowdtXazXEJe1i7cFT1iUo6i1mext9I9dJZ40ovM8LrLdfG8uETtVwo36
         dmcmqm1mrcYUgVvWDNPELcm3BA7pzcXwAHllTcYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 049/135] netfilter: nf_tables_offload: skip EBUSY on chain update
Date:   Tue,  3 Dec 2019 23:34:49 +0100
Message-Id: <20191203213019.293433576@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 88c749840dff58e7a40e18bf9bdace15f27ef259 ]

Do not try to bind a chain again if it exists, otherwise the driver
returns EBUSY.

Fixes: c9626a2cbdb2 ("netfilter: nf_tables: add hardware offload support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index c0d18c1d77ac0..04fbab60e8080 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -241,7 +241,8 @@ int nft_flow_rule_offload_commit(struct net *net)
 
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWCHAIN:
-			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD))
+			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD) ||
+			    nft_trans_chain_update(trans))
 				continue;
 
 			err = nft_flow_offload_chain(trans, FLOW_BLOCK_BIND);
-- 
2.20.1



