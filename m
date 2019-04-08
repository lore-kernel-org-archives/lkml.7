Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56127C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2749C20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="AU1KUwf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDHCiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:38:21 -0400
Received: from owa.iluvatar.ai ([103.91.158.24]:5257 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbfDHCiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:38:19 -0400
X-AuditID: 0a650161-773ff700000078a3-e7-5caab4179207
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id A8.E3.30883.714BAAC5; Mon,  8 Apr 2019 10:38:15 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1554691095; h=from:subject:to:date:message-id;
        bh=+Ok9chkdp27Y5YtmQeTDw961jkYIka3EJirxsNMqBYg=;
        b=AU1KUwf+Zui5EhUQvq/QC5qbPp2q+T2lBS/6sJVrspxov87D9kSQiQTtkeRNZDwrFsdHElnMip0
        msK+EKc5CzFQ1Os1AWLZC2dgi84GzzQes1HRpchaESdHRPLMBD06hu85Y43J1ph1MmMa4YAnVaQea
        8w9znxLNchlW8ECK9DM=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Mon, 8 Apr 2019 10:38:14 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <akpm@linux-foundation.org>
CC:     <william.kucharski@oracle.com>, <ira.weiny@intel.com>,
        <palmer@sifive.com>, <axboe@kernel.dk>, <keescook@chromium.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH 2/2] lib/scatterlist.c: add more commit for sg_alloc_table_from_pages
Date:   Mon, 8 Apr 2019 10:37:46 +0800
Message-ID: <20190408023746.16916-2-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408023746.16916-1-sjhuang@iluvatar.ai>
References: <20190408023746.16916-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-105.iluvatar.local (10.101.1.105) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsXClcqYpiu+ZVWMwal/bBZz1q9hs1h9t5/N
        Yv/T5ywWZ7pzLS7vmsNmcW/Nf1aLzRMWAInFXUwOHB6zGy6yeCze85LJ4/LZUo9Nnyaxe5yY
        8ZvF4+PTWywel5qvs3t83iQXwBHFZZOSmpNZllqkb5fAlbH3ymrmgv1sFae7WtkaGHtZuxg5
        OCQETCRevzTuYuTiEBI4wShx4s80xi5GTg5mAQmJgy9eMIMkWATeMkk0n77MBlHVyiRxbusk
        dpAqNgENibkn7jKD2CIC8hJNXx6xgxQxC9xilNgx4QkLSEJYIFRi68IWNhCbRUBFovfMRbAG
        XgELiemT21lBbAmg5tUbDjCDnMQpYCkxfTrYFUJAJa0Nk9khygUlTs4EGckBFFeQeLFSC6JT
        SWLJ3llMEHahxIyJKxgnMArNQvLDLCTdCxiZVjHyF+em62XmlJYlliQW6SVmbmKEREXiDsYb
        nS/1DjEKcDAq8fDeyF4VI8SaWFZcmXuIUYKDWUmEd+dUoBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHesokmMUIC6YklqdmpqQWpRTBZJg5OqQYmMyeFFTPbMndc+FGjLTqdYfrC2WlefY1/3ft7
        12Q0HT2zenHP354/fBq6U/5teXVvP0uVwc5tMw/d/h1VdCG8uTykRkfz5/r5RT94tV5Wa5cX
        vA8Tn2z9m6l0w7579ldfNjyac311R4+FU9lX+9DynSqzhKU26OcuKK/+wyoY0vZMLPT7EY+w
        HEflldcXvtnP9jv5YP0mzTsMO5J2a0dcOx3bv//dJM9W7uadu94wZDlXzK5gOvG6ouSNRqF4
        gpbcyftRtZefvubq2L2SfbZj9sTnxaEuu/tmztZ8/6vvmFJoDpfTghwXd418u5h7IXunptU/
        Tt1sevXh4tOVn55N/s/xMGWd6eGnEz5eNhJzUmIpzkg01GIuKk4EAOJRwDIHAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_user_pages_fast() may mess up the page order in @pages array,
We will get the wrong DMA results in this case.

Add more commit to clarify it.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 lib/scatterlist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 739dc9fe2c55..c170afb1a25e 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -450,6 +450,9 @@ EXPORT_SYMBOL(__sg_alloc_table_from_pages);
  *    specified by the page array. The returned sg table is released by
  *    sg_free_table.
  *
+ * Note: Do not use get_user_pages_fast() to pin the pages for @pages array,
+ *       it may mess up the page order, and we will get the wrong DMA results.
+
  * Returns:
  *   0 on success, negative error on failure
  */
-- 
2.17.1

