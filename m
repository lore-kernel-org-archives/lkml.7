Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E238C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191E422C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154790;
	bh=kQogq5q7TgVnT/79suhILfXBjUEJhKtEX/sKEyHCqPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=maytaWPY3e+ie/+3lMvPxGR0fgplIUs/FdtxdwPDrMUiSn7DQLKouc4pE/6ENRPYk
	 3WAKcXia2eUg4PhquHbOgTEB390dL2m6qo1XTOcmLWPtXS2atVWgDieIK2VSpljz6H
	 9oYEm5ehSFQ0BnqNhLwFH3ILzLFoSR/nQj7KXOuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbfGZP03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387894AbfGZP0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:26:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0205C218D4;
        Fri, 26 Jul 2019 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154780;
        bh=kQogq5q7TgVnT/79suhILfXBjUEJhKtEX/sKEyHCqPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RT0wlzP/GtmlHQpgOR1++aRA0nsLD7jELMd2G4JLcHXP8EsUoyLfx0R7xTd+BZdQN
         //3UMIJ7l72xAZJjoL3Q5DP86CVQDC4WsXqYfkgKayUR/IFiwWf7MYCkPB3Gt96ZQc
         TSt+e0Vz7Z0zllSC/CfXrWzejQnjc5AOcY23T9tA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Donohue <linux-kernel@PaulSD.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 06/66] ipv6: rt6_check should return NULL if from is NULL
Date:   Fri, 26 Jul 2019 17:24:05 +0200
Message-Id: <20190726152302.607408339@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 49d05fe2c9d1b4a27761c9807fec39b8155bef9e ]

Paul reported that l2tp sessions were broken after the commit referenced
in the Fixes tag. Prior to this commit rt6_check returned NULL if the
rt6_info 'from' was NULL - ie., the dst_entry was disconnected from a FIB
entry. Restore that behavior.

Fixes: 93531c674315 ("net/ipv6: separate handling of FIB entries from dst based routes")
Reported-by: Paul Donohue <linux-kernel@PaulSD.com>
Tested-by: Paul Donohue <linux-kernel@PaulSD.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2215,7 +2215,7 @@ static struct dst_entry *rt6_check(struc
 {
 	u32 rt_cookie = 0;
 
-	if ((from && !fib6_get_cookie_safe(from, &rt_cookie)) ||
+	if (!from || !fib6_get_cookie_safe(from, &rt_cookie) ||
 	    rt_cookie != cookie)
 		return NULL;
 


