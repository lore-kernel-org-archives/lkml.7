Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B5CC606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACA921537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbW90Kx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbfGHO2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:28:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38317 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbfGHO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:28:48 -0400
Received: by mail-ua1-f66.google.com with SMTP id j2so5028379uaq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68vznt+Nl+HIjpVeyOFjYkL8X85BJYZga875EvEkgwM=;
        b=CbW90Kx6vg6zZV2z6W0S6oN+W+3Hf9bbaeVqDpGwX65nTM4Oi4hCzAJsL1IhLYr7Y6
         lUCGYwhOZ/ae7OfRWpnbNW4DokqfMe+nLQNPn6gExdLelOrIrUD4YHTEBDjAus5BfJkm
         VDf24sp95LpmMKk4xybv1bNRVTnF4SrD1AGWhxL0LwdqbkBtptd4kLhfAnq2njOoL3CY
         IH6dLgeRjtOdkjZUiWxvatMKKcZjiVVCfL2RjGs2RA1GfVaUyEgZggdcGo6hbk/nFW34
         k77GOgTFBeyzW+4YMZI6MRbQNe8gabkwlDvtEAv6nGFv0jirDvc+RFLzgIf6nm4VrDnl
         t17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68vznt+Nl+HIjpVeyOFjYkL8X85BJYZga875EvEkgwM=;
        b=CJBfdy1F5yctDE3BkZ3dz89MShNkvKW4UzYiYMB7s+1vWb0dyyv1btye1940Sec8ka
         6RDGhpIf+qChXOhlQEoFo+Fhu4LHBrcUXqbTpTXJ+Wo2xMJaALBuHvx6EJmHOKhIpKEE
         r9qEI77dgmahCbgAj33VFbD75a2L6dbGx8Uwivxjvpy9kNBkPre6j9g66MF/XDS9A9uN
         EZyLozB4otwtO/OJQl10gZ73NqJa7w2uFKfDmew03EIa1Qk0KOSct1ZFHPUVmaP300BU
         pOzXfnBXi96MTWgwZGNGZ4nlSZV+RDSobs7Y3C5Nyqnh6lekGMlm5o9HH6brvExBDuEI
         nnnA==
X-Gm-Message-State: APjAAAVH3sMNymAknLzq+SfwD2SRCvOQbqScVksozDLfWRg6sLf+OSig
        EAuVJ3KFz5JEPyHEyZoviV8uAaFXUxvhGzFQ1BDv9A==
X-Google-Smtp-Source: APXvYqxXaixiaeoRgKw4SCi4T30AcDWB5FfcW76Qs5xWqbCRh/dyia0EFH4sqoLPJ2X05DM7OGKxTFq/TY3O6G9kfG8=
X-Received: by 2002:a9f:230c:: with SMTP id 12mr7420727uae.85.1562596126944;
 Mon, 08 Jul 2019 07:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190708104355.32569-1-oded.gabbay@gmail.com> <20190708112136.GA13795@kroah.com>
 <CAFCwf11XN_stq3HHVGqD4_LKG8W3uFiYarfbwP50hw58Hi10Sw@mail.gmail.com>
 <20190708114259.GA16677@kroah.com> <CAFCwf10Zk2hjLceEjM_2dwz0=h1jmn_EZVKVjsJEE3ORooOzgA@mail.gmail.com>
 <20190708122033.GA19624@kroah.com>
In-Reply-To: <20190708122033.GA19624@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 8 Jul 2019 17:28:21 +0300
Message-ID: <CAFCwf10wO_6HqWbA3e_zRozHLDXg5sFvimb_sEs44X1yvGmL4A@mail.gmail.com>
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

