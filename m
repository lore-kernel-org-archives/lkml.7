Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141CAC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E8A2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919113;
	bh=dxoXWgxQRR9fmVdKQXfwIFqkFeZZdUdB1tLsIwrsVh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OeoE+fDO2XjX2msiA2mM4DjXk1cqKr8qnOr+5imI6e+UnOJjASps3pJPyGJbHMmLx
	 7CbmcfHGMRqsQWNd+JZv8N99MXui9ofsG1+KRB9lUEPKHNb5Mi2EVg3okMRb2zzgYF
	 Gwk64rBQEM2M21uVnDg60CAbx+fB/Bef8QxijWmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfKPPo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbfKPPox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:44:53 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2152072D;
        Sat, 16 Nov 2019 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919093;
        bh=dxoXWgxQRR9fmVdKQXfwIFqkFeZZdUdB1tLsIwrsVh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HoGgUA6wAdFUO160oscWND2qlEFY/arvLjF2RIkyvDEXnGVgCqeLPmh7hNUnj3UE2
         2In8X81aHT1JxvEJmrrY1ij3EfQvkzacIv4ei+sjxAl3aTGjuyvGzUwEN94tIJoaap
         yrW22UIR4LryTueyKu48tQiDnwFji5Xs7c0AR9y4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 151/237] linux/bitmap.h: fix type of nbits in bitmap_shift_right()
Date:   Sat, 16 Nov 2019 10:39:46 -0500
Message-Id: <20191116154113.7417-151-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

[ Upstream commit d9873969fa8725dc6a5a21ab788c057fd8719751 ]

Most other bitmap API, including the OOL version __bitmap_shift_right,
take unsigned nbits.  This was accidentally left out from 2fbad29917c98.

Link: http://lkml.kernel.org/r/20180818131623.8755-5-linux@rasmusvillemoes.dk
Fixes: 2fbad29917c98 ("lib: bitmap: change bitmap_shift_right to take unsigned parameters")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reported-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index a9805bacbd7ca..b71a033c781ef 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -403,7 +403,7 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 }
 
 static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
-				unsigned int shift, int nbits)
+				unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = (*src & BITMAP_LAST_WORD_MASK(nbits)) >> shift;
-- 
2.20.1

