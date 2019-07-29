Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D66C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD5620651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="Fxecae3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfG2EAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:00:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38868 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2EAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:00:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so26933327plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 21:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwFeAlQ6IuYgXIVYtx8CQnkRCdX32iDrGGlWM20HRkk=;
        b=Fxecae3xqy40byOksy98DwNVQZN9qFp551/NzOq4Phfam/XCTu8WtrrY9s7mcvzImk
         itO4BzaScGz+GvMdZa7H/D/FY/x6QxGFFyXZsQ14s8Ag2WVDs3skBoFUm26JbkETCnTw
         3gQBqiMBDiaj9rHv115aLNkBhy9u6NxJM0BUOlAqy6/jCBxC0I2gmFKH6ZLryt/2rPS0
         p9CB+O6XR91xwhNaHA4NNm7HTU8TIbLb+VHLIMcDBvA3dggBXDeh8PdrCKNHyGIGRnF+
         XbQY3NB+55neS3Ior5YC6LyYP7XPc5wkdTY4ig1waWnr8sJC9+5GqFASHeWnWsANL8r8
         gk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwFeAlQ6IuYgXIVYtx8CQnkRCdX32iDrGGlWM20HRkk=;
        b=FrTqkMfbUu2oGUSZeBpxmxUgoaRFbFV5+euW1h+ObBwIdZQkdwOOagvf00sR56IFUU
         7zG48387JRYLJGOxL5sW+y8uViSks/bISF9159T/4qltdj1Gdws/G3cKBmWvDEFRGicr
         1y9VVRDObWNm/xUkButwPHiw4Gyfq4J0FACOBeurD93vJuOOMLPaIKUYwUcqNNlDfgmu
         6rvU4g0uM/V1R+EpW4CyVujgPvwbXl2uiDWyGkt17FPwaFnejtgV+P1clmJ6e1d7y+Gn
         ccK77CQ0a+Ik2h0D78ZiztGRCGSqvuICXSsVSOhiMLu6rliITmqOQBAPHM2UKuLML5Jf
         hdiA==
X-Gm-Message-State: APjAAAWWPwV6C1/LaOLinTy0evWm+2j+9aIjIFlCoJ350WKPWSo7Ps0b
        rkGF2wI1S7RrOZu70dfwcZM=
X-Google-Smtp-Source: APXvYqwd9R3GmaUpLLYf1lGgzZM9NR9zEJpKD3gBITjlGHlKJVGKj9KGuL6LQrtgghl/lRVO+1wXfg==
X-Received: by 2002:a17:902:b582:: with SMTP id a2mr109947123pls.128.1564372831045;
        Sun, 28 Jul 2019 21:00:31 -0700 (PDT)
Received: from santosiv.in.ibm.com ([183.82.17.52])
        by smtp.gmail.com with ESMTPSA id g1sm100033948pgg.27.2019.07.28.21.00.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 21:00:30 -0700 (PDT)
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
Subject: [v6 3/6] extable: Add function to search only kernel exception table
Date:   Mon, 29 Jul 2019 09:30:08 +0530
Message-Id: <20190729040011.5086-4-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729040011.5086-1-santosh@fossix.org>
References: <20190729040011.5086-1-santosh@fossix.org>
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

