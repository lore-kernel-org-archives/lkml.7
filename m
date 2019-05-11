Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AE7C04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 02:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE60D217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 02:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557543174;
	bh=L33mQ8/qn8Lm5/kicXxefCGo8rvIjT9mwGwbjSmL9Lw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tOR6gCLYXJ12jSq9m4upvQyzfU8Adv65unBNyL2cHOjZATSKqTJ3+aweGNTC54ST6
	 +Oh4ftKTgQ/gEFTvJG1UMEIWZOiybZPTtdwSZ3YWOmjDeLHcSE3C3+Hx9NYaceoMi6
	 RVshPtQa9NycfZtqe7yXMP43JItkfljxg06G2iLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfEKCwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 22:52:53 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52734 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfEKCwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 22:52:53 -0400
Received: by mail-it1-f195.google.com with SMTP id q65so12426056itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 19:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1fNpqco5qTI/FVw/2N/OV6sdYiNRuMpuFae27tLYD8=;
        b=AsJhlTTxTVsHXRcV+TdHM1dqT6CDreRY5gyOr73MCbYVqnHrm9AQ3YBi3KpSl2YaBY
         AQA/RoOwihRXjLnMWyMT1lTIFCUMtWd/THzwzQ11ODv0V+hImkpFqMzlTyUA5vg4U8Lh
         iC7LdrFa9pBC97kV1H8nDMWfrZxoKKClWlX2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1fNpqco5qTI/FVw/2N/OV6sdYiNRuMpuFae27tLYD8=;
        b=QSYUTGFoTJ9CS/s5sTtBhANFtxDeiqiPKX6YI/d/scePIx0HbiVOh820bxnpm5g2Sk
         Qrl50WJZhx7xJ8vBDjkSVgvLIstFXvsTtsbzNrDm+WnQJprdv6T7Sqov4rJsl5QQaH+1
         iodmrwMWbfUdBg+11vztq8IRtm70Xk5t6g01SQms36jIl9eUmXyS3xG4i8Mh/WrGuyv9
         4VeaCL6mUrL6j07tka7dSgVfqZyvsc/y41CAA8RqmmzW+o4GtOMJ0D2EoyBw+gBI76G7
         COybYvKsZPIMClnH9DYTItURV1jR7JDPvlrSrVJxsd6z8Nj2z9QN7Lv44TrTcr5h40W9
         83Bg==
X-Gm-Message-State: APjAAAVMJHVWCK0qkzNYTYVqwWdoakGiKkhT6m7Z0osmTlBHnm5h0+GQ
        /KazvTB41U1uQGKPLF/CVeOBLg==
X-Google-Smtp-Source: APXvYqyMyX9jt4xcnd1qUvb3Gz1jooVogYkic/p578UGF9RMWCcUnZVoGP84Uj7fcMIrKG/QoqQHKg==
X-Received: by 2002:a24:5258:: with SMTP id d85mr10156123itb.124.1557543172404;
        Fri, 10 May 2019 19:52:52 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm2962460ios.30.2019.05.10.19.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 19:52:51 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, alexei.starovoitov@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, daniel@iogearbox.net,
        davem@davemloft.net, torvalds@linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] selftests: fix bpf build/test workflow regression when KBUILD_OUTPUT is set
Date:   Fri, 10 May 2019 20:52:49 -0600
Message-Id: <20190511025249.32678-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")
broke bpf build/test workflow. When KBUILD_OUTPUT is set, bpf objects end
up in KBUILD_OUTPUT build directory instead of in ../selftests/bpf.

The following bpf workflow breaks when it can't find the test_verifier:

cd tools/testing/selftests/bpf; make; ./test_verifier;

Fix it to set OUTPUT only when it is undefined in lib.mk. It didn't need
to be set in the first place.

Fixes: commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/lib.mk | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 098dd0065fb1..077337195783 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -3,15 +3,9 @@
 CC := $(CROSS_COMPILE)gcc
 
 ifeq (0,$(MAKELEVEL))
-    ifneq ($(O),)
-	OUTPUT := $(O)
-    else
-	ifneq ($(KBUILD_OUTPUT),)
-		OUTPUT := $(KBUILD_OUTPUT)
-	else
-		OUTPUT := $(shell pwd)
-		DEFAULT_INSTALL_HDR_PATH := 1
-	endif
+    ifeq ($(OUTPUT),)
+	OUTPUT := $(shell pwd)
+	DEFAULT_INSTALL_HDR_PATH := 1
     endif
 endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
-- 
2.17.1

