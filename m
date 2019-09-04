Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA8C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCFF2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRY+hyU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfIDQlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:41:08 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:39741 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfIDQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:41:07 -0400
Received: by mail-yb1-f201.google.com with SMTP id f71so17217805ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R8s/mQuDt3czxphpJ1IOQV2hi08A6wKIrzyNkbM/SsQ=;
        b=sRY+hyU06eTXBM6iBLr3RXE26ciCgVXQhArqt2r3BnX58d/v7yEodvfwqLF194qAaK
         2y2ClIlPS7pC6hOp8/mVfi47uEwEhU8iPF8m0ua076ifWaQ118oKfRMA4bfit5jr/osx
         YYAJnEsCbXgtJkenXRHqHC8lSHZYbKzDaE22/L9ecUW9TfARG6hAugYIwzUwL7B3OXlG
         EmRfQP7qb7YANin7iMgF3pGJx+4odTEWqnfKchn5aEfgFCpZEL0Dui6ZPHzNrx9Kh0D4
         Lwpc47miT41I6kV7KjKvreSPExoSurFp+H6ccaG780izjm5w6gK3srOfrPZZhCLx0Q7n
         cqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R8s/mQuDt3czxphpJ1IOQV2hi08A6wKIrzyNkbM/SsQ=;
        b=rEKGb3D2kN8EXoB/BP83y8Nyi6Lze8wx7cTAGNUtFKfGgF4xTJhCkHMacB8Hu9o4y4
         Gb51Dwc47OCLgbR1AXpHfm0x89dyMUolfhpvazS9jzgMCUtEaJhRbM4CBhynVO6PgxRF
         m7tQjxv1Mhb5I0ESUd8K/CD0lBx5+mgJVb0lPTxBGenxH3U7bDL108tjgODEV9wqQ5BN
         yMGZwJqDG+Dw5cNC6slIwAkNU8kJAyV3LHQekJVZPE7QVuRmXOGPluDCZPb6R/Pg5wFx
         WK1CTGa9dZ9x6c8nubz3LK5Ofi395m1huUcWfb5jGMH3QQ1zf5YXd1WfeHsZ4DMQyIJw
         PAjA==
X-Gm-Message-State: APjAAAXcr7uPiCQfvpWnQpYwgj/esq8jooraiw6qgUsBtQAAXAq2A4Hp
        lbKFqtRTqwcbJAsRaren4YE0QPVpbQae2Ig9
X-Google-Smtp-Source: APXvYqxzNr/i+tgw6CmrAR/6JQkqHrAV0NHOGj24YLgU72jAjdnlgCUSFpi5cASY7Xpkf2HXokV3Z2/BO781tEdZ
X-Received: by 2002:a81:1090:: with SMTP id 138mr30179873ywq.179.1567615266845;
 Wed, 04 Sep 2019 09:41:06 -0700 (PDT)
Date:   Wed,  4 Sep 2019 18:41:00 +0200
Message-Id: <c28135c82eaf6d6e2c7e02c1ebc2b99a607d8116.1567615235.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH ARM64] selftests, arm64: add kernel headers path for tags_test
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tags_test.c relies on PR_SET_TAGGED_ADDR_CTRL/PR_TAGGED_ADDR_ENABLE being
present in system headers. When this is not the case the build of this
test fails with undeclared identifier errors.

Fix by providing the path to the KSFT installed kernel headers in CFLAGS.

Reported-by: Cristian Marussi <cristian.marussi@arm.com>
Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index a61b2e743e99..f9f79fb272f0 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,6 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
+CFLAGS += -I../../../../usr/include/
 TEST_GEN_PROGS := tags_test
 TEST_PROGS := run_tags_test.sh
 endif
-- 
2.23.0.187.g17f5b7556c-goog

