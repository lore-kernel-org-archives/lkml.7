Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C943C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623332189E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfH0Guq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfHHMyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:54:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39138 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfHHMyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:54:09 -0400
Received: by mail-ua1-f66.google.com with SMTP id j8so36333514uan.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GW4A3C1/4qWDt5LBlXwXuni4NJquarin7tqfcXTVjvA=;
        b=lfH0Guq7PuuNdAstn4QvxA1WDWXEF3ZxoZMxUurXLdQB0K1b8QuLdXm2RUBdqBkzjw
         nbHOEKeJ9d2HszCaaGiYFnL67LCAcQQUu1X41qjlxyKlZEUkINo2nyce8/wG5u/eXAEh
         KoITeRYbzKBbwlBtfBNxPixbvmO3FEDl6fu+uZepjSR+VHrgZZ0ikN9zeDm3uC7Q/+xg
         5kOLVIOwx+rBBafuahCEcDUrg7fzRmu0ba9qOPREpDwEFYUqfw7e1i5PO/dcm8O7vfYl
         +Nbkeg991B9T7Fibad/cb1gjMXj2lYJe1eCam3pzY8q/qUq5SRKA01XEeXCdfg3WhtNH
         m/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GW4A3C1/4qWDt5LBlXwXuni4NJquarin7tqfcXTVjvA=;
        b=G2O44yUYy2VsrcMPbFp8/VVdM5lJkdUcgn/w8pM8vUc2iWt7RdF/d8prEPjHdTSaBW
         ghPRYEhg/Cxqo+3KtiCSkDGnfoxUEvl7B9bIzKiiY/X7F2yHqP9vNCT4jWS62B90NU7z
         dvk6yeEpfAst8Bz5MUO7S6t7P8L7WRKoFdhXkd6zX1XEgTpglMJtlsuyai7z+SACLAHp
         W46gmpjW3Rgp08jh52FJWjhixlESfZgwMQSwx3pWzHnaFcsdmRQxd1bdmKZhRcngS1my
         7OfYD9hvfvofHFYuIAGVBMaz8vKm//Esyr6zJ5YREPtfD86I/nQuc5f3XzZXpZD660zR
         ThUw==
X-Gm-Message-State: APjAAAUz6hgWwdDnX/ZMJE8eaaaGubR3Bm3FKuXSrODm5WMLaXJCy+rB
        SGE2Yv5TckGduQCOdfdIwls=
X-Google-Smtp-Source: APXvYqxA8ql4HsS90B4Em4+N++thda+fqBtapHgDdeZqhSEKF1hyxafxxEBRNkzfdHs9nDqOh9ekGA==
X-Received: by 2002:ab0:2906:: with SMTP id v6mr9065083uap.96.1565268848111;
        Thu, 08 Aug 2019 05:54:08 -0700 (PDT)
Received: from asus-S451LA.lan ([190.22.21.218])
        by smtp.gmail.com with ESMTPSA id r190sm26961692vkr.8.2019.08.08.05.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2019 05:54:07 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     linux@armlinux.org.uk, michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v2 1/2] ARM: zynq: support smp in thumb mode
Date:   Thu,  8 Aug 2019 08:52:42 -0400
Message-Id: <20190808125243.31046-2-luaraneda@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808125243.31046-1-luaraneda@gmail.com>
References: <20190808125243.31046-1-luaraneda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add .arm directive to headsmp.S to ensure that the
CPU starts in 32-bit ARM mode and the correct code
size is copied on smp bring-up.
This is related to the fix applied to SoCFPGA by
commit 5616f36713ea
("ARM: SoCFPGA: Fix secondary CPU startup in thumb2 kernel")

Additionally, start secondary CPUs on secondary_startup_arm
to automatically switch from ARM to thumb on a thumb kernel

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
Suggested-by: Michal Simek <michal.simek@xilinx.com>
---
Changes:
v1 -> v2:
- Reword commit message to include related commits
---
 arch/arm/mach-zynq/headsmp.S | 2 ++
 arch/arm/mach-zynq/platsmp.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
index ab85003cf9ad..3449e0d1f990 100644
--- a/arch/arm/mach-zynq/headsmp.S
+++ b/arch/arm/mach-zynq/headsmp.S
@@ -7,6 +7,8 @@
 #include <linux/init.h>
 #include <asm/assembler.h>
 
+	.arm
+
 ENTRY(zynq_secondary_trampoline)
 ARM_BE8(setend	be)				@ ensure we are in BE8 mode
 	ldr	r0, zynq_secondary_trampoline_jump
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index a7cfe07156f4..38728badabd4 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -81,7 +81,7 @@ EXPORT_SYMBOL(zynq_cpun_start);
 
 static int zynq_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	return zynq_cpun_start(__pa_symbol(secondary_startup), cpu);
+	return zynq_cpun_start(__pa_symbol(secondary_startup_arm), cpu);
 }
 
 /*
-- 
2.22.0

