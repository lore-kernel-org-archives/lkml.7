Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD4C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857FE20874
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559770630;
	bh=hRjVy/CO7YM1z5cKzh8kkJkVNQFxbWcdSFFGP8DWFqg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kikBN6ieZFyRPkBhKvK6OvJr+0hO3yNbokZki/JSdfezQp1bku6MWCKPhhko8B7+s
	 2Vg/yk9B9W0WKBDlt7676uyL5m61mX5OTsKik2fHn+NkwjKoZqYi93ozq7QlLNuvps
	 Lzd+THur0pXnSg0/77ZLjWwYhgGFwORuTHBs8gWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFEVhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:37:09 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35707 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEVhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:37:09 -0400
Received: by mail-it1-f194.google.com with SMTP id n189so5961339itd.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RddNyObAm0IDCsAeqeXV9IFkPclFRQuRiqHF+RZKGFg=;
        b=gU2c5w+dA8zAHUeXRZUJDm6mK83x2bcDiByc1SmfMfobUK8jfgOQgbFrERUtJ60LSb
         XFgrooOkCPIOYWl45gFK1RBnBmnziFRo6YZ3zmVo6EmDJbmz2oACKi9x/hH8iKGSV5Ki
         WZqVV/6A5zMARtc6KeQCp23iZl9C4dQnUVJQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RddNyObAm0IDCsAeqeXV9IFkPclFRQuRiqHF+RZKGFg=;
        b=Rldhcyl41hKvetaVNDH4MM5CSu81g1kgH1PJlqk9Ca4lioxmBJJpWVHaA0pQyEnno5
         KigG1SdQPpuuG9MmjRSd7PpbFOXtRG3KWsMC1aCFMsNYupP3gfi4fCsXzf1qsy4zJ2Ly
         S7G+PhuxYxna9Elrbuj/320OOcm9J+rtERGZLRWrusQjqsjmzZenUc7RLiSgLUfakgNy
         xGNB9XxgVC0siMQviYY888h1aLHWEI4aIy3HkcHctlB+Sa60rteJS03ZHoApt9XKI4GR
         odtU5NlfJGLCD28BgD/LslP1P4UjMbc9u+EClADD8LAMUXmHf6qFgNANylVY5XR+DUuK
         ja9Q==
X-Gm-Message-State: APjAAAWI3wCnmjreGps+gZX6uHThmPKbs89WVlZ4FKjAEg0jr3NJibpH
        s+j47cBmn9lH7peU3v0URZ5y28cpVAE=
X-Google-Smtp-Source: APXvYqxShW/LVwJ43kgJhL1H+U4Cw5dPlZFogSQVfZKY2qC/2YAbcXab5oWgSqEOiLg4I3ZHuVy9SQ==
X-Received: by 2002:a02:878a:: with SMTP id t10mr27772528jai.112.1559770628440;
        Wed, 05 Jun 2019 14:37:08 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z71sm29753itc.6.2019.06.05.14.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:37:07 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: vm: Fix test build failure when built by itself
Date:   Wed,  5 Jun 2019 15:37:04 -0600
Message-Id: <20190605213704.22902-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vm test build fails when test is built by itself using

make -C tools/testing/selftests/vm
or
cd tools/testing/selftests/vm; make

When the test is built invoking its Makefile directly, it defines
OUTPUT which conflicts with lib.mk's logic to install headers.

make --no-builtin-rules INSTALL_HDR_PATH=$OUTPUT/usr \
        ARCH=x86 -C ../../../.. headers_install
make[1]: Entering directory '/mnt/data/lkml/linux_5.2'
  REMOVE  shmparam.h
rm: cannot remove '/usr/include/asm-generic/shmparam.h': Permission denied
scripts/Makefile.headersinst:96: recipe for target '/usr/include/asm-generic/.install' failed
make[3]: *** [/usr/include/asm-generic/.install] Error 1
scripts/Makefile.headersinst:32: recipe for target 'asm-generic' failed
make[2]: *** [asm-generic] Error 2
Makefile:1199: recipe for target 'headers_install' failed
make[1]: *** [headers_install] Error 2
make[1]: Leaving directory '/mnt/data/lkml/linux_5.2'
../lib.mk:52: recipe for target 'khdr' failed
make: *** [khdr] Error 2

Fixes: 8ce72dc32578 ("selftests: fix headers_install circular dependency")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/vm/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 05306c58ff9f..9534dc2bc929 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
 
-ifndef OUTPUT
-  OUTPUT := $(shell pwd)
-endif
-
 CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS = -lrt
 TEST_GEN_FILES = compaction_test
-- 
2.17.1

