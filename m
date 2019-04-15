Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02EAC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A6D20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356220;
	bh=kCpm+MyXmaaPxl+WAR7wPjIj+5TZtAOJr4Lre1+Vvms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sUYhjPKzg2fflNthRU2Ea8r+422HMFSVQVFNMTJvVErKJ+4lK3ye3+vhLUjD7caeY
	 GVvVDq02JLJcw4x+GGUZynK0zUwkKvtXXkwLEPSTBYX4SpU/h/CH6N8taFPkysoI9i
	 FVPD4HY2UBBXuiGo+aPu/BuzBkVBMEhFDWpqIs1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfDOTXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbfDOTHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 615EA21905;
        Mon, 15 Apr 2019 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355239;
        bh=kCpm+MyXmaaPxl+WAR7wPjIj+5TZtAOJr4Lre1+Vvms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djwuJ4WSptQ5vxVQfQLoaNudhGCuh8N+ED+hP1GMtB82JTaS9tG2Ul8SqUeB91lQm
         fRR5iMg2TgSYBp9S5Muc/ugY0nrqe8tZRYmg0OpuSf7j9CcE3ci2+jr6z3NRHXLhow
         e/b1Thy2HA5dXKfD+THqqqi/WJzJOSNvmfnNSzB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhao Qiang <qiang.zhao@nxp.com>,
        Yalin Wang <yalin.wang@sonymobile.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 063/101] include/linux/bitrev.h: fix constant bitrev
Date:   Mon, 15 Apr 2019 20:59:01 +0200
Message-Id: <20190415183743.823917556@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 6147e136ff5071609b54f18982dea87706288e21 upstream.

clang points out with hundreds of warnings that the bitrev macros have a
problem with constant input:

  drivers/hwmon/sht15.c:187:11: error: variable '__x' is uninitialized when used within its own initialization
        [-Werror,-Wuninitialized]
          u8 crc = bitrev8(data->val_status & 0x0F);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/bitrev.h:102:21: note: expanded from macro 'bitrev8'
          __constant_bitrev8(__x) :                       \
          ~~~~~~~~~~~~~~~~~~~^~~~
  include/linux/bitrev.h:67:11: note: expanded from macro '__constant_bitrev8'
          u8 __x = x;                     \
             ~~~   ^

Both the bitrev and the __constant_bitrev macros use an internal
variable named __x, which goes horribly wrong when passing one to the
other.

The obvious fix is to rename one of the variables, so this adds an extra
'_'.

It seems we got away with this because

 - there are only a few drivers using bitrev macros

 - usually there are no constant arguments to those

 - when they are constant, they tend to be either 0 or (unsigned)-1
   (drivers/isdn/i4l/isdnhdlc.o, drivers/iio/amplifiers/ad8366.c) and
   give the correct result by pure chance.

In fact, the only driver that I could find that gets different results
with this is drivers/net/wan/slic_ds26522.c, which in turn is a driver
for fairly rare hardware (adding the maintainer to Cc for testing).

Link: http://lkml.kernel.org/r/20190322140503.123580-1-arnd@arndb.de
Fixes: 556d2f055bf6 ("ARM: 8187/1: add CONFIG_HAVE_ARCH_BITREVERSE to support rbit instruction")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Yalin Wang <yalin.wang@sonymobile.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/bitrev.h |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

