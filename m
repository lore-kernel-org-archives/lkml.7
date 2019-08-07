Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC841C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9005721EF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="KVVHNX5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfHGO5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:57:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45604 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbfHGO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:57:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so41229555plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCjlN6WUVTqi9Ls8DV65kSTfioWg+e5KAofys5HWp+8=;
        b=KVVHNX5JdgxTMcjfH2tXB/29kUpAfAhrmRoufpzO/vtZ+qISQnJpPJLnpWCoPCzTMN
         XfnRticIn8zT0uTjjmBEV9iB7ftUuef53x68wIjX4F6D7OwQnzfMyBJvyza0UESjjVN5
         0t7qBjnklPraDRg4XG8rqnojS3soobzpNE4PR0V5tJ3MkBLvx8u6pppKqee2H/mz0huX
         W/kBRB3alG00YfDaJoi3BEVZtip71Afa/UFamFeqwMoLULNzSRXbi3ymWfSG+7XMPJER
         c3C29nDYU8CTMWY0Vr/k3Haoxl9zrW+zoqLYJPvxXmnM+ge5crRQcBmTdqnDkD5CReHD
         n6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCjlN6WUVTqi9Ls8DV65kSTfioWg+e5KAofys5HWp+8=;
        b=CdcZrZfXNerA3kKO28gbmH8PYpwaShjKhMD1xSh821LUfWCSnuirNUZd9QP3trsQZ3
         W+l65+o6U6Jds9hWtuYb43hX3oS3wAJLa3tfe8qi3uQOgv406FAxXunhoeBSn1MIVRGD
         wUM4i9LcCWHtZqsZOD7P50/fzjdQ/w6/33ZLysozWbxXXjejJ2NuCM5Pq+XaRX1XP5GE
         7TZeoIKPrY2meDv+31sbXSCgOes+7IoZntUJE/Rs2LFNGVJIIFcXOOEJYA/K1HO1okpA
         2ncG71Cxwhln2prjk7Q20Vbw/JxrHjl+9kQS+fOxo6s6mmycWcVxxjj6ewLRqDWLjonn
         He2A==
X-Gm-Message-State: APjAAAU6q0/a/GaiPXOb3Fg3UeSCYq1G0IPDJkwG55uht8jUxyG7sHTR
        g2FlqBZoQwYUXlxK3tY9kudzAg==
X-Google-Smtp-Source: APXvYqwgdGhG+bvstw2uSm2Nqd/uqXQrbMhYKPt9/CeAGqfLRAOLhojclnU6sDuu6tNz/RCahuCq7Q==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr8748173plo.1.1565189849100;
        Wed, 07 Aug 2019 07:57:29 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([183.82.17.96])
        by smtp.gmail.com with ESMTPSA id l4sm93617475pff.50.2019.08.07.07.57.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 07:57:28 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
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
Subject: [PATCH v8 4/7] extable: Add function to search only kernel exception table
Date:   Wed,  7 Aug 2019 20:26:57 +0530
Message-Id: <20190807145700.25599-5-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807145700.25599-1-santosh@fossix.org>
References: <20190807145700.25599-1-santosh@fossix.org>
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
2.20.1

