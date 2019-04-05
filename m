Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF63FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8642175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 04:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mcZYLV1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfDEE5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 00:57:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEE5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 00:57:20 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD30A1EC0A6C;
        Fri,  5 Apr 2019 06:57:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554440239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ZJ3BzxrdEPGzbhcvzY3hQl47oFhRbPY61VCjeox4lA0=;
        b=mcZYLV1bbuvl/2lFTXBo7WJf1mBkXOAiC2QOYHRYyS4tnO9xSgkimbxNQGz0IbHlhkCv/n
        iRoaGPiHNVWZIUPx9w13Rtc9EUjC9xpU0SPUECmIlBhsDvOmQbHaDni/1mMbv5g0lXFIkg
        rQ743Pz7iYQY9EQDD5swuJ8neiMRxMY=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] overflow.h: Rename __ab_c_size() to __calc_size()
Date:   Fri,  5 Apr 2019 06:57:11 +0200
Message-Id: <20190405045711.30339-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... to make its name readable to humans so that it can denote what that
helper does.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/linux/overflow.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 40b48e2133cb..a9cb77d54df0 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -278,7 +278,7 @@ static inline __must_check size_t array3_size(size_t a, size_t b, size_t c)
 	return bytes;
 }
 
-static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
+static inline __must_check size_t __calc_size(size_t n, size_t size, size_t c)
 {
 	size_t bytes;
 
@@ -302,7 +302,7 @@ static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define struct_size(p, member, n)					\
-	__ab_c_size(n,							\
+	__calc_size(n,							\
 		    sizeof(*(p)->member) + __must_be_array((p)->member),\
 		    sizeof(*(p)))
 
-- 
2.21.0

