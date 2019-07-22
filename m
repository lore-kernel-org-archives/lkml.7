Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F95DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EFD2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGVHYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:24:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42337 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfGVHYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:24:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so27852015qkm.9;
        Mon, 22 Jul 2019 00:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+4pxoZrWgO5E8eTqf7t3xt/WeKLRxeau7aUPE4BCe4=;
        b=UQHD4PT73y7CX6SeT7wIK2WSKXlKehOyVQC7lIbJFoYsHVLaukfQzxZVu/sEs+z9U8
         VRTr+MlmpfElaXZZddoRiMXxLCZ5raWlXXEHSihHUQBwzB4pGzy0Q9sIvemtSTBcGia0
         NWxLVmKd09C3tLBpf8IhGGAlZGT6HGpMea3Hwoq4g3C8vnJB4frPwncYiUNhtWncc9Ly
         Zh4d+WrCmXdI1QIidLxqXirs8mWlVmCVK2y535u968j6OX4ZAvIAtLuPYIsr/uC3EDTD
         GooOdHv20SjTymm1svB9H9IVpepqAhenprIRMPxMqnV3H280aupFVqSognUavxXgruA4
         eDYw==
X-Gm-Message-State: APjAAAUPHrr9/nc/gdGWc1IlZYaNK3u9zQ8uAaxJpGL+5eUorQECi0lV
        v3mYIIl9xwP2QPrB14aMYHzWCKWHeNP+k/Wx5sQBIiD+YY4=
X-Google-Smtp-Source: APXvYqxria+TrhASVX7JnFTBLLrsJIrFZPKswd2aHs4vuFuWi4KkslOspEiVk06cPQF313P9HDkUKcmYFrO0uZfczMk=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr11642591qki.352.1563780272040;
 Mon, 22 Jul 2019 00:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
 <CAK8P3a2AeUpmNfFLJSvHT=AJ0kFRT2B=TWDm0HsTwoHt2jQ0gQ@mail.gmail.com>
 <CAK7LNATPbCjwzVnAigsQ8tQRXjC31uxgPg3jgi7pwp+N1RPgWw@mail.gmail.com>
 <CAK8P3a3cURmbGZc-6ESLjrF465VLnBroD4QENyfsSsCrNenRrA@mail.gmail.com>
 <CAK7LNARN=iNmresDJ2=J1wOb2QYoZ7yw4O0Q9sYVPo0jRKDf=w@mail.gmail.com>
 <CAK8P3a133ekPqkLWfC2ee0mT3iLbFzSjJ9FDokSyaX+hMVigKA@mail.gmail.com> <21af683a-a188-7aa9-9c82-98c02b8717f8@metux.net>
In-Reply-To: <21af683a-a188-7aa9-9c82-98c02b8717f8@metux.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 09:24:15 +0200
Message-ID: <CAK8P3a35jUoK0zSXoJ9HDxSpvuUCRFos97tnjQWc9ERxwZ6y+Q@mail.gmail.com>
Subject: Re: [Question] orphan platform data header
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 8:46 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 21.07.19 16:15, Arnd Bergmann wrote:
>
> > That is different: the hardware attaches to a serial port and may well
> > be usable, and the user space side just contains a copy of the header,
> > see https://github.com/nwdigitalradio/ax25-tools/tree/master/yamdrv
>
> I believe that such header copies in userland applications are
> conceptionally wrong. Whenever something changes, both sides need
> to be kept in sync.
>
> Maybe we should talk to the hamradio folks to get this cleaned up.
> IMHO, this header should go to uapi.

Having copies of driver specific uapi headers is rather common,
and you won't have much success trying to get everyone to change
that.

The reasons why those applications do it are:

- The kernel already gives ABI guarantees so anything built with an
   old header file is expected to keep working indefinitely.
- Using a new header file won't help unless the application also
   knows about the added interfaces
- If an application uses more recent additions to the kernel headers,
  it either has to have a matching version of that header, or use a long
  series of #ifdef checks to deal with arbitrary versions.

> > It seems more useful to keep looking for drivers with a platform_data
> > header file that is no longer included by any platform for candidates
> > that may be obsolete.
>
> Some folks see platform_data old legacy that should be removed, but I
> don't aggree. For example w/ apu2 board driver (and corresponding
> amd-fch-gpio driver) I even had to introduce a pdata struct, so the
> board driver could configure the gpio driver.

The case that we are interested in is drivers that previously used
platform data in legacy board files that have since been replaced
with dtb based boots.

> Certainly, I would have
> preferred doing everything via DT, but that's not available on x86/acpi
> targets (if anybody knows a way to inject a DT snippet just for one
> driver in such a scenario, please let me know).

It's been done before, but usually with overlays that don't necessarily
make it any better than platform data. If you have a set of drivers where
one of them creates a platform device for the other driver, then platform
data is usually the easiest way, and I'm not aware of any move to
get rid of that.

As an alternative, you can use the generalized property support
from include/linux/property.h that works on top of DT, ACPI or
plain platform devices.

        Arnd
