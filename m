Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EDD206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfDCFpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:45:41 -0400
Received: from mx.sdf.org ([205.166.94.20]:61780 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfDCFpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:45:40 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x335jRBu028339
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Wed, 3 Apr 2019 05:45:27 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x335jQJO015258;
        Wed, 3 Apr 2019 05:45:26 GMT
Date:   Wed, 3 Apr 2019 05:45:26 GMT
Message-Id: <201904030545.x335jQJO015258@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Subject: [PATCH v2] ubsan: Avoid unnecessary 128-bit shifts
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        George Spelvin <lkml@sdf.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ARCH_SUPPORTS_INT128, s_max is 128 bits, and variable
sign-extending shifts of such a double-word data type are a non-trivial
amount of code and complexity.  Do a single-word shift *before* the cast
to (s_max), greatly simplifying the object code.

(Yes, I know "signed long" is redundant.  It's there for emphasis.)

On s390 (and perhaps some other arches), gcc implements variable
128-bit shifts using an __ashrti3 helper function which the kernel
doesn't provide, causing a link error.  In that case, this patch is
a prerequisite for enabling INT128 support.  Andrey Ryabinin has gven
permission for any arch that needs it to cherry-pick it so they don't
have to wait for ubsan to be merged into Linus' tree.

We *could*, alternatively, implement __ashrti3, but that becomes dead as
soon as this patch is merged, so it seems like a waste of time and its
absence discourages people from adding inefficient code.  Note that the
shifts in <math64.h> (unsigned, and by a compile-time constant amount)
are simpler and generated inline.

Signed-off-by: George Spelvin <lkml@sdf.org>
Acked-By: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/ubsan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

v1->v2:	Eliminated redundant cast to (s_max).
	Rewrote commit message without "is this the right thing to do?"
	verbiage.
	Incorporated ack from Andrey Ryabinin.

diff --git a/lib/ubsan.c b/lib/ubsan.c
index e4162f59a81c..a7eb55fbeede 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -89,8 +89,8 @@ static bool is_inline_int(struct type_descriptor *type)
 static s_max get_signed_val(struct type_descriptor *type, unsigned long val)
 {
 	if (is_inline_int(type)) {
-		unsigned extra_bits = sizeof(s_max)*8 - type_bit_width(type);
-		return ((s_max)val) << extra_bits >> extra_bits;
+		unsigned extra_bits = sizeof(val)*8 - type_bit_width(type);
+		return (signed long)val << extra_bits >> extra_bits;
 	}
 
 	if (type_bit_width(type) == 64)
-- 
2.20.1

