Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E41CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B932089C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO4ChYOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfKDSnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:43:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36298 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDSnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:43:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id v19so12936376pfm.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cyveooZxsbFfSYt42gpZZRf9Ppul5ahlN5Luw1xLEm4=;
        b=FO4ChYOqG1oNRDV8SFJM1O6g1rKgs4mD1S0mwnjOEy5e6gznsdmb5Jbzut8qZl6Npe
         nqbw1ZRdW9fKLWI5Fl5LwloHqCuMW7rAUEVfq0trD5a+642EDknbaeqZIRAT5A62TOuR
         nIucVLMqEbDF1rT+VQ24c/BaY4GgmhPZAGiq+fG8zGyDtzg2xmJu/a8ZacMBFkjSqeEd
         rqbgql8j3pybZYsun81OVSIhtsL3ptEH0Zd2G0xjPuoDh0Cx1vRULjqZYELe6VPVwPlG
         Yd7sLRbWek0Zz+j+/3c8/eyRXvV9+bz1a+94RsFKowibI+XSM/pcD6UMqaoe5Z4qqPnh
         LYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cyveooZxsbFfSYt42gpZZRf9Ppul5ahlN5Luw1xLEm4=;
        b=tSLD50PlZzQe51ye3wpF3efOFJRBdXOOFZ/nEDClhic/FCTFkGV1XHtNrvOj+RVoSo
         HvOXEMg0UdztTUa2i4ZzrRWFjHxWlTOkJ1fT+PhqucSKDmmXNS2efnGNcrUIiMZeAvlq
         QSB073dEQ/xE7maoSqdKDXLRAHqcsw7rEPpnqIZkN2XlqaQqN2eUT8vTicmSJFxN7NcG
         hp5DTcCrniqLmwpq1ithhN1em8a5AC8ijsjQ+hfG6P1h3Zj+jbH20HySZzIylaM4EVz6
         iJ1K5XJAiC0LLh1+6Lgd/KS52itMLIG4ZEzaQEnO31YwDF81uoWK/wOrsx180GORWTAz
         WEHw==
X-Gm-Message-State: APjAAAWtXOoPNGaI+5ZWHcAuKb7DozqsQ/j80LoK5czucR/LTCAULC4o
        NHpzkkqiBz1D67zRLtudeOBwUWUKtrz409IIuOZr1w==
X-Google-Smtp-Source: APXvYqzuga0pKYHVfkPxXV2Lqd6Ui/1l1fMs3gogk5Nnz/GzfH+hGl3UgXjsw4DiCvAlC8VU05yqiG01ckGdVV3QW3g=
X-Received: by 2002:a63:d70e:: with SMTP id d14mr31076676pgg.10.1572893000068;
 Mon, 04 Nov 2019 10:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20191030174429.248697-1-ndesaulniers@google.com> <fa4e28a9a16c54319916be005159e250@agner.ch>
In-Reply-To: <fa4e28a9a16c54319916be005159e250@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Nov 2019 10:43:08 -0800
Message-ID: <CAKwvOd==f801+AfJWwrO3tbSRoizCa2HV7pViOqedJbipN9nOw@mail.gmail.com>
Subject: Re: [PATCH] arm: replace Sun/Solaris style flag on section directive
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Fangrui Song <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Peter Smith <peter.smith@linaro.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roy Franz <rfranz@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 2:05 PM Stefan Agner <stefan@agner.ch> wrote:
>
> Hi Nick,
>
> On 2019-10-30 18:44, Nick Desaulniers wrote:
> > It looks like a section directive was using "Solaris style" to declare
> > the section flags. Replace this with the GNU style so that Clang's
> > integrated assembler can assemble this directive.
> >
> > The modified instances were identified via:
> > $ ag \\.section | grep \#

Submitted: https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8933/1

>
> I actually have the *very same* patch on my tree, just did not cleanup
> the commit message and submit :-(

Send in those patches!

>
> Anyways, this looks good to me:
>
> Reviewed-by: Stefan Agner <stefan@agner.ch>


Thanks all for those reviews.
-- 
Thanks,
~Nick Desaulniers
