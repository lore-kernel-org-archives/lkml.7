Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9B7206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wT/BEegA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUXvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:51:43 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43930 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:51:42 -0500
Received: by mail-pg1-f201.google.com with SMTP id k7so2850636pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 15:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1T1UpCeydKo8c69iE696L0TyG6TBO0S0rujCmrpRiXc=;
        b=wT/BEegA59gkz+IDqsv8EwP2H4rvwnrvlBG8zAXZ25M2YldyjfigLKYpyqHpT379WL
         Lopo5fVUW4NUMEEZrrIc4kJeyzURU5YrHZm4wHyOV7h8d44mADXqmM9htGMNvN1JZq7B
         I5PejRWhV4WPrJ+0sw979iln17jtBT/UcYKtU/Fl4JAM0jx9rOsvwYJ5jzVdPtsKLyB4
         EjtaMD2RQBx7xP5P9W3o9M0dZ/r+dy06zNVYGLiRw1EUrBx6q/NSvJgIdQYjWlPXmLYi
         s3LJHQrg3JQzvedPtiLScLol2lPo09BNNGKBxLy6+zAlEKyEaPD4NFgrHRdo24Lt3jni
         ezJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1T1UpCeydKo8c69iE696L0TyG6TBO0S0rujCmrpRiXc=;
        b=ftRZGAJqkxEtloYYdvQyPKj9xP0Mc9RIsTlrHwkoVx0Nv0h1De93jGVUJuAfBSoE/t
         4ClXwiLSVgv4d7AWpFcHHiIoBATR1zOvMgQZtiiIwaVtXV4apSaQoKmaqrY26ls5AH0p
         NUzn5CcDnGFSIBqezxFg0pekKiUUqUvIarOl2OA9Gara1mta1d2RjTRxd1pE4r3SacyL
         Cj7wcYVPzZTTrKiRaaRTJClwKdZcw4peo7K3Df1RdwApC9iVM6Kg9HBw9J0rWoFRLAgl
         EOiw80R4YSsRZTKzdkSymACr9IlSxkMqJ7/GwepIgGFTEtGiCAnS9q0U0sBVqd0Ep8XH
         gx7w==
X-Gm-Message-State: APjAAAUUUnFWSn2P/gY4S3US4swazqPy4cHYaTq+Lw8pa8SiAhEPXJ0i
        BrQ1IK6/7vv2ZGoCh4CpneQx9a8ojOV5Zg==
X-Google-Smtp-Source: APXvYqxqDObiKuAtQd6VNMB5jJg4dvQfChOpJvo0SZqGPpVKts3oLqyq/Kj/rY6/KKnc3g5dRMYeF9eD/qV48Q==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr12813226pgc.345.1574380301840;
 Thu, 21 Nov 2019 15:51:41 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:50:58 -0800
Message-Id: <20191121235058.21653-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH kselftest/test] kunit: Always print actual pointer values in asserts
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit assertions and expectations will print the values being tested. If
these are pointers (e.g., KUNIT_EXPECT_PTR_EQ(test, a, b)), these
pointers are currently printed with the %pK format specifier, which -- to
prevent information leaks which may compromise, e.g., ASLR -- are often
either hashed or replaced with ____ptrval____ or similar, making debugging
tests difficult.

By replacing %pK with %px as Documentation/core-api/printk-formats.rst
suggests, we disable this security feature for KUnit assertions and
expectations, allowing the actual pointer values to be printed. Given
that KUnit is not intended for use in production kernels, and the
pointers are only printed on failing tests, this seems like a worthwhile
tradeoff.

Signed-off-by: David Gow <davidgow@google.com>
---
This seems like the best way of solving this problem to me, but if
anyone has a better solution I'd love to hear it.

Note also that this does trigger two checkpatch.pl warnings, which warn
that the change will potentially cause the kernel memory layout to be
exposed. Since that's the whole point of the change, they probably
sohuld stay there.

 lib/kunit/assert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 86013d4cf891..a87960409bd4 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -110,10 +110,10 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 			 binary_assert->left_text,
 			 binary_assert->operation,
 			 binary_assert->right_text);
-	string_stream_add(stream, "\t\t%s == %pK\n",
+	string_stream_add(stream, "\t\t%s == %px\n",
 			 binary_assert->left_text,
 			 binary_assert->left_value);
-	string_stream_add(stream, "\t\t%s == %pK",
+	string_stream_add(stream, "\t\t%s == %px",
 			 binary_assert->right_text,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
-- 
2.24.0.432.g9d3f5f5b63-goog

