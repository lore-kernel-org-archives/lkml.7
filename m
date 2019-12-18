Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B5C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAB821582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VH+6fBo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLRXfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:35:42 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42170 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLRXfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:35:42 -0500
Received: by mail-yb1-f194.google.com with SMTP id z10so1496519ybr.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 15:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wWAEvjdhihSGHkV+1yOnTGUKSIjjppKQd/dJmsVVjs=;
        b=VH+6fBo/lDW8MRM/Csre5tRebK/BtDPju6jsZb5c93hYRPEKn1Msj6jHRsbMvBFEOJ
         dM1boMHPgKJf5BMx78yeSWIaWjTwOHB7LSQIAWnR/WPBOX2ugvf/mglpZlAHxN28w7pQ
         HshfiA4sjwCz/iqdz/XJw6Z4IcQx6RL2Rj3dm00B9T0iHogdtwUB9rerZ6q0qgtu9C3i
         vc1Ty0/phBaorIc24JMasAECsILemIkDEpf4BhgNTTjOmV8FU6WYgz2+x3xR9QvF1ZVH
         lbnGfzjqfORTUg+ljzAAEkAGTmEJV/qZedOO8FkbNXZrZGv6/c5Kq0c5BbaJoeYdZjRV
         dvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wWAEvjdhihSGHkV+1yOnTGUKSIjjppKQd/dJmsVVjs=;
        b=pBwparRbV47TcgWjcsYVaN65prrHRjKj/HPpic9yh/wjmDbnp1yrm/xvmLuHs356AP
         L0cesbNOifhczkx7tvsadaKcOUFEmSjYJArFxofo1r9A3n1arkJlMF1kTf4cPz9Ho/+5
         b3We8AKbO8YZsdPKtMMYHz4Ufixx894Hq+znxyqHGP2FThGCRZge4cdMORxWGmhD+axs
         iLVJrxbdCS265f9nmQv3P9wRstkmnBcdP0EY48u3fTqyUFx4k7p+VJleJLn6sySq1DWu
         NDig87Ivsh+nnzwVcIVcTuduAjIvbmtileT+HknboHchxy0iFpC5RGlSjutoehBorKRN
         BpsQ==
X-Gm-Message-State: APjAAAU7f+z+q/5IRSOArRWOrTdvVGzXUAtAaPJ93P5CwZ69QVN6UuPg
        Y+PKApX/Ndx0xpD4drGmbT7JPnO5U/lTaV1/EhD2fg==
X-Google-Smtp-Source: APXvYqzc67hxY4HpYRbedQjlpsEL9vQPoY2m2y6N+X9XNT9xxSf1XmZ2uJxO3VT1zIKbaVOjDqU9HS/5+hDDnGYZP/I=
X-Received: by 2002:a25:8502:: with SMTP id w2mr4128894ybk.428.1576712140372;
 Wed, 18 Dec 2019 15:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20191128125100.14291-1-patrick.rudolph@9elements.com>
 <20191128125100.14291-2-patrick.rudolph@9elements.com> <CAODwPW8Koy1BvKGJU6PKexYx+PNE+WY7+m69gcxT689vBy+AoQ@mail.gmail.com>
 <CAOxpaSXUgNXaZ40ScZKZQ+iDEQ=vqPytLgicBx==hxp5uL_+dA@mail.gmail.com>
 <CAL_quvScPUuocogrghzH_vNb2uxyBupBKYikG0Bwf4OcfSRWsQ@mail.gmail.com>
 <5df87d6e.1c69fb81.f0643.a6b6@mx.google.com> <CAL_quvS_3o7UNmqP+QDCcHosw8JkQ03Kx5NjgUxFhO5FO=_-Mg@mail.gmail.com>
 <20191218094729.GC22923@kuha.fi.intel.com>
