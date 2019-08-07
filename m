Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528ACC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254612229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="n+46KW4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbfHGQuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:50:11 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.56]:17954 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387967AbfHGQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:50:09 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 6712A4627B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2019 11:50:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vP8ah8bXM4FKpvP8ahGiDo; Wed, 07 Aug 2019 11:50:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9OhMj7mJRoIKJ600Mv9jGb+7f/od8LHwUOBGDK6431k=; b=n+46KW4bbtihW9zMfA6jh+2UUp
        sMSj60x7aPUhtTR6KmXsifZWRx2O2hU3seJjg6lsV41haMd7znnXgbM82u+WXfPG3IC40v1ZGvsdi
        jPNNbh7K/Db6tahv++o3HwXmPKOHkJLYJKtsD2DXbstgdoWOcxAvgWMbG07SPgvR1cKNSrFtkxb/z
        YIudsFOk9svaaedTOWkQNa6FrGaRb4vodlgvJRUccvzCuvNAminCr0q/Qj4W0mt97IdR+FQM3aZ76
        W+Q6T7OBUiPlbpzs3Qg6a6mP449QsjxAqq9j5dW9z1/cfdLgBS9rRHwi91hQHTY1BHvwznXv0ThGr
        SW3Ddeyw==;
Received: from 187-162-252-62.static.axtel.net ([187.162.252.62]:45988 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hvP8W-000voF-LO; Wed, 07 Aug 2019 11:50:07 -0500
Date:   Wed, 7 Aug 2019 11:49:57 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] perf/x86/intel/uncore: Use struct_size() in kzalloc_node()
Message-ID: <20190807164957.GA32638@embeddedor>
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
X-Source-IP: 187.162.252.62
X-Source-L: No
X-Exim-ID: 1hvP8W-000voF-LO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-62.static.axtel.net (embeddedor) [187.162.252.62]:45988
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct intel_uncore_box {
        ...
        struct intel_uncore_extra_reg shared_regs[0];
};

size = sizeof(struct intel_uncore_box) + count * sizeof(struct intel_uncore_extra_reg);
instance = kzalloc_node(size, GFP_KERNEL, node);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc_node(struct_size(instance, shared_regs, count), GFP_KERNEL,
node);

Notice that, in this case, variable size is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/x86/events/intel/uncore.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 3694a5d0703d..013768dc8f37 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -313,12 +313,11 @@ static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
 static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
 						 int node)
 {
-	int i, size, numshared = type->num_shared_regs ;
+	int i, numshared = type->num_shared_regs;
 	struct intel_uncore_box *box;
 
-	size = sizeof(*box) + numshared * sizeof(struct intel_uncore_extra_reg);
-
-	box = kzalloc_node(size, GFP_KERNEL, node);
+	box = kzalloc_node(struct_size(box, shared_regs, numshared), GFP_KERNEL,
+			   node);
 	if (!box)
 		return NULL;
 
-- 
2.22.0

