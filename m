Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A98FC00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14BB2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfCBWQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 17:16:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37762 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfCBWQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 17:16:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id m9so860104qkl.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 14:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bR0p/R7by6RvefIldSpKSAx2xSqpBquQGgzDi4xf7FE=;
        b=IeonzNhr42JL5T7p5QPPWcZkCapaxM4/hXoisiixst/adNPuCufzf4EpbK6w/e8MxJ
         24iPq5sitNRB7IIpxL98i2xJaqE+WSvyMk8T+UfJvPmuFG3LsnFGtrcgmrM+iT3azS9P
         RGt1zL7fJQXmA7G7rhLcuLtg/8iXlUwkD1iZH+6WVRPCUMrf5LQejggCyp8TrudKPwOD
         UKfdsPnfymWdE1JDGSGIG7BNRKRZSde45qpJ1tA+gwhHzMG0wHO6R8AHINp3E+uYC69x
         lormCIOiU7YnnsaRxEFt3g6Vn6CPLF0OxwGoySmiXP+6n2TIF8jM029LpV+vg7E5CHHK
         eskQ==
X-Gm-Message-State: APjAAAW0ynJSunReM3Ttn+gK4iBHE4Q0QhIlhC1QOldU/rKwPC2m3GGX
        x+vIsn7cMbTKZNAOhTCB2EwDukrvVyIe4fAtyTo=
X-Google-Smtp-Source: APXvYqwUqUX/NmZOaq4VfwXrxuZ+efNU5lDfaBzWIhxiqBkSa4Jb2/h+AluvxZWZF+YoekmtOSc+s2L7VTvmqCJ+HA4=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr8882575qkh.173.1551564970578;
 Sat, 02 Mar 2019 14:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20190212180441.15340-1-keescook@chromium.org> <20190212180441.15340-2-keescook@chromium.org>
 <CAK8P3a2xC3OVckPnweSjor3AH5LpSzichKxAjkAcgXDtCf0QmQ@mail.gmail.com>
 <CAKv+Gu_+GZ8Ut0nN+za+V48Eo6O27P_go3Dk1rDe1Wederad1Q@mail.gmail.com> <CAGXu5jLwEh-_v_aVm35hSqbX3QzdFOy_AwEa4mmKM8JmWtiKGA@mail.gmail.com>
In-Reply-To: <CAGXu5jLwEh-_v_aVm35hSqbX3QzdFOy_AwEa4mmKM8JmWtiKGA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 2 Mar 2019 23:15:53 +0100
Message-ID: <CAK8P3a3r-VV=xwuUgC5kMoNsOymjzSoZ4h-ks_p7AzNDfPa4oA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gcc-plugins: structleak: Generalize to all variable types
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 4:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Mar 2, 2019 at 1:05 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 28 Feb 2019 at 21:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > > I get similar results with asan-stack=1 but without your plugin, only
> > > the combination of the two has the explosive stack size growth.
>
> I can look more closely, but I'm not sure it's entirely worth it:
> these two may not make sense to build at the same time. (e.g. the
> use-after-scope config was disallowed to work with this plugin.)

Well, I still want to make sure all 'randconfig' builds complete without
warnings, and without having to turn off the otherwise useful
stack overflow warnings.

One thing I noticed is that your patch removes the 'depends on
!COMPILE_TEST' check for GCC_PLUGIN_STRUCTLEAK_BYREF_ALL,
so if we add that back in, it would at least take care of the
allmodconfig and randconfig cases.

> > > I can help analyze this further, but maybe you can have a look first,
> > > there might be something obvious when you read the input to the
> > > plugin.
> > >
> >
> > Is this before or after use-after-scope was disabled entirely?
>
> I was wondering the same thing, but I assumed it didn't matter: it
> wasn't possible to use both before it was entirely disabled.

Right. I already had the use-after-scope stuff disabled for
build testing, using the same 'depends on !COMPILE_TEST'
check, so one more reason it did not make a difference.

      Arnd
