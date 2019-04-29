Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0229C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87006215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JO7QS5Tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfD2TlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:41:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37857 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2TlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:41:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so5656145pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzJtRAExAyIJIpll0DdlInVHVh+qcKOa3wHz8C2eEa8=;
        b=JO7QS5Tci8be+0D9TlrsD+ZYjFGdRq0P88jQAW3aKDKfbmTNg1EUxmtG66QnH/8f5W
         UbSqD6hdaczxrfZHxzgKKausQu1R25myBc7wWO3dXhhyePXzPhlW7GYife0YqtH3/qbG
         4YD+kAqgoXci7wAC6DzAuUCS8ALNS2luB/bcBuxjYITruwVfxjAE81H/WNh7jI+3D4wC
         fyXvsVFoVViJqfbkg+tOxy/flM0pKuJ3r6Az3nyUn64FSN9aXEEhuGzroi/tVxIrl9kh
         Tp14UxgBguC+WG7H6IvNzJtlpGBpclrssU2p09mgU1MdI5alR+dtCYj+5WRcjb8SJyx5
         aSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzJtRAExAyIJIpll0DdlInVHVh+qcKOa3wHz8C2eEa8=;
        b=i4a7V37Ar44Tss0uk/gDrja/qWOwVmNeSm2FbBpNv6VsQCEgsqxV75VeWsCyG+BNYB
         W5/FDimjdSiSOWtMJLhgz3DHUQJMfdJO1CVC+wfSTZsy/gal0H/9qdYgVjE6IXMjEomY
         3j13saYZ7lVVpfnZtW+ru0Iq+rPCiAGccY7fKtpBgq5s6KHvE4n93eXiNNd+8hptB58M
         swIR0ioaGwTCIu6NbDzZ6ooWTiIVLfWw4fr7nLr38SGFwbIsO8S9dzTwgBTp3KtcSgfV
         LxolX6S313nefVjI+IiN7h9D7IbUTc/U0kzxNcTrW4B753Ca+q837UcOmA/yK8IWtTdT
         H4LQ==
X-Gm-Message-State: APjAAAWcDrLoEhULStfjVurihx5NBgrz2L8P7e7npry3TGFb8oP/lpRf
        QipQsfrFfMCt2ofjVlvDj7jGAMvdHT6zBcvBulHVsMHv/YY=
X-Google-Smtp-Source: APXvYqwTTYcr+zcBxdoaerowqOSRILD2f0lQzhTtKzig13TLEjbYvMQGE+VKCnhxNR1qT6tui2D/AjT2B4bQrwFt/DU=
X-Received: by 2002:a62:2541:: with SMTP id l62mr43049234pfl.243.1556566864562;
 Mon, 29 Apr 2019 12:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <20190429165137.mwj4ehhwerunbef4@localhost>
 <CAO=notwewAeeLz=LsOcSj=DakLGW0KjeDHALP5Nv2ckgkRqnFA@mail.gmail.com>
 <CAOesGMipoKED=XLg+VtEVG0Os_MUzsPgOfBFJ+qoJs_fNmP+3g@mail.gmail.com> <CAO=notwU7LzEiBmzb6AJrgP3RGXE+66OwZVU8CqVE6RSKRvo1w@mail.gmail.com>
In-Reply-To: <CAO=notwU7LzEiBmzb6AJrgP3RGXE+66OwZVU8CqVE6RSKRvo1w@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Mon, 29 Apr 2019 12:40:53 -0700
Message-ID: <CAO=notwK7t+EZBVr1LH2Cgexyi8fH=kpdUUZC1J3DRunPPwXUw@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Olof Johansson <olof@lixom.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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

On Mon, Apr 29, 2019 at 12:35 PM Patrick Venture <venture@google.com> wrote:
>
> On Mon, Apr 29, 2019 at 12:27 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Mon, Apr 29, 2019 at 10:12 AM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Mon, Apr 29, 2019 at 10:08 AM Olof Johansson <olof@lixom.net> wrote:
> > > >
> > > > On Thu, Apr 25, 2019 at 07:25:49PM +0200, Greg KH wrote:
> > > > > On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > > > > > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > > > > > >
> > > > > > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > > > > > >
> > > > > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > > > > currently present into this folder.  These drivers are not generic part
> > > > > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > > > > >
> > > > > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > > > >
> > > > > > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > > > > > didn't see it on v1 before re-sending v2 to the larger audience.
> > > > > >
> > > > > > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > > > > > Ack this version of the patchset since it changes when the soc/aspeed
> > > > > > Makefile is followed.
> > > > >
> > > > > I have no objection for moving stuff out of drivers/misc/ so the SOC
> > > > > maintainers are free to take this.
> > > > >
> > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > I'm totally confused. This is the second "PATCH v2" of this patch that I came
> > > > across, I already applied the first.
> > >
> > > I think the issue here was that I added to the CC list another email
> > > and so you may see the v2  without that mailing list, and a v2 with it
> > > --
> > >
> > > Does this require a v3?  I honestly didn't think so, but this was the
> > > first time I had to add more people without needing other changes.
> >
> > Well, v2 doesn't build. I'll fix it up locally by adding an 'endmenu'
> > to drivers/soc/aspeed/Kconfig. But... brings up questions how this was
> > tested before submitting?

Thanks for fixing this for me, and I apologize for the nuisance of it.

>
> That's a lost change issue. I'll try to be more diligent in the
> future.  My dev workspace  is disconnected from the kernel used for
> upstreaming patches, so if i make a change in one it isn't always
> reflected in the other.  I'm working on rectifying the underlying
> build space issue to let me use the same repo.
>
> >
> > scripts/kconfig/conf  --allnoconfig Kconfig
> > drivers/soc/Kconfig:24: 'menu' in different file than 'menu'
> > drivers/soc/aspeed/Kconfig:1: location of the 'menu'
> > drivers/Kconfig:233: 'menu' in different file than 'menu'
> > drivers/soc/aspeed/Kconfig:1: location of the 'menu'
> > <none>:34: syntax error
> >
> > > >
> > > > Patrick: Follow up with incremental patch in case there's any difference.
> > > > Meanwhile, please keep in mind that you're adding a lot of work for people when
> > > > you respin patches without following up on the previous version. Thanks!
> > >
> > > w.r.t this patch series.  I found an issue with v1, and released a v2
> > > with the detail of what changed.  I thought that was the correct
> > > approach.  I apologize for creating extra work, that's something
> > > nobody needs.
> >
> > It's ok to submit newer versions, but it's convenient when they get
> > threaded also in non-gmail mail readers (by using in-reply-to).
>
> Roger that.
>
> >
> >
> > -Olof
