Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7C5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A3F2082C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU6o2yLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfCXWB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:01:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34475 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:01:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id j89so6120135ljb.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HiAmdfM33ePJseP1ilfoPLxxobyapnNBphiekvoFsj0=;
        b=hU6o2yLYsmDSXK5UEsT0QkfmFneXQ6n/dxHldjZxxj5iSJH1xmF7AocpiKuaTlE1yb
         r+c+WDFciEZ2QXy/uLrz7RwkJvQsc9ISJwCN1WtKdi4zXsTc6Y0lQHW2X9STOAQ9QlwL
         psavaLEctwBonhhtq2XF7gSvu8m0l9YHQTqq8VYvsPAuKgqgutqCQ0d64KWseAoBolIs
         keTvtmiEjQ1ibIWETEtoPkcKguEkUCJVM9LyK023NvnV+grEzJkDqmpx9hwHv5fiNgnV
         Fi543hd/WXgWmQ0NKleULZlfUcBumjl6H0ic5QSlzn8HqrFBw7Ic+FoSzxPadw7r10Pd
         UAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiAmdfM33ePJseP1ilfoPLxxobyapnNBphiekvoFsj0=;
        b=MnXQ9CS/PGA+Q9ptQf4C7V3hg8hVvN9OEfagxLSrFYdmHn8qYo5D5xYH7eBwZnvFqO
         1ZVQJoa7AgjRxtaeZfeXsyGU+PgmTjHALun7xRC1m9zsd0EY2HaLCy3DHzyGysMGBmtu
         YFnvCFezrHVCTCyM73DcsuXcPEsT1nHqytw02P6iq4wAfj9P6vDHo9VZCdzkKX9FdMxS
         Q4vqLxh+eHZDyehe5f1W0JZg6nr1+7v/tYWsrFpKnK2ntW6LEj15uDqThV7yW74IxRv+
         SwDOzy0pN7M2WCQxyPfqdSrSDk9Ommh4q1Fj8GwKeJvfqiuBbbz/wefN5T4fxwUmJNYj
         V8FA==
X-Gm-Message-State: APjAAAWLYQVPwQuk+nqB+/yFp1Fr/SJTiw/aK9ih29J3tzC8UoZwJSS9
        TCVDwkDTn4/YzWNZq9yPyvfQ0bZ+72vjc4qjaTk=
X-Google-Smtp-Source: APXvYqy3brJvhSRHe5vyXsKAUAhclRPooVY+msRJIZcXx0ie2CV0JMOKCGDz+tyR21d2ZeaF0+kgCUI8ulWBIb+2WwA=
X-Received: by 2002:a2e:5b44:: with SMTP id p65mr11267787ljb.182.1553464915221;
 Sun, 24 Mar 2019 15:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190323171343.GA19483@gmail.com> <CAHk-=whLMT2kaYwwcdMtjvadjdv0aULvb8fsGWqT0V=DUMjp+w@mail.gmail.com>
In-Reply-To: <CAHk-=whLMT2kaYwwcdMtjvadjdv0aULvb8fsGWqT0V=DUMjp+w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 24 Mar 2019 23:01:44 +0100
Message-ID: <CANiq72kYJoeY=VqAG82-XNX5d_FoMkHHNtXO+-n0fsy-zif4og@mail.gmail.com>
Subject: Re: [GIT PULL] auxdisplay for v5.1-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Mar 24, 2019 at 10:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Side note: this is very annoying. As part of the rc release I'm going
> through things like this, and I notice that the new Kconfig option has
> absolutely no help text.
>
> That might be acceptable if the choice of options made sense and would
> be obvious to people, but they aren't obvious. Particularly not when
> you come from not having an option at all, it's not at all clear that
> what _used_ to happen was that "flash" option.
>
> And yes, the Kconfig source code makes it look like there are help
> texts. But a help text on the individual options for a choice isn't
> actually shown when you ask for help - it's the help text for the
> *choice* that matters. Not that those invisible help texts actually
> _help_ anything anyway.

The help on the actual option is a good point; we will add it. Also
the Kconfig in general needs a bit of love, I think.

Thanks a lot for taking a look, by the way!

Cheers,
Miguel
