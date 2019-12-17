Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9BAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDBA24676
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFWhJc01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfLQUQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:16:52 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45479 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfLQUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:16:46 -0500
Received: by mail-yw1-f67.google.com with SMTP id d7so3771139ywl.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLo3YgqfZWpHDaMVADfGw84K9zVEXzo6Zsavpri7aPQ=;
        b=QFWhJc01yHhJRElEVrRbuDSLdYLW4e/DomuRGPS7+TgiAG5tLiXXQUd/gKy6INrIm1
         TceSyMUKrXEjyizJCqxZmzNEF8EOat0RoJMdEVuQmRhuIyLzm1PdAR/oQhli8xOdCPGl
         SZZlYfr3z085wEbaubUcyq3IiE9SV0w4Hn6fpKJEyQcojS22MmB3usam/KPc3bNNGGOS
         sNCIyFMBVHcyq2fOQWJlhsRU7mzW3BmCx8/rJ6IoDaaIGvWeYOZ4dVyyfsxIZBXiYxej
         K18acyzqbO9fzfoVZe48a92pt0Dxym3cC1eqVxICQGpYwPOlP1Xp//s7NzTshYTEvu0W
         FgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLo3YgqfZWpHDaMVADfGw84K9zVEXzo6Zsavpri7aPQ=;
        b=Ef+eX52Tg4VTOs1Q++xWesPPHa9moRb316FFIDk1FGiZRH0UGq9YfTAFTYFMcx2orZ
         w1E3evbeqJoF04kPo5Mv7ViNgYyLbfM1S+XWa25u6AiM8SkBFzAqPCCYitMbMeaU74A5
         Z3x5IZ0/UaQHZL6IpR28gYQm+n4CrWOqzlE7dqE/1AO8Tn6Sba7oybGMG9g86I7AyNTN
         doxWEAc/Dw2RrPn82rbwr466/aHldX0/GThRGd6cEt4cxkQE48SQs7IFRAPdC9I/D+ot
         FNhIcfWIjXlz/OYg3iP8h2aHqnVN3PmhVaY1sLqVtYblaVJ+m9LmmKxKTyyYXzktzGN3
         zV2w==
X-Gm-Message-State: APjAAAWbYFsEfMQXYfvIeqi+Y/2GueJW6RAoT3h7Gk8pqCpr58J4+Rtz
        4FhkCBYl0gdtAgRfBPWnPBV0kc29v8g8z768z591JA==
X-Google-Smtp-Source: APXvYqygLxcZT4RRwxuu51o/BOxORqqsBOLQuavkikYPkbT2Lo7OhQ82WGBQRolJvBB2ad6h5lw4tsI3/fmzZu2zgFI=
X-Received: by 2002:a81:2708:: with SMTP id n8mr357745ywn.437.1576613804857;
 Tue, 17 Dec 2019 12:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20191128125100.14291-1-patrick.rudolph@9elements.com>
 <20191128125100.14291-2-patrick.rudolph@9elements.com> <CAODwPW8Koy1BvKGJU6PKexYx+PNE+WY7+m69gcxT689vBy+AoQ@mail.gmail.com>
 <CAOxpaSXUgNXaZ40ScZKZQ+iDEQ=vqPytLgicBx==hxp5uL_+dA@mail.gmail.com>
 <CAL_quvScPUuocogrghzH_vNb2uxyBupBKYikG0Bwf4OcfSRWsQ@mail.gmail.com> <5df87d6e.1c69fb81.f0643.a6b6@mx.google.com>
