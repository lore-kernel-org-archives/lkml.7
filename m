Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD9C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A332521A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xvcWvOoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKMMrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:47:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38745 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfKMMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:47:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id z25so1479951oti.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 04:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hzS4SYZIt6NSpGEyuUnsFmOu8r8EHjFnb42rl1nHgcA=;
        b=xvcWvOoRVhAn4dsxU4VkYj8ICUAIK3dzZqwz4A12M1b/OSzothi1aeEN8C2VFcy3cG
         OZeLB4vaYMzrbreteBcvxV1hVxsOXLr0jeOK8wJPtIo3kV2CHdt8M2f2Ys/HXXcBRgqf
         6BCrGav8suM/KSxRuhhT9VWDu5lvxoqPoGEtKuov3vJyI1ShEeiBjsO02xWCTbfEQ518
         LeG8hqiedrAYe7QOv27SK0MgO7qUGyrfs9DpZymVAmrjbkgsF9go60tJ8VSoDKxzq4Qq
         zf3Yv/6GJfIF5GrjZn7cqcdi6BmorlsayObewnKRJ5BiSu8kyUnRFZyU1T75AaO9jOkH
         ztgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hzS4SYZIt6NSpGEyuUnsFmOu8r8EHjFnb42rl1nHgcA=;
        b=b2h8cy47Z/FADlzBZghEcAiloo2dMKIIRgNtivdAgphVvkpE+xcbzVzo0tUF2ZUc5/
         Eny8LzfTdYFZUtnN53/PwgelG+JSzaMaigv4KKKbToN/n8K4gCi7nRm/xpISlukbxWF5
         4L/9F+vhd/qd2kEDcGcOpq1J4jv1wPtFg/c1tsOYYMiVMMngXnrA/Uyp8BGv+Nx05Xgs
         OWD0SWHvRWUKEucK/3e9Abif19kRQpyMNp94p6/EXYDX8KFj30eXPp6pD3QhFnndMXfA
         mHZ7aaWE7+IB/+4/sYWdXnFNkv+W43XuBthfNoUQoBIHu9N+4lg8iwjaKNVEcQt20oZu
         6UHg==
X-Gm-Message-State: APjAAAWqXtGf0FmhknK3/ywfb7Qdw9AXeDFuyU/vwk41puTCQSXoeZVY
        eQO7a4hsmjnjNzI5TggcwlM1jkoT1ILTGIXvAK3v5w==
X-Google-Smtp-Source: APXvYqz489t5EwSifbd70BN2wc2Mi+1psbSHgq4dZBXQDgFewdQxLAk6JgWdnkuJm+7Ix7lh2CSmzpOuJ9BaftT5FHU=
X-Received: by 2002:a9d:344a:: with SMTP id v68mr3084723otb.85.1573649250095;
 Wed, 13 Nov 2019 04:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20191112221026.5859-1-labbott@redhat.com>
In-Reply-To: <20191112221026.5859-1-labbott@redhat.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 13 Nov 2019 13:47:19 +0100
Message-ID: <CAMpxmJX_haxjkY+vmm+ajC6hi-aa6k6m0o+d=RmTz5xjPXuo-g@mail.gmail.com>
Subject: Re: [PATCH] tools: gpio: Correctly add make dependencies for gpio_utils
To:     Laura Abbott <labbott@redhat.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lis 2019 o 23:10 Laura Abbott <labbott@redhat.com> napisa=C5=82(a):
>
>
> gpio tools fail to build correctly with make parallelization:
>
> $ make -s -j24
> ld: gpio-utils.o: file not recognized: file truncated
> make[1]: *** [/home/labbott/linux_upstream/tools/build/Makefile.build:145=
: lsgpio-in.o] Error 1
> make: *** [Makefile:43: lsgpio-in.o] Error 2
> make: *** Waiting for unfinished jobs....
>
> This is because gpio-utils.o is used across multiple targets.
> Fix this by making gpio-utios.o a proper dependency.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> I made a similar fix to iio tools
> lore.kernel.org/r/20191018172908.3761-1-labbott@redhat.com
> ---
>  tools/gpio/Build    |  1 +
>  tools/gpio/Makefile | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/gpio/Build b/tools/gpio/Build
> index 620c1937d957..4141f35837db 100644
> --- a/tools/gpio/Build
> +++ b/tools/gpio/Build
> @@ -1,3 +1,4 @@
> +gpio-utils-y +=3D gpio-utils.o
>  lsgpio-y +=3D lsgpio.o gpio-utils.o
>  gpio-hammer-y +=3D gpio-hammer.o gpio-utils.o
>  gpio-event-mon-y +=3D gpio-event-mon.o gpio-utils.o
> diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
> index 1178d302757e..6080de58861f 100644
> --- a/tools/gpio/Makefile
> +++ b/tools/gpio/Makefile
> @@ -35,11 +35,15 @@ $(OUTPUT)include/linux/gpio.h: ../../include/uapi/lin=
ux/gpio.h
>
>  prepare: $(OUTPUT)include/linux/gpio.h
>
> +GPIO_UTILS_IN :=3D $(output)gpio-utils-in.o
> +$(GPIO_UTILS_IN): prepare FORCE
> +       $(Q)$(MAKE) $(build)=3Dgpio-utils
> +
>  #
>  # lsgpio
>  #
>  LSGPIO_IN :=3D $(OUTPUT)lsgpio-in.o
> -$(LSGPIO_IN): prepare FORCE
> +$(LSGPIO_IN): prepare FORCE $(OUTPUT)gpio-utils-in.o
>         $(Q)$(MAKE) $(build)=3Dlsgpio
>  $(OUTPUT)lsgpio: $(LSGPIO_IN)
>         $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> @@ -48,7 +52,7 @@ $(OUTPUT)lsgpio: $(LSGPIO_IN)
>  # gpio-hammer
>  #
>  GPIO_HAMMER_IN :=3D $(OUTPUT)gpio-hammer-in.o
> -$(GPIO_HAMMER_IN): prepare FORCE
> +$(GPIO_HAMMER_IN): prepare FORCE $(OUTPUT)gpio-utils-in.o
>         $(Q)$(MAKE) $(build)=3Dgpio-hammer
>  $(OUTPUT)gpio-hammer: $(GPIO_HAMMER_IN)
>         $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> @@ -57,7 +61,7 @@ $(OUTPUT)gpio-hammer: $(GPIO_HAMMER_IN)
>  # gpio-event-mon
>  #
>  GPIO_EVENT_MON_IN :=3D $(OUTPUT)gpio-event-mon-in.o
> -$(GPIO_EVENT_MON_IN): prepare FORCE
> +$(GPIO_EVENT_MON_IN): prepare FORCE $(OUTPUT)gpio-utils-in.o
>         $(Q)$(MAKE) $(build)=3Dgpio-event-mon
>  $(OUTPUT)gpio-event-mon: $(GPIO_EVENT_MON_IN)
>         $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> --
> 2.21.0
>

Applied for fixes, thanks!

Bartosz
