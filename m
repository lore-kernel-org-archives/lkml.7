Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842CEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B672173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqXoWiS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfDPWAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:00:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46466 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPWAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:00:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id x188so18319551oia.13;
        Tue, 16 Apr 2019 15:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPkQGQTPqaBJVq/3YdYgaHbuYusSutUlgKg5qAS9MRk=;
        b=BqXoWiS92gyyN0UInPCvazkE9/LejgPRaYO5RfFWd4ZautyBjeuYmkxmmq2ZjdVQqa
         eEVTLMcrp6CAfY0r21J9DvWl6SzHn8tiX+N5GF2hoLX7Thb6//aTxJU83HlQRjtPTLpq
         EbNxT2+DMD5TPQrK8yHbMK0PA8uYYvjcgVfheJedUcwi++H1ep+IE0/ccbN9Mf5KN4uv
         y7CB923wPFBa52M533A5v39gXawg7XDeJNst8RsUTk7/nPIArU2DXSto+IPe5pYxJdKP
         5/WDtHx9yKFxGipLLY1fG/uTscKZqJmKM2tKZUIR0SxV6WUpTReWbe1coGBqirui887z
         EXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPkQGQTPqaBJVq/3YdYgaHbuYusSutUlgKg5qAS9MRk=;
        b=BXJu8XLSya3VPNv+IzoeA6lXvIXDTrcNo9HQZbAtIwD2NiRrF6Gto7NLLHagaTM5YV
         /a7Ro5+vGsrdTFEuWKGB8q7TofGIjevN0jA2fkgdsYljNTQRZgIGGNoI2FkD7JNKFSjk
         HTFFBAq+Ugn5y3LSuGIITVvbbCsIYsFTdgx3xolwcC+YoMhv0+ydW2MmPx/WHDX1IYcD
         IIguECVRfUy4bm6YiwTO+DQV7Cn0n9QlpzK/x38Fjf78ByQ/cQkCvQ9CeojZSue17Adr
         2+2Y42HUWrg1Jv+EvB6vyQghQYSlvwBEFsarSLZ6escfiG+InCo+e8HHWlZxFkXTeZ3A
         DU3A==
X-Gm-Message-State: APjAAAXhbfR9RvW8TnS5fcF1113FdQ6kuajYN2hwwj7p6KpWeUNyM5/O
        1JQO3jKAtqFxxsFs0ykK1nr8zTzKvzVhb+rlVdE=
X-Google-Smtp-Source: APXvYqz12E9ERNbe0Owl6aW9UcEsvjWIxeRQuaKXRdW/9JRFNbKLZmZSU1/z+/GpXtaj5bbCijeLZN/1RY+TVUbLjhs=
X-Received: by 2002:aca:c405:: with SMTP id u5mr26308973oif.77.1555452014698;
 Tue, 16 Apr 2019 15:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190416155618.1369-1-TheSven73@gmail.com> <20190416155618.1369-3-TheSven73@gmail.com>
 <4aecef30-0d64-c5f7-c4de-43b0754e2fdd@metux.net> <CAGngYiX3QP25MLupsc-=gfb6CAh5wK49eGs2xqHh_5LxrKtaAA@mail.gmail.com>
 <34a70ef9-4bb2-98f6-2344-3a0482b5cb7f@metux.net>
In-Reply-To: <34a70ef9-4bb2-98f6-2344-3a0482b5cb7f@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 16 Apr 2019 18:00:03 -0400
Message-ID: <CAGngYiUroMwErLugXeVXwHc37Nm+Bw4Tv5i1VUv8=qVcNbaSQQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] anybus-s: support HMS Anybus-S bus
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 5:02 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> But this port supports probing ?
> (so it's, bit like a single usb port w/o hub ;-))

Yes, that's exactly it.

>
> In the long run, Documentation/ IMHO would be the best place
> (at least for longer explainations).
>
> OTOH, a few more precise words in the commit message would be nice, too.

Ok, sounds like a plan.

>
> I guess that things like introducing new bus types or device classes
> are something that subsystem maintainers wanna be aware of :)
>

fieldbus_dev is a new subsystem.
At first I attempted to mainline the anybus-s drivers with a 'roll-your-own'
userspace API, but the feedback I got was: this userspace API should
really be generic... So this is my attempt to create a generic fieldbus_dev
API !

It's almost certainly insufficient, but it's a start. Ideally, this
should get lots
of review from people in the industry, but response to this patchset has
been underwhelming. That's the reason this is going into staging/.
Hopefully it will create discussion, and a way forward to a more extensive
userspace API. If not, it'll go to /dev/null after a year.
