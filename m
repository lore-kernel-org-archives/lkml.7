Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25895C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B3B20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkRW54/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfDLG0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:26:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37850 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfDLG0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:26:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so4691600pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 23:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBdaaEZ8SEIf+g8xkPJBFTwoCV33E4aJwWpajuaP5Ig=;
        b=KkRW54/5z4hDYQ1grT20jtVsDixTIX1CJXUTM9IIpz93Pqos0Zb05d/cqJd1hEk2Tu
         tttf0XUp7aacCwVSyWhv97qMCSDn7v9cFVEXpN1GxjqXwoMA9KyGZcYJdnQwspvFy8tM
         QLGK+ZYPC3Quz5UqVO1bl1B3LjvDq9B33yKV7GXDxWQ9++skShwZIEEM0rfh0I9rwd/g
         oUp0xzISTGL27YmFJc77XS8ufjOVAUuBALF90JCd/cmSJHCtzMAPVDobmx8yUi/A5UIS
         g0l9ZyqAIcJFQ+DJq/MbNCdwowxpcCpW3G0SsYuzE4Uf7NKNDCqHr5kxfM9Kz2FmBQwC
         Oifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBdaaEZ8SEIf+g8xkPJBFTwoCV33E4aJwWpajuaP5Ig=;
        b=MKE80GBLdW3hvqczfkJkQO4cTH6fXpDCVBPOQHJLGgm9WPeDDxb56rkJU8licy8NwQ
         CZXREkRsAKfxgKhJTrGfPx8DhSNmNQhSanEPpQVub063h48tQJah3+xc6bd/di8nrIh2
         pxPlLv8c/sgECS1aTLvjlkFzoTAnaweImXjonmy7TvJTHh0hVjvLyhyVU0+h6e6J6HUI
         C+ZSiFWCTfn7GDsvLoZJQCXEo6SKQYDfknuUa21rqIRAyXZ2lFO68jj8OZ5kC/xZL76M
         RdK8N/29L70c7FSxpmgum//r6kCQXHrgOgormihNtY5fuj1nO82ziUMYWq+3fPdfBxIi
         i5fQ==
X-Gm-Message-State: APjAAAVmBzBApgcf7rv4HxW+vWSEmVKrPcuy8YJBEFxIUxLY2YBYhS66
        +Fcaa0dfma+Tqbj0mFE+DA4=
X-Google-Smtp-Source: APXvYqzfZfQh0ucDN3ETSCMp9RweWBetOcbxq5ntjrnc+jy04qu/DNiRHdHUfrwTFkJsb5ySuCS/vQ==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr50064709pgv.322.1555050365692;
        Thu, 11 Apr 2019 23:26:05 -0700 (PDT)
Received: from localhost.localdomain ([110.70.47.249])
        by smtp.gmail.com with ESMTPSA id u17sm56985242pfn.19.2019.04.11.23.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 23:26:04 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH] watchdog: hard lockup message should end with a newline
Date:   Fri, 12 Apr 2019 15:25:57 +0900
Message-Id: <20190412062557.2700-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate print_modules() and hard lockup error message.

Before the patch:
NMI watchdog: Watchdog detected hard LOCKUP on cpu 1Modules linked in: nls_cp437

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/watchdog_hld.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 71381168dede..247bf0b1582c 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -135,7 +135,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
 		if (__this_cpu_read(hard_watchdog_warn) == true)
 			return;
 
-		pr_emerg("Watchdog detected hard LOCKUP on cpu %d", this_cpu);
+		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
+			 this_cpu);
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
-- 
2.21.0

