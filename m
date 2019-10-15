Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3753ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E29D2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571103910;
	bh=3o4hB/Ct6AOWRJ1wvfRDXC1AgTVdv22pVY1AR9qCZis=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ph8sFdZo/+2wyt3YabqK+87dgn90KFd9oo2NF2asTYIy/Qualy4bJ0PEP6NIQ28CS
	 T0tv7fbl6dS8S/7t4WA/aJI+J3La4a4C8aTRQ9DazESwMtx3s5e8N4d/SVGY7JZl51
	 sq1WH2SNfzaqKLUiG1ItEq6bwd1tFWdgmBcYjYqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfJOBpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 21:45:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39329 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfJOBpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 21:45:08 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so42321968ioc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 18:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACbmiCYl1yVzW4bsJf2DTWEll5BNUiB3x+RCIAqbI2k=;
        b=B/InPDWweJaDl3CRrbzGkfGi/hdoMZPNiDIO6rLtffTrpYjG8EeSUb02dH+bdcxu2I
         anWL0/ff0D/uJ5yG7pCpu5+TiftEGQzHM14PmSZMSGHMfUSJwej0Mh38Neob10oWLJg/
         UUnndznfpgJw6o5s+/+DDiISKHbXeFzP+UTfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACbmiCYl1yVzW4bsJf2DTWEll5BNUiB3x+RCIAqbI2k=;
        b=oXGPyki2Bkjh3R4GlDus/TrC8eULOJ92dhXcuFkx/H5K7jUCR6L0JDYdZGfoJKrTwv
         f0XJbP8ZKbv08sYNp1S54Ee3bexD7iZnt3nkTjVkcce+15X063vHsXEmP0EGKgWtjP1V
         zAvgTr1UD0zt73gb9oD73sYvI8gwBGccA11swjyKAYPaoSSP2lOwvyFi5WCNKhRHW3/u
         WSwn5xWMLBXTRJ9c7HfG6DMQooyjjEPuagHzL26P66B/rhjfoSZeVsxZMLnE3kXoXXp9
         If5lLePLT4Jsy4WXY1g6nmJdGvT/g3GuhE3+H0BLLxuc3MHnj46lG6uuxfc9rLIxNfUn
         Y9ug==
X-Gm-Message-State: APjAAAVHOE2RRS5FtseNSHPLUiOxCcsgnAtCFoHYQGIcd4KklZpkI7ca
        nIonrBm0p/UZ4EojcPEzUoplM/FI9DM=
X-Google-Smtp-Source: APXvYqxoSvmS9iWN6kz0F/95cyO2GEurBj1hgNbVDCZa3i5PpREYM09NLtzvw6i2AGGLT8UHtm0otg==
X-Received: by 2002:a92:cb84:: with SMTP id z4mr3868224ilo.78.1571103907831;
        Mon, 14 Oct 2019 18:45:07 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q17sm1888383ile.5.2019.10.14.18.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 18:45:06 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Bird <Tim.Bird@sony.com>
Subject: [PATCH] selftests: Fix O= and KBUILD_OUTPUT handling for relative paths
Date:   Mon, 14 Oct 2019 19:45:05 -0600
Message-Id: <20191015014505.14259-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix O= and KBUILD_OUTPUT handling for relative paths.

export KBUILD_OUTPUT=../kselftest_size
make TARGETS=size kselftest-all

or

make O=../kselftest_size TARGETS=size kselftest-all

In both of these cases, targets get built in ../kselftest_size which is
a one level up from the size test directory.

make[1]: Entering directory '/mnt/data/lkml/kselftest_size'
make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
        ARCH=x86 -C ../../.. headers_install
  INSTALL ../kselftest_size/usr/include
gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o ../kselftest_size/size/get_size
/usr/bin/ld: cannot open output file ../kselftest_size/size/get_size: No such file or directory
collect2: error: ld returned 1 exit status
make[3]: *** [../lib.mk:138: ../kselftest_size/size/get_size] Error 1
make[2]: *** [Makefile:143: all] Error 2
make[1]: *** [/mnt/data/lkml/linux_5.4/Makefile:1221: kselftest-all] Error 2
make[1]: Leaving directory '/mnt/data/lkml/kselftest_size'
make: *** [Makefile:179: sub-make] Error 2

Use abs_objtree exported by the main Makefile.

Reported-by: Tim Bird <Tim.Bird@sony.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 4cdbae6f4e61..3405aa26a655 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -86,10 +86,10 @@ override LDFLAGS =
 endif
 
 ifneq ($(O),)
-	BUILD := $(O)
+	BUILD := $(abs_objtree)
 else
 	ifneq ($(KBUILD_OUTPUT),)
-		BUILD := $(KBUILD_OUTPUT)/kselftest
+		BUILD := $(abs_objtree)/kselftest
 	else
 		BUILD := $(shell pwd)
 		DEFAULT_INSTALL_HDR_PATH := 1
@@ -102,6 +102,7 @@ include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
+#$(info abd_objtree = $(abs_objtree) BUILD = $(BUILD))
 
 # build and run gpio when output directory is the src dir.
 # gpio has dependency on tools/gpio and builds tools/gpio
-- 
2.20.1

