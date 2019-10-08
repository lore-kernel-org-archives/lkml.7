Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6343C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BF221835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NF0oX8YW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfJHUmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:42:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfJHUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M/gJiVen29JN0sHYdmfabbX09bRdcnd8PfJ0YX3VJFc=; b=NF0oX8YW3Mj/fz+0dz1Uo9OtJ
        pKxxyFmSilSSL/yTMRi1OIYdCF/eOx4pCoHvqOeN17U6Rd0j6JCV6IFlbWh5JXeS6lSiaEJ5Eb9Pb
        cpmEpkgNHL6HAixqfBn6nc6yZULSm32aR10+fgygUShVoSl0xVf8gJqndfRnuB8ffA12ZQZLd5JAt
        5jtqIDmV6NKxKtHF+J7b7doghpPhXiVHnnHESTk5QHoaZYgxzTsL6qCpU6XtCXQ8H4vOizhPGXFtk
        KnzmQjG7F1SFs4zVtXkvI3du4DQ2s4h+ZZZJWueSa5l+tnQ3g03uSk8q7tBj2U2DjQHHnb8IWbEqT
        c+UGDPf7g==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHwJ1-0004A6-9h; Tue, 08 Oct 2019 20:42:03 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] bitmap.h: fix kernel-doc warning and typo
Message-ID: <0729ea7a-2c0d-b2c5-7dd3-3629ee0803e2@infradead.org>
Date:   Tue, 8 Oct 2019 13:42:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning in <linux/bitmap.h>:

../include/linux/bitmap.h:341: warning: Function parameter or member 'nbits' not described in 'bitmap_or_equal'

Also fix small typo (bitnaps).

Fixes: b9fa6442f704 ("cpumask: Implement cpumask_or_equal()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/bitmap.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20191008.orig/include/linux/bitmap.h
+++ linux-next-20191008/include/linux/bitmap.h
@@ -326,10 +326,11 @@ static inline int bitmap_equal(const uns
 }
 
 /**
- * bitmap_or_equal - Check whether the or of two bitnaps is equal to a third
+ * bitmap_or_equal - Check whether the or of two bitmaps is equal to a third
  * @src1:	Pointer to bitmap 1
  * @src2:	Pointer to bitmap 2 will be or'ed with bitmap 1
  * @src3:	Pointer to bitmap 3. Compare to the result of *@src1 | *@src2
+ * @nbits:	number of bits in each of these bitmaps
  *
  * Returns: True if (*@src1 | *@src2) == *@src3, false otherwise
  */

