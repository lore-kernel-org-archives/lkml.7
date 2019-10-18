Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC5CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358FB222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Im9v9Mzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634345AbfJRRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:42:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46233 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405272AbfJRRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:42:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id k25so5871822oiw.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgmibiKo/0d1me29Z9Dof5MRYzr1N/NxNY1XetBfk8Q=;
        b=Im9v9MzyOaL8U2ABodimQMiMTAEx/ALWm+2aNR5YZ26YuKvMczxnA8y18urxRuG5/+
         XnQcLW/emDRhYE9NXkabF0vkvtB7/B1OFfA8yc2+J/8ojxg76NYqn5XEF+6dxQ3j2h+N
         W8t6SnO3PNtg31COYmZhMXfuGKIHm2m38ocLOoiR9IX5P9GsCHQlOalXy865b6wos+FW
         B0+x6QnnBH3aiaVPuVUZ0KG2tSujXnqZN+BcWBmEFAt50N0+lqqz81wqX9FfykNabdgv
         GbBqtF/9x13uD9f2ebYbNP8caXnjBcYIO58ADq19axMfogTi2lrhNIWRqNxK+9X+cD04
         +xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgmibiKo/0d1me29Z9Dof5MRYzr1N/NxNY1XetBfk8Q=;
        b=GHpE54ZOqlQWbg9I2YKzB85wPF73vDO4jmSpMoBFADj7lLkFJn4AcbZbhZNHfTwRAv
         62dYNTQPhZVW3uO8CnjMUyqrSq/2nhG/cdr0NMMTSObfXueNKobxkzccmDXixxaRvucN
         NQxcPgVG6pAVYKpKf8IHCGNocnebKdD/0uoMISTiJl/XJFumsTJFTp7Qb7Bad6aGJ58m
         NegVTgeINb7h4kFaL3Y/8AqiE/oTOyjkzJfAR9Fg0dklKihmvYny7jPWlKH8xm982Rhl
         j4cZ9N8bpTk0HdMN9GO0O8topFcuM68Hh55WO77ArSTunP56hz9qKIo1GiM2TSItEMZJ
         yD/A==
X-Gm-Message-State: APjAAAUVvhBpftP5SZljJyYxjlyM5CHFa0YLr0rgJTjklR/6OEsLJwaW
        n2Xw65HjjWRPVp3Vh6A9fFB02+pQVtTpzOjv0irvWA==
X-Google-Smtp-Source: APXvYqwal8PqTswvVVivN8N3jgNtD8TTtzaGZToccBg4XVuLF0lDOlAL78wRlCO4ZNDrki8LF+IX3VdRa5kC4ELpgWY=
X-Received: by 2002:aca:cd4d:: with SMTP id d74mr9183592oig.157.1571420553320;
 Fri, 18 Oct 2019 10:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191018161033.261971-7-samitolvanen@google.com>
In-Reply-To: <20191018161033.261971-7-samitolvanen@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Oct 2019 19:42:06 +0200
Message-ID: <CAG48ez30P_Af-cTui2sv-YVUY5DdA1DXHdMmAW1+KpvjEPWUOA@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:14 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> This change adds generic support for Clang's Shadow Call Stack, which
> uses a shadow stack to protect return addresses from being overwritten
> by an attacker. Details are available here:
>
>   https://clang.llvm.org/docs/ShadowCallStack.html

(As I mentioned in the other thread, the security documentation there
doesn't fit the kernel usecase.)

[...]
> +config SHADOW_CALL_STACK_VMAP
> +       def_bool n
> +       depends on SHADOW_CALL_STACK
> +       help
> +         Use virtually mapped shadow call stacks. Selecting this option
> +         provides better stack exhaustion protection, but increases per-thread
> +         memory consumption as a full page is allocated for each shadow stack.

Without CONFIG_SHADOW_CALL_STACK_VMAP, after 128 small stack frames,
you overflow into random physmap memory even if the main stack is
vmapped... I guess you can't get around that without making the SCS
instrumentation more verbose. :/

Could you maybe change things so that independent of whether you have
vmapped SCS or slab-allocated SCS, the scs_corrupted() check looks at
offset 1024-8 (where it currently is for the slab-allocated case)?
That way, code won't suddenly stop working when you disable
CONFIG_SHADOW_CALL_STACK_VMAP; and especially if you use
CONFIG_SHADOW_CALL_STACK_VMAP for development and testing but disable
it in production, that would be annoying.
