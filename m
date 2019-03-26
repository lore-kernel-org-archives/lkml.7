Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D161AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03622084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfCZUau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:30:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35172 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbfCZUat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:30:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so14420844wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 13:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i5/6d8DkJ+1CUc14Gu8uylUm6zElUHAUrY5oLnamC2g=;
        b=IKJFtgpXts8vB4rQ3Qe6dcU3uR0zRqfsK2/33GYfrNDDwQKeLLdoOBHpRdkUWjH1jV
         I3N1WLhANio/phWshsbDxu+81zwC0r9t4o+hya92dtyzROJcM/6lGEC39UTpkS0hwZmE
         PjESgJ099qJaFX7RqWuU1NUOZV8oB/53fkxfqGafg3sztlJK+AC21QlvUuxYY63Qxsb8
         D+ZgHWuBEPAXCn97h/Xa3XU84t1erqvarOoW+5bvd5yJvt70D3hjlMYAed5sGUaxprl0
         naQmi904LbnkuplFwCVVdQ4+DeWqYQBsx25Zwn5u+hnKJyMcK4ji+hABmhym9HaLDmbb
         Blzg==
X-Gm-Message-State: APjAAAXX2hVRmRmnLQtH74YdKV+PgGlEsRGpwDA5T0kGfY0DcB+Ah/ZM
        yd+yxcS9HQIwigLMLFyk8O8fwg==
X-Google-Smtp-Source: APXvYqxnDOsmiZ5KzOxUoWWpkiKDJ3s8DJkvdPY/tmmx5z60i2D7VeYnRwG03SoUh7dDHNjKw5wEFQ==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr17279326wmc.70.1553632247818;
        Tue, 26 Mar 2019 13:30:47 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id z11sm10573269wmf.12.2019.03.26.13.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 13:30:47 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] x86/realmode: don't leak kernel addresses
Date:   Tue, 26 Mar 2019 21:30:46 +0100
Message-Id: <20190326203046.20787-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
at boot "____ptrval____" is printed instead of the trampoline addresses:

    Base memory trampoline at [(____ptrval____)] 99000 size 24576

Remove the print as we don't want to leak kernel addresses.

Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/x86/realmode/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index d10105825d57..47d097946872 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -20,8 +20,6 @@ void __init set_real_mode_mem(phys_addr_t mem, size_t size)
 	void *base = __va(mem);
 
 	real_mode_header = (struct real_mode_header *) base;
-	printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
-	       base, (unsigned long long)mem, size);
 }
 
 void __init reserve_real_mode(void)
-- 
2.20.1

