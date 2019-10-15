Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD54ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 23:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFC02083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 23:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571182190;
	bh=FAdZvcnenwhlFxhwcsn2R9+6WGMj9jxQbY94oXTSUl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F7FyVPAZevGaz5frfd2qQOBHyoIsrs0mc/mdMLm+z5J/QmZtQb/7ROgCAk265AwIc
	 bf7x38WV6pxwJmn+I7Gx2Ka2kV6n6QkUsCfZaZ+g0CXU8qv4Sl7e6AbU0F9KTL546H
	 SJP6ZVZPS5pb5fcEBOZPK01TC3jyITdOAeQvxUCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390281AbfJOX3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfJOX3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 19:29:49 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83EB92083B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571182188;
        bh=FAdZvcnenwhlFxhwcsn2R9+6WGMj9jxQbY94oXTSUl8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OAa7nYhPqmH3fZS2ep3myJXmazQ+sdWJym29bqapL8IRxxQ0iN1XzUCumYlIDab7X
         AYp46TKyLq5X7l9/hzuoAioxKiTgOirGce5W10hxOeOxsOMCXkzS7Vb4uWdpmMncor
         MQmOTdtv5KYCm+jAEVTKCIb1Yj1Dq8jXg/abBA2Q=
Received: by mail-wr1-f49.google.com with SMTP id o28so3153288wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 16:29:48 -0700 (PDT)
X-Gm-Message-State: APjAAAVw9dKNq+gH7Gqe9SVdXHii54+ByRrbA2thBmSLOrcBbQyHG2W0
        3YFP8P7WVV9hC6PzT5zayMowjmAI/dNiKfJGQf4=
X-Google-Smtp-Source: APXvYqxzDItNIN17djf7TakZ7frMDK0m/FesWIBZei0lt/gvBQoA8a0hbOFvn/LcWfEJrFOCAckIwlcW9gxjsu0rQFs=
X-Received: by 2002:adf:ebd1:: with SMTP id v17mr29256wrn.204.1571182187025;
 Tue, 15 Oct 2019 16:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191821.11479-1-bigeasy@linutronix.de> <20191015191821.11479-7-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-7-bigeasy@linutronix.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 16 Oct 2019 07:29:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSVxgc5kw22dfotoHF91HxyTKC4ETYLTskEfyn3rf=kCw@mail.gmail.com>
Message-ID: <CAJF2gTSVxgc5kw22dfotoHF91HxyTKC4ETYLTskEfyn3rf=kCw@mail.gmail.com>
Subject: Re: [PATCH 06/34] csky: Use CONFIG_PREEMPTION
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could CONFIG_PREEMPT_RT be supported in csky ? Any arch backend porting ?

On Wed, Oct 16, 2019 at 3:18 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
>
> Switch the entry code over to use CONFIG_PREEMPTION.
>
> Cc: Guo Ren <guoren@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/csky/kernel/entry.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> index a7a5b67df8989..0077063280000 100644
> --- a/arch/csky/kernel/entry.S
> +++ b/arch/csky/kernel/entry.S
> @@ -277,7 +277,7 @@ ENTRY(csky_irq)
>         zero_fp
>         psrset  ee
>
> -#ifdef CONFIG_PREEMPT
> +#ifdef CONFIG_PREEMPTION
>         mov     r9, sp                  /* Get current stack  pointer */
>         bmaski  r10, THREAD_SHIFT
>         andn    r9, r10                 /* Get thread_info */
> @@ -294,7 +294,7 @@ ENTRY(csky_irq)
>         mov     a0, sp
>         jbsr    csky_do_IRQ
>
> -#ifdef CONFIG_PREEMPT
> +#ifdef CONFIG_PREEMPTION
>         subi    r12, 1
>         stw     r12, (r9, TINFO_PREEMPT)
>         cmpnei  r12, 0
> --
> 2.23.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
