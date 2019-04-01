Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021DBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A152084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="UCeE8vt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfDAI5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:57:19 -0400
Received: from mx.sdf.org ([205.166.94.20]:62471 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfDAI5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:57:19 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x318v9Ci028758
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Mon, 1 Apr 2019 08:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
        t=1554109036; bh=VLsgpNLkiK3DdqSgqhSO4zP/W3Xcz6bfCQwaaZPGDoE=;
        h=Date:From:To:Cc:Subject;
        b=UCeE8vt1D/jAsSgjM/1vFHMhQ/TMw2ZtiD/qEJ+5Wie8oGHhVKdCUloEBNCSay/fk
         d0ENQ2ZB0SEA7I6NPefZr44zwWmmbkAGyZoT9qO3CsLMj0uYJoHzqMpQGZop3A8r6d
         KSk1GOI1D3wosurz6v2VTSmkP+WgEJbXcCq+z03Y=
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x318v8J4007902;
        Mon, 1 Apr 2019 08:57:08 GMT
Date:   Mon, 1 Apr 2019 08:57:08 GMT
Message-Id: <201904010857.x318v8J4007902@sdf.org>
From:   George Spelvin <lkml@sdf.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        George Spelvin <lkml@sdf.org>
Subject: [PATCH] ubsan: Avoid unnecessary 128-bit shifts
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Double-word sign-extending shifts by a variable amount are a
non-trivial amount of code and complexity.  Doing signed long shifts
before the cast to (s_max) greatly simplifies the object code.

(Yes, I know "signed" is redundant.  It's there for emphasis.)

The complex issue raised by this patch is that allows s390 (at
least) to enable CONFIG_ARCH_SUPPORTS_INT128.

If you enable that option, s_max becomes 128 bits, and gcc compiles
the pre-patch code with a call to __ashrti3.  (And, on some gcc
versions, __ashlti3.)  Which isn't implemented, ergo link error.

Enabling that option allows 64-bit widening multiplies which
greatly simplify a lot of timestamp scaling code in the kernel,
so it's desirable.

But how to get there?

One option is to implement __ashrti3 on the platforms that need it.
But I'm inclined to *not* do so, because it's inefficient, rare,
and avoidable.  This patch fixes the sole instance in the entire
kernel, which will make that implementation dead code, and I think
its absence will encourage Don't Do That, Then going forward.

But if we don't implement it, we've created an awkward dependency
between patches in different subsystems, and that needs handling.

Option 1: Submit this for 5.2 and turn on INT128 for s390 in 5.3.
Option 2: Let the arches cherry-pick this patch pre-5.2.

My preference is for option 2, but that requires permission from
ubsan's owner.  Andrey?

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/ubsan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index e4162f59a81c..43ce177a5ca7 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -89,8 +89,8 @@ static bool is_inline_int(struct type_descriptor *type)
 static s_max get_signed_val(struct type_descriptor *type, unsigned long val)
 {
 	if (is_inline_int(type)) {
-		unsigned extra_bits = sizeof(s_max)*8 - type_bit_width(type);
-		return ((s_max)val) << extra_bits >> extra_bits;
+		unsigned extra_bits = sizeof(val)*8 - type_bit_width(type);
+		return (s_max)((signed long)val << extra_bits >> extra_bits);
 	}
 
 	if (type_bit_width(type) == 64)
-- 
2.20.1

