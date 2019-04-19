Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE233C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835032171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555716253;
	bh=ydnyKJZweRMYKL1eazmcP0gqMcsmNiqSZFZ6jEfK5V4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SIwpPY6FzG4cuEmAtwO65wsqFr/VYDghrR58kb0eV8X2zlddfPr6rtvWM8ELlhxNX
	 19pF78nLEggnNoX3/I85CNo8xACQkzkMUkXDXoHmBPU3o4bFmDvfJYcgWm2spBs028
	 T0ZfSnIC1srvUd6LeDONIL12UzKqbabxdJL48yKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfDSXYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:24:12 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53436 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDSXYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:24:12 -0400
Received: by mail-it1-f196.google.com with SMTP id y204so10468560itf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4DS1avFnyiFdbdES9jLYf8qPJs2YzliRnZrOZCnaiE=;
        b=bv9PZPjz4UM3jJ1eA22hJuuUCMIB4jApD+F1S6Du7axvH2paeH8uQafo2y4uPTjWY4
         qZZ8Q24N0/COCI/xyWmYT7BdiVxDoFdRDmGzt6Obv/aZUsW971bQNenCaJ8TjloBZKst
         fmk/gDNIIZR58r6YruZdBzmFL3sPMLpNacHmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4DS1avFnyiFdbdES9jLYf8qPJs2YzliRnZrOZCnaiE=;
        b=qTjKVScR19C/bxFmMpv8gLHcAKxdpbXKeQaLL0wQq6RZ1LwtlB1Am76AVdmPvy6gkO
         za2hVqIlDfCo3hUV1g6A6UBXW85fQwrFd5kZGwhzOWgVzWw0NSNXCL8rNnOqxdUDVTpP
         v88TY8nhmqY1lmZq94rnZZh3G5kGQrAgsaZv86r9PHHy+z7D7v9xwjLV1ZegCv+Xoq4G
         ATwUaR6euapzsOo7D0M3E7RZpvZeOkbwvU9qICJNAqr2CEb/a95IhQw0FedKJRls+M2s
         LNL6Egig98vBtOOfRU/ddjXH8vt6aUkbuTGxsMVonnvltn/y2iBJ3+ZU1xOKAPoE1t3+
         2ExA==
X-Gm-Message-State: APjAAAUL79v1BvFa7EuUJfX3wJDjTQiYPPy5LU5jCxfdCY7B0R4s5SsG
        2q065z9MWvGO0XHQJrHvL3QJZ3CANFxchw==
X-Google-Smtp-Source: APXvYqzdb+VtILtrZX1epLwLh4qM/D82AVtK8J3TKNxGh2nkBweMBbH9P1IKI/mHPeXUSdX1SCzgtA==
X-Received: by 2002:a24:953:: with SMTP id 80mr5188678itm.139.1555716251433;
        Fri, 19 Apr 2019 16:24:11 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f17sm2727001itb.13.2019.04.19.16.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 16:24:10 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Makefile: add kselftest-build target
Date:   Fri, 19 Apr 2019 17:24:04 -0600
Message-Id: <20190419232404.9746-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the use-cases is building kselftest and then installing.
Adding a target to just build the tests from the main Makefile
will help users and makes it easier.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 15c8251d4d5e..38a2ce3c343f 100644
--- a/Makefile
+++ b/Makefile
@@ -1195,6 +1195,9 @@ endif
 # ---------------------------------------------------------------------------
 # Kernel selftest
 
+PHONY += kselftest-build
+kselftest-build:
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests all
 PHONY += kselftest
 kselftest:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
-- 
2.17.1

