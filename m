Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8874320880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355386;
	bh=FoJIe2TwdMmVM4gnTTMV6e2QIidGjWXMULXNHmHdmBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GyUHAVDh5Vwqft0tTZLMAe44KpNgPvof2XJDTxw4fb3VEOgV/Qc9jB1kqJEe0eaT2
	 Z0aPHkgWykSrdlLnYOF2sXkEnYR2ucnWEKWn7qMQU8Rwxb46LYzGVA1yJR2ADyzZOs
	 hAPIYKuRJK6IWYY924ZfpkHivcK0jTesW9qbTVGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfDOTJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbfDOTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E3B20651;
        Mon, 15 Apr 2019 19:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355379;
        bh=FoJIe2TwdMmVM4gnTTMV6e2QIidGjWXMULXNHmHdmBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXb5P/0DeJHd/0npKb+hJqrOH/0zdfSykEDNmHvPB/bryj2IkhoZ6NsumQmOxNZd8
         K7W07CDUuGwADQozVtA0rbd3fsZjJVYVdcqNx8VdUnosQ+WhjFT7v7Ouf36zWvgfWN
         7z1lOY6KzT707AxOVIk2lBPhAkqSimTX/QsriiM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 005/117] netfilter: nf_tables: add missing ->release_ops() in error path of newrule()
Date:   Mon, 15 Apr 2019 20:59:35 +0200
Message-Id: <20190415183745.166517318@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b25a31bf0ca091aa8bdb9ab329b0226257568bbe ]

->release_ops() callback releases resources and this is used in error path.
If nf_tables_newrule() fails after ->select_ops(), it should release
resources. but it can not call ->destroy() because that should be called
after ->init().
At this point, ->release_ops() should be used for releasing resources.

Test commands:
   modprobe -rv xt_tcpudp
   iptables-nft -I INPUT -m tcp   <-- error command
   lsmod

Result:
   Module                  Size  Used by
   xt_tcpudp              20480  2      <-- it should be 0

Fixes: b8e204006340 ("netfilter: nft_compat: use .release_ops and remove list of extension")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f20b904873c6..acb124ce92ec 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2753,8 +2753,11 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 	nf_tables_rule_release(&ctx, rule);
 err1:
 	for (i = 0; i < n; i++) {
-		if (info[i].ops != NULL)
+		if (info[i].ops) {
 			module_put(info[i].ops->type->owner);
+			if (info[i].ops->type->release_ops)
+				info[i].ops->type->release_ops(info[i].ops);
+		}
 	}
 	kvfree(info);
 	return err;
-- 
2.19.1



