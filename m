Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F45C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6924E2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlRIHgbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfD0Gok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:44:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43190 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfD0GnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so2559750plp.10;
        Fri, 26 Apr 2019 23:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3mFI7V2IpbwOhuCcp+g9CO2dE2meFXsvyyAeb18NWyo=;
        b=JlRIHgbr6HB0GM/dfrBCsDnNLxTkOKzTB7qYCbAx4tDSjiPWdWErWZcgNMKz3646h4
         C8cKj9bZkmi6cPWikKj5uJAC7SrSg/qfrmI03cXhBRcOJHEMan3BYUSQ1ScXOsNa4u3Z
         IDQ4DfzWzmEsKN3rKTGM5uTvN695pUVNWWV4a8LMMvLzAhr7fWiHf2k7ZmkakgE11lMg
         wbrOSfmIb0CTjB/azGiS0/j+OjbriGytqXhtU6Bd27x2yAPLaWXYIt792EgmySvUAGOQ
         9VF/satnq8MCbRYyAQp+FRH27QsFCLaAp8PdnQobxJM8asT3n363jT4JX9FD5F/9ebkE
         0Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3mFI7V2IpbwOhuCcp+g9CO2dE2meFXsvyyAeb18NWyo=;
        b=Fb2V3scDSuIaD9RsJA5v4YGq3jzdnjbX11GqbT381MORxzQExTxtzQQd+InbiJk2I5
         8nwCHLZlabvHLnuUb1X7q1n6G6Lq/gBi1Od9CKc2nioFZsnYX1ZjNYuWLsdw+0Tjn4TH
         f7Wd0KCiZMqONkUfm7GJk0eQ7meuGsgqiOqs3QLnC8wND/R5ciH+kz4mRZ18UKMYah/V
         uA5dSN2TFrtqLR48WmHiiqqzX2wyjKBrryKLjtqVXEgmq29oyr7m6Vhbfhs2YTdquxdN
         RMKcwGZXCEmv1EHCyrC1ziVZ2SO2JHe/N7aE0M+yEtb4SqCs3alrnj/ITGLuuLSXP9z+
         kSsw==
X-Gm-Message-State: APjAAAUZpDRKLHtbae36L/n0J+5S0Y0DAH76955DFPID1Gs16v7mNlo9
        dBSgrrl4k4tf2pSTUcT6yI8=
X-Google-Smtp-Source: APXvYqx2WhBZnJIn8mqH1b7ixt4GF/6k4yp110M4lMdf7eXq6Mz7eqmVNfTsfdPSyk5JMfubTGyIEQ==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr48053244plb.6.1556347396829;
        Fri, 26 Apr 2019 23:43:16 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:16 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v6 09/24] x86/kgdb: Avoid redundant comparison of patched code
Date:   Fri, 26 Apr 2019 16:22:48 -0700
Message-Id: <20190426232303.28381-10-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

text_poke() already ensures that the written value is the correct one
and fails if that is not the case. There is no need for an additional
comparison. Remove it.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/kgdb.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 2b203ee5b879..13b13311b792 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -747,7 +747,6 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 {
 	int err;
-	char opc[BREAK_INSTR_SIZE];
 
 	bpt->type = BP_BREAKPOINT;
 	err = probe_kernel_read(bpt->saved_instr, (char *)bpt->bpt_addr,
@@ -766,11 +765,6 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 		return -EBUSY;
 	text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
 		       BREAK_INSTR_SIZE);
-	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
-	if (err)
-		return err;
-	if (memcmp(opc, arch_kgdb_ops.gdb_bpt_instr, BREAK_INSTR_SIZE))
-		return -EINVAL;
 	bpt->type = BP_POKE_BREAKPOINT;
 
 	return err;
@@ -778,9 +772,6 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 
 int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 {
-	int err;
-	char opc[BREAK_INSTR_SIZE];
-
 	if (bpt->type != BP_POKE_BREAKPOINT)
 		goto knl_write;
 	/*
@@ -791,10 +782,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 		goto knl_write;
 	text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
 		       BREAK_INSTR_SIZE);
-	err = probe_kernel_read(opc, (char *)bpt->bpt_addr, BREAK_INSTR_SIZE);
-	if (err || memcmp(opc, bpt->saved_instr, BREAK_INSTR_SIZE))
-		goto knl_write;
-	return err;
+	return 0;
 
 knl_write:
 	return probe_kernel_write((char *)bpt->bpt_addr,
-- 
2.17.1

