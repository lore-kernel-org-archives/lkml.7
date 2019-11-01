Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FF7CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F5B21835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="D6/bx9Qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfKAKIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:08:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41643 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfKAKIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:08:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id o3so12262868qtj.8;
        Fri, 01 Nov 2019 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dixvlRxBe1XqqJqVc1zgKXwNqGAEbJcLWXze4Juxj/A=;
        b=D6/bx9Qt4Sz4Zl1m7/iyiTMXK4O//gXhNKiXB2chqIP3aluDGN2fva+Y6wVKBDNG0P
         Li4oORgU/Hq8vdPn77G6Hk377QzmddzW+CNPZ9pO+TM2ikk2UmEM/qXJryAK1BMRT+/f
         4kl53gQeEIhRpSQ2xOi1McdZWP5sJpnLuRBcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dixvlRxBe1XqqJqVc1zgKXwNqGAEbJcLWXze4Juxj/A=;
        b=XXZGWPBebJbuv9N3iytPGKYictHNdu8vBThWxQxklk36q6vo4c3fvECl2TVU0el6m5
         f5cjaT03wEpcGQeAGw64KFkmu8/ML+jV+N43JGoFk051prb5+CZz+3MmNaEfyX2NpanX
         Ncw4hTk/v+clYDO//wbdFS5Ubi0AP6olTIfD+W96x99Rg330AJHkCsF9wTyOnfnIzLq0
         tr90fzv8Pq77Quxl97S94GLFcOziIrkLQNOc02j1wSXHHjD8EpWSeJz96kCiEIrE/hvY
         Foz9qhsQ5PnU+IixVkbx+Qnw+5gSbE0Xj8x0+BWbCvVVGehCflxwVwYH4ypHaU2mgUt+
         cceA==
X-Gm-Message-State: APjAAAUErNBBCm3D3N7hG4RtQouHEuE5WJs2JQkzCQZM7qRjoohkz/7F
        Dg0DEI8dHqoNYHKeDcAMYTAmBHrYMx4HanO2U/M=
X-Google-Smtp-Source: APXvYqy0Z22TcpdNer9jICrspqvBdfKr5qP78g1hshmD7TQOwlJJKb1RCeY5BVLa6y96G8jOc0taqrKjoAq9DFAyCus=
X-Received: by 2002:ac8:e03:: with SMTP id a3mr9899612qti.169.1572602929835;
 Fri, 01 Nov 2019 03:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191021194820.293556-1-taoren@fb.com>
In-Reply-To: <20191021194820.293556-1-taoren@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 1 Nov 2019 10:08:35 +0000
Message-ID: <CACPK8XcNxs5T=ZC_mRnvkOF_kqS1AvP=9PvMB6w9Fgn_XbtZQw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: add dtsi for Facebook AST2500
 Network BMCs
To:     Tao Ren <taoren@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Mon, 21 Oct 2019 at 19:49, Tao Ren <taoren@fb.com> wrote:
>
> The patch series adds "facebook-netbmc-ast2500-common.dtsi" which defines
> devices that are common cross all Facebook AST2500 Network BMC platforms.
> The major purpose is to minimize duplicated device entries among Facebook
> Network BMC dts files.
>
> Patch #1 (of 4) adds "facebook-netbmc-ast2500-common.dtsi" file, and the
> remaining 3 patches update CMM, Minipack and Yamp device tree to consume
> the new dtsi file.

The patches look okay to me. I modified the file name to match the
convention used by other device trees in the arm directory, where it
includes the SOC name first.

I also reworded the commit messages a little.

They have been merged into the aspeed tree for submission to 5.5.

Thanks!

Joel

>
> Tao Ren (4):
>   ARM: dts: aspeed: add dtsi for Facebook AST2500 Network BMCs
>   ARM: dts: aspeed: cmm: include dtsi for common network BMC devices
>   ARM: dts: aspeed: minipack: include dtsi for common network BMC
>     devices
>   ARM: dts: aspeed: yamp: include dtsi for common network BMC devices
>
>  arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 66 ++++---------
>  .../boot/dts/aspeed-bmc-facebook-minipack.dts | 59 ++++--------
>  .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 62 +-----------
>  .../dts/facebook-netbmc-ast2500-common.dtsi   | 96 +++++++++++++++++++
>  4 files changed, 136 insertions(+), 147 deletions(-)
>  create mode 100644 arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi
>
> --
> 2.17.1
>
