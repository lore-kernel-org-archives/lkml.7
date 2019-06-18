Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A14AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E132B20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UFyDjb+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfFRO4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:56:53 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:61838 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:56:53 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x5IEulO3002830
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 23:56:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x5IEulO3002830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560869808;
        bh=6dxnBt3fIGFW+ROubfk95PVQRUtkj7Ua/pB+llQ1Ju0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UFyDjb+14G6pcwzM0N1YGpjD8LsS7oJHSZ/R7lBwUgfiwxvwQ3UT7CvXrXF+ubFxA
         NxIPZ1Of+iqSsQuc6Iwn3kXLxP/Q5eVHjakfjmY7sJPvDpmewM3jPqNTh8F8Q8dxH6
         921U1Gl8n5Z5BTv1pmB2QOfkG66epNXapFSIlY2JOTqPpIZC+ZFBWa1STHil8rWSdX
         1IGZ2B7t+ZdgoZDB7ujiZxxWfL5L+DU4T6KMzDJkaVy8MAUHkOXmJiwOK1WVeiztgy
         9vBJXCTA9oznqY2IJlxMDpa+CWcNbpy2+ByGkF2cI7ChUeae8Eu4ZqckESqolTneKF
         f9TtQCfHM2FSA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id 34so6284304uar.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:56:48 -0700 (PDT)
X-Gm-Message-State: APjAAAUKb3WjwRZpTlojSYLBMqMZn1sPKMF4yMr+i5m9cjS3eITlsc1L
        Ka0fpdBB+oGieeymVxpFIiF/LYpsEfGhQU02fLs=
X-Google-Smtp-Source: APXvYqyFy7PjzXrke2SGI3Ov1shSEe5A0cTjaMUsuLy2ti7lQsJriQ0xM0+UJqKY02rLhDN4+v5wVdf9p3y6jUchTbc=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr24650793vsl.155.1560869807098;
 Tue, 18 Jun 2019 07:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190529182324.8140-1-Jason@zx2c4.com> <CAK7LNARFUaaJH+g3oGzwFyKnELum72nOzxnvUfMKYBaAoGVkug@mail.gmail.com>
 <CAHmME9rGAUW9hjjZ7ZqNvZvaOCGrVHs3JNhYyr6g2PhZgS3TQg@mail.gmail.com>
In-Reply-To: <CAHmME9rGAUW9hjjZ7ZqNvZvaOCGrVHs3JNhYyr6g2PhZgS3TQg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 18 Jun 2019 23:56:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4+O=eNoJHnW58pVob0Po0ULj3cEksXZ3w+kTGMNJj2w@mail.gmail.com>
Message-ID: <CAK7LNAT4+O=eNoJHnW58pVob0Po0ULj3cEksXZ3w+kTGMNJj2w@mail.gmail.com>
Subject: Re: [PATCH] arm: vdso: pass --be8 to linker if necessary
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, May 31, 2019 at 5:20 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey Masahiro,
>
> I'm not sure exactly. I did just notice another place --be8 is being added:

That is not my question.

I just asked about your commit log:
"big-endian ARM was relying on gcc to translate
its -mbe8 option into ld's --be8 option"

I grepped '-mbe8', but I did not see it anywhere
in the source tree.

So, I just wondered where it came from.


> ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> LDFLAGS_vmlinux += --be8
> KBUILD_LDFLAGS_MODULE   += --be8
> endif
>
> I suppose it's possible that this is kbuild related where one of those
> isn't winding up in the right place. I did see that the commit that
> this patch addresses uses "=" instead of the more usual ":=" or "+="
> for whatever reason.
>
> Jason

Perhaps, the following will be cleaner:

ldflags-$(CONFIG_CPU_ENDIAN_BE8) += --be8
ldflags-y += -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
            -z max-page-size=4096 -z common-page-size=4096 \
            -nostdlib -shared \
            $(call ld-option, --hash-style=sysv) \
            $(call ld-option, --build-id) \
            -T


I think this fix-up should be applied by Russell.
Please note he does not pick up patches directly from ML.
To ask him to pick up patches, you need to put
patches into his patch tracker.
(patches@arm.linux.org.uk)


-- 
Best Regards
Masahiro Yamada
