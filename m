Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C490C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1823216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566314337;
	bh=4g2+aX3eD3+4CJWSIyuirqp/mSdK6BbK4d0vGYiQL8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=st740erteLE73j57sKCM4L/SUQWV5vAs54ihDjzvkil6mSgO9LoeGk59wwgUHBqXl
	 Nnk9z8s8VHg1RSrU2Tvy8SRBm5HT1Ymawr3jtEluQpFgFAvHPSbk8qB4wc1XstGPC6
	 jsXm3vxYAj+JT4WUS2qwb/FlxG3MiRUJ3ozKt12g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfHTPS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfHTPSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:18:55 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291B822DD6;
        Tue, 20 Aug 2019 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566314334;
        bh=4g2+aX3eD3+4CJWSIyuirqp/mSdK6BbK4d0vGYiQL8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jje+bS2QRZhlNrEMcmQpztZthSiK/BSOgxTaupyUDC+ZiTGcIUrG5cubMWCYgal75
         ffqLLHv31yuz//Q/cTmfwCSzmP9NelQ58qQ2lTRYSq617kHwBZ64w1k5UYIIHXkVef
         fcxY70lDBKvx0czPwITE5ZAfiSjKYpGwdLqKrSAI=
Received: by mail-qt1-f182.google.com with SMTP id q4so6447804qtp.1;
        Tue, 20 Aug 2019 08:18:54 -0700 (PDT)
X-Gm-Message-State: APjAAAV0vDJH0Zu0npL+OXoxSW00tLdAnQNbbATy7WDJT/GGdl9qzpz2
        cNqI8+jsfmhn4BKBtVhrwv37iC8mDihADnDHGg==
X-Google-Smtp-Source: APXvYqwI8MbWsEoN6+B2x3wldzD/RbdVhOKqOd44O2Pi9UjWB8xzwz+yQBkw84t97EUZBfi7kdvPeR7mgfUNMe3lawQ=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr26470061qtc.143.1566314333309;
 Tue, 20 Aug 2019 08:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190806192654.138605-1-saravanak@google.com> <20190806192654.138605-2-saravanak@google.com>
 <CAL_Jsq+BwHSj1XUNp_eY362XnNoOqVTNHqAkvnbgece8ZQE3Qw@mail.gmail.com>
 <CAGETcx8+EETv6nSu+BEBStKvbmBs+tZZgo1u_Pw8SNu+7Urq1Q@mail.gmail.com>
 <CAL_JsqLdcn5aZdenLs3RSVCOE1PRNK_qYNmQR=fXPV+ZOQ9+PQ@mail.gmail.com> <CAGETcx8K2Ob7f7wchP6Z7Y=XGgX3h535ty62x6b-13-giGyZgA@mail.gmail.com>
In-Reply-To: <CAGETcx8K2Ob7f7wchP6Z7Y=XGgX3h535ty62x6b-13-giGyZgA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 10:18:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLdh41o2cQfG=spa_1HkPUgeyvVm2r0f=5OZiGP6Fw29g@mail.gmail.com>
Message-ID: <CAL_JsqLdh41o2cQfG=spa_1HkPUgeyvVm2r0f=5OZiGP6Fw29g@mail.gmail.com>
Subject: Re: [PATCH 2/2] of/platform: Disable generic device linking code for PowerPC
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 9:04 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Aug 14, 2019 at 4:41 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Aug 6, 2019 at 4:04 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Tue, Aug 6, 2019 at 2:27 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Tue, Aug 6, 2019 at 1:27 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > PowerPC platforms don't use the generic of/platform code to populate the
> > > > > devices from DT.
> > > >
> > > > Yes, they do.
> > >
> > > No they don't. My wording could be better, but they don't use
> > > of_platform_default_populate_init()
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/platform.c#n511
> >
> > Right, but the rest of the of/platform code is used (guess where it
> > got moved here from?).
> >
> > > > > Therefore the generic device linking code is never used
> > > > > in PowerPC.  Compile it out to avoid warning about unused functions.
> > > >
> > > > I'd prefer this get disabled on PPC using 'if (IS_ENABLED(CONFIG_PPC))
> > > > return' rather than #ifdefs.
> > >
> > > I'm just moving the existing ifndef some lines above. I don't want to
> > > go change existing #ifndef in this patch. Maybe that should be a
> > > separate patch series that goes and fixes all such code in drivers/of/
> > > or driver/
> >
> > So the initcall was originally just supposed to call
> > of_platform_default_populate(), but it's grown beyond that. That could
> > make things fragile as it is possible for platforms to call
> > of_platform_populate() (directly or indirectly) before
> > of_platform_default_populate_init(). That was supposed to work, but
> > now I think it's getting more fragile.
>
> Can you clarify what's wrong with of_platfrom_populate() being called
> before of_platform_default_populate_init()? If that's what a platform
> wants to do, they can do it? I have some thoughts of my own, but I
> want to hear yours.

Really, I'd like to get rid of platforms doing their own calls. That's
mostly an arm32 issue. Most of what's left are either platforms using
auxdata which was supposed to be a transition thing or ones that set a
parent device (soc_device). The former takes work to finish converting
platforms to DT and I don't know what to do for the latter other than
always or never set a parent device. Also, I know there's an issue on
atmel where we can't remove their of_platform_populate call because it
changes the probe order and breaks their pinctrl and gpio driver (I
started a patch for that...).

Rob
