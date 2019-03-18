Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C61C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A7B214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901808;
	bh=vjzMgO8k5Zo2S391cTWJCVbNk3oDhzoDKTRuGW2+nDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vn4BUb1Au0iJIJrzt7LUO43ZL11Btoy+X5JdKd5K8XKHw5dDXFZh1rrghmXwht5K/
	 CUEr/VI5FIfhyzVA+XBgQEk+8OaoAEwlhLYcCd6/09ONlqYrtkQPYw/hMpH+eana9k
	 v3gB5hY+7My4X1fCOodoQ1jFHcMIT4imBKJu+9Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbfCRJgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387717AbfCRJgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:36:44 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 878D92083D;
        Mon, 18 Mar 2019 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901804;
        bh=vjzMgO8k5Zo2S391cTWJCVbNk3oDhzoDKTRuGW2+nDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=169UTWuagNWg2z54HrKbdMLrSsaAwZw24D8+fvvWgvkibRtZHl3x5LGGtiyMhsn5e
         YjKXfXs1Kz08RcJN8t27BJi1RM2LbmbWGF9rNhp0lM95pGC3Bg7c7LUsWc20g6/tV4
         7L1M2kuXIsU1ocMtT6zuYIATH0GvO/UFXYJZn2hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kalash Nainwal <kalash@arista.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 19/31] net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255
Date:   Mon, 18 Mar 2019 10:25:54 +0100
Message-Id: <20190318084211.172429921@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
References: <20190318084210.397476003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3211,7 +3211,7 @@ static int rt6_fill_node(struct net *net
 		table = rt->rt6i_table->tb6_id;
 	else
 		table = RT6_TABLE_UNSPEC;
-	rtm->rtm_table = table;
+	rtm->rtm_table = table < 256 ? table : RT_TABLE_COMPAT;
 	if (nla_put_u32(skb, RTA_TABLE, table))
 		goto nla_put_failure;
 	if (rt->rt6i_flags & RTF_REJECT) {


