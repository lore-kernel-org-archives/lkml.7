Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0DAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584162175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LrjzKFxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfDXXMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:12:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37016 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfDXXMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:12:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so10157568pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=USyjebKhKCZCLrhUyqlX69vkoqbsFxWhHCmLAtiPTjk=;
        b=LrjzKFxVODV8Pr1dnRea7pyPGeBJmS9eBnfVmJ67fomco/hgGamwbbGddXrpUQ5OQ1
         cdhpoLVzPGviAFCFtMaF3mNFXVCW5MWqQCcNTRs9OtEyYC710xTyziMDzWkwNiE6mZol
         KhVfqc9y7DRORxOLfn28xAAdbUTtcUbEkoax0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=USyjebKhKCZCLrhUyqlX69vkoqbsFxWhHCmLAtiPTjk=;
        b=mgLm9vNxhh24BwdcKkUFo3/j1NEVSyzXgXLuq8IeET7+GpOl4vjpYiotRWLvdsmlTG
         hXRmWPrDF1kmPk6m/u65G4dlbJcvxvzmM2YTS/YJ2yRotMGOVfDAlEZiJrNtEp/IBoa/
         SOEIVm+iLUB9a+k/E0gxaJUohrsy2qih4XvkyA/qLzby5955KtCe2oUlT+qQf7TCF9+F
         aL5bU3x25/22OdPDypHAdTJKWrbicFuNkkodAD6XuVdTEhhhOq45fA+4lNlmi133byuR
         rw8mYB5WbUYQmd9ujXegvIvTxCSr6Q4DYUUguqQizvIHug1R8JIFlGSeAKY6b6WCjixi
         gdqg==
X-Gm-Message-State: APjAAAXCLVEphHD2saEk1B+9q1QyFwq5Ax/vfbm1xWe/ZdtM2wAH8/zY
        sel7R8g5wFDTg7ASwuBHngKMgw==
X-Google-Smtp-Source: APXvYqycbCdQbeLJP1q3+Fn6T26GnvkkzbCWr10Sjc48ytdPZn5nYqG/blhh4GIlO94nIyHI3nBTEw==
X-Received: by 2002:a62:474a:: with SMTP id u71mr35333692pfa.87.1556147565647;
        Wed, 24 Apr 2019 16:12:45 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a6sm39947726pgd.67.2019.04.24.16.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:12:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] selftests: Remove KSFT_TAP_LEVEL
Date:   Wed, 24 Apr 2019 16:12:36 -0700
Message-Id: <20190424231237.14776-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424231237.14776-1-keescook@chromium.org>
References: <20190424231237.14776-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since sub-testing can now be detected by indentation level, this removes
KSFT_TAP_LEVEL so that subtests report their TAP header for later parsing.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/Makefile            | 6 ------
 tools/testing/selftests/kselftest/runner.sh | 1 -
 2 files changed, 7 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 64699f59b95f..9f05448e5e4b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -86,12 +86,6 @@ else
 	endif
 endif
 
-# KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
-# printing from tests. Applicable to run_tests case where run_tests adds
-# TAP header prior running tests and when a test program invokes another
-# with system() call. Export it here to cover override RUN_TESTS defines.
-export KSFT_TAP_LEVEL=`echo 1`
-
 # Prepare for headers install
 top_srcdir ?= ../../..
 include $(top_srcdir)/scripts/subarch.include
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index b9f74e5a2ee5..eff3ee303d0d 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Runs a set of tests in a given subdirectory.
-export KSFT_TAP_LEVEL=1
 export skip_rc=4
 export logfile=/dev/stdout
 export per_test_logging=
-- 
2.17.1

