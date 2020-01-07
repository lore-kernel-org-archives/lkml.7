Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F4CC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329AD2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="muBYzEDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgAGJQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:16:34 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37459 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:16:33 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so8994188pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7oMdgWioDWITQzSI98n4NagJatFFPYMLbqTtAUUpj0w=;
        b=muBYzEDf3kXREd5gF/6B8QBbwzXQ3RFt696Xz/URWaNaLG9ung8yAF+OK3RJKqO3t8
         3vX9swBxnsrQyh/mJZkDaN6vc44EeKnHTyJZSLsbAGFC8BMiZJZjFTfCyBpYeENAz0gV
         n00TprtefUwyHJW71jx+mQ9WY4I/ucnCWax+RHAcaIMyGwYhVEoat88B1c61uUNdPGzC
         b9j19ZZP09ngqo45VMdPj7mhT13TKoT6GkpklqR4AOkfmWggI/3u6+YW1Gf3Y1yH2rje
         sYxiy5MY08iUZD9pWNIeLV5+lpBblpq2ncFB3OWfvEVjGhVh/yM9ft6FIo8fklLXvF8X
         gz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7oMdgWioDWITQzSI98n4NagJatFFPYMLbqTtAUUpj0w=;
        b=joQh6hflWlI1lZc1J5+V9pAGZRrjjAPLwgUkQRo2ySwkpYgW3KAPfMqut4O7Q8ApDj
         fG96lr5MTRjCev19QUoUVBZ0qCcB0ZaiK8ZFaySXkw0mOwnS6TC9OhKFYgZsdPOUWMD3
         WlyhhxssaE+Z1OWXvlTig3w1tvehcXPyHczcJRbaDrajKoVn7Ei+u26+Mn/NsE09pxyA
         kPJPII2a+MSQKOg5uV85V6K4Z+ris6BGOb+6FmpJa5uCRlUbsFr4Qjpnla8RaNk+MSVj
         Udj7MTB8K0A2voxzSxMsqKPdFmAPPB8H6YdwDXeRaOmQCB66tNS8Vh8EH86SxJKf4gyy
         YfnQ==
X-Gm-Message-State: APjAAAUWJ0KouBAMOk1GSe/U7hE5QPeU16FWn+BQg1GnxHkdt4rJ+M51
        HzRKpCqY7cOfKfXjyB37miwUQQ==
X-Google-Smtp-Source: APXvYqxjLep94Ti3iFTWlLDf1xdX+FyHt3IAErpNxzG6ui1L7m8uCDC6PAwPl7aQSChPTwNjZZihzg==
X-Received: by 2002:a17:902:9684:: with SMTP id n4mr44455505plp.154.1578388592754;
        Tue, 07 Jan 2020 01:16:32 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id s26sm48350814pfe.166.2020.01.07.01.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:16:32 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     green.hu@gmail.com, greentime@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH] riscv: to make sure the cores in .Lsecondary_park
Date:   Tue,  7 Jan 2020 17:16:18 +0800
Message-Id: <20200107091618.7214-1-greentime.hu@sifive.com>
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
 arch/riscv/kernel/head.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f8f996916c5b..d8da076fc69e 100644
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
@@ -303,6 +298,14 @@ ENTRY(reset_regs)
 END(reset_regs)
 #endif /* CONFIG_RISCV_M_MODE */
 
+__FINIT
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

