Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60DBC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D14E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391646AbfEXOaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:30:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390885AbfEXOaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:30:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 668BEE8D9F6C3ED72522;
        Fri, 24 May 2019 22:30:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 May 2019 22:29:54 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Subject: [PATCH] kernel: sysctl: change ipfrag_high/low_thresh to CTL_ULONG
Date:   Fri, 24 May 2019 22:38:27 +0800
Message-ID: <20190524143827.43301-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3e67f106f619 ("inet: frags: break the 2GB limit for frags storage"),
changes ipfrag_high/low_thread 'type' from int to long, using CTL_ULONG
instead of CTL_INT to keep consistent.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/sysctl_binary.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
index 73c132095a7b..ef0687f40f87 100644
--- a/kernel/sysctl_binary.c
+++ b/kernel/sysctl_binary.c
@@ -410,8 +410,8 @@ static const struct bin_table bin_net_ipv4_table[] = {
 	{ CTL_INT,	NET_IPV4_ICMP_RATELIMIT,		"icmp_ratelimit" },
 	{ CTL_INT,	NET_IPV4_ICMP_RATEMASK,			"icmp_ratemask" },
 
-	{ CTL_INT,	NET_IPV4_IPFRAG_HIGH_THRESH,		"ipfrag_high_thresh" },
-	{ CTL_INT,	NET_IPV4_IPFRAG_LOW_THRESH,		"ipfrag_low_thresh" },
+	{ CTL_ULONG,	NET_IPV4_IPFRAG_HIGH_THRESH,		"ipfrag_high_thresh" },
+	{ CTL_ULONG,	NET_IPV4_IPFRAG_LOW_THRESH,		"ipfrag_low_thresh" },
 	{ CTL_INT,	NET_IPV4_IPFRAG_TIME,			"ipfrag_time" },
 
 	{ CTL_INT,	NET_IPV4_IPFRAG_SECRET_INTERVAL,	"ipfrag_secret_interval" },
-- 
2.20.1

