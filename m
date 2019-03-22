Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA10121916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254512;
	bh=1kNltL75Zn59/rdgq+aZjSBMF0D1I5XnxyjagXjDHGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pZ6H/AzKquSc5dMUAG8E3kMphCWh25PFsF5iofimHtxwxZgkW9icChIJ83uLqKOVi
	 COCVZe8GHCG1D7fCmkeAPe1rW+L0DJKBb0DAGrkR8Yfz0kBr7vGB7ZhksHlVr/GghC
	 VOZxlhqJZyFTsb5b/kfil+0sNqRiKYWEDRteqyCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfCVLfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbfCVLfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03D0218B0;
        Fri, 22 Mar 2019 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254504;
        bh=1kNltL75Zn59/rdgq+aZjSBMF0D1I5XnxyjagXjDHGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zyc1JJH2A9taK5j3GzopnIoaj/mnsRamWiijj//aijT347tj94hyq0y4W49taHMW3
         VVGsahEwJCp1CcezVD5U4iOY9or2ZtPwKAytSJaFpHGqj/XpXB2oJHr4mZUfB20Xy5
         5SVyr6rvkKw0/3R0wc8HsdsrbPLMnLQk2MM0Wd/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kalash Nainwal <kalash@arista.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 138/230] net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255
Date:   Fri, 22 Mar 2019 12:14:36 +0100
Message-Id: <20190322111246.350788779@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3095,7 +3095,7 @@ static int rt6_fill_node(struct net *net
 		table = rt->rt6i_table->tb6_id;
 	else
 		table = RT6_TABLE_UNSPEC;
-	rtm->rtm_table = table;
+	rtm->rtm_table = table < 256 ? table : RT_TABLE_COMPAT;
 	if (nla_put_u32(skb, RTA_TABLE, table))
 		goto nla_put_failure;
 	if (rt->rt6i_flags & RTF_REJECT) {