--- a/include/linux/bitrev.h
+++ b/include/linux/bitrev.h
@@ -34,41 +34,41 @@ static inline u32 __bitrev32(u32 x)
 
 #define __constant_bitrev32(x)	\
 ({					\
-	u32 __x = x;			\
-	__x = (__x >> 16) | (__x << 16);	\
-	__x = ((__x & (u32)0xFF00FF00UL) >> 8) | ((__x & (u32)0x00FF00FFUL) << 8);	\
-	__x = ((__x & (u32)0xF0F0F0F0UL) >> 4) | ((__x & (u32)0x0F0F0F0FUL) << 4);	\
-	__x = ((__x & (u32)0xCCCCCCCCUL) >> 2) | ((__x & (u32)0x33333333UL) << 2);	\
-	__x = ((__x & (u32)0xAAAAAAAAUL) >> 1) | ((__x & (u32)0x55555555UL) << 1);	\
-	__x;								\
+	u32 ___x = x;			\
+	___x = (___x >> 16) | (___x << 16);	\
+	___x = ((___x & (u32)0xFF00FF00UL) >> 8) | ((___x & (u32)0x00FF00FFUL) << 8);	\
+	___x = ((___x & (u32)0xF0F0F0F0UL) >> 4) | ((___x & (u32)0x0F0F0F0FUL) << 4);	\
+	___x = ((___x & (u32)0xCCCCCCCCUL) >> 2) | ((___x & (u32)0x33333333UL) << 2);	\
+	___x = ((___x & (u32)0xAAAAAAAAUL) >> 1) | ((___x & (u32)0x55555555UL) << 1);	\
+	___x;								\
 })
 
 #define __constant_bitrev16(x)	\
 ({					\
-	u16 __x = x;			\
-	__x = (__x >> 8) | (__x << 8);	\
-	__x = ((__x & (u16)0xF0F0U) >> 4) | ((__x & (u16)0x0F0FU) << 4);	\
-	__x = ((__x & (u16)0xCCCCU) >> 2) | ((__x & (u16)0x3333U) << 2);	\
-	__x = ((__x & (u16)0xAAAAU) >> 1) | ((__x & (u16)0x5555U) << 1);	\
-	__x;								\
+	u16 ___x = x;			\
+	___x = (___x >> 8) | (___x << 8);	\
+	___x = ((___x & (u16)0xF0F0U) >> 4) | ((___x & (u16)0x0F0FU) << 4);	\
+	___x = ((___x & (u16)0xCCCCU) >> 2) | ((___x & (u16)0x3333U) << 2);	\
+	___x = ((___x & (u16)0xAAAAU) >> 1) | ((___x & (u16)0x5555U) << 1);	\
+	___x;								\
 })
 
 #define __constant_bitrev8x4(x) \
 ({			\
-	u32 __x = x;	\
-	__x = ((__x & (u32)0xF0F0F0F0UL) >> 4) | ((__x & (u32)0x0F0F0F0FUL) << 4);	\
-	__x = ((__x & (u32)0xCCCCCCCCUL) >> 2) | ((__x & (u32)0x33333333UL) << 2);	\
-	__x = ((__x & (u32)0xAAAAAAAAUL) >> 1) | ((__x & (u32)0x55555555UL) << 1);	\
-	__x;								\
+	u32 ___x = x;	\
+	___x = ((___x & (u32)0xF0F0F0F0UL) >> 4) | ((___x & (u32)0x0F0F0F0FUL) << 4);	\
+	___x = ((___x & (u32)0xCCCCCCCCUL) >> 2) | ((___x & (u32)0x33333333UL) << 2);	\
+	___x = ((___x & (u32)0xAAAAAAAAUL) >> 1) | ((___x & (u32)0x55555555UL) << 1);	\
+	___x;								\
 })
 
 #define __constant_bitrev8(x)	\
 ({					\
-	u8 __x = x;			\
-	__x = (__x >> 4) | (__x << 4);	\
-	__x = ((__x & (u8)0xCCU) >> 2) | ((__x & (u8)0x33U) << 2);	\
-	__x = ((__x & (u8)0xAAU) >> 1) | ((__x & (u8)0x55U) << 1);	\
-	__x;								\
+	u8 ___x = x;			\
+	___x = (___x >> 4) | (___x << 4);	\
+	___x = ((___x & (u8)0xCCU) >> 2) | ((___x & (u8)0x33U) << 2);	\
+	___x = ((___x & (u8)0xAAU) >> 1) | ((___x & (u8)0x55U) << 1);	\
+	___x;								\
 })
 
 #define bitrev32(x) \


