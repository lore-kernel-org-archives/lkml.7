Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E946FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33CE20872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfDAADc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 20:03:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39484 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbfDAADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 20:03:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so9182845wmk.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 17:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWrdRGJn5dVC50iLYuhO2qdpO+kh39KXcfSk2TUVctg=;
        b=SjyCDxgtKRNycW8mXX21ytBrpYgmWsRYtaco+0VUahe8ndoSzodNar//d37+NbXPyj
         5FyNIWQtiZ3nPffwACNY5Ox+JWN+7X3jIYg78RHMp4Nn2x08uVn1D9e8gB1dja0X5Ahb
         trSXgguSbnl5OndB6Q+J7F0wqFAdxGKUSuMUERSruuUK5sSVlQZl1Bc63zsJulDLvBdt
         jesnI5v6Pb85FjZf6XiDBVy/tkz7LPGCfoxcMm8tREisU1hrZBpEXW8edG0cnJSqU/b7
         bx7cvZtY05CnAJPqnAMrfZCIgJAwN6t0v0RzpR+PnyoTD8rNPxUkaHxPC9e5jx0CejtR
         4Mtw==
X-Gm-Message-State: APjAAAVUvpZN3A8t08xpMJ0nmkEg+yvizfJXSIv8vWMQYTOqjglU58AZ
        1uNeVTmSQ5pL+8rMvhikOW/oSDgokyo=
X-Google-Smtp-Source: APXvYqx/CRRO9wjCsCYKdq+DWrnmBmKjRoMmHqNZZ//xZg7jOakGioNGM1r9QuRIgmWz77Ph/sFXOQ==
X-Received: by 2002:a1c:a00a:: with SMTP id j10mr10543430wme.15.1554077010608;
        Sun, 31 Mar 2019 17:03:30 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id w2sm7066694wrm.74.2019.03.31.17.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 17:03:29 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/traps: print faulty addresses on stack overflow
Date:   Mon,  1 Apr 2019 02:03:27 +0200
Message-Id: <20190401000327.26742-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
when a stack overflow happens "____ptrval____" is printed instead of the
real addresses:

    BUG: stack guard page was hit at (____ptrval____) (stack is (____ptrval____)..(____ptrval____))

Even if leaking kernel layout information is usually a bad thing, probably
the system needs to be rebooted anyway past this point, so force the
address print as the obfuscation makes the error message useless.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d26f9e9c3d83..0d3695334dfd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -301,7 +301,7 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 						struct pt_regs *regs,
 						unsigned long fault_address)
 {
-	printk(KERN_EMERG "BUG: stack guard page was hit at %p (stack is %p..%p)\n",
+	printk(KERN_EMERG "BUG: stack guard page was hit at %px (stack is %px..%px)\n",
 		 (void *)fault_address, current->stack,
 		 (char *)current->stack + THREAD_SIZE - 1);
 	die(message, regs, 0);
-- 
2.20.1

