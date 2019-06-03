Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19B3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24AD280CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ui2HFJbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfFCKvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:51:09 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38877 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfFCKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:51:09 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so11624443itk.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVlFqe9K3dpzMXBqO3onEIwgqdoMrC9jSiKlsTsm+KA=;
        b=ui2HFJbrMgcbCdCR8lZgDXCgpVlJzmJXm/yjyCdTymvUROCbMa4Sn8GwY7R7f3EgB5
         3LXWiuPFHS2SgZK4rx+XDHRSzfiCdz0woo61aiXKUI1EZG9g5o5pWXCF2B6sRHkaatZz
         H6W6O9pmWNtDwlcayUPBzd1lk8bZSA+KMNMwU18GgkiK9gZ3B63kyCncCg+wcbusVhAN
         z83V7dT6ZkXWAdsr0+V3pUhf2OmJMgW5cxtMYwqRd4N6CMX/ffZqGL2hyONTMhikX59n
         /1fizGKsZ/2l5bRBYZNxNpyO/8E3AWVOQGJsb+/2E41ukfV+U6TiSMeUFUpRLPwjDI1Q
         mkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVlFqe9K3dpzMXBqO3onEIwgqdoMrC9jSiKlsTsm+KA=;
        b=AiphLZoPpe76I6GnvAO/BUSp5DiIH2+LBVSa1KEncqjLiRZdIL8tDt1lHpb/FaDm9Q
         3P6PKW5xHDGbOlBcQKzw2HYZgJExmKTDFwcqR9HkbzmMpwbgU9uXunRlvqGtjXMvXqJY
         ew5OWoFxC7PeWIyM53WQcUSDQOMdtd4OXFMFYmrp0H45I/ta5kNT2/Cj7v890jZpHUgV
         1gYPekhnioLj8XcvvvKWcUeAWL7Q2f6l7bt6VhoyuJ4Df3+ERw24YKYYraOix5ebfGo0
         HdTYonjdRC35q8suzvPGY6B97K/RChPjNu9zjKYJ0hej1QFMqehcKHEDjsK1xW5sFTDU
         BVnw==
X-Gm-Message-State: APjAAAXl3dv80/EMWQeJeZLf1TWHjPS/5hd3MXcSw7Ood1kWO2FpOMts
        gtNdiNrSenRdBmwjtYr58W38iLtVOz2s9v9h6pFJXg==
X-Google-Smtp-Source: APXvYqzn0MRLC5N5kcLdHOnSaIKD6r+ynGuCBp764dPnHmhCDmTV9GXCNDSm1bMvcjXHvRrT92XY8gPCGXxPCmcW8f4=
X-Received: by 2002:a02:22c6:: with SMTP id o189mr3896549jao.35.1559559068416;
 Mon, 03 Jun 2019 03:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190603091148.24898-1-anders.roxell@linaro.org>
In-Reply-To: <20190603091148.24898-1-anders.roxell@linaro.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Jun 2019 12:50:56 +0200
Message-ID: <CACT4Y+Yes1Fxk24qemvB6b7NWzSD24ciqZsm0UN61jph46EdOQ@mail.gmail.com>
Subject: Re: [PATCH] mm: kasan: mark file report so ftrace doesn't trace it
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 11:11 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> __kasan_report() triggers ftrace and the preempt_count() in ftrace
> causes a call to __asan_load4(), breaking the circular dependency by
> making report as no trace for ftrace.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  mm/kasan/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 08b43de2383b..2b2da731483c 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -3,12 +3,14 @@ KASAN_SANITIZE := n
>  UBSAN_SANITIZE_common.o := n
>  UBSAN_SANITIZE_generic.o := n
>  UBSAN_SANITIZE_generic_report.o := n
> +UBSAN_SANITIZE_report.o := n
>  UBSAN_SANITIZE_tags.o := n
>  KCOV_INSTRUMENT := n
>
>  CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_generic.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_generic_report.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
>
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
> @@ -17,6 +19,7 @@ CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
>  CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
>  CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> +CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
>  CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
>
>  obj-$(CONFIG_KASAN) := common.o init.o report.o


Acked-by: Dmitry Vyukov <dvyukov@google.com>

Is it needed in all section? Or you just followed the pattern?
Different flag changes were initially done on very specific files for
specific reasons. E.g. -fno-conserve-stack is only for performance
reasons, so report* should not be there. But I see Peter already added
generic_report.o there. Perhaps we need to give up on selective
per-file changes, because this causes constant flow of new bugs in the
absence of testing and just do something like:

KASAN_SANITIZE := n
KCOV_INSTRUMENT := n
UBSAN_SANITIZE := n
CFLAGS_REMOVE = $(CC_FLAGS_FTRACE)
CFLAGS := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
