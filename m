Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDA9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3262420836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="dDyq48lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLKDSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 22:18:18 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:16137 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbfLKDSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:18:17 -0500
X-AuditID: 0a650161-773ff700000078a3-ac-5df076848390
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id F8.A1.30883.48670FD5; Wed, 11 Dec 2019 12:54:28 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1576034299; h=from:subject:to:date:message-id;
        bh=bYKUznT4W57bS0w+T6BvMvEPKsggqZyWXbpiDvbJE74=;
        b=dDyq48lpR/3YBYdXRA+cbnHkUx74pNktqUzP0Bmr9avcFO8j9OoFpW1G4ukWb4Dd8wvBIH7O9s9
        whuI5AcwxHqFLCP+E0WNjEpv+E1UyQZmW1DgCMvtVcRssZxqkOo8yZc6nnqwHIyjN+z/szFYt1nE9
        GTqNpUIcYvoeLRVmwjE=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Wed, 11 Dec 2019 11:18:16 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <jbaron@akamai.com>
CC:     <linux-kernel@vger.kernel.org>, <1537577747@qq.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH v3] lib/dynamic_debug: make better dynamic log output
Date:   Wed, 11 Dec 2019 11:17:56 +0800
Message-ID: <20191211031756.10631-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209094437.14866-1-sjhuang@iluvatar.ai>
References: <20191209094437.14866-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsXClcqYpttS9iHW4N8SPYvJVw+wWcxYfJzV
        4vKuOWwOzB6Tjyxg9rj1bC2rx+dNcgHMUVw2Kak5mWWpRfp2CVwZ57t+shb85K+4dW0jewPj
        e54uRk4OCQETiZMvt7F0MXJxCAmcYJT487qHBSTBLCAhcfDFC2aQBIvAWyaJyaums0NUtTFJ
        nOldwQpSxSagITH3xF2gKg4OEQFxiffzXSGaYyXmdu1jBrGFBVwl+ts2MoHYLAKqEo+OrwWz
        eQUsJHa83cQMcYW8xOoNB8BsTgFLiUNX34DVCAHVXJh3iRmiXlDi5MwnLCCrhAQUJF6s1IJo
        VZJYsncWE4RdKPH95V2WCYxCs5C8MAtJ9wJGplWM/MW56XqZOaVliSWJRXqJmZsYIUGbuIPx
        RudLvUOMAhyMSjy8AuffxwqxJpYVV+YeYpTgYFYS4T3e9i5WiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOK/Qv6cxQgLpiSWp2ampBalFMFkmDk6pBiaV3kepB47VRMrtyM/e/fP/V1XeBXdfH8iw
        dHRqVqzjeRKXEsHolSMe0jLFOfqJoH5s9SYrYwuZSfbbjeO1U/LY3+5ryE+779J3NDWr23n+
        LJGV8Wu8rvwOu/b6Tl5CxPRPzeySTZ3cXBPleTtNL+ZubuV5Mdnm/+eUb8u6191S3ftPK9Am
        s0stae7tvBMHQ76tK+NWuW5wPGvZ8vgVCVdKAuW22qad63wtv7j1XZLCxl2erRu14revXe+d
        Kq0Z3+F27nyom951te2fXSvn/PRoa3G8cIovP5Fl68STrmbM4SuFlGredMnE3tKxVdsi/OXc
        l8IFGjN4zxzhslPZFMXKobX43hINcQNvfpHTSizFGYmGWsxFxYkAOSqQzdcCAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver strings, device name and net device name are not changed for
the driver's dynamic log output. But dynamic_emit_prefix() which contains
the function names may change when the function names are changed.

So the patch makes the better dynamic log output.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
v2 -- > v3:
	change the net log and ibdev log
---
 lib/dynamic_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..762f718fecd9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -589,9 +589,9 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 	} else {
 		char buf[PREFIX_SIZE];
 
-		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s %s %s: %pV",
 				dev_driver_string(dev), dev_name(dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	}
 
@@ -619,11 +619,11 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 		char buf[PREFIX_SIZE];
 
 		dev_printk_emit(LOGLEVEL_DEBUG, dev->dev.parent,
-				"%s%s %s %s%s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+				"%s %s %s %s %s: %pV",
 				dev_driver_string(dev->dev.parent),
 				dev_name(dev->dev.parent),
 				netdev_name(dev), netdev_reg_state(dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	} else if (dev) {
 		printk(KERN_DEBUG "%s%s: %pV", netdev_name(dev),
@@ -655,11 +655,11 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		char buf[PREFIX_SIZE];
 
 		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
-				"%s%s %s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+				"%s %s %s %s: %pV",
 				dev_driver_string(ibdev->dev.parent),
 				dev_name(ibdev->dev.parent),
 				dev_name(&ibdev->dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	} else if (ibdev) {
 		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
-- 
2.17.1

