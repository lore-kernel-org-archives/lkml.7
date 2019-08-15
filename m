Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F1C32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A23C2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="kx/F92EI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfHOAkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:40:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36421 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfHOAkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:40:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so406438pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NE1NaEdbx0Ad3W/X+QOOKHTKwGbGj5XSKxU/TTh8Rxs=;
        b=kx/F92EIvgVscq26b9mG+oTWkqgH/UgDixb/knVX7AKbZH7UAYjDIAtgmZWN+eEkWC
         QTkpGbyUgPR11u689ZLX0Q1GduPOp13mmdJ/8+yoUETL2QlqysyvxcUH937IqsR8eZTi
         yEKcQ7H7T5fb0YSiRhdxVz3YXtysDzqXQWWje5JWdEQo5XA/RzXmel/vZdHWKeDf9xwy
         es5sisvD5LiTRbegfRlaSRJkq9upAOlAsqQZpkNqBjXWEzbmjOiOE0tuq5B8ot723oO1
         Oq9MkRN3zqftLcjqZYQAxd6H57WVU3RPzdHWgEAMlJ2KScV9HVT2T9XTa/Rwi+ykxz8M
         LZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NE1NaEdbx0Ad3W/X+QOOKHTKwGbGj5XSKxU/TTh8Rxs=;
        b=g6ks9WBfNKSjRb1HAEgk8Jxv5RONSVZFvazFAKrb6EhWzq1gactvdshOzHmlyDzLCU
         terMjJNF+aQJu9OovMSe31eS5Q0HZS3juTeB5EsNIplXeXSla0ntSpuvV3K7cnQQ6AA8
         4kqIg7iS4o+GFNtMuz/Doz8snRdq/+8357cuBVMkhdzHXpsOBTeGe54mtPWH+COOxwTl
         NJiSi623gWQ76YUEVN2UibCAoP9Pl7MWmkBfv6AXTDEUT2Gg3Dn6MoiS4BektsTdztW3
         y0EaL+NQRtTQrS/ELrV1FecZ4r8XnfI3ZxMQkp40Z5OIq44kiP5OUh9cK0BixDB2K7la
         8HdA==
X-Gm-Message-State: APjAAAUqsTE955S3AuqSBtAUM7g4qR9WK8JoNLymwNJc1Ac/LTTU8Z6Q
        h/c9CWWoTnw+buw5PaVZValcKg==
X-Google-Smtp-Source: APXvYqyh9hz5oxKLPRj0zyZyWCZYkTrZdDpWsxydX7vVAWAjqbfcxklr2+JBF6YDzYoBBp3i6GYzUQ==
X-Received: by 2002:a63:58c:: with SMTP id 134mr1598098pgf.106.1565829612820;
        Wed, 14 Aug 2019 17:40:12 -0700 (PDT)
Received: from santosiv.in.ibm.com ([49.205.218.176])
        by smtp.gmail.com with ESMTPSA id g8sm815917pgk.1.2019.08.14.17.40.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 17:40:12 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v10 4/7] extable: Add function to search only kernel exception table
Date:   Thu, 15 Aug 2019 06:09:38 +0530
Message-Id: <20190815003941.18655-5-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815003941.18655-1-santosh@fossix.org>
References: <20190815003941.18655-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain architecture specific operating modes (e.g., in powerpc machine
check handler that is unable to access vmalloc memory), the
search_exception_tables cannot be called because it also searches the
module exception tables if entry is not found in the kernel exception
table.

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
2.21.0

