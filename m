Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39632CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B99320684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z67VptU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfJUKLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:11:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33119 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:11:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so1001672wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ejY+9Vm9aWJOs97zrA807+W9n/23O9nYbfu1WQqsyN4=;
        b=Z67VptU0dpTYTmG3ohv8pDSd0+CsFi7qspyxYHYbGvD4wdiRDK3vqJVHPZPaqGXGOm
         uiLYWy/FZwE/YhpSsGe+Sl426PcGkC6fMRTzwDAHXswSlrMcjOkTambq8295/tCALvGN
         rKKL5+SWYo8AmXf6bCtgIPSZ2htVNwBaq/RYG1N2EpqnkLXR1qUvuOSfxPAs8j7Wf7kD
         3ll16iGmFYL4xgfA8RE0S8f7n+faLm8GMFfaXf3OxL6zXNAX5JcGExaSdX2c1FHiTUTH
         qMKjwTektqUZvXtXiNWR0tqZbofdwnfpfpP7aVIwRxsGnEe4DScDdboA2uBjKM8tZt8Q
         6KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ejY+9Vm9aWJOs97zrA807+W9n/23O9nYbfu1WQqsyN4=;
        b=LVF3ne7Z2uLcjyBJ8EZhConz2C0XeeAC2FNFF5ewGLoT9ZTygyZ7Vnzmi9XXrTpRx/
         Xq7u9/31Qp+lR0j3FLWCge0OVqqGJWJ5Gk4vEHGzKXm4qSDOh02af9grn5Ef2b1uXqNY
         i5w0z3AYXhFTfDqL++8tPTHujX5c7ySALi8SA4yBCYdUvU3ctMADIqZ7Bt+du6f4j/cP
         Ytvrh4vqwME8w8kEH/db5tbG6zT9O6Uv+zBn9VtS0hpBqRoLl3d5WsMNHSWqs4EI92E7
         UbK7FwWlhtmniOF3BvdPcXsPSJ1SMw7E5u/yTZnQJjvggTpWEdoCH/do+p6kTX01+y6G
         4oTw==
X-Gm-Message-State: APjAAAVuatymDRTq897GwNUtR5bImt2Ed9ph+t0rVTqRNwHDeNWmfq3U
        uBQCCZJFr8m6DokIc+itcXjPEQ==
X-Google-Smtp-Source: APXvYqz6f/D7+PFLZCxKK/K5eWFiAXnAStPWGTZJu/8oCjOA5TUh20GOlE1d4q4CuQdJrKGrqV6Xcg==
X-Received: by 2002:a1c:2884:: with SMTP id o126mr20068584wmo.153.1571652667359;
        Mon, 21 Oct 2019 03:11:07 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j63sm15978535wmj.46.2019.10.21.03.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:11:06 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, kbuild test robot <lkp@intel.com>
Subject: [PATCH v2] kdb: Avoid array subscript warnings on non-SMP builds
Date:   Mon, 21 Oct 2019 11:10:56 +0100
Message-Id: <20191021101057.23861-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent versions of gcc (reported on gcc-7.4) issue array subscript
warnings for builds where SMP is not enabled.

kernel/debug/debug_core.c: In function 'kdb_dump_stack_on_cpu':
kernel/debug/debug_core.c:452:17: warning: array subscript is outside array
+bounds [-Warray-bounds]
     if (!(kgdb_info[cpu].exception_state & DCPU_IS_SLAVE)) {
           ~~~~~~~~~^~~~~
   kernel/debug/debug_core.c:469:33: warning: array subscript is outside array
+bounds [-Warray-bounds]
     kgdb_info[cpu].exception_state |= DCPU_WANT_BT;
   kernel/debug/debug_core.c:470:18: warning: array subscript is outside array
+bounds [-Warray-bounds]
     while (kgdb_info[cpu].exception_state & DCPU_WANT_BT)

There is no bug here but there is scope to improve the code
generation for non-SMP systems (whilst also silencing the warning).

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 2277b492582d ("kdb: Fix stack crawling on 'running' CPUs that aren't the master")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Changes in v2:
    
     - Moved the IS_ENABLED(CONFIG_SMP) test to the first (slightly easier
       to read the code, improves code generation a little)
     - Sent out as a proper patch e-mail ;-)

 kernel/debug/debug_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 70e86b4b4932..2b7c9b67931d 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -444,7 +444,7 @@ int dbg_remove_all_break(void)
 #ifdef CONFIG_KGDB_KDB
 void kdb_dump_stack_on_cpu(int cpu)
 {
-	if (cpu == raw_smp_processor_id()) {
+	if (cpu == raw_smp_processor_id() || !IS_ENABLED(CONFIG_SMP)) {
 		dump_stack();
 		return;
 	}
--
2.21.0

