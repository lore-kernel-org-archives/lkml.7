Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7377C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F7C206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNHPZJQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfFUHN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:13:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34599 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfFUHNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:13:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so5475679wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 00:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XT/pfvoYcCU99F59K2rs15fGDiUVH52ZV6XFVTDAZg=;
        b=FNHPZJQT0oP/iQev1yEfbzz7TBuZfZ/U6l19Qs+u5B4uUVILUj88XveLBnE1cP7phD
         avkhrE2Nk/QJZ5WTFd9XtYLs8i2uMGwzJog4716PxM9t1zTTHSm08eZ2djwc6Ey6xNVK
         ysMqi/6adk3t9hKFEV0mEDjWFJKoa4qeHjIzhil/lLLR6ipm+rV9Rb5RiYQJNc3+zHZg
         71MlXZ4N8KghHFoGBeSAc4jjai+PyXVFVf7/goaDUPZSUgPVgquWFPoyCg/TBXPLaQJ4
         RwmPH2Ez8uxL58aVivHwpMCDxRASNQiqvVkqNa2F0axmXHDjvBdYY8itTDMKcbRTJvH8
         oIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1XT/pfvoYcCU99F59K2rs15fGDiUVH52ZV6XFVTDAZg=;
        b=tP0iry0NzHGS6TbzkuIgKfsA0e1NQzvHmyi9apBQsjEiLZX8bGcRJ/kgzJ08GtwCtP
         qtYdc4JnONpZGQNWKDzTIMaKhKy+WiEuGt7wZZtRWZD1QREzGUhxaMMuRGQb/vQTc6sc
         BnZyDK4KS63Wz6Wg5TOQXgzKWwAbST6snRrWy5RMJoyIRwD1WWX7qz2OeUr2dUTPzPTE
         4PjhdGgMP3VJwQZMCCLfpL/FMSDOkp11OOBdlmd+EjKLFy4+KISe5SALl7LyDKkZ9mYq
         BPv8u50WOQsi9T03fXMsoXkO+82izRVmT9CjearltItuGfc2eqdFofbsri2W5KotR9jv
         GXFg==
X-Gm-Message-State: APjAAAU+ER0HW0aJ7bBj3NDSCZtbErBs36bCGn3c5hHIEoRsqxDpx29M
        2l248zEtp2sBpsXOfeQsOrU=
X-Google-Smtp-Source: APXvYqwic8lT0iHowCcMQQlRyfpllWHv0oF80PCYXOg98bo0prLqUtrK6pWcKhlDH+DD0zDRFjsgUg==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr39709226wrw.266.1561101233750;
        Fri, 21 Jun 2019 00:13:53 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id b2sm2202403wrp.72.2019.06.21.00.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 00:13:53 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id E9CBB11459C7; Fri, 21 Jun 2019 09:13:51 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Joel Stanley <joel@jms.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: Fix build for clang
Date:   Fri, 21 Jun 2019 09:13:42 +0200
Message-Id: <20190621071342.17897-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file `longlong.h` makes uses of GNU extensions, this trigger
an error when compiling this code with clang. Add a special flag to make
clang tolerate this syntax.

Silence the following warnings triggered using W=1:

    CC      lib/mpi/generic_mpih-mul1.o
  ../lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
        -fheinous-gnu-extensions
                  umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
          : "=r" ((USItype) ph) \
                  ~~~~~~~~~~^~

and

    CC      lib/mpi/generic_mpih-mul2.o
  ../lib/mpi/generic_mpih-mul2.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
        -fheinous-gnu-extensions
                  umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
          : "=r" ((USItype) ph) \
                  ~~~~~~~~~~^~

  1 warning generated.
    CC      lib/mpi/generic_mpih-mul3.o
  ../lib/mpi/generic_mpih-mul3.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
        -fheinous-gnu-extensions
                  umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
          : "=r" ((USItype) ph) \
                  ~~~~~~~~~~^~

Or even:

  ../lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
                                  sub_ddmmss(n1, n0, n1, n0, d1, d0);
                                  ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~

Cc: Joel Stanley <joel@jms.id.au>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 lib/mpi/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/mpi/Makefile b/lib/mpi/Makefile
index d5874a7f5ff9..de4d96e988a3 100644
--- a/lib/mpi/Makefile
+++ b/lib/mpi/Makefile
@@ -5,6 +5,13 @@
 
 obj-$(CONFIG_MPILIB) = mpi.o
 
+ifdef CONFIG_CC_IS_CLANG
+CFLAGS_generic_mpih-mul1.o  += -fheinous-gnu-extensions
+CFLAGS_generic_mpih-mul2.o  += -fheinous-gnu-extensions
+CFLAGS_generic_mpih-mul3.o  += -fheinous-gnu-extensions
+CFLAGS_mpih-div.o  += -fheinous-gnu-extensions
+endif
+
 mpi-y = \
 	generic_mpih-lshift.o		\
 	generic_mpih-mul1.o		\
-- 
2.20.1

