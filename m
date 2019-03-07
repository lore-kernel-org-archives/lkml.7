Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA5CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117B320840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCGXvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:51:51 -0500
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:52742 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726217AbfCGXvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:51:50 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7F3ED1805B2C9;
        Thu,  7 Mar 2019 23:51:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: art80_66f1c43c6950d
X-Filterd-Recvd-Size: 1571
Received: from XPS-9350 (unknown [149.142.244.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Mar 2019 23:51:47 +0000 (UTC)
Message-ID: <d81a9133ad20d478dc8c14fbc8d1bacf4c8ffe94.camel@perches.com>
Subject: [PATCH] s390/mem_detect: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD)
From:   Joe Perches <joe@perches.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Mar 2019 15:51:45 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_ENABLED should generally use CONFIG_ prefaced symbols and
it doesn't appear as if there is a BLK_DEV_INITRD define.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/s390/boot/mem_detect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/mem_detect.c b/arch/s390/boot/mem_detect.c
index 4cb771ba13fa..5d316fe40480 100644
--- a/arch/s390/boot/mem_detect.c
+++ b/arch/s390/boot/mem_detect.c
@@ -25,7 +25,7 @@ static void *mem_detect_alloc_extended(void)
 {
 	unsigned long offset = ALIGN(mem_safe_offset(), sizeof(u64));
 
-	if (IS_ENABLED(BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
 	    INITRD_START < offset + ENTRIES_EXTENDED_MAX)
 		offset = ALIGN(INITRD_START + INITRD_SIZE, sizeof(u64));
 

