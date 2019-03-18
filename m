Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F83C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D76B2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902024;
	bh=7HqKm7EU7B+E5NW2iUVY0RchmMA4SsGNYEkLR6RySPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a7WAk9k+eZrtiDjjw5jUY/qYrrcsx3zTZ148GmjRenP2HWZqJ6oxxWZ44ihmowGNf
	 F2mX9GUy84SW2uEtQjSrpEosPevKVyipwvgmNbR83V3Ra3kf6um0NnstExe96VEe6L
	 9fD8uOtXik6FEM1G3peWhekVV8UTf5zwDYFIDMAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfCRJkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbfCRJfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:35:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22CE4214AF;
        Mon, 18 Mar 2019 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901710;
        bh=7HqKm7EU7B+E5NW2iUVY0RchmMA4SsGNYEkLR6RySPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJMSNHGfrYOHKCx6JowOwgWt0gzBdhCjeXD6er6IpkJUiVN3r6l3hBqtWIjLlR7YU
         nCKe/e2j/gysxi5ddpHNcbm6lPtew+gR2UiYmpOjLNZAE3M4i0oa35vvafgR/GrBdw
         Wy8OFB+FDx59YzU4IlDMycTRC4/TRP+0947PsRUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kalash Nainwal <kalash@arista.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 24/34] net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255
Date:   Mon, 18 Mar 2019 10:25:48 +0100
Message-Id: <20190318084148.097666500@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
References: <20190318084144.657740413@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalash Nainwal <kalash@arista.com>

[ Upstream commit 97f0082a0592212fc15d4680f5a4d80f79a1687c ]

Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255 to
keep legacy software happy. This is similar to what was done for
ipv4 in commit 709772e6e065 ("net: Fix routing tables with
id > 255 for legacy software").

Signed-off-by: Kalash Nainwal <kalash@arista.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3495,7 +3495,7 @@ static int rt6_fill_node(struct net *net
 		table = rt->rt6i_table->tb6_id;
 	else
 		table = RT6_TABLE_UNSPEC;
-	rtm->rtm_table = table;
+	rtm->rtm_table = table < 256 ? table : RT_TABLE_COMPAT;
 	if (nla_put_u32(skb, RTA_TABLE, table))
 		goto nla_put_failure;
 	if (rt->rt6i_flags & RTF_REJECT) {


