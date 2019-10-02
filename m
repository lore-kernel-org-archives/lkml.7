Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9961CC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B5A21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfJBGR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 02:17:27 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:48693 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726430AbfJBGR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 02:17:27 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x9260oNT065606;
        Wed, 2 Oct 2019 14:00:50 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 2 Oct 2019
 14:16:15 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     <alankao@andestech.com>, <paul.walmsley@sifive.com>,
        <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <aryabinin@virtuozzo.com>, <glider@google.com>,
        <dvyukov@google.com>, <alexios.zavras@intel.com>,
        <allison@lohutok.net>, <Anup.Patel@wdc.com>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <atish.patra@wdc.com>,
        <kstewart@linuxfoundation.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>
CC:     Nick Hu <nickhu@andestech.com>
Subject: [PATCH v2 1/2] kasan: Archs don't check memmove if not support it.
Date:   Wed, 2 Oct 2019 14:16:04 +0800
Message-ID: <c9fa9eb25a5c0b1f733494dfd439f056c6e938fd.1569995450.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1569995450.git.nickhu@andestech.com>
References: <cover.1569995450.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x9260oNT065606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip the memmove checking for those archs who don't support it.

Signed-off-by: Nick Hu <nickhu@andestech.com>
---
 mm/kasan/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6814d6d6a023..897f9520bab3 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -107,6 +107,7 @@ void *memset(void *addr, int c, size_t len)
 	return __memset(addr, c, len);
 }
 
+#ifdef __HAVE_ARCH_MEMMOVE
 #undef memmove
 void *memmove(void *dest, const void *src, size_t len)
 {
@@ -115,6 +116,7 @@ void *memmove(void *dest, const void *src, size_t len)
 
 	return __memmove(dest, src, len);
 }
+#endif
 
 #undef memcpy
 void *memcpy(void *dest, const void *src, size_t len)
-- 
2.17.0

