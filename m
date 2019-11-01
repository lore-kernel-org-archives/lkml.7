Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C4CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B257F217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOioWwe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfKAMi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:38:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45351 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKAMi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:38:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id v8so7092371lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=juqxyreB5rY3ImJv0Yzp4e8QkO+2AnsGZqFg+4e86YU=;
        b=hOioWwe5kY1eJn+gNXXXGCtQIGfwwKoCfEY71pJgLCu8ZmVCShigTi8h1TjqpaF/nl
         Hlpb8uMQprdG+vZhECVg4H8bbvYMVq9/H8NKAME1KsKC3V5jfP3kQ2piq5/qLuRoIKNK
         B1AJu1jLuwjk41xYITajZ4P0WD1cm/E22Ga9/bMfNa4wVk7LokbWo0B39KxMjG+bLU9L
         mkwmXsHDLCZraG2lcoEvMLvY7DO6517fresD6x9W88uAFz8l2OLIUpxll90xq7uqJzqv
         u/ayC8knOTofjfRDmOCCpRTG4BuqRGKArpT1E1gRcF0S/GFlCjr/KNPhiSopL+UxNkiq
         w05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=juqxyreB5rY3ImJv0Yzp4e8QkO+2AnsGZqFg+4e86YU=;
        b=g7lNCcLX4Nq5RwxOUKTliU6rPr2aOKf5777UoTh9EbA2kPgFMOkZz61S4YfBoola4R
         X2uAmE1lD9sAUz6c+YCrBepJmYYjFKoGOTv1MQ0Ss9vIMvdSwuaSEpI9lgqkggXrPi7n
         /vjv35HbCpcsYJ41DvavUA8DUVIPhD21NJ+hQRV5uxmzdsj73AFfIeM9RghBCnBDZ40D
         dUhesZF6HLlYeIPc/REe3ppjHivywgzx33j6RgtMQ38T93GIpICy8iNN8OOR0DW+h8rR
         iYnla8r8tFYTPV/U75cI4lj7MENGcfrk2PJ53xz7uanUxiG9leroMFQOaRrJCzQXaGQb
         Y6DQ==
X-Gm-Message-State: APjAAAU55YomwADDjMdYYvJhoYz6X6I8AeCDrEnmcWEayPJH17uzPBrk
        3lNXBE4rYSH3TEgMNrtARps=
X-Google-Smtp-Source: APXvYqxpUbm+U8ECtUPsSGNSvGxeXAeoY3AN1KOlVt9YXjJAN2eauSZ0pug+KdS29dXLtUgyVdyCaw==
X-Received: by 2002:a19:f107:: with SMTP id p7mr6945750lfh.91.1572611934429;
        Fri, 01 Nov 2019 05:38:54 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id a8sm2722127ljf.47.2019.11.01.05.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:38:52 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id B5F0746123B; Fri,  1 Nov 2019 15:38:50 +0300 (MSK)
Date:   Fri, 1 Nov 2019 15:38:50 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, X86-ML <x86@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip] x86/fpu: Fix missing variable rename in a comment
Message-ID: <20191101123850.GE1615@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fpu code has been reworked the pcntxt_mask is changed to
xfeatures_mask. Reflect it in the comment. Surely this is rather
a cosmetic change but still.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
CC: Ingo Molnar <mingo@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/kernel/fpu/xstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-tip.git/arch/x86/kernel/fpu/xstate.c
===================================================================
--- linux-tip.git.orig/arch/x86/kernel/fpu/xstate.c
+++ linux-tip.git/arch/x86/kernel/fpu/xstate.c
@@ -840,7 +840,7 @@ void *get_xsave_addr(struct xregs_state
 
 	/*
 	 * We should not ever be requesting features that we
-	 * have not enabled.  Remember that pcntxt_mask is
+	 * have not enabled.  Remember that xfeatures_mask is
 	 * what we write to the XCR0 register.
 	 */
 	WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr)),
