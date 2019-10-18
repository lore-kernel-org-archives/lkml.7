Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9ECCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B27B222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCkne4s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405932AbfJRFR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:17:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40223 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfJRFR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:17:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so4717986wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GXpwiWbrAU/653GmrWZ4CKDfopVqbQJlCnoRGMU0IXo=;
        b=HCkne4s8lruvHSjpE5jf0OgLyMhPwrvNwZ3XZUMDJxIAmbTJ7U0e0j5lACmvchXOqb
         2wIXjnp6mVboS7gpgge2/f0WIp8FzhCfT1YzwjZn2XMChTk+3gX4w/G3wm1ASj5evE2v
         9KiN6Bd+zRI7o53M1ioDgisIswMb4TuhvO4CAV+HMlcpRWwIq6DGiBu+HsFpiLvXgdyx
         yyAuvxqH9F6W51uc00HyFnNZGHyf5BfLq8tgaAZ5qX1mMOJQD3r3KIrfjNUUGuKn5IDz
         wwRkRZtW4RWjuR6lMcdS7SsHtCR7KkOHVEIl/XHnXpbtnpPonSGPxfNxqxg7BH4lcH/l
         Ympw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GXpwiWbrAU/653GmrWZ4CKDfopVqbQJlCnoRGMU0IXo=;
        b=G0/jnQmEb05EHvsLil5J+W6LvmN/D4zMM4ySd91IGO6mT/732tQQXP53TO7qupNI6z
         3tmtjgF9ZLSlvjYT5f85p++6StTg0Udd4EL7Tjk6+v2jHtC7+kjwD+DezDLPKpWne8I4
         +A0hX/p0Ua8raMte4EMQYbFJ6V5jztdBLlp9AQiYdN48e306aURaAx3Sx6kgD/6qMDGx
         9UsoJSzJLrPhw8lYQW85qaE3+2wcz1NRLql29dPGEbbx3G/IF4ytTKg0zZBxIR3Xn4F6
         MFZ+c2Xkcp4N6Az4xmgHCNMY42A6kksOB3Dpi9SSp62sBO/YgWuGzKBVEcLzx6uQrQmY
         6SFg==
X-Gm-Message-State: APjAAAWEjEEs3L4jHqE21EcbaO+YBfO6fCSSuaYp6nJzinr4D5u3Aumo
        l+hm856TkBzolpYQFIex04FKdbtx
X-Google-Smtp-Source: APXvYqz+4Pinskrf2UCosw5rgRX7f2A0VhKcLk6IxtbU+1p4dOJAsqVStmjoGBzaMqSnB+Zff8cyzQ==
X-Received: by 2002:a1c:9e07:: with SMTP id h7mr5807160wme.96.1571372104081;
        Thu, 17 Oct 2019 21:15:04 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:18e1:7d90:ccf5:4489])
        by smtp.gmail.com with ESMTPSA id x9sm4453820wrq.63.2019.10.17.21.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:15:03 -0700 (PDT)
Date:   Fri, 18 Oct 2019 06:15:02 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] riscv: add missing prototypes
Message-ID: <20191018041501.cuyyhcm23dsihcif@ltop.local>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
 <20191018004929.3445-6-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018004929.3445-6-paul.walmsley@sifive.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:49:26PM -0700, Paul Walmsley wrote:
> sparse identifies these missing prototypes when building arch/riscv:
> 
> arch/riscv/kernel/cpu.c:149:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?
> arch/riscv/kernel/irq.c:27:29: warning: symbol 'do_IRQ' was not declared. Should it be static?
> arch/riscv/kernel/irq.c:57:13: warning: symbol 'init_IRQ' was not declared. Should it be static?
> arch/riscv/kernel/syscall_table.c:15:6: warning: symbol 'sys_call_table' was not declared. Should it be static?
> arch/riscv/kernel/time.c:15:13: warning: symbol 'time_init' was not declared. Should it be static?
> arch/riscv/kernel/smpboot.c:135:24: warning: symbol 'smp_callin' was not declared. Should it be static?
> arch/riscv/kernel/smp.c:72:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?
> arch/riscv/mm/init.c:151:7: warning: symbol 'trampoline_pg_dir' was not declared. Should it be static?
> arch/riscv/mm/init.c:157:7: warning: symbol 'early_pg_dir' was not declared. Should it be static?
> arch/riscv/kernel/process.c:32:6: warning: symbol 'show_regs' was not declared. Should it be static?
> arch/riscv/kernel/ptrace.c:151:6: warning: symbol 'do_syscall_trace_enter' was not declared. Should it be static?
> arch/riscv/kernel/ptrace.c:165:6: warning: symbol 'do_syscall_trace_exit' was not declared. Should it be static?
> 
> Fix by adding the missing prototypes to the appropriate header files.

For functions defined in C but used ony in assembly, you can also simply mark
them as '__visible'  (aka __attribute__((exrernally_visible)) ).
 
Best regards,
-- Luc
