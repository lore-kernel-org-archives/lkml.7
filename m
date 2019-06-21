Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5BBC48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B7E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfFUJoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:44:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41648 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:44:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so6206532qtj.8;
        Fri, 21 Jun 2019 02:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UY8gc9yYdcrJaXj0oq+rSDKkKaI9rAlIB6YxZFfkWXQ=;
        b=Fvi0nR8MJitJ26p6pK+R5VuJGZORZoc9cIg5WjwfrfbiPRTeuEMTdafycbG8Zi+mxM
         qPuFBraZzMwIB+nbJwNmirYKKVdcSJ5x9kH0hAtFL6nLq6FShLhevVSZHRopzFXj217l
         WRg+lwzj1Hf5yGlBAGZVc3p0H3h3+8PTHZW7A3k3I5tCVD4rwlhT1zv0gCtgIa1DmbaE
         y9+ivWxlyBACO1IlCEOBRK0x/x4htrTst7KUzoNAXjqBalFgN34080Ek/lBmcJlD0y3I
         Ab04dAouQcpFgVE3NlyJjQWUKN1+BY4++E7Kfug95BagRUePQnqCRpIa34+whmxrSuD8
         cyog==
X-Gm-Message-State: APjAAAWqpLUkCowDoIlsoXQkjYN4409Cjxdt3NaeMoaiWBpicmoBCNWs
        QwH4wN/HFQl1B2hdwHlnzZ4v49b0V5pzW/Hoe8k=
X-Google-Smtp-Source: APXvYqyELuB33Y3aeHZUjXmmv39YykBnKQQHL21jwTSNms7xEEim4bbw6VNEYbvt3mtHFkco6KdkNtS0jstXubqO3iM=
X-Received: by 2002:a0c:87ab:: with SMTP id 40mr42484713qvj.93.1561110256287;
 Fri, 21 Jun 2019 02:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190618094731.3677294-1-arnd@arndb.de> <201906201034.9E44D8A2A8@keescook>
In-Reply-To: <201906201034.9E44D8A2A8@keescook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 11:43:58 +0200
Message-ID: <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com>
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with KASAN_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 7:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jun 18, 2019 at 11:47:13AM +0200, Arnd Bergmann wrote:
> > The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> > leads to much larger kernel stack usage, as seen from the warnings
> > about functions that now exceed the 2048 byte limit:
>
> Is the preference that this go into v5.2 (there's not much time left),
> or should this be v5.3? (You didn't mark it as Cc: stable?)

Having it in 5.2 would be great. I had not done much build testing in the last
months, so I didn't actually realize that your patch was merged a while ago
rather than only in linux-next.

BTW, I have now run into a small number of files that are still affected
by a stack overflow warning from STRUCTLEAK_BYREF_ALL. I'm trying
to come up with patches for those as well, we can probably do it in a way
that also improves the affected drivers. I'll put you on Cc when I
find another one.

      Arnd
