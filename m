Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C1EC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF0C22ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="K2Dp0nXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfGXNc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:32:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42874 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfGXNc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:32:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so33705294qkm.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VVlcNSa1m2lmqoAvGdWAXDGQzs62Yp1UxP1TI92+l3k=;
        b=K2Dp0nXLVoNti+TEAeDh9CSLDRmAglIPXZVan9Nx9POLt2vz8wcZ+6ts43qH58k4hp
         dfL9Kz6vSqHSgAZWbE+A7FBJM1TdRMwn7Ic0Fb6NsIIiyHlm19j2eluBXBFTVKr5x00Z
         HV0gVSFxx+CSpUNSPpZ8tYN6BR0H65rukDRXTgHL4KqjETMV+TFxNssT6DslDCdPhVr1
         KZUraxiy18oQ3l8NEeUPkJjH6a9HsGwuJRMeoEQhgKCUdJ3QgSovOZEuNox8XLWqyMW6
         RFpE+TYW5riexOpvRLkWYV+gFEUNJV2Kst/LelXM12gKuVbkwgsgIfauJ3Psu62y2ZqS
         Yg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VVlcNSa1m2lmqoAvGdWAXDGQzs62Yp1UxP1TI92+l3k=;
        b=GJzSwTM3pFjEH2tsJhMwfErseG+Qp+iabwkDGZBjH/4Wsh2/dflbIB0rBaF9qdGMvh
         OY6hMY0AxrVQYMZFPd53uCfqRzjzfNgJ6AF8tulriWvCVXw5vdQWEljNV+cqs+xuHM5O
         HF/0LJ1USLSHKLHuGOJ/k9PGMWs1U90xfYh1iuywzflCuqs5QsEm9J1LDODgy5C6mubw
         UFUEYIAsW0w0+3ii9J4AZQkAjStxpICDYLr0KTsgJs5JMUM2AJStEO2rXhPt/Q9OLy4j
         OioM/zcu+onRVT9/hPlhwBz8JmBaF6E0JhcXNwhS1fEw46XGQWkkv3n5SxgVe3e4uWif
         hMhA==
X-Gm-Message-State: APjAAAX/1oBtf3MUZi/Y7elckyMLMykVQJQYBLCMH9/xO7IzhrImdW6d
        OzuAK+Ab63lO9PNyqPruFnRwxQ==
X-Google-Smtp-Source: APXvYqwfiEBRGDv0Fl+LzDaXkF5umNZChanqsAUd1U+6ODFBHjZDU0Vb8i++QEVvl49WaG3zAnaYnw==
X-Received: by 2002:a05:620a:1448:: with SMTP id i8mr54936345qkl.73.1563975176507;
        Wed, 24 Jul 2019 06:32:56 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j6sm2476101qtl.85.2019.07.24.06.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 06:32:55 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     willy@infradead.org
Cc:     davem@davemloft.net, jeffrey.t.kirsher@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] net/ixgbevf: fix a compilation error of skb_frag_t
Date:   Wed, 24 Jul 2019 09:32:37 -0400
Message-Id: <1563975157-30691-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "net: Rename skb_frag_t size to bv_len" [1]
introduced a compilation error on powerpc as it forgot to rename "size"
to "bv_len" for ixgbevf.

[1] https://lore.kernel.org/netdev/20190723030831.11879-1-willy@infradead.org/T/#md052f1c7de965ccd1bdcb6f92e1990a52298eac5

In file included from ./include/linux/cache.h:5,
                 from ./include/linux/printk.h:9,
                 from ./include/linux/kernel.h:15,
                 from ./include/linux/list.h:9,
                 from ./include/linux/module.h:9,
                 from
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:12:
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function
'ixgbevf_xmit_frame_ring':
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4138:51: error:
'skb_frag_t' {aka 'struct bio_vec'} has no member named 'size'
   count += TXD_USE_COUNT(skb_shinfo(skb)->frags[f].size);
                                                   ^
./include/uapi/linux/kernel.h:13:40: note: in definition of macro
'__KERNEL_DIV_ROUND_UP'
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
                                        ^
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4138:12: note: in
expansion of macro 'TXD_USE_COUNT'
   count += TXD_USE_COUNT(skb_shinfo(skb)->frags[f].size);

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index bdfccaf38edd..52375cebfbb8 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4135,7 +4135,7 @@ static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
 	 */
 #if PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD
 	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
-		count += TXD_USE_COUNT(skb_shinfo(skb)->frags[f].size);
+		count += TXD_USE_COUNT(skb_shinfo(skb)->frags[f].bv_len);
 #else
 	count += skb_shinfo(skb)->nr_frags;
 #endif
-- 
1.8.3.1

