Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C862C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC19206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwWbi0+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfL3Lyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:54:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36000 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3Lyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:54:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so13807643plm.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 03:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V+g+xlQXMz8TlHVe3WFWad+hv/3Pdq14q2xVD02b8Io=;
        b=nwWbi0+/ep9t/WPbfTkbW5p4gr85rcVB6Ycsae5fiHZaLySs8fGoBbjG2KEc2/wsRP
         CxfhX/JYz5R2x+892WD5tPRtnieAzgTOWGxxat9vcZHqdXlDNrvXUZVmeO/hjvnAW4Lz
         vj6k+5ADkGCK/DiEiZcHhgS87wRDbbtGEncgBMTKMmMY5KQZXYSUcuONMOpIlgE056St
         OhyMhgTy6D8RtG8YSKymYcvrn6mYGgFaaGCRvDFb5a51+vR+fGB+/zZcq5vw3vS94jg+
         xcoBj1TWU4ckgeTndjE3ohPYcFgM8Ixf7+TTyZU0TW0FKA0r+HBT7N7j7T6ZfnVuJFg3
         i6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+g+xlQXMz8TlHVe3WFWad+hv/3Pdq14q2xVD02b8Io=;
        b=IVK+bZd3aSRbKqJjsCxpwk6AuimNRrrSLSDLTvGeTmUj52LHAqgFDYuzez5EKvn8SK
         GGTEDvchEeWO6CC5mdxc07L9HW24HsksTZYTOJQtrtQGjGGVBzwAEux3xXO+D1VBCL0e
         Jp/A7P9lAwdrkv00i/B4UEEAXkMJotw4DVdbiFCdUFeRvaOy3GxPP3Y1VS9Lc/Kcf3DM
         Yqh1s7sQo/y4G5SvkTRcwTVfitJKqIl8fifp0flUhLeJSbjgvpA7NeqpczdiL6Sxjed/
         BE+8d19ZSVWvuRH/6Tk9TDT+cPJ2ZGu1qknRVE4hETWYhd97975sFcfHYEbc5Y/tr+O6
         S8/g==
X-Gm-Message-State: APjAAAXLF9sRJBvB1GEEwH/raC1miluoPXDLeq5a0sgnURyN70rijDA7
        +Lxhx5t3ADTMBS9IByO226g=
X-Google-Smtp-Source: APXvYqwa4+u3wBznl7zWe8cbMyh2wxVNyBvlYQwv1pIW2WqcFpzBxENV12PsrBSHa7EnamJlz2nrRA==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr69540164plo.5.1577706890709;
        Mon, 30 Dec 2019 03:54:50 -0800 (PST)
Received: from localhost ([49.207.54.121])
        by smtp.gmail.com with ESMTPSA id e1sm52685912pfl.98.2019.12.30.03.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 03:54:50 -0800 (PST)
Date:   Mon, 30 Dec 2019 17:24:48 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [RFC PATCH 1/2] ARM: !MMU: v7-M: prepare preemption support
Message-ID: <7a69ad9c2db39f6f17225eb0e79057bc221cc4a4.1577705829.git.afzal.mohd.ma@gmail.com>
References: <cover.1577705829.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577705829.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange getting thread_info pointer & popping lr so as to have an
easy to review diff for preempt support that is going to be added.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/kernel/entry-v7m.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index de1f20624be1..581562dbecf3 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -48,7 +48,7 @@ strerr:	.asciz	"\nUnhandled exception: IPSR = %08lx LR = %08lx\n"
 	@ routine called with r0 = irq number, r1 = struct pt_regs *
 	bl	nvic_handle_irq
 
-	pop	{lr}
+	get_thread_info tsk
 	@
 	@ Check for any pending work if returning to user
 	@
@@ -57,7 +57,6 @@ strerr:	.asciz	"\nUnhandled exception: IPSR = %08lx LR = %08lx\n"
 	tst	r0, V7M_SCB_ICSR_RETTOBASE
 	beq	2f
 
-	get_thread_info tsk
 	ldr	r2, [tsk, #TI_FLAGS]
 	tst	r2, #_TIF_WORK_MASK
 	beq	2f			@ no work pending
@@ -65,6 +64,8 @@ strerr:	.asciz	"\nUnhandled exception: IPSR = %08lx LR = %08lx\n"
 	str	r0, [r1, V7M_SCB_ICSR]	@ raise PendSV
 
 2:
+	pop	{lr}
+
 	@ registers r0-r3 and r12 are automatically restored on exception
 	@ return. r4-r7 were not clobbered in v7m_exception_entry so for
 	@ correctness they don't need to be restored. So only r8-r11 must be
-- 
2.24.1

