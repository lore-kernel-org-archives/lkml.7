Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1B3C74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56D720872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Da22eipD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfGKROX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:14:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33719 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfGKROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:14:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so3358951plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucw9rSRviGvxmtHa1eJcbGqoOfZIZgp2Nd0u5B3lWZA=;
        b=Da22eipDrFV3sVjp5lhMK1Ag4ov7GIbghnsCPMLPbWr4HTpMO+0Xb4J2rn8DRx6qHT
         raOPgwKUlI6vG5+eZKye7qCGQQETow7AmhpRoh5cHUdPCXlRT2cKL12Jq3MiFeBw679W
         wk1YpqERzczakZBDQQ8pko2DW4C1f70wJ9S/ns+5k4w9umeU1hYehewCAr5tVqqhs2DW
         GqdMBotLNyKw4ICag2o2Axnjtx62CvFcXWSjSNMUtdvoLBIYxzy7ujuT7vx9Sj96r9wA
         vjLfAdfQxMO9pCXH+JWhO4dfi00ckikjgNwJov9+WJZ2h2rnzwxooDe//g0ahmSlempo
         WnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucw9rSRviGvxmtHa1eJcbGqoOfZIZgp2Nd0u5B3lWZA=;
        b=thPFdvTZKKdCRkLGLNNPOrFWggGW2HHzK4c7qWA+wWIKsr1pTZGYi6VM8cGgBYSL7i
         SSMFYXnDm+LqsMias+nj0QZrZyypVJnZfKkqjPBZu0ivkCRHUEHjYttIItFcPFD1+EVv
         L0xMD+fYj8fQhNwZA0bHeemNcACmfSHiCLYQ6YiVWFIuK8UBhmU31WlnDaQdjNrbQbMM
         Z3dt7UWBjIpL9XGUvPgf0IzvJvjfuDG5yM4i/D5Jm+u6qrs6rbgZxi0PHZT1FcyPc8wB
         QgfC/clyTIo9YVjzCqz8spJoY9C2c35lgM+8fSl81adxvdAKzVnrlaevxxlwN9fwim2E
         5zbQ==
X-Gm-Message-State: APjAAAWQjuQ25Fnd66r3QsliJjoLN+OyBSb4VViRs/ciBbh4LZvutWvZ
        R0bJDAs2yxIXeWCDangcZViMbtJx2/JFGpC9H+5XlA==
X-Google-Smtp-Source: APXvYqyCiqSqHnYjKAeXDLQuC0c8sZpZJD60JXgP1quXPWouPH4pF7fZdEdLqQyRgFNNeHBCL0hiMDCMtYcdYDM2b4s=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr5777071plq.223.1562865261987;
 Thu, 11 Jul 2019 10:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190710130206.1670830-1-arnd@arndb.de> <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
 <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jul 2019 10:14:10 -0700
Message-ID: <CAKwvOdkubvsRCnJKCaesB=PF=DgXfsBzwzR8kyE9NzWPU8Gehg@mail.gmail.com>
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 5:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> clang does not like an inline assembly with a "=q" contraint for
> a 64-bit output:

Seems like starting in GCC 7, GCC may not like it either:
https://godbolt.org/z/UyBUfh
it simply warns then proceeds with code gen.  Another difference may
come from when GCC vs Clang perform dead code elimination (DCE) vs
semantic analysis.

-- 
Thanks,
~Nick Desaulniers
