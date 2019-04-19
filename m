Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A38C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCF62171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555716195;
	bh=fFfB7Ozhg/nPpRe5DJTGbObtG38I2bcNcTLujyMefsc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PFsJDpXByt1YmV/F9kcGqM5Bx5IU/o0m8goC9DVRxpUqHWQogos2YuB9yuiNrGoII
	 gVNNS3BHs3qlQOVQYvxVvU6QSlT+bbmlAJkodqQpOoozRMkqzi1UhRt7bsXvgbwE1Z
	 7fydkoMa+m7vIpDIHgzdqRTWwiWWFPAo3/9NROhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfDSXXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:23:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53332 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDSXXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:23:13 -0400
Received: by mail-it1-f193.google.com with SMTP id y204so10466370itf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=atDLwfDA7rORBqIZfz3seZ7IuymQDCP5i79eWQ4zDT4=;
        b=Ighg3CZPP+6vgzIT3bMIXesO9zQBozDpimUhknWGsi0JEbwpnx2IaiyCI2K74j6qUz
         xZvSiF52VBmhcPFZX8a9O12h2XyDDOPJ4zV3Oorf7eetH+3Kk1I3CrGlnpw9ILNDJiSJ
         6CGwzDS59y/f0kOIPXDvGzMT4YM2rMpsD7k3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=atDLwfDA7rORBqIZfz3seZ7IuymQDCP5i79eWQ4zDT4=;
        b=RFDrn7xPQSvLCq8BY0aw90MgNOZbXePoevJGGtr9H4tbdmfUCFiliCd15u10xUz4kg
         N7jupQ43IQr0aNRTJEKDhxJzyF84XAHCCukCMqgxUirJ8NnUXWY4xUSENQNmDjo8Df7I
         IIpV0WKlDcI5LVsEQX18/rWBxZUwmV3usB3k9ifzqdTLwFObnGLENlNzn9mlygemO709
         cQNRHMto0vCRyA+lJKX9MMUQNpB+Lq9bkvb6E2+QFWh2HWBl5GYUgfESAeDwSHvkA0AI
         SzkjXsG7z24V6dkYe9pbizB25SABgP96JrnE90hD1J6JiB1tTm8T4trFadsJv8TTKhrN
         JQEA==
X-Gm-Message-State: APjAAAXpifmdsUpSViuYWi9fJLFo/zwvyF0JHM0Wq/YAd9gysn9m+che
        uVZUzacS2I8wOCJXLDsvBVI87A==
X-Google-Smtp-Source: APXvYqwni5eAyDRmxZmesoEfO555+37agRpyLsf83X/89yW+65bYnGITpCpbJAlxikHedtZnFogshw==
X-Received: by 2002:a24:454e:: with SMTP id y75mr5358364ita.5.1555716192955;
        Fri, 19 Apr 2019 16:23:12 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y17sm4672375ita.2.2019.04.19.16.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 16:23:11 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: build and run gpio when output directory is the src dir
Date:   Fri, 19 Apr 2019 17:23:09 -0600
Message-Id: <20190419232309.9664-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build and run gpio when output directory is the src dir.  gpio has
dependency on tools/gpio and builds tools/gpio objects in the src
directory in all cases making the src repo dirty even when object
relocation is specified.

This fixes the following commands from generating gpio objects in
the source repository:

make O=dir kselftest
export KBUILD_OUTPUT=dir; make kselftest
make O=dir -C tools/testing/selftests
expoert KBUILD_OUTPUT=dir; make -C tools/testing/selftests

The following still don't work (need fixing in gpio Makefile):
make O=dir kselftest TARGETS="gpio"
export KBUILD_OUTPUT=dir; make kselftest TARGETS="gpio"
make O=dir -C tools/testing/selftests TARGETS="gpio"
expoert KBUILD_OUTPUT=dir; make -C tools/testing/selftests TARGETS="gpio"

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b43c5f41fb3e..f2ebf8cf4686 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -99,6 +99,15 @@ ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
 
+# build and run gpio when output directory is the src dir.
+# gpio has dependency on tools/gpio and builds tools/gpio
+# objects in the src directory in all cases making the src
+# repo dirty even when objects are relocated.
+ifneq (1,$(DEFAULT_INSTALL_HDR_PATH))
+	TMP := $(filter-out gpio, $(TARGETS))
+	TARGETS := $(TMP)
+endif
+
 # set default goal to all, so make without a target runs all, even when
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
-- 
2.17.1

