Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F91C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93FB20659
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUS7OTHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfGaUhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:37:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51115 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfGaUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:37:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so62215803wml.0;
        Wed, 31 Jul 2019 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Ad1NCToWXZTQRV4Ttp/KixfCZVZvJNhr1ng0+uFB0U=;
        b=HUS7OTHI0nOhTR1EypLAwV3WGLFJzyNNDC5Fuu1OVzfIFaNsnEtVHFz3CHkQtYU8pq
         x50WNqAh5N3XQwVG1LXxBzt+JRqEGkBWZpzoBbEwfsq+MDQi6473wQ5FAFrN5oloDm6I
         6vzPpODaGECtCkr3Cp2qGKYqDQyO4m4GhGDTih+s9Ur4w/X8IHUDFfRkWXiM7oWa/lPU
         1xOmN6K1DV34d5hw9ONjIBMSOmhQo2ipEKYq4kO5FTd4cz8qqWo57My3yPGTAm0q+OYU
         jrJtUGGe3537qXzswQKksHiYltyHqNe497MQN94TDoqOazRswFnWBJUuf/FRlP7Yqiam
         exgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Ad1NCToWXZTQRV4Ttp/KixfCZVZvJNhr1ng0+uFB0U=;
        b=lJ8DjaWilVb9oMTxrWOFndABNS0giPK1CJdkcbvHRccIGhotForXuLT4ka8v4/LRoD
         r3+rw80zBNoZWKKi/uwiBz5tAkg9y1PZnuhgVC/8KXfyxtNQBTE+26DJdaHvBOj5cXI0
         Sw4iAsiqjlGsHIzzqOPFF4j1A//tBg1VdD/LFGQWD1VFvXyHEqQ4Pe8JORu2P8uSzRQl
         gILPUcpAC5Ps5IRuUrW2z2/nqibYl0aB4V3GF9bzEV/JNtcd2UnmEBBgN7Kw1lFfHUdf
         qwEXUZIAIywY2pXxA97QFa2WNYSROUo++3VrzmgDaTvHs/k4ycNG+WtbfaZu9M1ySa5F
         libg==
X-Gm-Message-State: APjAAAWBgHMNudxP2wwGTpbqze476ChSOTn+h28nyyeROZru/mvVnPGM
        o1Yy8qqAQWV2M0DlMCw8F9xYNCLkR5oLVg==
X-Google-Smtp-Source: APXvYqx1/Q0uveVq5FV8+XH5STD3bgkAXXFg30KGFFyawCzxVmplf3ARBL/1G5Pc26DRP0+epGnCFQ==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr114587742wme.147.1564605436488;
        Wed, 31 Jul 2019 13:37:16 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id t13sm83919608wrr.0.2019.07.31.13.37.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 13:37:15 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:37:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     David Collins <collinsd@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] of/platform: Add missing const qualifier in
 of_link_property
Message-ID: <20190731203714.GA41488@archlinux-threadripper>
References: <20190729221101.228240-4-saravanak@google.com>
 <20190731181733.60422-1-natechancellor@gmail.com>
 <CAGETcx9LXP9b_W_1XQFmjODPJVrbnU+vH1RKer2i=jU7Q7EADg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9LXP9b_W_1XQFmjODPJVrbnU+vH1RKer2i=jU7Q7EADg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 01:33:40PM -0700, Saravana Kannan wrote:
> On Wed, Jul 31, 2019 at 11:19 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang errors:
> >
> > drivers/of/platform.c:632:28: error: initializing 'struct
> > supplier_bindings *' with an expression of type 'const struct
> > supplier_bindings [4]' discards qualifiers
> > [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> >         struct supplier_bindings *s = bindings;
> >                                   ^   ~~~~~~~~
> > 1 error generated.
> >
> > Fixes: 05f812549f53 ("of/platform: Add functional dependency link from DT bindings")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > Given this is still in the driver-core-testing branch, I am fine with
> > this being squashed in if desired.
> >
> >  drivers/of/platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index e2da90e53edb..21838226d68a 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -629,7 +629,7 @@ static bool of_link_property(struct device *dev, struct device_node *con_np,
> >                              const char *prop)
> >  {
> >         struct device_node *phandle;
> > -       struct supplier_bindings *s = bindings;
> > +       const struct supplier_bindings *s = bindings;
> >         unsigned int i = 0;
> >         bool done = true, matched = false;
> 
> Odd. I never got that email. Thanks for fixing this. I'll squash it
> into my patch series since I have a bunch of other kbuild errors about
> documentation.
> 
> -Saravana

It was a clang only email (which currently just get sent to our
clang-built-linux mailing list as there is a lot of overlap with GCC).

Not sure why there was no GCC email about this but oh well. Thanks for
picking it up!

Cheers,
Nathan
