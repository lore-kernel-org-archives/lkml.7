Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E6C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A607C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDZOZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:25:47 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34199 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDZOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:25:47 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MbTCr-1gmtxm3d05-00buge; Fri, 26 Apr 2019 16:25:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joseph Myers <joseph@codesourcery.com>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Lukasz Majewski <lukma@denx.de>,
        Stepan Golosunov <stepan@golosunov.pp.ru>
Subject: [PATCH 1/2] y2038: make CONFIG_64BIT_TIME unconditional
Date:   Fri, 26 Apr 2019 16:25:04 +0200
Message-Id: <20190426142531.1378357-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fIJzz9wj+ao9HQhnAv2jIWZsWFqfvgw+Oy7O3nycVovvV0MS3Nl
 obIIVIsSedgGiymLYKpYSUVpHoc0Xcjsn53G1AvEPhlQsm2EHLdpnRl0pg0Dxmn/zokJKiI
 +AeQdQ0tz7vq+N4Kmh27Ieor82N4OMHIeaKqP6oD8uhU93QAXEACHahCYcwkCVoYvqSYm7O
 uwPHbqqhCC3dpx1MNU4yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C4fKpd5A+4U=:odrg9PhoL/1HJOZeNkOhyH
 O5M1WrSt4d+MH2c9+JEu1wd/Z5pn2eEOsryNN3uybDS9OxybN0RXnwcaigQuLyec8Gus1fvhP
 MYdgH0vV2ziysm8z86qu/QN4EjMrnxFJZ5FtfFyQ3HRuNESSvCJb0UbM/0geqZNXChsafkWTn
 KGvj8uMgqByj4Ws6TqLgtYtYy1CLa7MngzGPozURxTXR+Cxw1KPrCFV5vuqDfSErTb4Ewp9WC
 Dmlb2n7zt7hYgMg8a90UZKnTD7+Wzek90pVVLE0UXYluR/kbDPk0aXHR/0pEj6tnUX/r/R5MN
 H2CLQ/ZNtptifaq36R3fN28U8uXYlbG34Y/cM0ssKRIIILtL2JxRTwzq6uDtKowKdEB9LHVnb
 7/UvSI4/R92K9gSW6NXyRkONVFS+5ZQJNuzVb6wphWoD3xkF6/g/2+jxcrJmjob8Ncqicowv9
 iVeMXCMjRiIOsC2ILZJcGFocNyBWSLO+rTO8Ec+I/yBOzvivNPOqu3jRMuMW6k4LLDIEtBfn5
 aTRqVND8JstKCpCGAXv5//LrHHW3kUSatMukMmGHTe2GJDDJ/QflFs704ninGzLLNZfhDcLFq
 GN5FxvBhne8zC0kkcwzB5NxItoWuGTyt4SZHulZOh30vBrv9K+vDdRhRoSeB3A7jhNNd4UJTQ
 O9GjSTI4dvgRtgr73d/g+LmVdnDWkZ4juE2zwDlztY1qCe5bwJv0t7JV2VL/yiPCv3xFw8EGy
 6EOZryWlAU7I+t20v7gKmC/tDbQuXPGr3cMYrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Stepan Golosunov points out, we made a small mistake in the
get_timespec64() function in the kernel. It was originally added under
the assumption that CONFIG_64BIT_TIME would get enabled on all 32-bit
and 64-bit architectures, but when I did the conversion, I only turned
it on for 32-bit ones.

The effect is that the get_timespec64() function never clears the upper
half of the tv_nsec field for 32-bit tasks in compat mode. Clearing this
is required for POSIX compliant behavior of functions that pass a
'timespec' structure with a 64-bit tv_sec and a 32-bit tv_nsec, plus
uninitialized padding.

The easiest fix for linux-5.1 is to just make the Kconfig symbol
unconditional, as it was originally intended. As a follow-up,
we should remove any #ifdef CONFIG_64BIT_TIME completely.

Link: https://lore.kernel.org/lkml/20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru/
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Stepan Golosunov <stepan@golosunov.pp.ru>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please apply this one as a bugfix for 5.1
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
-- 
2.20.0

