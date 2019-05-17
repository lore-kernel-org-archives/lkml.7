Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C8C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6799D20868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfEQHP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:15:57 -0400
Received: from smtpbg65.qq.com ([103.7.28.233]:41125 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbfEQHP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:15:57 -0400
X-QQ-mid: bizesmtp16t1558077328tbi6f6eq
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 17 May 2019 15:15:23 +0800 (CST)
X-QQ-SSF: 01400000000000H0HG32B00A0000000
X-QQ-FEAT: L3blbkxtNtm+rzjeLRXoZ87U2dRsGzkJKd3sLysIF5OldGCxQpoqhZumo3jum
        6x3gEM9G6qf0l3C0nCWcEtcmUgumZ1M6+ZAaSuRl6TiaekbuNvuELF6/SYrfiPHXvRwQ+18
        ypxQjiYFptwzB1Yxc9ueB0QiIijgDD+puA8rlsxL5EEj0E20oTUrvvH4SIHeX9xDxMARU3v
        snNP+UHs9X31GE+puCBrih71fo4kXZKrtECDILW8fK+sanJvNCBqgUXZyOyrxl8cvJUxjka
        Bm2joRSzQz9+m1xPv59XLHUrbjVTs4Qllc9f/HzvwvN/B7g/RjJA3kK+U=
X-QQ-GoodBg: 2
From:   xiaolinkui <xiaolinkui@kylinos.cn>
To:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaolinkui@kylinos.cn
Subject: [PATCH] arch: s390: use struct_size() in kmalloc()
Date:   Fri, 17 May 2019 15:15:17 +0800
Message-Id: <1558077317-12201-1-git-send-email-xiaolinkui@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new struct_size() helper to keep code simple.

Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 arch/s390/include/asm/idals.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
index 15578fd..6fb7ace 100644
--- a/arch/s390/include/asm/idals.h
+++ b/arch/s390/include/asm/idals.h
@@ -122,8 +122,7 @@ idal_buffer_alloc(size_t size, int page_order)
 
 	nr_ptrs = (size + IDA_BLOCK_SIZE - 1) >> IDA_SIZE_LOG;
 	nr_chunks = (4096 << page_order) >> IDA_SIZE_LOG;
-	ib = kmalloc(sizeof(struct idal_buffer) + nr_ptrs*sizeof(void *),
-		     GFP_DMA | GFP_KERNEL);
+	ib = kmalloc(struct_size(ib, data, nr_ptrs), GFP_DMA | GFP_KERNEL);
 	if (ib == NULL)
 		return ERR_PTR(-ENOMEM);
 	ib->size = size;
-- 
2.7.4



