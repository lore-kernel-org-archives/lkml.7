Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61821C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2F920679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V8BnXMDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfDYQ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:57:01 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42595 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfDYQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:57:00 -0400
Received: by mail-ua1-f65.google.com with SMTP id h4so208713uaj.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhjVqPrexfBwwSFeYo5d0b9deTZm5zd8YIOKCbvOido=;
        b=V8BnXMDMeWX1zzuigvaZ4qzb59d97nPAyFg89UKBbAYtsyI19824929pswa+TZ65JO
         ZmtBHSaHG77ynAPaVGkwtSKm4glA+lxbgY1fJrtLXXHn9g2uCYgdHqAURUVw8EGDY4Bi
         CFIu9ACAkSmEBMlAO0/lj2XIkjZhK7DLzsVJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhjVqPrexfBwwSFeYo5d0b9deTZm5zd8YIOKCbvOido=;
        b=TNT10FF/lpxJM2YFCeWPdT+7rHxOpTbGXUypw0tnXU5ay5rLZmBjlB8huc9lO2A+Dy
         4ST5CmahOnS1xLFc8/XtK6nFQ6s6Rxb6+nEoUIkG443JyEqfwz9qyeAG2acBXszjE1vv
         EOZlkxdVP5Xcfo0K34/hurFHggT7Mci+PCgLYt79JNWPeaakpSatuWdk4vjeXQ/LJq79
         2D8kl3vUhXAwwAbYLOF+mZJxw3PZgxCRdq/2pKZ/Omc80d06lq3/RUfxRgV1E2PmKaDj
         aQK7/D8HOT4yIYzRNfR0qNtDH6+8zL3PSA4DuAQ3Aey223IZ0D34pddBWJhKlcoQQ9nx
         Mdcg==
X-Gm-Message-State: APjAAAXSEnsD0su54X2Drp7AQ5cfyvH+Tkjo2+be1F/2rKLC7fk9UBKH
        OfuL2UxBMK8G65ajNzkmAOXvlQ5e+y0=
X-Google-Smtp-Source: APXvYqykLuwDhviLR6u3bfWoMzsXoJXpsIZjZ4iKhv4cbqOAg+/u2UjAanZTAcI76umcOlT0aS80UA==
X-Received: by 2002:ab0:6592:: with SMTP id v18mr20989088uam.63.1556211418638;
        Thu, 25 Apr 2019 09:56:58 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id b197sm22700859vkd.9.2019.04.25.09.56.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:56:56 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id w13so294056vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:56:56 -0700 (PDT)
X-Received: by 2002:a67:eecb:: with SMTP id o11mr21602235vsp.66.1556211415479;
 Thu, 25 Apr 2019 09:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190424231237.14776-1-keescook@chromium.org> <20190424231237.14776-8-keescook@chromium.org>
 <1ca5ee52-ab07-9142-2e45-44df1e94276e@kernel.org>
In-Reply-To: <1ca5ee52-ab07-9142-2e45-44df1e94276e@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 25 Apr 2019 09:56:44 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+F1iSu5GDG_FCykABXkH_gXcF=zjwwyev1vTDCXRLoVg@mail.gmail.com>
Message-ID: <CAGXu5j+F1iSu5GDG_FCykABXkH_gXcF=zjwwyev1vTDCXRLoVg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] selftests: Remove KSFT_TAP_LEVEL
To:     shuah <shuah@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 9:36 AM shuah <shuah@kernel.org> wrote:
>
> On 4/24/19 5:12 PM, Kees Cook wrote:
> > Since sub-testing can now be detected by indentation level, this removes
> > KSFT_TAP_LEVEL so that subtests report their TAP header for later parsing.
>
> Does this take into ksft_print_header() getenv logic to avoid printing
> TAP headers from tests when they fork? e.g timers tests do that a lot.

I didn't change the ksft_print_header() code, in case you want it back
in the future. But nothing sets that variable any more in my series:

$ git grep KSFT_TAP_LEVEL
tools/testing/selftests/kselftest.h:    if (!(getenv("KSFT_TAP_LEVEL")))

I don't see the timers tests using print_header() at all, actually...

$ cd tools/testing/kselftest/timers
$ git grep print_header | wc -l
0

-- 
Kees Cook
