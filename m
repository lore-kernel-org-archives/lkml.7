Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483D8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A60215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886987;
	bh=itihUV75LrKfmppqFKpEer/o557PHmae8JTZEu0oCCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QHy9POfKgGBN92XZDLvXLHTFHWJtXHhboOwZxzySHXkThD+DSo2NVK8vzp5U5/BHT
	 i8AhwPbzjV9cTKjmeq50x1Nd6kKd0LpsEqgvzm+U1NpqIwJzaD9UAAD1KCzW2M98KL
	 kW9AfYuZ9eNlz+qu3wkPznNEVjA0WmZybDq46GpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfK0UgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfK0UgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:36:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F5052173B;
        Wed, 27 Nov 2019 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886981;
        bh=itihUV75LrKfmppqFKpEer/o557PHmae8JTZEu0oCCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLph9cCgmM8Y3DFGMvX25Vvj/CK+ip3gKS3sd3L+VtSmO3E9aSgv3tSI/lOTYN0MG
         /fn1lRll0eC3QXyWS9CTcQ8pPoMMHX0HFvILabFb12w12iibC+avR6qS9UaJ1Z36aM
         CX/bLAlUZ43/qqxI4K5UQw9Cf/UEMp9QelaQ2XpM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 065/132] linux/bitmap.h: fix type of nbits in bitmap_shift_right()
Date:   Wed, 27 Nov 2019 21:30:56 +0100
Message-Id: <20191127203002.474605254@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index e9d5df4315d94..714ce4a5e31fd 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -308,7 +308,7 @@ static __always_inline int bitmap_weight(const unsigned long *src, unsigned int
 }
 
 static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
-				unsigned int shift, int nbits)
+				unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = (*src & BITMAP_LAST_WORD_MASK(nbits)) >> shift;
-- 
2.20.1



