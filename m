Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184FFC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB622184B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WPRcOlBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDLALL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:11:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47076 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDLALL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:11:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so4196742pfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6OeTWA9VQSd3NbwEDeXQUKakof8cdRIwi/Z/BNNmjCA=;
        b=WPRcOlBvuy0aTnPUV4isEKo9st3ofkrxAsF+2Vgnj3mvemy/IuWuSzSkeYceYQyOY4
         NeSOlVC/wcHIPISuL8R0VaVlK825KEMTFqUYhr0JQnAR8qBXOtN3fxfZHbx0kgpA8CZD
         6P2z3VSg+Pqd6vViuxkzdBephpHeiQue4j4Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6OeTWA9VQSd3NbwEDeXQUKakof8cdRIwi/Z/BNNmjCA=;
        b=ukRuOXdO0uSDkS2D98ToirCB98pb+bDlvcZ576k/ctJkrwx3GOp20QLy5+GSnZXnWA
         iInHGqOm3ymY4OEcuExC9dmp4DKxoldTvZAsb3pNqejLcJMMt7jEEvr4OJB0dLgd1UZy
         H2KIMSdr2wt0w7zKLvp6rxr/lx0239c0OpupfuEuZjE1R8dlx/2kZ1BdVqryNgKgiwdx
         LYKhhCQJg2QtG5jkqRcJzGYeK4XkwuV3LEJGxzDAGjexVlCpv9IyLUpLDI+fMIsASSVX
         PPjCW+GQRYD5rp3oaO0lDmb2an1+ZWOblrDpVLss7v9pnWvry2Ct1ENOOQYnI4LMtu5R
         aFQA==
X-Gm-Message-State: APjAAAVUjusBTb0oe7l35HEvVrbv04ED8n0vtm1L1JR9gIB83x9dCQSt
        LDEq5LXvOPpO/WMWv8OAzar81w==
X-Google-Smtp-Source: APXvYqxHAXMuO4byLy8md2p5UxIGKasqS+wXkSMF+NQkLI/oGPfi3IhhJGYZ83VhqcFtDQWoe74fVg==
X-Received: by 2002:a63:720c:: with SMTP id n12mr50217088pgc.348.1555027870565;
        Thu, 11 Apr 2019 17:11:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g67sm61418544pfg.94.2019.04.11.17.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 17:11:09 -0700 (PDT)
Date:   Thu, 11 Apr 2019 17:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/harness: Add 30 second timeout per test
Message-ID: <20190412001108.GA3576@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep tests from hanging forever, this adds an alarm signal
to each test run. This assumes an individual test doesn't take longer
than 30 seconds.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2d90c98eeb67..941d9391377f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -696,6 +696,7 @@ void __run_test(struct __test_metadata *t)
 	t->passed = 1;
 	t->trigger = 0;
 	printf("[ RUN      ] %s\n", t->name);
+	alarm(30);
 	child_pid = fork();
 	if (child_pid < 0) {
 		printf("ERROR SPAWNING TEST CHILD\n");
@@ -744,6 +745,7 @@ void __run_test(struct __test_metadata *t)
 		}
 	}
 	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
+	alarm(0);
 }
 
 static int test_harness_run(int __attribute__((unused)) argc,
-- 
2.17.1


-- 
Kees Cook
