Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF2C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4C02084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802352;
	bh=IW/FH2Ge38FoPwIKam244A3ofR5WOVQDwGpmI/So+Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=terCKXtfSPMhjzQVFQhWaz1N56WJ3nsl9GgFmEtXlFwMKw+05HcaZOjPXi3rEUu2z
	 xFNhubCZXMVo7jaFTlWw1gR0t8NVBwjh7MhRogmytzlv5djwegRYA7/1YgQOkJFoqG
	 Tt27jYHfDEM3ec8RuI4UnAjD1UshIiBHHoYU6wRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfHNRFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbfHNRFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:05:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2AE12084D;
        Wed, 14 Aug 2019 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802348;
        bh=IW/FH2Ge38FoPwIKam244A3ofR5WOVQDwGpmI/So+Wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eS8hyGzIW3SNeGVxZWs4k2QLsMbvlC1mo3wcRH5HUu08+GfKN5MvH+OB4hqGoT2Os
         xGX7GWrD0iH/WsZRVqyY63Yeb6jPY7SnUZhShA3JI737nFH7+vDVXWIrkbvvElxJQU
         lkNodEgHHlJos6INMSDwMuYE32nZZGM0SWAfXNpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 063/144] netfilter: nf_tables: Support auto-loading for inet nat
Date:   Wed, 14 Aug 2019 19:00:19 +0200
Message-Id: <20190814165802.474880431@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b4f1483cbfa5fafca4874e90063f75603edbc210 ]

Trying to create an inet family nat chain would not cause
nft_chain_nat.ko module to auto-load due to missing module alias. Add a
proper one with hard-coded family value 1 for the pseudo-family
NFPROTO_INET.

Fixes: d164385ec572 ("netfilter: nat: add inet family nat support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_chain_nat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_chain_nat.c b/net/netfilter/nft_chain_nat.c
index 2f89bde3c61cb..ff9ac8ae0031f 100644
--- a/net/netfilter/nft_chain_nat.c
+++ b/net/netfilter/nft_chain_nat.c
@@ -142,3 +142,6 @@ MODULE_ALIAS_NFT_CHAIN(AF_INET, "nat");
 #ifdef CONFIG_NF_TABLES_IPV6
 MODULE_ALIAS_NFT_CHAIN(AF_INET6, "nat");
 #endif
+#ifdef CONFIG_NF_TABLES_INET
+MODULE_ALIAS_NFT_CHAIN(1, "nat");	/* NFPROTO_INET */
+#endif
-- 
2.20.1



