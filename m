Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB50C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C3B2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569347237;
	bh=CDsQCCWEvr2A7zyfQUVdBqdmq6QEu6ZAIeMmwjNsvmI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wB+hl6g+942I1RkWMdq1nvZgximxErYIcn0PcPA19N4eiVddJwhIJg9JFfas/MFfC
	 C9alRIyomOYO6y+wYLr9TTN+5GFydd/mqK1tVz+VPW6v+sSmeycTc7+cRz3pvvKJT4
	 lE2yWRAi6X3Qfn9m2/eLU2HQzpZwLOxouJcCWbUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502069AbfIXRrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:47:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38204 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404360AbfIXRrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:47:14 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so6562923iom.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sONLmqddY+Y0W77yDXFSLQK6pHND+fJKUek6mxyHYu8=;
        b=OIblsRJ5uIelXVRQU5YmPxM7aQ3XvPIVU47v7i5VzUuiJWVQc+ZCGV0TCtwsq7vAhi
         7AMeQqeA2gwlL/3weIidhv7ZGQX6/23dFe7T4uMbvpTtf82zBBTn38y8S+Y+5TOs7GX1
         Vg5cAscqbc2YNKmTfs4E5gAGVLi/epm7vwmAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sONLmqddY+Y0W77yDXFSLQK6pHND+fJKUek6mxyHYu8=;
        b=NPucoVH+9BVR/RQUMNy2/ZGuciZXw8LkcaPhvSsuBSDJ4lB67VX2WI3d8ymZBbf6fi
         l+RKXjlVD0yprTuHaC6Rzq09Kw5Nlm6SnbQdgKUZasgc/wx7BXdAh6GJJ7SSbTsxXqtN
         peqXkZhxNj4162RnnPcg5o4IvdMDdhDqUx7pBk2Cd39YqIi7+uH75RPrVNujT2Zwhd1F
         B8dABclZpy+zMjY0wMUzm1Kg/5LgXVpNj1wmcyZrBcVTXcW2MgroU5+FaOJ3hLBReqKb
         D71bnJlaIM5KIdBHJ42DGVc6hP/xpQVjnQnowKY7F1SvyDxaj5m06YySKzrbbAUmSy+z
         SH4Q==
X-Gm-Message-State: APjAAAW8fK0JPoIA7S/uT006XAS8Sq7eNPZvgaiIXvigBwdAHvngQ7g0
        3F6AWb+hVx4WtUSkjGDS35SxOw==
X-Google-Smtp-Source: APXvYqylUpTbfQAiSexVdEmVaZha7iPWjbQujTYTfuWbX1w4iDVVNEBgOFmVwbAIZzylyr4NItVtAw==
X-Received: by 2002:a05:6638:738:: with SMTP id j24mr5280350jad.74.1569347233737;
        Tue, 24 Sep 2019 10:47:13 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l3sm2345828ioj.7.2019.09.24.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 10:47:13 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, adobriyan@gmail.com, akpm@linux-foundation.org,
        sabyasachi.linux@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: execveat: Fix _GNU_SOURCE redefined build warn
Date:   Tue, 24 Sep 2019 11:47:10 -0600
Message-Id: <20190924174711.22068-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following _GNU_SOURCE redefined build warn:

execveat.c:8: warning: "_GNU_SOURCE" redefined

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/exec/execveat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index cbb6efbdb786..045a3794792a 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -5,7 +5,9 @@
  * Selftests for execveat(2).
  */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE  /* to get O_PATH, AT_EMPTY_PATH */
+#endif
 #include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
-- 
2.20.1