In-Reply-To: <5df87d6e.1c69fb81.f0643.a6b6@mx.google.com>
From:   Mat King <mathewk@google.com>
Date:   Tue, 17 Dec 2019 13:16:33 -0700
Message-ID: <CAL_quvS_3o7UNmqP+QDCcHosw8JkQ03Kx5NjgUxFhO5FO=_-Mg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:02 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Mat King (2019-12-13 13:31:46)
> > On Mon, Dec 9, 2019 at 11:57 PM Julius Werner <jwerner@chromium.org> wrote:
> > > > +static int cbmem_probe(struct coreboot_device *cdev)
> > > > +{
> > > > +       struct device *dev = &cdev->dev;
> > > > +       struct cb_priv *priv;
> > > > +       int err;
> > > > +
> > > > +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > > > +       if (!priv)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
> > > > +
> > > > +       priv->remap = memremap(priv->entry.address,
> > > > +                              priv->entry.entry_size, MEMREMAP_WB);
> > >
> > > We've just been discussing some problems with CBMEM areas and memory
> > > mapping types in Chrome OS. CBMEM is not guaranteed to be page-aligned
> > > (at least not the "small" entries), but the kernel can only assign
> > > memory attributes for a page at a time (and refuses to map the same
> > > area twice with two different memory types, for good reason). So if
> > > CBMEM entries sharing a page are mapped as writeback by one driver but
> > > uncached by the other, things break.
> > >
> > > There are some CBMEM entries that need to be mapped uncached (e.g. the
> > > ACPI UCSI table, which isn't even handled by anything using this CBMEM
> > > code) and others for which it would make more sense (e.g. the memory
> > > console, where firmware may add more lines at runtime), but I don't
> > > think there are any regions that really *need* to be writeback. None
> > > of the stuff accessing these areas should access them often enough
> > > that caching matters, and I think it's generally more common to map
> > > firmware memory areas as uncached anyway. So how about we standardize
> > > on mapping it all uncached to avoid any attribute clashes? (That would
> > > mean changing the existing VPD and memconsole drivers to use
> > > ioremap(), too.)
> >
> > I don't think that uncached would work here either because the acpi
> > driver will have already mapped some of these regions as write-back
> > before this driver is loaded so the mapping will fail.
>
> Presumably the ucsi driver is drivers/usb/typec/ucsi/ucsi_acpi.c? Is
> that right? And on ACPI based systems is this I/O memory or just some
> carved out memory region that is used to communicate something to the
> ACPI firmware? From looking at the ucsi driver it seems like it should
> be mapped with memremap() instead of ioremap() given that it's not
> actual I/O memory that has any sort of memory barrier or access width
> constraints. It looks more like some sort of memory region that is being
> copied into and out of while triggering some DSM. Can it at least be
> memremap()ed with MEMREMAP_WT?

Yes this is the ucsi_acpi.c driver that has caused this issue to come
up. It does just use a region of memory carved in the BIOS out for the
purpose of this device. The kernel can write to this memory and call a
_DSM to push data to an EC or call the _DSM to pull from the EC into
this memory region. See
https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/bios-implementation-of-ucsi.pdf
. The driver is very explicit about using uncached memory and I
suspect that is why memremap() was not used, but I am not sure why
uncahed memory is needed. The only consumers of this memory are the
driver itself and the ACPI asl code in the _DSM which as far as I know
is being exectued by the kernel directly. Are there any other reasons
to use uncached memory when dealing with ACPI asl code?

>
> It also looks like this sort of problem has come up before, see commit
> 1f9f9d168ce6 ("usb: typec: ucsi: acpi: Workaround for cache mode
> issue"). Ugh.
>
> >
> > Perhaps the best way to make this work is to not call memremap at all
> > in the probe function but instead call memremap and memunmap every
> > time that data_read is called. memremap can take multiple caching mode
> > flags and will try each until one succeeds. So if you call it with
> > MEMREMAP_WB | MEMREMAP_WT in data_read it should succeed no matter how
> > it has been mapped by other drivers which should already be loaded
> > when it is called.
>
> I've been wanting to change memremap() to be a "just give me memory"
> type of API but haven't finished that task. It got hung up on mapping
> memory specially for UEFI framebuffers to match whatever the UEFI mmap
> table tells us.
>