In-Reply-To: <20191218094729.GC22923@kuha.fi.intel.com>
From:   Mat King <mathewk@google.com>
Date:   Wed, 18 Dec 2019 16:35:29 -0700
Message-ID: <CAL_quvSKHwOTeatoju=nTmhyf6iTRGD3zY1Nxv=DcJrzQNV3sg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 2:47 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Dec 17, 2019 at 01:16:33PM -0700, Mat King wrote:
> > On Tue, Dec 17, 2019 at 12:02 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Mat King (2019-12-13 13:31:46)
> > > > On Mon, Dec 9, 2019 at 11:57 PM Julius Werner <jwerner@chromium.org> wrote:
> > > > > > +static int cbmem_probe(struct coreboot_device *cdev)
> > > > > > +{
> > > > > > +       struct device *dev = &cdev->dev;
> > > > > > +       struct cb_priv *priv;
> > > > > > +       int err;
> > > > > > +
> > > > > > +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > > > > > +       if (!priv)
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
> > > > > > +
> > > > > > +       priv->remap = memremap(priv->entry.address,
> > > > > > +                              priv->entry.entry_size, MEMREMAP_WB);
> > > > >
> > > > > We've just been discussing some problems with CBMEM areas and memory
> > > > > mapping types in Chrome OS. CBMEM is not guaranteed to be page-aligned
> > > > > (at least not the "small" entries), but the kernel can only assign
> > > > > memory attributes for a page at a time (and refuses to map the same
> > > > > area twice with two different memory types, for good reason). So if
> > > > > CBMEM entries sharing a page are mapped as writeback by one driver but
> > > > > uncached by the other, things break.
> > > > >
> > > > > There are some CBMEM entries that need to be mapped uncached (e.g. the
> > > > > ACPI UCSI table, which isn't even handled by anything using this CBMEM
> > > > > code) and others for which it would make more sense (e.g. the memory
> > > > > console, where firmware may add more lines at runtime), but I don't
> > > > > think there are any regions that really *need* to be writeback. None
> > > > > of the stuff accessing these areas should access them often enough
> > > > > that caching matters, and I think it's generally more common to map
> > > > > firmware memory areas as uncached anyway. So how about we standardize
> > > > > on mapping it all uncached to avoid any attribute clashes? (That would
> > > > > mean changing the existing VPD and memconsole drivers to use
> > > > > ioremap(), too.)
> > > >
> > > > I don't think that uncached would work here either because the acpi
> > > > driver will have already mapped some of these regions as write-back
> > > > before this driver is loaded so the mapping will fail.
> > >
> > > Presumably the ucsi driver is drivers/usb/typec/ucsi/ucsi_acpi.c? Is
> > > that right? And on ACPI based systems is this I/O memory or just some
> > > carved out memory region that is used to communicate something to the
> > > ACPI firmware? From looking at the ucsi driver it seems like it should
> > > be mapped with memremap() instead of ioremap() given that it's not
> > > actual I/O memory that has any sort of memory barrier or access width
> > > constraints. It looks more like some sort of memory region that is being
> > > copied into and out of while triggering some DSM. Can it at least be
> > > memremap()ed with MEMREMAP_WT?
> >
> > Yes this is the ucsi_acpi.c driver that has caused this issue to come
> > up. It does just use a region of memory carved in the BIOS out for the
> > purpose of this device. The kernel can write to this memory and call a
> > _DSM to push data to an EC or call the _DSM to pull from the EC into
> > this memory region. See
> > https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/bios-implementation-of-ucsi.pdf
> > . The driver is very explicit about using uncached memory and I
> > suspect that is why memremap() was not used, but I am not sure why
> > uncahed memory is needed. The only consumers of this memory are the
> > driver itself and the ACPI asl code in the _DSM which as far as I know
> > is being exectued by the kernel directly. Are there any other reasons
> > to use uncached memory when dealing with ACPI asl code?
>
> The reason why I did not use memremap() was because I was convinced
> that there will soon be physical devices such as PD controllers that
> supply the interface, and with those the memory resource given to the
> driver would be real bus memory. But that was already years ago,
> and there still are no such devices that I know of, so if you guys
> want to change the driver so that it uses memremap() instead of
> ioremap(), I'm not going to be against it. But just be warned: We can
> not guarantee that there isn't going to be IO side effects in every
> case.

I am a little confused how this hypothetical PD controller would look
with regards to the ACPI table. Would it still have an OperationRegion
for the MMIO address of the controllers mailbox? Would the _CRS point
to the MMIO of the mailbox directly or would it still use physical
memory? If it is pointing to the MMIO mailbox is the _DSM essentially
a noop?

>
> But why is the UCSI ACPI mailbox a problem for you guys? Why do you
> have the UCSI ACPI device object in your ACPI tables in the first
> place?

The problem is that with our UCSI implementation in coreboot the 48
byte mailbox sometimes is in the same page as memory that gets
memremap()ed as write-back before the ucsi driver is loaded and when
it is loaded the ioremap fails.

>
>
> thanks,

>
> --
> heikki
