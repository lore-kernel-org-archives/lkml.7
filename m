Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB045C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8006C20861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDHB7UOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfGHLwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:52:00 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36184 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfGHLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:52:00 -0400
Received: by mail-vk1-f193.google.com with SMTP id b69so2393055vkb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PDRHy4wkZl9+Br30ibWAWCz004CWBTP1/Ht93SrVhE=;
        b=qDHB7UOUimA7xh0CRledp9ZO50JFVc2w/3iPMP0nIJCuKKfDAFf2jGL2qaIy/ewtfj
         LX+4Ql2EIGTBuzsoMpnmEP/0/My6UV24AzDr89EVSP70u5JFyTHKOuYzqn1MJA7lGeSu
         G2vdEcSeYV4fn23D+3vqnY3ZauHfoUviwvf21IKpbr1d9BGn9LxULiRBMhuZvhDscwsN
         ZxfupQ0/FOoYLmG9YBH7GmKtiAhg8XrohR35LpjZHJnmMNGo93tLGpRfY/rvFHm3x8BP
         3aEB22U9ZOpKIZnbEEMSYF6zzimkX/84GNA5gqJAwDS3Ou/jqgKDs8On305WffHs1oGZ
         CASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PDRHy4wkZl9+Br30ibWAWCz004CWBTP1/Ht93SrVhE=;
        b=djRX3qgHMSAs/oIGB8feVyk0jbysGTLhyRHGEkWxq29lonmAALwUjeYRHNbEdnITgU
         xqSW1j2Tv5IQIcN2697GbXFha0Q/luVCTv2JWVh9xST+grR/524AHbOAxcoyJwutPYKZ
         2Xtf+HMSGVEPjlWo6XwUsJS3vyoJEPv5uQYDhB/diPLdKAB+x8LdWSL0PcR2Rf9JrcN3
         o2RNgY7i/WRak+5TTgvqdNI9DDW7g+sr8R3RIYTJwF8z8KrCtjTS+QbxbZsnEMbvggnj
         hNT4xS8xyUiZ2r8FrjRN0LPM2Uhv5aMV5zkVoz9pI9Lcwl1++KOKKtALAjY4VeI7z5R2
         1EKg==
X-Gm-Message-State: APjAAAU2G3oMdJPYeoxB24CW/457X9viXyZCep8MOk69Fz9J95rA0mze
        ZRKWjNngSPi/OqF9c+as32npZf+l7ojgwziu/3o=
X-Google-Smtp-Source: APXvYqw6t3/DTwcBnZ2o0ffQaL+kB0nbUmh0pzDDqtZXoh1wju2grRydN4l18XvxVm4CDKKzufBT0NQ2OfNk1EeFm5A=
X-Received: by 2002:a1f:2e56:: with SMTP id u83mr5041322vku.68.1562586718840;
 Mon, 08 Jul 2019 04:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190708104355.32569-1-oded.gabbay@gmail.com> <20190708112136.GA13795@kroah.com>
 <CAFCwf11XN_stq3HHVGqD4_LKG8W3uFiYarfbwP50hw58Hi10Sw@mail.gmail.com> <20190708114259.GA16677@kroah.com>
In-Reply-To: <20190708114259.GA16677@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 8 Jul 2019 14:51:33 +0300
Message-ID: <CAFCwf10Zk2hjLceEjM_2dwz0=h1jmn_EZVKVjsJEE3ORooOzgA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use correct variable to show fd open counter
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 2:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 08, 2019 at 02:30:13PM +0300, Oded Gabbay wrote:
> > On Mon, Jul 8, 2019 at 2:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jul 08, 2019 at 01:43:55PM +0300, Oded Gabbay wrote:
> > > > The current code checks if the user context pointer is NULL or not to
> > > > display the number of open file descriptors of a device. However, that
> > > > variable (user_ctx) will eventually go away as the driver will support
> > > > multiple processes. Instead, the driver can use the atomic counter of
> > > > the open file descriptors which the driver already maintains.
> > > >
> > > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > > ---
> > > >  drivers/misc/habanalabs/sysfs.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
> > > > index 25eb46d29d88..881be19b5fad 100644
> > > > --- a/drivers/misc/habanalabs/sysfs.c
> > > > +++ b/drivers/misc/habanalabs/sysfs.c
> > > > @@ -356,7 +356,7 @@ static ssize_t write_open_cnt_show(struct device *dev,
> > > >  {
> > > >       struct hl_device *hdev = dev_get_drvdata(dev);
> > > >
> > > > -     return sprintf(buf, "%d\n", hdev->user_ctx ? 1 : 0);
> > > > +     return sprintf(buf, "%d\n", atomic_read(&hdev->fd_open_cnt));
> > > >  }
> > >
> > > Odds are, this means nothing, as it doesn't get touched if the file
> > > descriptor is duped or sent to another process.
> > >
> > > Why do you care about the number of open files?  Whenever someone tries
> > > to do this type of logic, it is almost always wrong, just let userspace
> > > do what it wants to do, and if wants to open something twice, then it
> > > gets to keep the pieces when things break.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I care about the number of open file descriptors because I can't let
> > multiple processes run simultaneously on my device, as we still don't
> > have the code to do proper isolation between the processes, in regard
> > of memory accesses on our device memory and by using our DMA engine.
> > Basically, it's a security hole. If you want, I can explain more in
> > length on this issue.
>
> But the issue is that you can't "force" this from the kernel side at
> all.  Trying to catch this at open() time only catches the obvious
> processes.
>
> As I said, how do you check for:
>         fd = open(...);
>         fd_new = dup(fd);
>
>         write(fd, ...);
>         write(fd_new, ...);
>
> or, pass the fd across a socket?  Or other fun ways of sending file
> descriptors around a system.
>
> You have to trust userspace here, sorry.  If someone wants to do
> multiple accesses, they can, but again, they deserve the pieces when
> things fall apart.

I see what you are saying, but from *security* perspective, I don't
think I really care about the scenarios above, right ?
Because that would mean a user duplicated his *own* fd. Sure, things
won't work for him, but what do I care about that, as you rightly
said.
I'm only concerned about the security risk, where there is a
legitimate user and a malicious one. Because I can't isolate between
them, I want to be able to allow only one of them to run.
I don't care if one of them duplicates his own FD, right ?

Please tell me if my assumption here is correct or not, because this
has implications.

>
> > We have the H/W infrastructure for that, using MMU and multiple
> > address space IDs (ASID), but we didn't write the code yet in the
> > driver, as that is a BIG feature but it wasn't requested by anyone
> > yet.
> >
> > So the current solution is to block the ability to open multiple file
> > descriptors.
> >
> > Regarding this specific sysfs property, I don't really care about it.
> > I simply saw that it is shown in other drivers and I thought it may be
> > nice for a system admin utility to show it.
>
> What drivers show the number of open file descriptors?  Time to go
> delete them as well :)
hehe
I tried to grep for it but I couldn't find any. Strange because I was
sure I saw this in some driver.
As I said, I don't really care about it. I will delete this to prevent
further errors.

Oded

>
> thanks,
>
> greg k-h
