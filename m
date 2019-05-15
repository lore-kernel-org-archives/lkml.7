Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A903CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB082166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918571;
	bh=QJLn3MhYYMiQkOw7GCZd4wzuFVq9wPRftRqIVNE/dic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tz50QRqvr1lMbl82X6boIUUJDzO3YvW6AhrrDxqIBukCZzTOicm/jOECQX/jDJR+F
	 rqEFBEaMAQ+vknm4sKVqx6EQKLqkJ/2H6uWs4QbmDxUC8J4Ao6/h/kLNRV8GntbiHe
	 j8dqDKYt6GCTOJpz+EwJANZM0+ZzYmUdegC1hoKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfEOLJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbfEOLJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:09:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D53E3216FD;
        Wed, 15 May 2019 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918566;
        bh=QJLn3MhYYMiQkOw7GCZd4wzuFVq9wPRftRqIVNE/dic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9lEq978+D+iWY6br0pXABJ5xR18IY7HOpOf/UKu4IDdDttKLpA3X5C3+rx5h5C1F
         5jPV6T+jPs3tGKTTbCOtpi3zm9C3x6Ih9arU4EpR5KddXmhslNaPHGAfbfLDSPAYGE
         Xm/rVa4luTiGFnbqI0T1E3upFwhPpiQZpMuBU9+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 181/266] bitops: avoid integer overflow in GENMASK(_ULL)
Date:   Wed, 15 May 2019 12:54:48 +0200
Message-Id: <20190515090729.051143618@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

commit c32ee3d9abd284b4fcaacc250b101f93829c7bae upstream.

GENMASK(_ULL) performs a left-shift of ~0UL(L), which technically
results in an integer overflow.  clang raises a warning if the overflow
occurs in a preprocessor expression.  Clear the low-order bits through a
substraction instead of the left-shift to avoid the overflow.

(akpm: no change in .text size in my testing)

Link: http://lkml.kernel.org/r/20170803212020.24939-1-mka@chromium.org
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bitops.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -19,10 +19,11 @@
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #define GENMASK(h, l) \
-	(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
 
 #define GENMASK_ULL(h, l) \
-	(((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+	(((~0ULL) - (1ULL << (l)) + 1) & \
+	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);


