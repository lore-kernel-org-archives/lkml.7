Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25752C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE05F20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgABRLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:11:45 -0500
Received: from muru.com ([72.249.23.125]:49906 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgABRLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:11:44 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8FFFE8087;
        Thu,  2 Jan 2020 17:12:24 +0000 (UTC)
Date:   Thu, 2 Jan 2020 09:11:40 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pavel Machek <pavel@ucw.cz>, Olof Johansson <olof@lixom.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        Marcel Partap <mpartap@gmx.net>, merlijn@wizzup.org,
        martin_rysavy@centrum.cz
Subject: Re: Droid 4 regression in 5.5-rc1, armsoc-soc tree
Message-ID: <20200102171140.GB16702@atomide.com>
References: <20191228162929.GA29269@duo.ucw.cz>
 <20191228193622.GA13047@duo.ucw.cz>
 <20191230173507.GM35479@atomide.com>
 <20200102110025.GA29035@amd>
 <CAK8P3a2Ya+GZRRA_THZBVDq7SWO8UYoUPwW5fEyorCVjPnd1qA@mail.gmail.com>
 <20200102140609.7vsfwcjyvbbrmcjx@ucw.cz>
 <CAK8P3a1NU62zf8zJAMZq5KFNuvDdrf3dUcLU4HY83Q=oDC611w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1NU62zf8zJAMZq5KFNuvDdrf3dUcLU4HY83Q=oDC611w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [200102 14:48]:
> On Thu, Jan 2, 2020 at 3:06 PM Pavel Machek <pavel@ucw.cz> wrote:
> 
> > # good: [ab818f0999dc73af3f966194d087e9f6650f939f] Merge tag
> > # 'omap-for-v5.5/maintainers-signed' of
> > # git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
> > # arm/soc
> > git bisect good ab818f0999dc73af3f966194d087e9f6650f939f
> > # first bad commit: [38206c24ab09b4f4c2a57de5c1af0bb2e69cf5b6] Merge tag
> > # 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> >
> > ...and am not sure how to interpret the result, or what to do next :(.
> 
> This means that either the bisection is unreliable (it might be 100%
> reproducible or you mixed up good/bad once), or that the arm-soc
> branch was indeed good by itself but had a conflict with some other
> change that torvalds merged earlier.
> 
> I would suggest to go back to the list I had extracted in my previous
> email and revert all the commits that I identify there, on top of
> linux-5.5-rc4. If some commit is not easily reverted, skip that one
> at first.
> 
> Ideally this gets you a working kernel based on -rc4, and then
> you can bisect that to find which revert fixed it.

Also please check your dtb is up to date. We still have a lot of
stuff missing from the device tree meaning an old dtb will likely
be incomplete for many devices.

Regards,

Tony
