Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D0FC388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAC422508
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="izfFFobe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfI3Ugr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:36:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43185 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfI3Ugr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:36:47 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so41810290iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3dwIE3HGnY2ji6BL2lgrdHCeKt8hwvNYITijQeMpag=;
        b=izfFFobeeAuaCN1MYV2cqTTC9SJ2B7X/u+g6CPl+hSPnOUnRbP1/BCohkPY00SKjOS
         ngbgS5eggV73d5N3fvNsmyx4AdZ9BelpEyLZgIOQWjYZ0H/t1h9hwcopTh8luMLUlkAD
         UvFLMMtPQWZq9ybp6G3XRQa3ba3kFxGlWt+PhVFEisFiy/ivTvQCpq4WDb2zRJWntAjY
         RnpfLShbUA0uQ0c6YpBTgnszBbNpKq4tSWd29vid/pr0QWpkPNtc9dlZZOHIWHtbr1I4
         64grZ5gAZJhw0mPO812L2fmFF+Kgqu62rcwu8tU01ioPJdvJ0r7FYafvOLbDi1a734kX
         h+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3dwIE3HGnY2ji6BL2lgrdHCeKt8hwvNYITijQeMpag=;
        b=VrVbWC04P1csTQZEFsYRZN3MJNreeu1qHR8ItfcY10wsk6PoxHWnyk9PfQ/NitpgfJ
         lDd/o7QNYnlcIEbk3lHRs3mBOJZz8j2cfER4cvqxsUIjwqm6CTrUaJH++3n3s+taPaAI
         E3FdbayGHvDDzKqgK0iGdRFjZdeA+YLPgnlZSuV9iEKZ8PKAPSFQUJiizeXDxMvpicw9
         vS3A07lUIWnv4n7suiAUTFDC10ODimcyG8bLwYaIfc2XFK6UkIixE5QqJn8qnjtKQOMR
         iO0majDPzRdk4IA3qym1+TMf8qdGUyCVMTFIV/6a4OfrEFz2u1NxEDl3oc4TDde7aVyK
         BBnQ==
X-Gm-Message-State: APjAAAVAsSdR2oTZt3KNY94qzBzijNb/yjWVeJJ6NAy0/WPmnqH56J0E
        qB9CPsLOM8hnR1DBebeQv7mV8IRrWSS9Mg26IsNLgIBi90zw3w==
X-Google-Smtp-Source: APXvYqyXj8WDjHDG8Ly151dv7OzUri8sYlz4HJQ8uFbvR+QF/bAefpHZooDpQz+OMMR2j4tK+jKhsia3WuUY762LNpQ=
X-Received: by 2002:a92:4799:: with SMTP id e25mr22126652ilk.72.1569864912988;
 Mon, 30 Sep 2019 10:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190911183632.4317-1-krzk@kernel.org> <CAK8P3a2pBV+fh0rHitZ30Zz61QNRLfNSD-nhnzq4ZtxSh66F1Q@mail.gmail.com>
 <CAJKOXPcOSvc2DfoN+7Tca=t5dSm3RcKqmm06AfR0PAVBeY=GvQ@mail.gmail.com>
 <20190929175134.fsieffurfdiqhpj2@localhost> <20190930080217.GA23709@pi3>
In-Reply-To: <20190930080217.GA23709@pi3>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 30 Sep 2019 10:35:01 -0700
Message-ID: <CAOesGMi2w9vci+kU=WFHJJBqgz9BM5RJBzqwwrR7k=275w4Tyg@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] arm64: dts: exynos: Pull for v5.4
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
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

On Mon, Sep 30, 2019 at 1:02 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sun, Sep 29, 2019 at 10:51:34AM -0700, Olof Johansson wrote:
> > Hi,
> >
> > On Thu, Sep 12, 2019 at 08:32:47AM +0200, Krzysztof Kozlowski wrote:
> > > On Wed, 11 Sep 2019 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Wed, Sep 11, 2019 at 8:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Unfortunately the patches were applied right after closing the linux-next.
> > > >
> > > > Hi Krzysztof,
> > > >
> > > > I took a look at these and am not convinced this is right:
> > > >
> > > > > 1. Fix boot of Exynos7 due to wrong address/size of memory node,
> > > >
> > > > The current state is clearly broken and a fix is needed, but
> > > > I'm not sure this is the right fix. Why do you have 32-bit physical
> > > > addressing on a 64-bit chip? I looked at commit ef72171b3621
> > > > that introduced it, and it seems it would be better to just
> > > > revert back to 64-bit addresses.
> > >
> > > We discussed with Marek Szyprowski that either we can go back to
> > > 64-bit addressing or stick to 32. There are not known boards with more
> > > than 4 GB of RAM so from this point of view the choice was irrelevant.
> > > At the end of discussion I mentioned to stick with other arm64 boards
> > > (although not all), so revert to have 64 bit address... but Marek
> > > chosen differently. Since you ask, let's go back with revert.
> > >
> > > >
> > > > > 2. Move GPU under /soc node,
> > > >
> > > > No problem
> > > >
> > > > > 3. Minor cleanup of #address-cells.
> > > >
> > > > IIRC, an interrupt-controller is required to have a #address-cells
> > > > property, even if that is normally zero. I don't remember the
> > > > details, but the gic binding lists it as mandatory, and I think
> > > > the PCI interrupt-map relies on it. I would just drop this patch.
> > >
> > > Indeed, binding requires both address and size cells. I'll drop it.
> >
> > Looking through the history of pending material, I didn't see a new pull for
> > this material. Just checking in to see if there's something we missed?
>
> No, it's me who forgot to resend. I was sure that I rebased the branch
> and created new pull request. However it seems I did not. Let's keep it
> for next merge window... v5.4-rc should be any minute, I guess?

Yeah, we're too late for this merge window but feel free to send it
for next release.


-Olof
