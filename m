Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B587CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AE92089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Kl/m7Y/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504256AbfJRGGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:06:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41685 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732869AbfJRGGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:06:31 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so6029706ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=O0YWLx1kD/F6QW3/VV+7nUBXVt/vWL0doC9Fcyl1Wqs=;
        b=Kl/m7Y/ajU/WtKp6CuNso3JHk66JxIhKK8JZ6DGeotQKmRmSwQNeMQ/yz6ud9qH6uX
         DCOr1spOt7BK5yTOKRAJzEt5auJt+CBZNwb1qtOqk+q38gGLCf5F9ZJBmkVp74eqDFwN
         7hhszy0FyXw2NeiHz2w3dTy76MwvVrSU8OpufwBs0B47+y1v6s6SVS23KMPJdqlZci5A
         +mOb5cRrzygUTqOaLIJz8URvLPti/p6BRP8AfK0j2ZyndvJpSD934ortXdxwKRSJb7+P
         v7Jr/kpkestXDCCfg/dlsl52p5XdSVP4NCkm/Vqd/SaCSTzosydZDdHLRxMsbPLxfUBh
         sKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=O0YWLx1kD/F6QW3/VV+7nUBXVt/vWL0doC9Fcyl1Wqs=;
        b=eRvCc8R5xljTTXe9Uup0B7ct4U6tqjebLplgBwLaMwC+KxCFgthIzNizsKlbLnOvzg
         Y/q3oxZ22SjPjXgbRlYk0+587X8LWr7/qhB7iR0U8+ry2RDDMnwu1uPrOe4e46bNlz/N
         b46DCKhkR6y26ELXyCUkJgpR0ZqPMJFYo0SspyE3SdJYmLSrG7ks/e/jef+WqfOrcBUo
         lEoDBAeypum2XwUt8hN7aoniP99/ll4pxEJGsl5gzt7ZNLZuTWyfL58Z1gPMGa7+KpT6
         Xj5cCJsGNyFrc0Kp82QJYhTudkdDt6WEHt9786c6nXw4jws2KSB8XWNJsTWyF8ECw6zl
         NdHA==
X-Gm-Message-State: APjAAAWbKsoTSYHA2S3wqsZXG9/GjrboJaPRcQ0lQDK+AuhHAddDgDG/
        LHUE6hY1QY1VqYS5RuIUZimj5w==
X-Google-Smtp-Source: APXvYqy+KgLjTQErLSCPcrhJFv8Hc2JXme03IT6wtx/F7tDJvZb74d6AnF09cSPWFizqEJ5qwmAKdA==
X-Received: by 2002:a6b:cac1:: with SMTP id a184mr3760620iog.297.1571378790468;
        Thu, 17 Oct 2019 23:06:30 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id n26sm2079036ili.8.2019.10.17.23.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 23:06:29 -0700 (PDT)
Date:   Thu, 17 Oct 2019 23:06:28 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] riscv: add missing prototypes
In-Reply-To: <20191018041501.cuyyhcm23dsihcif@ltop.local>
Message-ID: <alpine.DEB.2.21.9999.1910172306180.3026@viisi.sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com> <20191018004929.3445-6-paul.walmsley@sifive.com> <20191018041501.cuyyhcm23dsihcif@ltop.local>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Luc Van Oostenryck wrote:

> On Thu, Oct 17, 2019 at 05:49:26PM -0700, Paul Walmsley wrote:
> > sparse identifies these missing prototypes when building arch/riscv:
> > 
> > arch/riscv/kernel/cpu.c:149:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?
> > arch/riscv/kernel/irq.c:27:29: warning: symbol 'do_IRQ' was not declared. Should it be static?
> > arch/riscv/kernel/irq.c:57:13: warning: symbol 'init_IRQ' was not declared. Should it be static?
> > arch/riscv/kernel/syscall_table.c:15:6: warning: symbol 'sys_call_table' was not declared. Should it be static?
> > arch/riscv/kernel/time.c:15:13: warning: symbol 'time_init' was not declared. Should it be static?
> > arch/riscv/kernel/smpboot.c:135:24: warning: symbol 'smp_callin' was not declared. Should it be static?
> > arch/riscv/kernel/smp.c:72:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?
> > arch/riscv/mm/init.c:151:7: warning: symbol 'trampoline_pg_dir' was not declared. Should it be static?
> > arch/riscv/mm/init.c:157:7: warning: symbol 'early_pg_dir' was not declared. Should it be static?
> > arch/riscv/kernel/process.c:32:6: warning: symbol 'show_regs' was not declared. Should it be static?
> > arch/riscv/kernel/ptrace.c:151:6: warning: symbol 'do_syscall_trace_enter' was not declared. Should it be static?
> > arch/riscv/kernel/ptrace.c:165:6: warning: symbol 'do_syscall_trace_exit' was not declared. Should it be static?
> > 
> > Fix by adding the missing prototypes to the appropriate header files.
> 
> For functions defined in C but used ony in assembly, you can also simply mark
> them as '__visible'  (aka __attribute__((exrernally_visible)) ).

Thanks, I'll take this suggestion.


- Paul
