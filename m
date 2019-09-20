Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C28C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A4420C01
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394771AbfITGKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:10:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437271AbfITGJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:03 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B1F4F5C802E27764F3F7;
        Fri, 20 Sep 2019 14:09:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:54 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 12/32] crypto: n2: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:24 +0800
Message-ID: <20190920062544.180997-13-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/crypto/n2_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index dc15b06e96ab..40b81013213e 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -381,8 +381,8 @@ static int n2_hash_cra_init(struct crypto_tfm *tfm)
 	fallback_tfm = crypto_alloc_ahash(fallback_driver_name, 0,
 					  CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(fallback_tfm)) {
-		pr_warning("Fallback driver '%s' could not be loaded!\n",
-			   fallback_driver_name);
+		pr_warn("Fallback driver '%s' could not be loaded!\n",
+			fallback_driver_name);
 		err = PTR_ERR(fallback_tfm);
 		goto out;
 	}
@@ -418,16 +418,16 @@ static int n2_hmac_cra_init(struct crypto_tfm *tfm)
 	fallback_tfm = crypto_alloc_ahash(fallback_driver_name, 0,
 					  CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(fallback_tfm)) {
-		pr_warning("Fallback driver '%s' could not be loaded!\n",
-			   fallback_driver_name);
+		pr_warn("Fallback driver '%s' could not be loaded!\n",
+			fallback_driver_name);
 		err = PTR_ERR(fallback_tfm);
 		goto out;
 	}
 
 	child_shash = crypto_alloc_shash(n2alg->child_alg, 0, 0);
 	if (IS_ERR(child_shash)) {
-		pr_warning("Child shash '%s' could not be loaded!\n",
-			   n2alg->child_alg);
+		pr_warn("Child shash '%s' could not be loaded!\n",
+			n2alg->child_alg);
 		err = PTR_ERR(child_shash);
 		goto out_free_fallback;
 	}
-- 
2.20.1

