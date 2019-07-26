Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A59C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D76218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155193;
	bh=1tzAILFEnFOxvmk+bcKc+0/O/eBffjJhaQCUsy6WV6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uiCkljSqBKLXH3wKx9+wSZ+0uCd4Vr2PcP5y/7iQLUXx5TAyLTvGiBh/3b4p2/ts0
	 EE2W3wSc/G4RUq7wXGMyG6ZGr8idQLtlxJ/3jA02EDK7NqagbrbWCgG771ro71mRfj
	 5dEz++IPphMyieKDin0FkKhrepzV/nBLbLRBxvT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbfGZPdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389595AbfGZPdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:33:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED7420644;
        Fri, 26 Jul 2019 15:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155186;
        bh=1tzAILFEnFOxvmk+bcKc+0/O/eBffjJhaQCUsy6WV6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGHAkEZbLvW1P1vllJwa6T5S0n571s48HkuX/RlE6hSc6331YC517Yk/OEAcb+4FX
         C+xd8ZmhlyHLH3xEZ2SuI6dphjJyYzRrgWikN9p+vmBjFFEWUWD1XnHIqPu/y51TiI
         j7frqCQa2eU5cqa1tGftICLa7pH+R8u3zixDcH6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Donohue <linux-kernel@PaulSD.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 06/50] ipv6: rt6_check should return NULL if from is NULL
Date:   Fri, 26 Jul 2019 17:24:41 +0200
Message-Id: <20190726152301.335828258@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152300.760439618@linuxfoundation.org>
References: <20190726152300.760439618@linuxfoundation.org>
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
@@ -2214,7 +2214,7 @@ static struct dst_entry *rt6_check(struc
 {
 	u32 rt_cookie = 0;
 
-	if ((from && !fib6_get_cookie_safe(from, &rt_cookie)) ||
+	if (!from || !fib6_get_cookie_safe(from, &rt_cookie) ||
 	    rt_cookie != cookie)
 		return NULL;
 


