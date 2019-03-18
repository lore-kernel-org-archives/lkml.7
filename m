Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C345C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA01214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901396;
	bh=I1aChPTFltAzHKdm1nY5D5F2NY83WAfdc7wCfvOBHDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0HN6as3IaJtk49xVU5+KA4mdKK4omHOLqfnjGh7N2uuqfCNm975iLtxUzQifS85BR
	 qKf7FjwJz5WWkUJqtTSglz1wBkaN/erd52OicI6C1knv23H8PWGPmEr3zyGCLJuqFj
	 fGgtoBixK3lTUuin+8RxFPgc2YKUo/AUtgisOqDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfCRJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbfCRJ3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:29:50 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA45921734;
        Mon, 18 Mar 2019 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901390;
        bh=I1aChPTFltAzHKdm1nY5D5F2NY83WAfdc7wCfvOBHDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBuVPA74Gszh/7Rjdw3g/ecElqePesmWxLyR8pG+M2hCKBzcCJvdjGOhXBOorRd6W
         P2W7ZjhCQMBjgzGuJHt2Dph9oQj/KiEGTwbAzGtFKwkieOCHQ/T6e4DrtHT4fqlhOD
         Rgw4xQeaa9ZOtxv1AGeWYtnAY2UWmqfHhX1HZGGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kalash Nainwal <kalash@arista.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 30/52] net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255
Date:   Mon, 18 Mar 2019 10:25:17 +0100
Message-Id: <20190318083846.960885928@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4660,7 +4660,7 @@ static int rt6_fill_node(struct net *net
 		table = rt->fib6_table->tb6_id;
 	else
 		table = RT6_TABLE_UNSPEC;
-	rtm->rtm_table = table;
+	rtm->rtm_table = table < 256 ? table : RT_TABLE_COMPAT;
 	if (nla_put_u32(skb, RTA_TABLE, table))
 		goto nla_put_failure;
 


