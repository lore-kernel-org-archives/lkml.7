Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1ADC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E912147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="UWe7teRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfD2RNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:13:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35521 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfD2RNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:13:01 -0400
Received: by mail-it1-f196.google.com with SMTP id w15so231089itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25fiyi7j1Bbc8JQlGA4N04qFKyRP6T12Pl+h/G3rDyI=;
        b=UWe7teRVNHnVVVX7AxpBK7ppMB7htmVYCLs2maddnhAQN3s3CmuabCZeOMH8mGI/+6
         /JAfjgHvCS2HhFocaMlJd0BXxYtS9navSccjbvY6qbHBMMr4XEP05Vux6hRDc7FRqF9t
         kiOiH9k0iz1UZcROEN79XDk6Y4qZ4lS4HzZB2oSvWSi83Rn8F2YFkjGPBu66JMg3b00L
         7fc+GysM/pjBsAmOQm4Bn8C/JvFBndEdO1r5YjJ9N0VM9tkAqjSOPKtK1qzYDc9iIoYW
         FuK/BnRIigm4/uC2qkKopwb616CzVTL2ueBStfTT9+WDc3wTMj6WBvJkt9HrY9wm4l1G
         xNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25fiyi7j1Bbc8JQlGA4N04qFKyRP6T12Pl+h/G3rDyI=;
        b=qXSooUE+hqr/eANWAyVduGmk2mDV3n+f8ktmdlD6DHAnVgZc49SbRMADedXlEFTDYE
         KI/We1VkMIY4VjprCuEn5v56K4f4XsNzZ/vp/rz1osWGo7X6IcLuL3cMu3i9ZMwdJR6o
         In3WKnvamvpPOJy3hY/HcidqtNV9uSABM9LsvQMS/MTZ7/Q9J9d7WrYl5wtFEkZWWi5m
         RyKTlJ+SCSxapWgfOuAADduINiGyp/s5hihBhxDv4JD2KqxVi53mQxJwsUTVK7ftIqiZ
         cGwVCQXumXaRdgtN5NK3AQhhkbaxf2Q16YqEg2sUzEJ1ORhHULdCMez6JAWJ17u6ieqb
         eEMw==
X-Gm-Message-State: APjAAAXXNVyxgi+JUKTJ27RF3Kg5Y16pIG8i/QgFWkT3jbFE61+YB0Ra
        Gp+UwWBdEC8qaFF6RdcN3OXtvUivMTcezwbKn5G3VQ==
X-Google-Smtp-Source: APXvYqweY4l9yaoGv4MZCSEVnHgtdmzETHUyk5nS1Ww7LwbZsUOtMDtCJk63xjgrLfehIEYLnqh+/O9ZQ0ZLjkXKcqk=
X-Received: by 2002:a24:58c:: with SMTP id 134mr87853itl.103.1556557980790;
 Mon, 29 Apr 2019 10:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <20190429165137.mwj4ehhwerunbef4@localhost>
In-Reply-To: <20190429165137.mwj4ehhwerunbef4@localhost>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 29 Apr 2019 10:12:48 -0700
Message-ID: <CAOesGMg49z4Gip-bLK-h7+LSLa4Fu68r11gT2EV8E8xMCPGDxg@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:08 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Apr 25, 2019 at 07:25:49PM +0200, Greg KH wrote:
> > On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > > >
> > > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > > >
> > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > currently present into this folder.  These drivers are not generic part
> > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > >
> > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > >
> > > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > > didn't see it on v1 before re-sending v2 to the larger audience.
> > >
> > > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > > Ack this version of the patchset since it changes when the soc/aspeed
> > > Makefile is followed.
> >
> > I have no objection for moving stuff out of drivers/misc/ so the SOC
> > maintainers are free to take this.
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> I'm totally confused. This is the second "PATCH v2" of this patch that I came
> across, I already applied the first.
>
> Patrick: Follow up with incremental patch in case there's any difference.
> Meanwhile, please keep in mind that you're adding a lot of work for people when
> you respin patches without following up on the previous version. Thanks!

Not only that, but subthreads were cc:d to arm@kernel.org and some
were not, so I missed the overnight conversation on the topic.

If this email thread is any indication of how the code will be
flowing, there's definitely need for more structure. Joel, I'm hoping
you'll coordinate.

I'm with Arnd on whether the code should be in drivers/soc or not --
most of it likely should not.


-Olof
