Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8CDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E4421670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbfIFVLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 17:11:55 -0400
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:36182 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728338AbfIFVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:11:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 678358368F02;
        Fri,  6 Sep 2019 21:11:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: team46_2d769cac3b337
X-Filterd-Recvd-Size: 2775
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Sep 2019 21:11:52 +0000 (UTC)
Message-ID: <a68114afb134b8633905f5a25ae7c4e6799ce8f1.camel@perches.com>
Subject: [PATCH] docs: printk-formats: Stop encouraging use of unnecessary
 %h[xudi] and %hh[xudi]
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Louis Taylor <louis@kragniz.eu>
Date:   Fri, 06 Sep 2019 14:11:51 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

As Linus said in:
Link: https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/

It's a pointless warning, making for more complex code, and
making people remember esoteric printf format details that have no
reason for existing.

The "h" and "hh" things should never be used. The only reason for them
being used if if you have an "int", but you want to print it out as a
"char" (and honestly, that is a really bad reason, you'd be better off
just using a proper cast to make the code more obvious).

So if what you have a "char" (or unsigned char) you should always just
print it out as an "int", knowing that the compiler already did the
proper type conversion.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/core-api/printk-formats.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index c6224d039bcb..ecbebf4ca8e7 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -13,10 +13,10 @@ Integer types
 
 	If variable is of Type,		use printk format specifier:
 	------------------------------------------------------------
-		char			%hhd or %hhx
-		unsigned char		%hhu or %hhx
-		short int		%hd or %hx
-		unsigned short int	%hu or %hx
+		char			%d or %x
+		unsigned char		%u or %x
+		short int		%d or %x
+		unsigned short int	%u or %x
 		int			%d or %x
 		unsigned int		%u or %x
 		long			%ld or %lx
@@ -25,10 +25,10 @@ Integer types
 		unsigned long long	%llu or %llx
 		size_t			%zu or %zx
 		ssize_t			%zd or %zx
-		s8			%hhd or %hhx
-		u8			%hhu or %hhx
-		s16			%hd or %hx
-		u16			%hu or %hx
+		s8			%d or %x
+		u8			%u or %x
+		s16			%d or %x
+		u16			%u or %x
 		s32			%d or %x
 		u32			%u or %x
 		s64			%lld or %llx


