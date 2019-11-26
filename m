Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3885C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC932071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574731303;
	bh=e7359V1WvyvcBQg5ikrLHwOABGhZa5YKZhU8/BE3aQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QygQOiIw0Z8uhvw89KYjyyrE5c87lQT8+mClquACb5NlQsstPWXmQXptYqLO6MA1N
	 tOdzjBCSKYxJ7Mvxwlmg4RQQMLKD9ryBGUcECdhZwHFEQ6a+UW2MZGPY75dbNTTGUs
	 G9gMaDO+TwR6ywgNpSDeF8s0K9pcn9RkTA3Kz+fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKZBVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfKZBVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 20:21:42 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4122071E;
        Tue, 26 Nov 2019 01:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574731301;
        bh=e7359V1WvyvcBQg5ikrLHwOABGhZa5YKZhU8/BE3aQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TE4m1oxmJmtlpVBG2eV6GOyAZ2V6quFqvt6pOhdOEYr32QdTwJexQbOxOmgYOCByU
         R7Z0hJ1VD+Xmr3oKXp/OEVQMM57EbnFPmu7K6n9eF2UbnZ32Wa3EYsRowzF1Avsgkw
         j5HFzPpeOdf0LPymBsSvvhJL/WrZU6IkpUg8Bdkw=
Received: by mail-lf1-f43.google.com with SMTP id b20so12618172lfp.4;
        Mon, 25 Nov 2019 17:21:40 -0800 (PST)
X-Gm-Message-State: APjAAAUeNHVvsyZ/b8Jb0i5H8NKsTAr851BntrLlgGQnhVr20STqxaq6
        uq016jjCRlAVrJmrOdxeuJvAZJIHNwRXHrDIAk0=
X-Google-Smtp-Source: APXvYqzjm0lHW/dFvML+RlZZjEu7Rk6hAz7NCz+1OhCEN70pKaWUsjUhF/xxKAAoAZzcpU4p6wW3pniZS2DRGdBKHuI=
X-Received: by 2002:ac2:5228:: with SMTP id i8mr22194773lfl.69.1574731298851;
 Mon, 25 Nov 2019 17:21:38 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191125125531eucas1p17f4044301903eeafe56865ed63738798@eucas1p1.samsung.com>
 <20191125125515.30795-1-m.szyprowski@samsung.com> <7f6a5924-58f9-aafb-18c5-c749ad355a02@samsung.com>
 <20191125093932.4a111dc8@gandalf.local.home> <5fdca7d0-c130-457a-2ce2-74f645b60f8d@samsung.com>
In-Reply-To: <5fdca7d0-c130-457a-2ce2-74f645b60f8d@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 26 Nov 2019 09:21:27 +0800
X-Gmail-Original-Message-ID: <CAJKOXPept5Po3UDfLWCTYEupiip-Y6ZXtdaOGTQd8K-6m11DbA@mail.gmail.com>
Message-ID: <CAJKOXPept5Po3UDfLWCTYEupiip-Y6ZXtdaOGTQd8K-6m11DbA@mail.gmail.com>
Subject: Re: [PATCH] arm: exynos_config: Restore debugfs support
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 at 23:31, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 11/25/19 3:39 PM, Steven Rostedt wrote:
> > On Mon, 25 Nov 2019 15:30:39 +0100
> > Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:
> >
> >> It seems that commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_=
FS
> >> dependency") disabled DEBUG_FS also in some other ARM defconfigs.
> >>
> >> For some of them it may be a correct change but a preferred way to
> >> introduce such changes would be to:
> >>
> >> - add explicit CONFIG_DEBUG_FS=3Dy instances to all affected defconfig=
s
> >>   while removing DEBUG_FS selection from TRACING config item
> >>
> >
> > I strongly disagree. It was wrong to assume DEBUG_FS is attached to
> > TRACING. If someone wanted DEBUG_FS in their def config, they should
> > have added it specifically. The addition of DEBUG_FS to defconfigs no
>
> There is a theory and a practice.
>
> In theory you are are correct. ;-)
>
> In practice people don't manually edit configuration files nowadays.
>
> They do 'make menuconfig' and enable what they need and disable what
> they do not need.  Then they do 'make savedefconfig' and copy resulting
> "stripped" defconfig file as their new platform defconfig. As a result
> defconfigs rely on many default settings (also they explicitly disable
> only items that are enabled by default but you don't want them).

I agree with Bart=C5=82omiej. Your interpretation Steven essentially
prohibits any use of savedefconfig to trim automatically the config
from unneeded options. Therefore many defconfigs which do not have
DEBUG_FS or other options directly, but they want it.

Some time ago I had patches removing specific non-existing options
from defconfigs. For each option I provided a rationale that it is
gone/etc so let's remove it from defconfig. Most of maintainers picked
them up but few (2-3?) instead run savedefconfig to clean up
everything automatically.

Best regards,
Krzysztof