On Mon, Jul 8, 2019 at 3:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 08, 2019 at 02:51:33PM +0300, Oded Gabbay wrote:
> > On Mon, Jul 8, 2019 at 2:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jul 08, 2019 at 02:30:13PM +0300, Oded Gabbay wrote:
> > > > On Mon, Jul 8, 2019 at 2:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Jul 08, 2019 at 01:43:55PM +0300, Oded Gabbay wrote:
> > > > > > The current code checks if the user context pointer is NULL or not to
> > > > > > display the number of open file descriptors of a device. However, that
> > > > > > variable (user_ctx) will eventually go away as the driver will support
> > > > > > multiple processes. Instead, the driver can use the atomic counter of
> > > > > > the open file descriptors which the driver already maintains.
> > > > > >
> > > > > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > > > > ---
> > > > > >  drivers/misc/habanalabs/sysfs.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
> > > > > > index 25eb46d29d88..881be19b5fad 100644
> > > > > > --- a/drivers/misc/habanalabs/sysfs.c
> > > > > > +++ b/drivers/misc/habanalabs/sysfs.c
> > > > > > @@ -356,7 +356,7 @@ static ssize_t write_open_cnt_show(struct device *dev,
> > > > > >  {
> > > > > >       struct hl_device *hdev = dev_get_drvdata(dev);
> > > > > >
> > > > > > -     return sprintf(buf, "%d\n", hdev->user_ctx ? 1 : 0);
> > > > > > +     return sprintf(buf, "%d\n", atomic_read(&hdev->fd_open_cnt));
> > > > > >  }
> > > > >
> > > > > Odds are, this means nothing, as it doesn't get touched if the file
> > > > > descriptor is duped or sent to another process.
> > > > >
> > > > > Why do you care about the number of open files?  Whenever someone tries
> > > > > to do this type of logic, it is almost always wrong, just let userspace
> > > > > do what it wants to do, and if wants to open something twice, then it
> > > > > gets to keep the pieces when things break.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > I care about the number of open file descriptors because I can't let
> > > > multiple processes run simultaneously on my device, as we still don't
> > > > have the code to do proper isolation between the processes, in regard
> > > > of memory accesses on our device memory and by using our DMA engine.
> > > > Basically, it's a security hole. If you want, I can explain more in
> > > > length on this issue.
> > >
> > > But the issue is that you can't "force" this from the kernel side at
> > > all.  Trying to catch this at open() time only catches the obvious
> > > processes.
> > >
> > > As I said, how do you check for:
> > >         fd = open(...);
> > >         fd_new = dup(fd);
> > >
> > >         write(fd, ...);
> > >         write(fd_new, ...);
> > >
> > > or, pass the fd across a socket?  Or other fun ways of sending file
> > > descriptors around a system.
> > >
> > > You have to trust userspace here, sorry.  If someone wants to do
> > > multiple accesses, they can, but again, they deserve the pieces when
> > > things fall apart.
> >
> > I see what you are saying, but from *security* perspective, I don't
> > think I really care about the scenarios above, right ?
> > Because that would mean a user duplicated his *own* fd. Sure, things
> > won't work for him, but what do I care about that, as you rightly
> > said.
> > I'm only concerned about the security risk, where there is a
> > legitimate user and a malicious one. Because I can't isolate between
> > them, I want to be able to allow only one of them to run.
>
> But how can you tell if the first one is the "malicious" one and the
> second one is "legitimate"?  You do that by the "normal" file
> permissions and the like, you don't try to do a "first one wins!" type
> of policy, that's crazy :)

I don't care who is malicious and who is not. Of course I can't count
on "first one wins" to do that...
What I care about, is that two different processes won't be able to
send jobs to the device at the same time. That's it.
But I see your point about not using file-descriptors to enforce this
limitation.
I will change my code, but it will take a bit of time. It's not a
trivial change.

Thanks,
Oded

>
> > I don't care if one of them duplicates his own FD, right ?
>
> If you are trying to keep someone from having multiple FD per device,
> then yes, you should care.  The point is, you can't know.
>
> > Please tell me if my assumption here is correct or not, because this
> > has implications.
>
> Don't rely on "first one wins!" as a security policy to prevent bad
> things from happening.  That's never going to work, let userspace police
> these things, as that is the only place you can do it properly (or with
> a selinux/apparmor/lsm policy).
>
> > > > We have the H/W infrastructure for that, using MMU and multiple
> > > > address space IDs (ASID), but we didn't write the code yet in the
> > > > driver, as that is a BIG feature but it wasn't requested by anyone
> > > > yet.
> > > >
> > > > So the current solution is to block the ability to open multiple file
> > > > descriptors.
> > > >
> > > > Regarding this specific sysfs property, I don't really care about it.
> > > > I simply saw that it is shown in other drivers and I thought it may be
> > > > nice for a system admin utility to show it.
> > >
> > > What drivers show the number of open file descriptors?  Time to go
> > > delete them as well :)
> > hehe
> > I tried to grep for it but I couldn't find any. Strange because I was
> > sure I saw this in some driver.
>
> If you run across it again, please let me know.  It's a common
> "anti-pattern" that I have been guilty of in the past.
>
> thanks,
>
> greg k-h
