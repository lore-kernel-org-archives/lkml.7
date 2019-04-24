Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256EFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A6720684
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PYO9LHzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbfDXVJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:09:22 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42861 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfDXVJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:09:22 -0400
Received: by mail-vs1-f66.google.com with SMTP id f15so11237387vsk.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oO1cIU2AnZi6mcNUNwULvsUo8ImP+bDCeOEcV2C9dwE=;
        b=PYO9LHzlXRD5KUnMQNr6V8Utry7fY4JCL+g6OTmgdecbZwKpTc+YCjo2//MFxOp4pe
         3N1Rp2OZs+H67CFCcBA96oKzJLgclQd0L+qI2erR5pZFNsxEOf58b64p0+1LX1kCiKgb
         ywd9i5S9p/oW/1qBiVdzA7gpjZfWsTeOoHVTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oO1cIU2AnZi6mcNUNwULvsUo8ImP+bDCeOEcV2C9dwE=;
        b=Z2RVQKUQCS5PPYhFN8hVAWzkMPTyDio8zppQWIQZIyedYKz4595tb6VVNOlumZJo2o
         sgbkNMAK3H0JbkOMi52kWW8nvVtEQ42mKWlmWSn0zSuMUjMTjC1SMUohvaLEhLpxB/Yh
         IlB+fpRW/SuSjoe0s1hJIEISKLu9t7zNsyPb7mFyw6qe1vT6VBXNEnb73X7mRhwde9//
         U7B4naMTwasvHwZMpK3FAw6cCLbasfuu4fhvxSH1aSYuh0b5NYWZ8xx9y5L4GjIZ5G1G
         j2v/fHVDXQJU4P3qX4VSP3NBqA+2CRcZ+lbsCH9R7RrTMshlvmGmUqo5LGNJ6youbsni
         722g==
X-Gm-Message-State: APjAAAUBtRfSfH0BmlqDWByFWpXT6xxYctpNwzCVobv502hP5DLVYx/W
        WMRlUoFIoD8AXjlTrDB4z6hxL9+jSQ4=
X-Google-Smtp-Source: APXvYqzfZO4I6qNIQUjvR9c+SdmBnS1DKX0zK2vDlaIgeMyOMvbQylrtk73p1kIWTvFh8+oRLuC5ZA==
X-Received: by 2002:a05:6102:206:: with SMTP id z6mr8026329vsp.186.1556140160820;
        Wed, 24 Apr 2019 14:09:20 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id u6sm12832824vke.54.2019.04.24.14.09.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:09:20 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id g127so11261751vsd.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:09:20 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr18305831vsp.188.1556139733580;
 Wed, 24 Apr 2019 14:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190423194925.32151-1-keescook@chromium.org> <20190423194925.32151-3-keescook@chromium.org>
 <84ed0a4b-b1e5-ae86-56c1-40a212734667@linux.com>
In-Reply-To: <84ed0a4b-b1e5-ae86-56c1-40a212734667@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Apr 2019 14:02:02 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKkv2EvxZEO_V_0djDhaW-+WToZ2D477_PRnnMfAFDpTA@mail.gmail.com>
Message-ID: <CAGXu5jKkv2EvxZEO_V_0djDhaW-+WToZ2D477_PRnnMfAFDpTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] security: Move stackleak config to Kconfig.hardening
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 8:25 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 23.04.2019 22:49, Kees Cook wrote:
> > This moves the stackleak plugin options to Kconfig.hardening's memory
> > initialization menu.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Hello Kees,
>
> I see the changes in STACKLEAK help, looks good to me.
> For this patch -
>   Reviewed-by: Alexander Popov <alex.popov@linux.com>

Thanks!

> By the way, for your information, GCC_PLUGIN_STRUCTLEAK help is now unreachable
> from 'make menuconfig'.

Good point. I'll see if I can find a sensible place to move this to.
There isn't really a place for just the plugin details any more...
hmm.

-- 
Kees Cook
