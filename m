Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF188C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15D622CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ln7FlWdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfH2TGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:06:09 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.251]:36738 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbfH2TGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:06:08 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 13F30A4EF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:06:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3PkFiB0xb4FKp3PkGiF4du; Thu, 29 Aug 2019 14:06:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3+46xOrI9yy3LuOhJZ5rmqfr4aF7buwsYetlbyfyvSU=; b=ln7FlWdWq1Un9s4oy/dP68rvSQ
        TJnWL2hfqTjoz+3qyEAHw1M9p5TVCgHJRS6FIjDUkVoB5Fp1Xg53bPK6GKtekC+PflgtgtZ776Tdy
        N8sXXKpmhMhZTMKYKA1Vm0WRGA/VnWDby8hTFEhZHMK2Eegh8898DUK5y06xj/frawbEm+v6KrZNd
        8a9tJLkqK9os6hZf24ajT6J0HAP6o5V9WF8LEX39ksicjtpwh6M7MaOSRv98v9qJQC6CE2Mkngo7G
        OZzfg+M8OqxIhqsa6eraB1bLfGSd8UwnPQ3fDm1j03dHFO1C3wKWII3ibEx3uYpgAoPHkqdhrkBxA
        aH2p7BdQ==;
Received: from [189.152.216.116] (port=45156 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i3PkE-001rxt-Vo; Thu, 29 Aug 2019 14:06:07 -0500
Date:   Thu, 29 Aug 2019 14:06:05 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] percpu: Use struct_size() helper
Message-ID: <20190829190605.GA17425@embeddedor>
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
X-Exim-ID: 1i3PkE-001rxt-Vo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:45156
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct pcpu_alloc_info {
	...
        struct pcpu_group_info  groups[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(*ai) + nr_groups * sizeof(ai->groups[0])

with:

struct_size(ai, groups, nr_groups)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 7e2aa0305c27..7e06a1e58720 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2125,7 +2125,7 @@ struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
 	void *ptr;
 	int unit;
 
-	base_size = ALIGN(sizeof(*ai) + nr_groups * sizeof(ai->groups[0]),
+	base_size = ALIGN(struct_size(ai, groups, nr_groups),
 			  __alignof__(ai->groups[0].cpu_map[0]));
 	ai_size = base_size + nr_units * sizeof(ai->groups[0].cpu_map[0]);
 
-- 
2.23.0

