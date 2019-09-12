Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C2C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42149208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568280968;
	bh=o907g5ReEliliHp1jD4CGBcMPQ67MvCxuOBHbk2SLo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c6ncLz6rjj9vglupp+sROvVtAz2+hHsmI0EdS2ikU62nYleWn5c3GQcUZs0kWOcvU
	 TVvzMJMBUBrG4QPeTY28+imfYXP1sTQ3HI9i2a8TtbKCszh6KPS7891kCh2Hn9hNCe
	 1MpeGigjDye7pecz+1vWmn2pGD4RdYTrIci0vEfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfILJgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbfILJgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:36:06 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B74E214AE;
        Thu, 12 Sep 2019 09:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568280965;
        bh=o907g5ReEliliHp1jD4CGBcMPQ67MvCxuOBHbk2SLo8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o1xGloPCicmW15KwhTZntnYk9UgcnskLW5PH/c/xxbRhKaLacFzc8CvB2J+0DQrRc
         DmH0vr4s84gZGWW7v/kFNjEwG6hvRU2NYJ+PK/IKjPrj+w8caQZ0FzqV6Y9hU3WSXS
         YX4shUuhOadTXh3H+dc6BQoY5GIQkNJIEmZn7Wi8=
Received: by mail-lf1-f49.google.com with SMTP id u3so3654681lfl.10;
        Thu, 12 Sep 2019 02:36:04 -0700 (PDT)
X-Gm-Message-State: APjAAAV/ySBJw6q+9AoSlv7T/95l/EuCgXsOf075O1RUCTefc8OqRXX+
        LdjfnfgQVoAodqRaGT9KAGtPFZsyxd5H1TY5pws=
X-Google-Smtp-Source: APXvYqzNtU0oOWZlIguKWNCiRl9oM+J21geYpRmVzSkBE7O4GULM3ap8wAEl5NWM9fgFCw9iRpQV6IrRFR1+xbj1uWc=
X-Received: by 2002:ac2:43b8:: with SMTP id t24mr8235535lfl.24.1568280963225;
 Thu, 12 Sep 2019 02:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190911183632.4317-1-krzk@kernel.org> <CAK8P3a2pBV+fh0rHitZ30Zz61QNRLfNSD-nhnzq4ZtxSh66F1Q@mail.gmail.com>
 <CAJKOXPcOSvc2DfoN+7Tca=t5dSm3RcKqmm06AfR0PAVBeY=GvQ@mail.gmail.com>
In-Reply-To: <CAJKOXPcOSvc2DfoN+7Tca=t5dSm3RcKqmm06AfR0PAVBeY=GvQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 12 Sep 2019 11:35:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcF_NVeyR7cRnq-6obi39MocA0aRGUn_9aExjBy0VXkWw@mail.gmail.com>
Message-ID: <CAJKOXPcF_NVeyR7cRnq-6obi39MocA0aRGUn_9aExjBy0VXkWw@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] arm64: dts: exynos: Pull for v5.4
To:     Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019 at 08:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 11 Sep 2019 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Sep 11, 2019 at 8:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > Unfortunately the patches were applied right after closing the linux-next.
> >
> > Hi Krzysztof,
> >
> > I took a look at these and am not convinced this is right:
> >
> > > 1. Fix boot of Exynos7 due to wrong address/size of memory node,
> >
> > The current state is clearly broken and a fix is needed, but
> > I'm not sure this is the right fix. Why do you have 32-bit physical
> > addressing on a 64-bit chip? I looked at commit ef72171b3621
> > that introduced it, and it seems it would be better to just
> > revert back to 64-bit addresses.
>
> We discussed with Marek Szyprowski that either we can go back to
> 64-bit addressing or stick to 32. There are not known boards with more
> than 4 GB of RAM so from this point of view the choice was irrelevant.
> At the end of discussion I mentioned to stick with other arm64 boards
> (although not all), so revert to have 64 bit address... but Marek
> chosen differently. Since you ask, let's go back with revert.
>
> >
> > > 2. Move GPU under /soc node,
> >
> > No problem
> >
> > > 3. Minor cleanup of #address-cells.
> >
> > IIRC, an interrupt-controller is required to have a #address-cells
> > property, even if that is normally zero. I don't remember the
> > details, but the gic binding lists it as mandatory, and I think
> > the PCI interrupt-map relies on it. I would just drop this patch.
>
> Indeed, binding requires both address and size cells. I'll drop it.

Short update: no, address-cells are not required by bindings. They are
optional. In case of lack of them, the parent address-cells will be
used so effectively this patch was changing it from 0 to 1. Anyway
this was not expressed in commit msg so I'll drop it.

Best regards,
Krzysztof
