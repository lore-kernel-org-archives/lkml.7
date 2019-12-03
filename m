Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928B7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5944B20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414617;
	bh=kL71wP3leg6UsZPFuAZ/oDTnuSVOuvvCd5M1TGU+M5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dhrEe4M6nW27yiEEJPzmd7ygOx9li6Wx/XuGf0bJ9r27Ax0rE15oVgHTxL+t8cHJi
	 TFjlKo1oUPdLAYO1GnfcCPP5/5IlNBbD/j6TPB3/+7OjuyHrDlbBlCAq2hsKtKGEuC
	 jz5GVGGR0mZwIEfeV1Nfj21SsokHOnPns5fxRXBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfLCWm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbfLCWmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:42:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144B920803;
        Tue,  3 Dec 2019 22:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412973;
        bh=kL71wP3leg6UsZPFuAZ/oDTnuSVOuvvCd5M1TGU+M5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mu89n6nWCB4/x7Ga+9ezMC+jNWG2sUaybFgAoL5trYiYA5FDqsyw1yImU5mZTgo+9
         MJLqxn0DySULuKjd3Yrct6KtI0HaF58AdxG8KkKrmm7NkMogaxyrxVXQuD/POH8aKi
         1PS1zBDRHHOPHsRQyygjl0z68QHJ0zFKxoBDi1NA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 048/135] netfilter: nf_tables: bogus EOPNOTSUPP on basechain update
Date:   Tue,  3 Dec 2019 23:34:48 +0100
Message-Id: <20191203213019.092932734@linuxfoundation.org>
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

[ Upstream commit 1ed012f6fd83e7ee7efd22e2c32f23efff015b30 ]

Userspace never includes the NFT_BASE_CHAIN flag, this flag is inferred
from the NFTA_CHAIN_HOOK atribute. The chain update path does not allow
to update flags at this stage, the existing sanity check bogusly hits
EOPNOTSUPP in the basechain case if the offload flag is set on.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3b81323fa0171..5dbc6bfb532cd 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1922,6 +1922,7 @@ static int nf_tables_newchain(struct net *net, struct sock *nlsk,
 		if (nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
+		flags |= chain->flags & NFT_BASE_CHAIN;
 		return nf_tables_updchain(&ctx, genmask, policy, flags);
 	}
 
-- 
2.20.1



