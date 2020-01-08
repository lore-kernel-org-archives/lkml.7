Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332B3C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071C22070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="knnFu4kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgAHCks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:40:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40910 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHCkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:40:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so799230pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 18:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YdOoXfjMlmlNHacUP7Z48pi92SG1YwN9wrHsFZ4ZOxI=;
        b=knnFu4kfnLycncKppgXa/Y7ob1Z6g9DGNmJB3EohyBMwhCgaAc91+DxBk+nzQdjg+l
         jcfiucb2QUK8C5aKxaPM2z/dxSLT6k5DuvrckWwJIo81LdIob1zjnxkaqw+J0WENgUBz
         q1KxQXgQBVQed7tzA6aBlY3R0x2WgdFg4lIwKIORXFlgQnOzDtutBKEgP5yh+AP8qnEx
         C8nrnBWFHBnfQURBRQCStTBmeoQlAyNV4PvnOT5X40/CxvbNabnmKn4jgKfVgt9Dcpj+
         k4PUnFjEVBsSUZEQ6pXbh6UybKiyz/TEmTmRwOdlg6fyN6g23NjWPbRqtu91t2TRUOLZ
         IO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YdOoXfjMlmlNHacUP7Z48pi92SG1YwN9wrHsFZ4ZOxI=;
        b=nN3zqhqb2/bFprps8cuVUfR2F3QkiL25sC3B3RyIadGThiKeJRqBRl4e57D3y2yLg7
         /0AUfZyHworfBc8XAglVCzMV8Si1IHNLjy2pP8mLRfTSaHmEhs4wDBRt/oGGcdguwzNj
         uQePfYW21cNnyssCbMMCk6Ar7I9m6VtltXZsoNrWEkLKEiEakRtIOJLkURRy+x+7WJrd
         bA44ZXb/bnbgPECe049Zk6lthogDs/BLk57HbozERGp/Vqs1X3tIiGlgLN82If2MAyeT
         0sbZyi1XlZMxzS904gdviO0ZlYmAsv+lmgUXguExNpYA3HJK/sUDQLfb8oQz426+GXxa
         x5rg==
X-Gm-Message-State: APjAAAX8yIOhBDbSfmxE3OX0MFrQwWmUVF18MCXIiV/7c28uSWMaBwYk
        AIL/idZkNZxQSHGUm+7EWo/vzg==
X-Google-Smtp-Source: APXvYqwEU/CLUZ+DPliiIIBvw3Nnr70BPkLNpg5SROWYJCuvyinwiF0BSh22tEYUZLUX/hfXXJVdzA==
X-Received: by 2002:a63:f403:: with SMTP id g3mr2950955pgi.62.1578451246863;
        Tue, 07 Jan 2020 18:40:46 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id b65sm1151234pgc.18.2020.01.07.18.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 18:40:46 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     green.hu@gmail.com, greentime@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH v2] riscv: to make sure the cores in .Lsecondary_park
Date:   Wed,  8 Jan 2020 10:40:35 +0800
Message-Id: <20200108024035.17524-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in secondary_park is currently placed in the .init section.  The
kernel reclaims and clears this code when it finishes booting.  That
causes the cores parked in it to go to somewhere unpredictable, so we
move this function out of init to make sure the cores stay looping there.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/head.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f8f996916c5b..276b98f9d0bd 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -217,11 +217,6 @@ relocate:
 	tail smp_callin
 #endif
 
-.align 2
-.Lsecondary_park:
-	/* We lack SMP support or have too many harts, so park this hart */
-	wfi
-	j .Lsecondary_park
 END(_start)
 
 #ifdef CONFIG_RISCV_M_MODE
@@ -303,6 +298,13 @@ ENTRY(reset_regs)
 END(reset_regs)
 #endif /* CONFIG_RISCV_M_MODE */
 
+.section ".text", "ax",@progbits
+.align 2
+.Lsecondary_park:
+	/* We lack SMP support or have too many harts, so park this hart */
+	wfi
+	j .Lsecondary_park
+
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
-- 
2.17.1

