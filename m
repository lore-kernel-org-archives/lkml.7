Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4734C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB120850
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566866233;
	bh=4cCCW5gggmUhljpou2v4hYvgPA9Rk9c60MfxjAGdMY8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wshKsJkVVJgcU/FL9xsxwHruGuutIJBSOEVlrFYhy2XtvErnOyfNENbI8xv5g6qXY
	 oN9y/WvIVEVzNsKDg0Sfsx3WrvbN5QgQvVokWcHgyGUBT4YKcG47CzxKVqUPJ+7OXD
	 piM4rmV+tzWeFbZo7ZAY6nAX87sCoSfMfqh6JQSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfH0AhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:37:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38052 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfH0AhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:37:12 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so42115089iog.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 17:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzeVAWovI9wNatL9dmXA8c77UhbonukUh6rmg5r+32k=;
        b=RFd2pTJzpbhIHF6iGKKLVB6oA47DzUgxrLAPE7IxEi6UB3IZzHyhvbYooAtYVjcJWW
         4DjCKMeysWFIR+5+ixOtvr0LuvkmTvkQfQRH2mCLNjECnJxVKcUAXiVoZ+ZTljt9wt+Q
         sDuBx6JUPqc8uKtyJhA0TdgvqrzmEPubyW8eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BzeVAWovI9wNatL9dmXA8c77UhbonukUh6rmg5r+32k=;
        b=rnNkwbw+PBm7ujTM9y2z6RZOBqJnEiscaTAqCBoMNHVLf2eMo2NTT9y9tIHyQ74VyR
         2tIG69Yf+ZdaHU3XYI2oIVdBrFNZJpmHL6LEfW/ipRUBtuAIr8tyXl9nCN7Are3CWJoo
         YVwELS2ljgqdtn26OspenmPgHNB1NOPseMbM8IQCTg8mhkPJTqiBmpBZtSvgJJxkpbXP
         gSb7HVmUo6Xj1/c919LY/cLISD8BbmG+mqN4+UroR+9iwiDRktESwfulcWhoTXLpeuBE
         v9cMiI+T6omfuE5eNO6wKzlXbrt40jTz+62r/zkAZ17cVk4/J2ZXaM3kOyVe96MY4x4M
         ms8w==
X-Gm-Message-State: APjAAAXUiQr+/JmoLwDAuug8fOh5BIt9M03xUEfn9K4WpoQFXXDakydQ
        yrSqkp7xGnpWA+/patVekFJcDQ==
X-Google-Smtp-Source: APXvYqxc72IrPdBOQjJ7DSRNsqCKEkfC2oIBkrJ4CwrkYFZ/PDg3oRQ89onY+gSPvXLkKnSmphNiWw==
X-Received: by 2002:a5d:9c12:: with SMTP id 18mr6327310ioe.48.1566866231264;
        Mon, 26 Aug 2019 17:37:11 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v23sm9995828ioh.58.2019.08.26.17.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:37:10 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.rue@linaro.org,
        anders.roxell@linaro.org
Subject: [PATCH v2] doc: kselftest: update for clarity on running kselftests in CI rings
Date:   Mon, 26 Aug 2019 18:37:09 -0600
Message-Id: <20190827003709.26950-1-skhan@linuxfoundation.org>
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
Changes since v1: Fixed "WARNING: Title underline too short."

 Documentation/dev-tools/kselftest.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 25604904fa6e..308506c5e8fa 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -12,6 +12,31 @@ write new tests using the framework on Kselftest wiki:
 
 https://kselftest.wiki.kernel.org/
 
+Recommendations on running kselftests in Continuous Integration test rings
+==========================================================================
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

