Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEDEC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E952084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfEOJSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:18:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfEOJSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:18:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 339C08B7995CE51A24C9;
        Wed, 15 May 2019 17:18:15 +0800 (CST)
Received: from FRA1000014316.huawei.com (100.126.230.97) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 May 2019 17:18:04 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <shameerali.kolothum.thodi@huawei.com>
CC:     Wen Yang <wen.yang99@zte.com.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/60] arm64: cpu_ops: fix a leaked reference by adding missing of_node_put
Date:   Wed, 15 May 2019 17:16:44 +0800
Message-ID: <20190515091737.18578-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190515091737.18578-1-Jonathan.Cameron@huawei.com>
References: <20190515091737.18578-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [100.126.230.97]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
  ./arch/arm64/kernel/cpu_ops.c:102:1-7: ERROR: missing of_node_put;
  acquired a node pointer with refcount incremented on line 69, but
  without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/kernel/cpu_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index ea001241bdd47..00f8b8612b69f 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -85,6 +85,7 @@ static const char *__init cpu_read_enable_method(int cpu)
 				pr_err("%pOF: missing enable-method property\n",
 					dn);
 		}
+		of_node_put(dn);
 	} else {
 		enable_method = acpi_get_enable_method(cpu);
 		if (!enable_method) {
-- 
2.19.1

