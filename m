Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D32ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F620206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="h59ldwVg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="h59ldwVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfJKQDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:03:02 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36858 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbfJKQDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:03:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 489898EE10C;
        Fri, 11 Oct 2019 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1570809781;
        bh=J0NaFNhmxrsSU0oV0MRIM5pZ3/y6f0UNORoLr6xoa3U=;
        h=Subject:From:To:Cc:Date:From;
        b=h59ldwVghe7Q/RGV6FtY6DBmqSD9kDs77b27o4/bqiJJ6Eih9AyH6p4xwxapQrRnv
         kX7oISm1s5g/HCWrxHr0VGi1M+0d5G39GNWC3qOJNedohEMZalUSpX71vIgXTNRTS4
         dihyGPJFd59XYt2KMx0vlHRdo0wfUe1mV1H7/HqY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cGojt9yQ91Xe; Fri, 11 Oct 2019 09:03:01 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B32188EE0ED;
        Fri, 11 Oct 2019 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1570809781;
        bh=J0NaFNhmxrsSU0oV0MRIM5pZ3/y6f0UNORoLr6xoa3U=;
        h=Subject:From:To:Cc:Date:From;
        b=h59ldwVghe7Q/RGV6FtY6DBmqSD9kDs77b27o4/bqiJJ6Eih9AyH6p4xwxapQrRnv
         kX7oISm1s5g/HCWrxHr0VGi1M+0d5G39GNWC3qOJNedohEMZalUSpX71vIgXTNRTS4
         dihyGPJFd59XYt2KMx0vlHRdo0wfUe1mV1H7/HqY=
Message-ID: <1570809779.24157.1.camel@HansenPartnership.com>
Subject: [PATCH v2] tpm: use GFP kernel for tpm_buf allocations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Fri, 11 Oct 2019 09:02:59 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code uses GFP_HIGHMEM, which is wrong because GFP_HIGHMEM
(on 32 bit systems) is memory ordinarily inaccessible to the kernel
and should only be used for allocations affecting userspace.  In order
to make highmem visible to the kernel on 32 bit it has to be kmapped,
which consumes valuable entries in the kmap region.  Since the tpm_buf
is only ever used in the kernel, switch to using a GFP_KERNEL
allocation so as not to waste kmap space on 32 bits.

Fixes: a74f8b36352e (tpm: introduce tpm_buf)
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: fix 0day spotted problem with free_page taking an unsigned long
    not a void *
---
 drivers/char/tpm/tpm.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index a7fea3e0ca86..3a7998d7309a 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -284,7 +284,6 @@ enum tpm_buf_flags {
 };
 
 struct tpm_buf {
-	struct page *data_page;
 	unsigned int flags;
 	u8 *data;
 };
@@ -300,20 +299,18 @@ static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 
 static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
-	buf->data_page = alloc_page(GFP_HIGHUSER);
-	if (!buf->data_page)
+	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!buf->data)
 		return -ENOMEM;
 
 	buf->flags = 0;
-	buf->data = kmap(buf->data_page);
 	tpm_buf_reset(buf, tag, ordinal);
 	return 0;
 }
 
 static inline void tpm_buf_destroy(struct tpm_buf *buf)
 {
-	kunmap(buf->data_page);
-	__free_page(buf->data_page);
+	free_page((unsigned long)buf->data);
 }
 
 static inline u32 tpm_buf_length(struct tpm_buf *buf)
-- 
2.16.4

