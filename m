Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A3BC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC1720B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="Eho+brQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfHEGWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:22:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40224 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfHEGWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:22:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so39159044pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 23:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwFeAlQ6IuYgXIVYtx8CQnkRCdX32iDrGGlWM20HRkk=;
        b=Eho+brQhzJydpVnUPuw9YbBLL4VaxwgoHLETt98sxch+Lo919BKFoGXOfsq8ftacph
         m4HcYoA5BQSimaMSd4rHOIIzt/ezpm/gpX0EAuy065a445CUrmQRXkRCw7AzTNpFymvX
         UfMlO5B7riL8iZYXfvoFAIEhkLmvqkPM3Uybsib5fyUqfd0shKRvhUnABa2eFP44dKzh
         6PdWuYXvzdk1P1vMY51blSUCw8TA4H42xCg9ws9uSMg7FhHjUQ3L5ywLHCWvv4gwG2To
         giDz7Lw8OUQhx1BMQ5E7wU4/UvUv2MuFfSArRKiU+vKgeAq8xYRpoIqPJ2xuNC9x340G
         09Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwFeAlQ6IuYgXIVYtx8CQnkRCdX32iDrGGlWM20HRkk=;
        b=LHN6hn+GWyWFadSz1G0f3y8dmPOUvROZGJvB8+fBTw1MW7ca4Ve6mSAIQkm1QnAu17
         kdyQ0snbo0ki8zELVo6bZdkk5NdOCufswAJqpJd8c3UebFtSLMK/NOtQDezK9HTHSBfl
         hcbF5lxsC2kiAKS4xHxkMOo0L/ypzTlEyl0ceecAJZgfbzDQ4NY85WrTf/ACxHSn4uDF
         6qAzC0yiTdNez8Q6df2rW3bEhjMUXscgIMy5DJIVtlqiW8nIcEa09dggoZlray+fdNkG
         OfolSTedx6QCI1B7SgZlBCIjIoBDGoyKId1hgsaFYxBA3wywX6LrNeLzEkyiK69f2bAW
         +B5A==
X-Gm-Message-State: APjAAAUFyEqtIYxagPWkMHVRxbaaii4e3cnIpVUXKME1Otof16z3rhJH
        S2ai9TyiIiwl8WxePqCwMA0=
X-Google-Smtp-Source: APXvYqx7K+ONyEzdf0Lqszdy5CwUdI5/P0s0j8L1dhasXmKvbPzGbzeYcM4vVZlMnCnJpuYA3ucrxQ==
X-Received: by 2002:aa7:8102:: with SMTP id b2mr30531102pfi.105.1564986169679;
        Sun, 04 Aug 2019 23:22:49 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.66])
        by smtp.gmail.com with ESMTPSA id i14sm124680082pfk.0.2019.08.04.23.22.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 23:22:49 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v7 4/7] extable: Add function to search only kernel exception table
Date:   Mon,  5 Aug 2019 11:52:22 +0530
Message-Id: <20190805062225.4354-5-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805062225.4354-1-santosh@fossix.org>
References: <20190805062225.4354-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain architecture specific operating modes (e.g., in powerpc machine
check handler that is unable to access vmalloc memory), the
search_exception_tables cannot be called because it also searches the module
exception tables if entry is not found in the kernel exception table.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/extable.h |  2 ++
 kernel/extable.c        | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/extable.h b/include/linux/extable.h
index 41c5b3a25f67..81ecfaa83ad3 100644
--- a/include/linux/extable.h
+++ b/include/linux/extable.h
@@ -19,6 +19,8 @@ void trim_init_extable(struct module *m);
 
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
+const struct exception_table_entry *
+search_kernel_exception_table(unsigned long addr);
 
 #ifdef CONFIG_MODULES
 /* For extable.c to search modules' exception tables. */
diff --git a/kernel/extable.c b/kernel/extable.c
index e23cce6e6092..f6c9406eec7d 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -40,13 +40,20 @@ void __init sort_main_extable(void)
 	}
 }
 
+/* Given an address, look for it in the kernel exception table */
+const
+struct exception_table_entry *search_kernel_exception_table(unsigned long addr)
+{
+	return search_extable(__start___ex_table,
+			      __stop___ex_table - __start___ex_table, addr);
+}
+
 /* Given an address, look for it in the exception tables. */
 const struct exception_table_entry *search_exception_tables(unsigned long addr)
 {
 	const struct exception_table_entry *e;
 
-	e = search_extable(__start___ex_table,
-			   __stop___ex_table - __start___ex_table, addr);
+	e = search_kernel_exception_table(addr);
 	if (!e)
 		e = search_module_extables(addr);
 	return e;
-- 
2.20.1

