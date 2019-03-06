Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D9CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855152063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jA2n9ERj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfCFSoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:44:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37375 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfCFSoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:44:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id s22so9305182pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Q9JVrQM5g86z//emudDTvqgPCz4G8IKm2xbJJqgFAs=;
        b=jA2n9ERjAeNYQ4YfUc3qfGQ3ahMZEF4MXXHz/T1/IgjlS/0CvjUUaPhgJXHAIsT/do
         RuaYSD9mJTKdqjb/PT2zouMF289k4vYYVZdw8btr3dPxVR4qf9YOeiP7MSVkON0P93hi
         g8GzzkO74wHExyX70+RCv+nHTDr7IdQinsVhhIZAkFU9IVmFkOiddfiFx9T+7e2C+IyA
         cup6ItcuTo/l1ajNOoYI8Cv2/ViJcoMKQyDVT9ygD6pUNdPA+RJjZwsjL58Qd6srYmmV
         EV7NA9F/a+VFMUIo9wzLmTsvS5MIijcPa1/BSKb/KaerBi1QwuVsAEO3FU77m989iHEv
         OLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Q9JVrQM5g86z//emudDTvqgPCz4G8IKm2xbJJqgFAs=;
        b=KYOOyGcDQ5zFeNa+8IxlIsk8Dty+19gzqsGim4EziAovDswQGoZSubudYMd1Jq2MPG
         tXBBKWWdGgLqUAKsFDTtLydIj3wJw5CW1jLnNz35Sm1Mc3hhdN5t7O4YmQN4PeEKcFDU
         EMefPhsle71mQLReepC1IiPPGZX3CMNnl0qmm+Z2zGkWT/3YXfsyeYiN3r17SViCNMdK
         cfWYqeqeF6S3JJjy4FRAndkp38hD0ujCl99kYq298Orp4D8UOPHxwu5zckADV9IBA0Cj
         ojRggJkd04YIgL9CcD6GTxpwdtt6OUMV8ch4Wn+GPSRdLg1l35GCMTGNla5GDhk0EWUy
         U/zA==
X-Gm-Message-State: APjAAAWWFW23eyRtJhG1C0d7IvEK6GMFwk8uglNbtdjUElgjt/aqow2I
        I94QgtNW7G63HOL95DAEKTpA1eOHvJAPHXZUIB/WHw==
X-Google-Smtp-Source: APXvYqzExV9zVNTVE6yf/7E/2CMSjaN/3x6J0E1R2XGjmMF0HI5/BoFfIyFTGTnB79zO5d+5orms2nDy91XnDM6LM2Y=
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr8419549pld.238.1551897852619;
 Wed, 06 Mar 2019 10:44:12 -0800 (PST)
MIME-Version: 1.0
References: <d55027ee95fe73e952dcd8be90aebd31b0095c45.1551892041.git.jpoimboe@redhat.com>
In-Reply-To: <d55027ee95fe73e952dcd8be90aebd31b0095c45.1551892041.git.jpoimboe@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Mar 2019 10:44:01 -0800
Message-ID: <CAKwvOdmHe-bkt34E5yf81GoiFRHR8EPnu8wqk2aD2u8P_4Q5jQ@mail.gmail.com>
Subject: Re: [PATCH] x86/unwind/orc: Fix ORC unwind table alignment
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 9:08 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> The .orc_unwind section is a packed array of 6-byte structs.  It's
> currently aligned to 6 bytes, which is causing warnings in the LLD
> linker.
>
> Six isn't a power of two, so it's not a valid alignment value.  The
> actual alignment doesn't matter much because it's an array of packed
> structs.  An alignment of two is sufficient.  In reality it always gets
> aligned to four bytes because it comes immediately after the
> 4-byte-aligned .orc_unwind_ip section.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/218
> Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")

Thanks for the patch Josh, we appreciate it.  It looks like
ee9f8fce9964 landed in v4.14-rc1.  Should we CC stable?

> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Dmitry Golovin <dima@golovin.in>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 3d7a6a9c2370..f8f6f04c4453 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -733,7 +733,7 @@
>                 KEEP(*(.orc_unwind_ip))                                 \
>                 __stop_orc_unwind_ip = .;                               \
>         }                                                               \
> -       . = ALIGN(6);                                                   \
> +       . = ALIGN(2);                                                   \
>         .orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {             \
>                 __start_orc_unwind = .;                                 \
>                 KEEP(*(.orc_unwind))                                    \
> --
> 2.17.2
>


-- 
Thanks,
~Nick Desaulniers
