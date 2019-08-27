Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFBFC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7142053B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566864478;
	bh=NE1G0Bx9TJw9inCyxktGf5l0UYlWsl/XTdOOCNn0F+k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KYfn9OjCQAe9qJjQPSwdWA7kcauoQifADQ1Z5GHDh+1f3fuHA5/PqJXoWNCOqGzFx
	 z2mDlIrRqnkUNgCXtaeAyJ3izGzTvQbPEPr5AJER2xuAgDCF2euvBHMN758SBiY1Df
	 M08oKuHng21RFmC3l4vLm4xlukemIchmxsLaQyPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfH0AH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:07:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38156 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfH0AH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:07:56 -0400
Received: by mail-io1-f66.google.com with SMTP id p12so41979492iog.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5z2pwdyiPujj+zyGVyLnpKnSEToBkmyR8roMplmnXw=;
        b=F7BmUN+QmTsdUsQeCw8YeegWM0cNlrWFyAIOl5L9NAle+JqTUOdkwRelba5mvU1WTJ
         nlHOEuEZQQQ3GNuW4Ig+plu6no6vRqFHLyN4NyYdqmT9nAY9yreQXj2f1JmdsxgvQoyI
         6pUYSXPdJZ99uKo0LKgiHVktu3trX2JhLmZak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5z2pwdyiPujj+zyGVyLnpKnSEToBkmyR8roMplmnXw=;
        b=Oc2flIzuBqzZO8JbqzRSj5sm12AKCTtdF9hkOza7shnytOPMhklf3YmLRKjXbfVwpb
         6NR/deFVRZ1cvgx5f1goxsn8Xs5nVVAAtAxEOnK7mgjtixAfRcTsz0Ry8EhrJyXHiJ51
         kLb4xVZb7dXcLatNBoWvdnFzmapsbzNSOo480GL9G7BtSyzPrxP8gS4oDqN9G9xlUWq5
         7VXWbY7ngoNr7dVcq3xO9rw33/snQDvzLLWFBrAYFIt6Sk8yDOHoUqRNrtJMmMKVeqiC
         SPNPCwbja3M4y7MMiBvQO9TD9j/3ckBz06doxDCjUFtwDT98UnGHnURvxnfEsnQ99g7l
         AcNg==
X-Gm-Message-State: APjAAAUsN8WEPtVhp3xi+2T0SfcQXODydARJQ3xEQgb9czX4I79PNsNT
        lNPUW4gP5+XjaY5uslDewwAwdw==
X-Google-Smtp-Source: APXvYqwZXQTYcLqLmGjeo3QU1lIjgbyL1qWx8uhRds422nNNmVUSG9ZPkZS7URWw5OLsPs8YCbVZpQ==
X-Received: by 2002:a6b:5d0d:: with SMTP id r13mr825424iob.89.1566864476030;
        Mon, 26 Aug 2019 17:07:56 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k9sm12164773ioa.10.2019.08.26.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:07:55 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.rue@linaro.org,
        anders.roxell@linaro.org
Subject: [PATCH] doc: kselftest: update for clarity on running kselftests in CI rings
Date:   Mon, 26 Aug 2019 18:07:53 -0600
Message-Id: <20190827000753.25081-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to add clarity and recommendations on running newer kselftests
on older kernels vs. matching the kernel and kselftest revisions.

The recommendation is "Match kernel revision and kselftest."

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/dev-tools/kselftest.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 25604904fa6e..e55d9229fa8c 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -12,6 +12,31 @@ write new tests using the framework on Kselftest wiki:
 
 https://kselftest.wiki.kernel.org/
 
+Recommendations on running kselftests in Continuous Integration test rings
+=========================================================================
+
+It is recommended that users run Kselftest from the same release. Running
+newer Kselftest on older kernels isn't recommended for the following
+reasons:
+
+- Kselftest from mainline and linux-next might not be stable enough to run
+  on stable kernels.
+- Kselftests detect feature dependencies at run-time and skip tests if a
+  feature and/or configuration they test aren't enabled. Running newer
+  tests on older kernels could result in a few too many skipped/failed
+  conditions. It becomes difficult to evaluate the results.
+- Newer tests provide better coverage. However, users should make a judgement
+  call on coverage vs. run to run consistency and being able to compare
+  run to run results on older kernels.
+
+Recommendations:
+
+Match kernel revision and kselftest. Especially important for LTS and
+Stable kernel Continuous Integration test rings.
+
+Hot-plug tests
+==============
+
 On some systems, hot-plug tests could hang forever waiting for cpu and
 memory to be ready to be offlined. A special hot-plug target is created
 to run the full range of hot-plug tests. In default mode, hot-plug tests run
-- 
2.20.1

