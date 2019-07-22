Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB1BC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE90A21951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2cyMu/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfGVVle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:41:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35581 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbfGVVle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:41:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so19721217plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHgKF/faf+gKSnKAdZwRQ42YfMIcLjQkGrWNVDHMzzA=;
        b=H2cyMu/ZFAlYdAKuXo8YXN2d2hW2DEgweE6r0eAihkbksCldk6lxhw2szgOWFREedO
         ukPiQAopqTStPckMQ3klpifciyLZfM7Tz/iEPx0PxKk/QwyIaJZ1dTVTw9hyU6nQKOGH
         RQ2p/OCdDXtm2osqt7tDX0hRSCbri+KmUD4jK3wQXhAy+/dZNayydvQ/mRvJRcXc+IHq
         5O48jC3A1jCUrkGpeOUasqf7HKqWuDOSUjGJ8ZOSUmxwDaqIAQEvzajMpBrPoYQt3bVu
         yXZgpG0ITR3yaSGrDfAYPpy18mHD6fIx1M79+8ghfv7kGRHSPHZG7QsswkJA5CpcXY8x
         OUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHgKF/faf+gKSnKAdZwRQ42YfMIcLjQkGrWNVDHMzzA=;
        b=EE5lUJse6NIvRRVv7a/vEBO4f5ScKFG7GhhVXtrU75J7jCag8X30ILHbWTppfCqe32
         BKerHnpKjsn6DrRwL6xH7nPUXKvt+XhIO36nWmEIfZxQa4nY+f6qJoamDsjyYzGV8DQG
         wQGn7b6PBWm+DvZ4twN83lO8Doj7+h2PO9+q85XDIQOB99VICVwCBj2tci7dTnDV56Mo
         Anq0q3xrlNoY+RLu2kPNGrBBlxfMfTx7WtIqJp2+tqqSHvsDxuK6gcRkzd2LKW0i3PQn
         D/owbBYPpwrR9uPt+8iDf7md7gywwGt72WxwYSJbPuKYFY6ZoI1V8bZFyBPKQwESLWpT
         Tgaw==
X-Gm-Message-State: APjAAAV78Sf2CLBaxqXiEhYfqzhjMxxsoj8TKBS8GHVT3Pu0XbN5fcEz
        AQG5DYctbTJAJuD4g3Sgn2oIOjYR5h1gDHBFVhp5Uw==
X-Google-Smtp-Source: APXvYqwdhXuSHTybL80N4tO/8K5uECQXQgdWPPjd++uRaFairNx8n+9ry/np/I3gr7/SbS1m0vlVXAz6f4dN30fv3f0=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr74093089pld.119.1563831692996;
 Mon, 22 Jul 2019 14:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190722213250.238685-1-ndesaulniers@google.com> <20190722213250.238685-3-ndesaulniers@google.com>
In-Reply-To: <20190722213250.238685-3-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jul 2019 14:41:21 -0700
Message-ID: <CAKwvOdnkaT+zQFoXtjmf+CE0B4RHPr1zuH2pVRpP6=aVjq7nCA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support kexec/kdump for clang built kernel
To:     Joe Perches <joe@perches.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe,
Is it possible to have scripts/get_maintainer.pl always cc
linux-kernel@vger.kernel.org?  I just sent out a series, and it seems
the cover letter didn't get sent to LKML.  I usually use this shell
function to send patches:
```
function kpatch () {
  patch=$1
  shift
  git send-email \
      --cc-cmd="./scripts/get_maintainer.pl --norolestats $patch" \
        $@ $patch
}
```

Invoked via:
```
$ mkdir purgatory
$ git format-patch HEAD~2 --cover-letter -o purgatory -v2
$ kpatch purgatory/v2-000* --cc peterz@infradead.org --cc
clang-built-linux@googlegroups.com
```
Maybe I should just add `--cc linux-kernel@vger.kernel.org` to my
shell function?

On Mon, Jul 22, 2019 at 2:33 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> 1. Reuse the implementation of memcpy and memset instead of relying on
> __builtin_memcpy and __builtin_memset as it causes infinite recursion
> in Clang (at any opt level) or GCC at -O2.
> 2. Don't reset KBUILD_CFLAGS, rather filter CONFIG_FUNCTION_TRACER flags
> via `CFLAGS_REMOVE_<file>.o = -pg`.
>
> The order of the patches are reversed; in case we ever need to bisect,
> the memcpy/memset infinite recursion would occur with just patch 2/2
> applied.
>
> V2 of: https://lkml.org/lkml/2019/7/17/755
>
> Nick Desaulniers (2):
>   x86/purgatory: do not use __builtin_memcpy and __builtin_memset
>   x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS
>
>  arch/x86/purgatory/Makefile    | 15 ++++++++++-----
>  arch/x86/purgatory/purgatory.c |  6 ++++++
>  arch/x86/purgatory/string.c    | 23 -----------------------
>  3 files changed, 16 insertions(+), 28 deletions(-)
>  delete mode 100644 arch/x86/purgatory/string.c
>
> --
> 2.22.0.657.g960e92d24f-goog
>


-- 
Thanks,
~Nick Desaulniers
