Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1069C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588E20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567586247;
	bh=hoAius6REhdbGBpQkFZpk5CeOOmO3Yn/3gIEtQoNWWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jaoDXT9DQ9/FFDOlzfIbupWnVLVK8LWuKXK52tjOk9xaeO8IoFa1aRg/OO0rp2K0L
	 fKm4iRaa5y4G1Zixk5M3F6idiVEBHPeqPBvkhGUuw+rGAOPD+pFQdz3dhDWR7daDqs
	 0ZYTUaiwzUMpZiJB1cttc+nVXvT6VjGfELMOjqAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfIDIh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfIDIh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:37:26 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9440823400;
        Wed,  4 Sep 2019 08:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567586244;
        bh=hoAius6REhdbGBpQkFZpk5CeOOmO3Yn/3gIEtQoNWWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m8/PRsxKuktjjE9T7/5NZ0LBzGps6QBKzHzUtzjZnjv5htkPdHVQh8+sFQbJXM+oV
         wJ9auiMz/imRsYyTJZzMVOUpYLK52y7ldef2H7SbULXf2DGzZeSjMAiHGgkwtzOxk2
         m2m2Wt89goHMOd58PZStIh0ngFEFvAtWbIeFgFKk=
Received: by mail-lf1-f41.google.com with SMTP id j4so15186608lfh.8;
        Wed, 04 Sep 2019 01:37:24 -0700 (PDT)
X-Gm-Message-State: APjAAAXK37eov+qy74V/wuO7vUpgxIpcxH/ci7iiVqbfFdkRR4dTilma
        p1SPmJI10/HsqXYfksUkBNJaHVQr0TsCjMkPKCI=
X-Google-Smtp-Source: APXvYqynl8t4zpgSOSPhgXGm6urGPD6YD5RT2LviyIZz5LcMF3/ZNtjnIiHi6xBSeCZLQGGW5B0TO2IWt+JPxz/llZY=
X-Received: by 2002:ac2:4853:: with SMTP id 19mr16484011lfy.69.1567586242704;
 Wed, 04 Sep 2019 01:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190816163042.6604-1-krzk@kernel.org> <CAJKOXPcgZ2_ofZyAeTSxALkALaP-SFNfvNmNPYSPyLzuhpGZ0w@mail.gmail.com>
 <20190822183519.GA23735@kozik-lap> <CAK8P3a1_Qw=OB31yOCrpPs8Ys+=9tt4Pnyd=3+2JGzRXJV1KAw@mail.gmail.com>
In-Reply-To: <CAK8P3a1_Qw=OB31yOCrpPs8Ys+=9tt4Pnyd=3+2JGzRXJV1KAw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Sep 2019 10:37:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfRMXkm_pT560Ry5k-zFWpkRDmFHSs2Fb3RL7d4h=ka9g@mail.gmail.com>
Message-ID: <CAJKOXPfRMXkm_pT560Ry5k-zFWpkRDmFHSs2Fb3RL7d4h=ka9g@mail.gmail.com>
Subject: Re: [GIT PULL 1/3] soc: samsung: Exynos for v5.4
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 at 19:21, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 22, 2019 at 8:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Wed, Aug 21, 2019 at 09:51:09AM +0200, Krzysztof Kozlowski wrote:
> > > On Fri, 16 Aug 2019 at 18:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> > > >
> > > >   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-5.4
> > > >
> > > > for you to fetch changes up to 40d8aff614f71ab3cab20785b4f213e3802d4e87:
> > > >
> > > >   soc: samsung: chipid: Convert exynos-chipid driver to use the regmap API (2019-08-15 20:25:25 +0200)
> > > >
> > > > ----------------------------------------------------------------
> > > > Samsung soc drivers changes for v5.4
> > > >
> > > > Add Exynos Chipid driver for identification of product IDs and SoC
> > > > revisions.  The driver also exposes chipid regmap, later to be used by
> > > > Exynos Adaptive Supply Voltage driver (adjusting voltages to different
> > > > revisions of same SoC).
> > >
> > > It turns out that it brings troubles (code is executed on every
> > > platform polluting logs because it is an initcall, not a driver) so
> > > Sylwester (submitter) asked to skip the submission.
> > >
> > > Please ignore the pull request.
> >
> > I talked with Sylwester and Bartlomiej who contributed the chipid driver
> > and they provided small incremental fixes. The driver is still useful
> > and in the future it will be expanded towards AVS. Therefore please pull
> > it or optionally wait a week and I will send incremental pull request
> > with fixes.
>
> Pulled into arm/drivers for now.
>
> I have drafted a related patch recently, regarding the related
> arch/arm/plat-samsung/cpu.c file. This is part of a longer series
> I'm working on, see https://pastebin.com/ZqeU3Mth for the
> current version of this patch.

You can then also adjust the include path in arch/arm/mach-exynos/Makefile.

> The observation is that mach-exynos
> is almost completely independent of plat-samsung these days, and my
> patch removes the last obstacle from separating the two. I have
> another set of patches to do the same for mach-s5pv210 (which shares
> half of its pm.c with plat-samsung, but nothing else).

Great!

Best regards,
Krzysztof
