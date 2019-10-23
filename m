Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B5CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C015C2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406150AbfJWNsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:48:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405869AbfJWNsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:48:52 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6112AE0667A3215C47FE;
        Wed, 23 Oct 2019 21:48:48 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 21:48:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <mahesh@linux.vnet.ibm.com>,
        <ganeshgr@linux.ibm.com>, <yuehaibing@huawei.com>,
        <gregkh@linuxfoundation.org>, <npiggin@gmail.com>,
        <tglx@linutronix.de>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND][PATCH] powerpc/pseries: Use correct event modifier in rtas_parse_epow_errlog()
Date:   Wed, 23 Oct 2019 21:48:38 +0800
Message-ID: <20191023134838.21280-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtas_parse_epow_errlog() should pass 'modifier' to
handle_system_shutdown, because event modifier only use
bottom 4 bits.

Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/platforms/pseries/ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 3acdcc3..1d7f973 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -255,7 +255,7 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 		break;
 
 	case EPOW_SYSTEM_SHUTDOWN:
-		handle_system_shutdown(epow_log->event_modifier);
+		handle_system_shutdown(modifier);
 		break;
 
 	case EPOW_SYSTEM_HALT:
-- 
2.7.4


