Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456A5C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3F1206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803620;
	bh=CMtC4t94zvH+sK9mOeNZYQhRE9tKxvGvOKZoQrxpeok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cT9UF+1ItvgLKbVWS7zJ9htqR6LayDZXU/KGzpVMY0IZTr0u+/0yCxJivMynuNqoA
	 M6ImZFoqSS2TjKQGTTooOvcOaEehPvWoe6c6AFxsnOBKiPVmlUy5/Tj/6xBE4wKQ8J
	 9E/MxVCKbEut083yzybBppxAMceXJVBdQD5MCv2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHNR06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbfHNREQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:04:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EECD208C2;
        Wed, 14 Aug 2019 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802256;
        bh=CMtC4t94zvH+sK9mOeNZYQhRE9tKxvGvOKZoQrxpeok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1nvbpciR3+aa3B41M2FHytnJOQ33Bm84RZCa8mrpwz0vAY3D5KN7jCzS3n1H8IHK
         yN/6zPVi5W/qQahob/G/Vv8UpJpiI6zFRc0/+Yu0EA3/mk0OZfAwqyf9nTMzDITc+c
         MgfoiFmHNIydQoqpYTCzYLmufQhUtT0TTSTKhNKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Hesse <mail@eworm.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 054/144] netfilter: nf_tables: fix module autoload for redir
Date:   Wed, 14 Aug 2019 19:00:10 +0200
Message-Id: <20190814165802.092528994@linuxfoundation.org>
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

[ Upstream commit f41828ee10b36644bb2b2bfa9dd1d02f55aa0516 ]

Fix expression for autoloading.

Fixes: 5142967ab524 ("netfilter: nf_tables: fix module autoload with inet family")
Signed-off-by: Christian Hesse <mail@eworm.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_redir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index 8487eeff5c0ec..43eeb1f609f13 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -291,4 +291,4 @@ module_exit(nft_redir_module_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Arturo Borrero Gonzalez <arturo@debian.org>");
-MODULE_ALIAS_NFT_EXPR("nat");
+MODULE_ALIAS_NFT_EXPR("redir");
-- 
2.20.1



