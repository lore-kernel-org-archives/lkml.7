Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A876C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069FE2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDfs0YUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDLKbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:31:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46851 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:31:23 -0400
Received: by mail-io1-f65.google.com with SMTP id p23so7987969iol.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WQbyqOPAtAKHJpghKd11W4/2Yyb0ontIueUbMrmfdc=;
        b=oDfs0YUboiLL0mN87xu5y7i9qNJ5JE0yEVyIgUhbrF0oR/chPDfZ9/jVb3aAlikYUO
         joSPpf7C0Q8yhtwoERpXOv6dsNgM7JsaostWXjdkIQd69yLFfmj2UAcBPGgH/4emFvGO
         TRoPDtE7cxOZR27w7eJ/af3n6OEenFq9B3hWiXk/MCuU1owNirWqHA6fMZ07vgcLoXnZ
         BmFUvFNGCttZY+3u1RvixlOFOLdjo0t/DnWhdbtGmYhZwAsiEaasDWAj4rJ1SYjVMnjY
         0WX+RxLeXvXs9GiEjA3zqScB95PDdVRKILozGmuidBDVrEA4PbROSSdWv/xspr1A7xUl
         dazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WQbyqOPAtAKHJpghKd11W4/2Yyb0ontIueUbMrmfdc=;
        b=Q5vooh4sf5PIAUoYLTZsqdPhAZtgKSpHJejzBOUqgGRr0N4Qp3e6GDaFmFaix6KvCW
         aFuU8+lyRrwbX2Yir9B2UJHirQLPebMYLSt+1cvHEgvz/LhY6g7lbdyNE0EvNMP1uDzo
         LOZ5+lHnbwgJTvAW9ZlVaXsNTpspbcX3U73Kg6d6ZDJW86ynOVHXrCwIf5tH9ldOeWFy
         R2gsKpD/34/P9dCLc8IV31BQ1X7+PGrRfySr5RiawaKk9uDRKGTdaJGd16xBnRc/aygR
         XEhbBmImOL4uFz2F3NRUd3pnRt25SgL2FO1J+7IBF4cn7WgOs5JQgFZ2JwR7ppAYqbUN
         TgnQ==
X-Gm-Message-State: APjAAAVXoItn1y+EegxlQ1BNZnRxXJj9wNPqiS7OfJpYzDWJpEihT8M9
        Fc1tueXU3geVF3RemBGx6TaD4SWdz/NDHWbDmUBgIwqUFc7e4w==
X-Google-Smtp-Source: APXvYqwvMLIK1HFy60gNsrOXH4u0C55qXgHWqOFBuPDlpWnMJK3thNtxpR337U5vODqX7ayEEUqEwv4jbuVhnZNBAoM=
X-Received: by 2002:a5e:c019:: with SMTP id u25mr35967437iol.104.1555065082180;
 Fri, 12 Apr 2019 03:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190412102733.5154-1-mark.rutland@arm.com>
In-Reply-To: <20190412102733.5154-1-mark.rutland@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Apr 2019 12:31:10 +0200
Message-ID: <CACT4Y+apUSRP2BwW7P-R4Mj0dZjHG++neM5wjH6RM4ae7VUVcg@mail.gmail.com>
Subject: Re: [PATCH] kcov: improve CONFIG_ARCH_HAS_KCOV help text
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 12:27 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> The help text for CONFIG_ARCH_HAS_KCOV is stale, and describes the
> feature as being enabled only for x86_64, when it is now enabled for
> several architectures, including arm, arm64, powerpc, and s390.
>
> Let's remove that stale help text, and update it along the lines of hat
> for ARCH_HAS_FORTIFY_SOURCE, better describing when an architecture
> should select CONFIG_ARCH_HAS_KCOV.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  lib/Kconfig.debug | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 0d9e81779e37..00dbcdbc9a0d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -753,9 +753,9 @@ endmenu # "Memory Debugging"
>  config ARCH_HAS_KCOV
>         bool
>         help
> -         KCOV does not have any arch-specific code, but currently it is enabled
> -         only for x86_64. KCOV requires testing on other archs, and most likely
> -         disabling of instrumentation for some early boot code.
> +         An architecture should select this when it can successfully
> +         build and run with CONFIG_KCOV. This typically requires
> +         disabling instrumentation for some early boot code.
>
>  config CC_HAS_SANCOV_TRACE_PC
>         def_bool $(cc-option,-fsanitize-coverage=trace-pc)
> --
> 2.11.0


Acked-by: Dmitry Vyukov <dvyukov@google.com>
