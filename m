Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D1C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F69204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pAwTcTNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEIIwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:52:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfEIIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:52:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x498qE0r1467660
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 May 2019 01:52:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x498qE0r1467660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557391935;
        bh=FwSPRiLSzeSlL4motpJx03miPIk2w1iG83hZBa3WD6Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pAwTcTNlSyxjY1h9AbPyh89mmdmKA/H24HwNdsj+xBagV1dmc6/SWxjGIYi7JgejL
         Z2QbwfJQQQKxolMF2deJ2Zvhjxvgq8EppTeDhXUaE7KPa2Ik0+Mjdjin3hvJUjsxqO
         IO0TA0S+EenYa4ASGQsZGQh5sbbqb/LcfGZWQDzej1s3wLEE97IgE6wsEOQVF3cMnd
         luINp740dUea1kbyMjOZZPrSEGY0d1JqhLqLjgECSwvuo64TrxkRPuPZryduV7QiWg
         Eb4YH4g2kkmfXGn83hUuEW7jfK0NuaGOD8Op4ZyJHDnbSHmuFXSaBueNDSklpbWRsj
         bfTUaAuIz/cGg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x498qAhC1467654;
        Thu, 9 May 2019 01:52:10 -0700
Date:   Thu, 9 May 2019 01:52:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-f3d964673b2f1c5d5c68c77273efcf7103eed03b@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, arnd@arndb.de,
        hpa@zytor.com, deepa.kernel@gmail.com, joseph@codesourcery.com,
        lukma@denx.de, stepan@golosunov.pp.ru, mingo@kernel.org
Reply-To: arnd@arndb.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, stepan@golosunov.pp.ru,
          lukma@denx.de, joseph@codesourcery.com, deepa.kernel@gmail.com
In-Reply-To: <20190429131951.471701-1-arnd@arndb.de>
References: <20190429131951.471701-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] y2038: Make CONFIG_64BIT_TIME unconditional
Git-Commit-ID: f3d964673b2f1c5d5c68c77273efcf7103eed03b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f3d964673b2f1c5d5c68c77273efcf7103eed03b
Gitweb:     https://git.kernel.org/tip/f3d964673b2f1c5d5c68c77273efcf7103eed03b
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 29 Apr 2019 15:19:37 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 21:07:10 +0200

y2038: Make CONFIG_64BIT_TIME unconditional

As Stepan Golosunov points out, there is a small mistake in the
get_timespec64() function in the kernel. It was originally added under the
assumption that CONFIG_64BIT_TIME would get enabled on all 32-bit and
64-bit architectures, but when the conversion was done, it was only turned
on for 32-bit ones.

The effect is that the get_timespec64() function never clears the upper
half of the tv_nsec field for 32-bit tasks in compat mode. Clearing this is
required for POSIX compliant behavior of functions that pass a 'timespec'
structure with a 64-bit tv_sec and a 32-bit tv_nsec, plus uninitialized
padding.

The easiest fix for linux-5.1 is to just make the Kconfig symbol
unconditional, as it was originally intended. As a follow-up, the #ifdef
CONFIG_64BIT_TIME can be removed completely..

Note: for native 32-bit mode, no change is needed, this works as
designed and user space should never need to clear the upper 32
bits of the tv_nsec field, in or out of the kernel.

Fixes: 00bf25d693e7 ("y2038: use time32 syscall names on 32-bit")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joseph Myers <joseph@codesourcery.com>
Cc: libc-alpha@sourceware.org
Cc: linux-api@vger.kernel.org
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Stepan Golosunov <stepan@golosunov.pp.ru>
Link: https://lore.kernel.org/lkml/20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru/
Link: https://lkml.kernel.org/r/20190429131951.471701-1-arnd@arndb.de

---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 33687dddd86a..9092e0ffe4d3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -764,7 +764,7 @@ config COMPAT_OLD_SIGACTION
 	bool
 
 config 64BIT_TIME
-	def_bool ARCH_HAS_64BIT_TIME
+	def_bool y
 	help
 	  This should be selected by all architectures that need to support
 	  new system calls with a 64-bit time_t. This is relevant on all 32-bit
