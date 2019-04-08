Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C7C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477F021473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfDHV14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:27:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDHV14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:27:56 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M9nhF-1hIoSp21wL-005non; Mon, 08 Apr 2019 23:27:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] s390: purgatory: pass --target option to clang
Date:   Mon,  8 Apr 2019 23:26:16 +0200
Message-Id: <20190408212648.2407234-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0tSFcfZEGhmi3LO0T7RG67wRm2IyqlmzXadJlocqt9B7sFY/+lt
 BWUl4xnwjasv1KClaYG7Kn5Q29ZfdAaeJfZW8NmnH0SKXn24hxqgxGmNL05YVrj8/jo+tGW
 0BiBBil8giHVcEoLEjBtaFPJU80sMQNK+F14LqY/3QzHfZS/LtIWZRtRLKGnm1scc+fiXVw
 1m4y1TPm6KQF2CH+AduSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ozYeKzMil0o=:UBmHGABlIwB+YQP1sDCHFM
 walQWJF2sawPSRMvC1sBwMtvQGQicSpyKGpdaZniEUAIt78/cEz93DJaoownsAolDojocCJ8p
 N3EbWxqyQMPK+F+4M4JATHXaSypkFJYZd6bK8iGBElWHlJWANTJA4oVDWnHkqwYld9DWSmw5G
 Te88C4VqjuH+mRD87FQ7D3fwJ6Y+WR/F2QjWd9F0KG493eHZJI+cBb4lkoAn8+2PZbwzzQyg+
 1F8/8xCwzZvcntngC8ef6wJdPQn1BBkqJOMKOb8IVsWdu62TB9qMwKb9yXsFiV3RlItsosvbC
 sYZ7fE3QCwq+CZU+mEu/Hm07eh3p7D7vTvOw7wtdAUJNrxZIRgJOfkc10yfNkuW6ZUqH5An4y
 5pJaVltEiYv5ZYMgQxrtg+ECgsPjt6k7ZTecjSsl8vDFg3i8XFq84K1zkqdfQiPz7eVYrwjMF
 BVByHw+ALQA2mxM7PRiNIYoASLPtS93MUacfXgpzGLLIi7ZbYKhOWCSy7JpbWsZwdkwPEu3o1
 91ZfinCStiZx+BoHvdybAY3Mv0hpUL/3pE/8MAxj9nKdzRg0jCv2KGOPbGENzzfdqfaFsy3Bx
 3femAuUhVScnVoHejDHQGUCcTcgxyKHCU0DeocSqvjNBzqDhk76gAOEJd9aQ2SPZ3nHsI4bmK
 /FUOnjRKAUAMz3FCybiHSqm4QdZlCuXl9InMi/b2Q2aYwDQkhAblm04zfxiRJ9ovrGr1jmjQU
 34nec+8F3QR0zgu+PlTc6X+fzJTN2ll39e5RZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purgatory Makefile does not inherit the original cflags,
so clang falls back to the default target architecture when
building it, typically this would be x86 when cross-compiling.

Pass --target=s390x-linux to all compilers that understand
this option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index ce6a3f75065b..3a14b968cec3 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
+KBUILD_CFLAGS += $(call cc-option,--target=s390x-linux)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
 
-- 
2.20.0

