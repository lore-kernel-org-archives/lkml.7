Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C52C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595F221773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfDXCWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 22:22:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbfDXCWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 22:22:50 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35BD6E198B7004FE7202;
        Wed, 24 Apr 2019 10:22:48 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 10:22:39 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <mahesh@linux.vnet.ibm.com>,
        <npiggin@gmail.com>, <ganeshgr@linux.ibm.com>, <anton@samba.org>,
        <ruscur@russell.cc>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] powerpc/pseries: Use correct event modifier in rtas_parse_epow_errlog()
Date:   Wed, 24 Apr 2019 10:17:39 +0800
Message-ID: <20190424021739.20916-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190423143533.26952-1-yuehaibing@huawei.com>
References: <20190423143533.26952-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

rtas_parse_epow_errlog() should pass 'modifier' to
handle_system_shutdown, because event modifier only use
bottom 4 bits.

Fixes: 55fc0c561742 ("powerpc/pseries: Parse and handle EPOW interrupts")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix compile issue by 'event_modifier'-->'modifier'
---
 arch/powerpc/platforms/pseries/ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index c97d153..744604d 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -285,7 +285,7 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 		break;
 
 	case EPOW_SYSTEM_SHUTDOWN:
-		handle_system_shutdown(epow_log->event_modifier);
+		handle_system_shutdown(modifier);
 		break;
 
 	case EPOW_SYSTEM_HALT:
-- 
2.7.0


