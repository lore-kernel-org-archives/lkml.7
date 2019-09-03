Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4FFC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F44217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="NggBeGRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfICBIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 21:08:21 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.124]:16947 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbfICBIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 21:08:20 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id C8F764B70
        for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2019 20:08:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 4xIxiFyJF3Qi04xIxiuJMH; Mon, 02 Sep 2019 20:08:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IPXpQjejrqZ52pjbtbF1TXRKNnTxNBlTRR+B1eBDFS4=; b=NggBeGRRGpw5drYbZbu6G1smfC
        9Z1ZTY75tiynbOHUZ1oFqX2WQnDVAGQx6cqNIgciH6dnIxALTY3m6gv+1KCjASWFOJj1/39Ta2Nzc
        Se0lFwg9cBX36Jv4xV4sRvWrIZuOMCoZQGaSvX+uMBadeiQjIaDH7TSKxyQwsdKn6DStD6EnbVxpz
        RZbQs/YFYrnCTEVe/Z51Lc3hYgmFFyD5tuhvl24zAx/xa8jGaRGSyb5neNRGI440Js62Ini1cYUnQ
        St34WaTw0GRZTpxYXqXEn2KYa/6AUSo/W4eFLHmwvELlL2ZR0FSHxlUxG5dsYwSD3/FRFfZqPu0P4
        ri16SXyg==;
Received: from [189.152.216.116] (port=44906 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i4xIw-0011oi-Kr; Mon, 02 Sep 2019 20:08:18 -0500
Date:   Mon, 2 Sep 2019 20:08:17 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: sched: taprio: Fix potential integer overflow in
 taprio_set_picos_per_byte
Message-ID: <20190903010817.GA13595@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i4xIw-0011oi-Kr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:44906
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix LL to constant 1000 in order to avoid a potential integer
overflow and give the compiler complete information about the proper
arithmetic to use. Notice that this constant is being used in a context
that expects an expression of type s64, but it's currently evaluated
using 32-bit arithmetic.

Addresses-Coverity-ID: 1453459 ("Unintentional integer overflow")
Fixes: f04b514c0ce2 ("taprio: Set default link speed to 10 Mbps in taprio_set_picos_per_byte")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/sched/sch_taprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8d8bc2ec5cd6..956f837436ea 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -966,7 +966,7 @@ static void taprio_set_picos_per_byte(struct net_device *dev,
 
 skip:
 	picos_per_byte = div64_s64(NSEC_PER_SEC * 1000LL * 8,
-				   speed * 1000 * 1000);
+				   speed * 1000LL * 1000);
 
 	atomic64_set(&q->picos_per_byte, picos_per_byte);
 	netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld, linkspeed: %d\n",
-- 
2.23.0

