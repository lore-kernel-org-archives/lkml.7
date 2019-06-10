Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE7C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1452082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390032AbfFJVWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:22:23 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.202]:36069 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389736AbfFJVWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:22:22 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id E47A97C7C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 16:22:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aRkDhsBuwiQeraRkDhQPXS; Mon, 10 Jun 2019 16:22:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.75.107] (port=49560 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1haRkD-003lwk-0k; Mon, 10 Jun 2019 16:22:21 -0500
Date:   Mon, 10 Jun 2019 16:22:19 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tracepoint: Use struct_size() in kmalloc()
Message-ID: <20190610212219.GA27692@embeddedor>
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
X-Source-IP: 189.250.75.107
X-Source-L: No
X-Exim-ID: 1haRkD-003lwk-0k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.75.107]:49560
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct tp_probes {
	...
        struct tracepoint_func probes[0];
};

instance = kmalloc(sizeof(sizeof(struct tp_probes) +
			sizeof(struct tracepoint_func) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kmalloc(struct_size(instance, probes, count) GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/tracepoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index df3ade14ccbd..73956eaff8a9 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -55,8 +55,8 @@ struct tp_probes {
 
 static inline void *allocate_probes(int count)
 {
-	struct tp_probes *p  = kmalloc(count * sizeof(struct tracepoint_func)
-			+ sizeof(struct tp_probes), GFP_KERNEL);
+	struct tp_probes *p  = kmalloc(struct_size(p, probes, count),
+				       GFP_KERNEL);
 	return p == NULL ? NULL : p->probes;
 }
 
-- 
2.21.0

