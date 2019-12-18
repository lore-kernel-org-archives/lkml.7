Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44275C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145672465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFouNkPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfLRQfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:35:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46506 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfLRQfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:35:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so2146398edi.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMqMKRVCOcjZgE/EV3cPuX6L8AH27Rm+Sh8f62ETxcQ=;
        b=eFouNkPT+BVqLskLEk9g7X/YCueGVws1Y4L7OAdK67iYfuw5Q3JA28QRS8d/LWFrDG
         1PI0GaIys/kiZnyYwXJr83Bv5EsUHu3bADQCvrKc+yqTejvNWp7QIJtShLaEEWXU6HZS
         gtG2/bpkanXeXAJmHX5+l8j7bSOHLYl8HcMu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMqMKRVCOcjZgE/EV3cPuX6L8AH27Rm+Sh8f62ETxcQ=;
        b=PvD3D2D9LShU8JU0wJUUDwUSX1QSlWvhroDjbrPbW82x3RgMQbo8hBID/8cE+xaf4V
         hInhJ4xpz+SkmVrUVjFXGYnzm51jKDDecFq3YyKSIma0vaTLC7/lNK8WwADZ8WWCJgdO
         HAxegxZNzj0Tu3KthndrJlr4HDYnrauEvH/c3j2uyoICHL756KYeJEW5YA4fRYrjV7xu
         u4ou9Dk2rca4Z35obxwtGoCEVf3YHhzy/Sf9sgJnWVdcNwctSovni4pyXqBGUhRB7h+0
         +xXdiylp6egj4cR+AcZntykmaRP5HQ0YeeNN/RhshfumkMqS0B6YKl7xjBi7AqB9ErGM
         rheg==
X-Gm-Message-State: APjAAAUaOvUXyHriVZvdAn2+tuSySFbbkdgOVZhu0euvyTHkpx2ehIW1
        kwfQdsK3uudop1m27Aegwqmw3DlYqOQ=
X-Google-Smtp-Source: APXvYqxGm5RrfopgB3U7Ca9ms+6aJKnScObGgsY0uXMDlLXQK6wGvaY9/VhA2SbP6B1aGExzlrjRhQ==
X-Received: by 2002:a17:906:7fd0:: with SMTP id r16mr3565126ejs.319.1576686945381;
        Wed, 18 Dec 2019 08:35:45 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id y4sm50647edl.11.2019.12.18.08.35.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 08:35:44 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id q6so2965788wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:35:43 -0800 (PST)
X-Received: by 2002:a5d:51cc:: with SMTP id n12mr3908491wrv.177.1576686943371;
 Wed, 18 Dec 2019 08:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191205000957.112719-2-thgarnie@chromium.org> <20191218124604.GE24886@zn.tnic>
In-Reply-To: <20191218124604.GE24886@zn.tnic>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Wed, 18 Dec 2019 08:35:32 -0800
X-Gmail-Original-Message-ID: <CAJcbSZE56E_JqWpxvpHd194SAVn0fGJRiJWmLy=zfOyTthsGCg@mail.gmail.com>
Message-ID: <CAJcbSZE56E_JqWpxvpHd194SAVn0fGJRiJWmLy=zfOyTthsGCg@mail.gmail.com>
Subject: Re: [PATCH v10 01/11] x86/crypto: Adapt assembly for PIE support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 4:46 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Dec 04, 2019 at 04:09:38PM -0800, Thomas Garnier wrote:
> > Change the assembly code to use only relative references of symbols for the
> > kernel to be PIE compatible.
> >
> > Position Independent Executable (PIE) support will allow to extend the
> > KASLR randomization range below 0xffffffff80000000.
>
> FFS, how many times do we have to talk about this auto-sprinkled
> sentence?!
>
> https://lkml.kernel.org/r/20190805163202.GD18785@zn.tnic

In the last discussion, we mentioned Ingo (and other people) asked us
to include more information for context. I don't care about having it
or not, just want to ensure people understand why the change is made.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
