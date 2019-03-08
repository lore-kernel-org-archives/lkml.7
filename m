Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31726C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED28E205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPNPtBkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfCHT0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:26:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43174 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfCHT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:26:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so14832735pfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 11:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdXYWLKTij5dMrqDfF85zfQXqkJy55f4HKLCN46UDR8=;
        b=vPNPtBktcud2omHncpHn+XsNx4CNk28H1Fi/XwasQ5AaWYTy3J6K2rsCUa2D7Xm6Df
         n4/6p+0mDAG5zqRTWfrgQqR6nG297rUubV6p1+XA4oi54ns/3CT8UMVOMFhhwMjL6mvZ
         yZJo4DGkPZbQRgz291OIsh94anza1i28At7c3yzAYhSRzLHp80TRSK2CWHjjLeQSgEEf
         XM3OV6PHChGme2ejawM+8qcLewz7XufYMklcOjyn93cUZjtRPXbfUGVqKYduhjgQ1zBH
         MCkdCPrC+d55kQYAdNQQU5vOP5ex+9Z6wmt/brz9fR7Hx8LswJbkJhbAqa5aXW9Khd9F
         21BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdXYWLKTij5dMrqDfF85zfQXqkJy55f4HKLCN46UDR8=;
        b=oayaUMJKs/kHCK4XM9GtYtLXT8/Bhpqq9qdctmixCGZp9U+Ss0uoEmtmtiZ9BjbEnL
         2cbQxfp2yPaRDpS458T/hkIgxy/USN6759ptM86TtSvyRWS5HY6PMzfLMvrbtrrI0xSq
         CEZSaTISTceUnmb3ithlziMVIVTP/3sBvb0P2bWjofh2g+gq7+9he1tpfjoDrMi6hV5d
         YwuNgsPdf50DCaNef4cTGwu2jvbL6HnWCBmYQSv5ayqR6u9jKT5r+nvSx09h7bWOJ+oh
         ZACJkXkFoa9TA5cyQ3xyC877pGZ6vFxI7qo9TfB0g8RiUXXT5Qk2QSAMXIwdekU/p3+H
         P6Ag==
X-Gm-Message-State: APjAAAXT9pzsKGS0wh+OCM567Rsy28L30OtH6ftZXFY6lU7St5xS2hW9
        XUqyNSlgdh2/3K1FoU1UPi45X1N7uVx8XHXPYUNmScty053JXQ==
X-Google-Smtp-Source: APXvYqzozCwfaFo6MueP5ELynhFzgM4ZNgcgvsWICmJ7mQUYFNN+e6v7UJqStA/k4t7iFY34FoP5XiaNXDMK4CliR6w=
X-Received: by 2002:a17:902:8e82:: with SMTP id bg2mr20480913plb.217.1552073182222;
 Fri, 08 Mar 2019 11:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20190308012023.5709-1-natechancellor@gmail.com> <155203363088.27405.11887329278848171622@skylake-alporthouse-com>
In-Reply-To: <155203363088.27405.11887329278848171622@skylake-alporthouse-com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 11:26:10 -0800
Message-ID: <CAKwvOd=mpKR2V9rOEDDytctxT7uSwREyqfDVrYEEessWL=DY8Q@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Zero initialize this_cpu in busywait_stop
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        clang-built-linux@googlegroups.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Sandeep Patil <sspatil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:27 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Nathan Chancellor (2019-03-08 01:20:24)
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/gpu/drm/i915/i915_request.c:1032:6: warning: variable 'this_cpu'
> > is used uninitialized whenever '&&' condition is false
> > [-Wsometimes-uninitialized]
> >
> > time_after expands to use two typecheck with logical ANDs between them.
> > typecheck evaluates to 1 but Clang clearly gets confused with the logic
> > that as semantic analysis happens early in the pipeline. Fix this by
> > just zero initializing this_cpu as it will always be properly
> > initialized before the comparison below.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/415
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > Alternatively, this can be solved by having the return value of
> > local_clock_us(&this_cpu) be a local variable but this seems less
> > controversial.
>
> I'll just wait for clang to be fixed, as this severely undermines any
> respect I have for its semantic analysis.
> -Chris

I'm still playing around with this in Godbolt (my hunch is that GNU C
statement expressions are maybe inlined as part of GCC's early
inlining phase).  For example:
https://godbolt.org/z/G54s5z

If you change `typecheck(unsigned long, a)` and `typecheck(unsigned
long, b)` in `time_after()` both to `1` (what `typecheck` would
evaluate to), then the warning goes away.  But a further
simplification shows that GNU C statement expressions are not the
problem:
https://godbolt.org/z/KzCN8m

I need to keep investigating, but there may be more we can do on the
compiler side.

It seems that another workaround that avoid default initialization is
to just create another local for the temporary expression that
provably initialized this_cpu, ie.

diff --git a/drivers/gpu/drm/i915/i915_request.c
b/drivers/gpu/drm/i915/i915_request.c
index c2a5c48c7541..5b90b5c35c8b 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -1028,8 +1028,9 @@ static unsigned long local_clock_us(unsigned int *cpu)
 static bool busywait_stop(unsigned long timeout, unsigned int cpu)
 {
        unsigned int this_cpu;
+       unsigned long local_clock = local_clock_us(&this_cpu);

-       if (time_after(local_clock_us(&this_cpu), timeout))
+       if (time_after(local_clock, timeout))
                return true;

        return this_cpu != cpu;

-- 
Thanks,
~Nick Desaulniers
