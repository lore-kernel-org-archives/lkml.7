Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B6C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12761216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPWgBS+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfETV41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:56:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36543 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfETV41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:56:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id z1so13942617ljb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQ4KeHf0p+vNIrYYtj0hF0egs+JpVxpzz0DY2WetVec=;
        b=NPWgBS+H1DcqLncApEZaEOk1dHll5azPVd0ixXvpRlmFqlMhfZmz304tqIbdMwA8yg
         uVjba8+qaqevsdzt7R5gnbFe5bs3+xpBww/L9XUehLWmm6d7/sXWHd977uKFWKzOMCkH
         kHshbhnNfTMIPrUdjZ/mhIpg0w2QHKsJFeRYrZaVK6e32ZLSbteQyEE9rjEAowwA+t1s
         Mug/Oj3QBV0ec/3kt3dG+jtzXbu9ljXxc46/GtS2jVOPh5G0FAgY7FtZMY+vcPXDAHry
         fDM/qEBVQ6/vbsxVbLR1uPYr56Dd6uT1B0EPPVxU0NipQ8AHcsnUB7rgmbngMee1gvTl
         p2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQ4KeHf0p+vNIrYYtj0hF0egs+JpVxpzz0DY2WetVec=;
        b=PJ3Td02LliAoFhhMDPO3mFACDBkLPss/vzCh75D0NxkaOExocSkCyzs6oTY3/fo0HS
         d55d8EKqHbgQpsyeuiCrbllVtZFkhDSC0NeDyvrUV8BLsIoVaLUKA8sD0cBi4x+wt0Tr
         E4jSvqaisxivqA1IEzS8mJSuuOlNRT5piKbLtUqlBzfeVhD58oRDrsbOelbTh1oQue7U
         Zh11jXwIxC9SbRbjMe5mjRYQcuQsSIczpZpywnQoTBTjhjsIaQz+BhW6Du/QOaT0K+AO
         QE0zxZ30XkbSlp3zmY/wp8w3Mn0Xl93wmNoPZJgETHBYV36mx7FON2gppV9aniBGBSob
         q87Q==
X-Gm-Message-State: APjAAAVE+zo67NJ5ViUTKiRinAelujLpaqdv6+ekREiPSCXbqgM3uUca
        IbBuPoNuRV03JQHsWsnahrmKBaI6bqODbowWcgfZRwRRbCk=
X-Google-Smtp-Source: APXvYqxh21iCFOO2IrTWYQZAbtOsCc3tfRmM9ybuXFfyKPTB0poOeDnP4yUUl0wxpBYSTa8u6LEnFRbCQmfyOjYiaXE=
X-Received: by 2002:a2e:9192:: with SMTP id f18mr26205190ljg.112.1558389384826;
 Mon, 20 May 2019 14:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190516064304.24057-1-olof@lixom.net> <20190516064304.24057-2-olof@lixom.net>
 <CAHk-=wj7uZ+rLecwEP+U3jRRPWRoB1QVTr8pHzTcmQadE=Ngvg@mail.gmail.com>
 <CAK8P3a27zgq3c_iWHVfypAc-hLag06Bs=Q2D7bn4i4nVfPQSyw@mail.gmail.com> <CAOesGMgQ9kF08PDzA3LSjsXt-ETB8vAnqo2EjtbKEMJ5UrnJnw@mail.gmail.com>
In-Reply-To: <CAOesGMgQ9kF08PDzA3LSjsXt-ETB8vAnqo2EjtbKEMJ5UrnJnw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 May 2019 23:56:13 +0200
Message-ID: <CACRpkdYBYHSgc_WRcCHobSCrLu0nN-Y9i=j7PFKtAPA9PbTwmQ@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ARM SoC <arm@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 7:10 PM Olof Johansson <olof@lixom.net> wrote:
> On Thu, May 16, 2019 at 8:53 AM Arnd Bergmann <arnd@arndb.de> wrote:

> > > I'm going to remove that #ifdef in my merge, because I do *not* want
> > > to see new warnings, and it doesn't seem to make any sense.
> > >
> > > Maybe that's the wrong resolution, please holler and let me know if
> > > you want something else.
> >
> > As far as I can tell, that is the best fix, thanks for the cleanup!
>
> Yeah, this was entirely on me -- it was found and fixed on linux-next,
> and Linus Walleij sent patches. However, as I was staging these pull
> requests, I applied them to a branch of fixes that I'm collecting for
> later this week instead of on top of the one I was sending.
>
> Thanks for fixing it up.

Oh well Linus wrote the bug and then Linus fixed it and then Linus
fixed it.

What is good to know is that no matter which Linus you use, you will
always get the right fix.

Yours,
Linus Walleij
