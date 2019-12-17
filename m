Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBC2206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fFhDyCx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLQHCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:02:08 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36791 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLQHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:02:08 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so4154672pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 23:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=z2DXh8dsAF5DZ/aZBsKALPhmsYvgC3PQ53Hh8OhN+H4=;
        b=fFhDyCx7M0zTkCsNT01vS3UqqRblXyPBY6VjzFHX0fyv2p4SC9Imc9KA91ynL+Y0FD
         vbMyHrVleOWVWCDfbYgnDQeBFx/4pnMplGvjxGlqT7tz/UkwrNSX2sZ72EhiodvjFI30
         FuKVI52+ZN1sK5eFP1bcUHsVjOdTRNbuNSOWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=z2DXh8dsAF5DZ/aZBsKALPhmsYvgC3PQ53Hh8OhN+H4=;
        b=PsmVSEnUQbehpRppNg6baphttRAwhyYt+azYeJCmKiqUFR8QKAiZC/TnwaWbh0cEQZ
         MbqzGdhOAMMh5KeIdcJER4KriDIJGIPd9+CThqhDMXBnTGwAKlxQKPnk/Oy14Dvm+Jm/
         2CHf1hlCC900fs5Zj5OQOBuxLCruldkIeB8vG++ciqgb5n1nWo6C2msyoouTph+OP4Bs
         2mv5nW2siY96F/tNdNBwVwDAwgztDeaKUqTaNIfLP+ruw1CR4E4Y3l5WkZoyf06ocPlr
         F9v8faKxq6BTkSfJEmWTWA9C2nEi2oCDBeS/LOnS0dnH4mwzwxA/tigv8T4ieDcej82q
         Ax1Q==
X-Gm-Message-State: APjAAAVVp8qoZNskGT/cvBxULj89ngmCB437xiHFEFnKwaPbSElPjb4f
        DtgF15KYQQFNqVIDrnQATN9kX/g5uZAZ4Q==
X-Google-Smtp-Source: APXvYqyLdS3RcwtkjyrzH7Yj9Jj4zv33WIN06ojZYvJOJ4JROCHunUScnZFzkQ0dnmQvtYRYk8ub1Q==
X-Received: by 2002:a17:902:8bc9:: with SMTP id r9mr15581481plo.48.1576566126973;
        Mon, 16 Dec 2019 23:02:06 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o6sm25262669pgg.37.2019.12.16.23.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 23:02:06 -0800 (PST)
Message-ID: <5df87d6e.1c69fb81.f0643.a6b6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_quvScPUuocogrghzH_vNb2uxyBupBKYikG0Bwf4OcfSRWsQ@mail.gmail.com>
References: <20191128125100.14291-1-patrick.rudolph@9elements.com> <20191128125100.14291-2-patrick.rudolph@9elements.com> <CAODwPW8Koy1BvKGJU6PKexYx+PNE+WY7+m69gcxT689vBy+AoQ@mail.gmail.com> <CAOxpaSXUgNXaZ40ScZKZQ+iDEQ=vqPytLgicBx==hxp5uL_+dA@mail.gmail.com> <CAL_quvScPUuocogrghzH_vNb2uxyBupBKYikG0Bwf4OcfSRWsQ@mail.gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>
To:     Julius Werner <jwerner@chromium.org>, Mat King <mathewk@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 23:02:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mat King (2019-12-13 13:31:46)
> On Mon, Dec 9, 2019 at 11:57 PM Julius Werner <jwerner@chromium.org> wrot=
e:
> > > +static int cbmem_probe(struct coreboot_device *cdev)
> > > +{
> > > +       struct device *dev =3D &cdev->dev;
> > > +       struct cb_priv *priv;
> > > +       int err;
> > > +
> > > +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> > > +       if (!priv)
> > > +               return -ENOMEM;
> > > +
> > > +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
> > > +
> > > +       priv->remap =3D memremap(priv->entry.address,
> > > +                              priv->entry.entry_size, MEMREMAP_WB);
> >
> > We've just been discussing some problems with CBMEM areas and memory
> > mapping types in Chrome OS. CBMEM is not guaranteed to be page-aligned
> > (at least not the "small" entries), but the kernel can only assign
> > memory attributes for a page at a time (and refuses to map the same
> > area twice with two different memory types, for good reason). So if
> > CBMEM entries sharing a page are mapped as writeback by one driver but
> > uncached by the other, things break.
> >
> > There are some CBMEM entries that need to be mapped uncached (e.g. the
> > ACPI UCSI table, which isn't even handled by anything using this CBMEM
> > code) and others for which it would make more sense (e.g. the memory
> > console, where firmware may add more lines at runtime), but I don't
> > think there are any regions that really *need* to be writeback. None
> > of the stuff accessing these areas should access them often enough
> > that caching matters, and I think it's generally more common to map
> > firmware memory areas as uncached anyway. So how about we standardize
> > on mapping it all uncached to avoid any attribute clashes? (That would
> > mean changing the existing VPD and memconsole drivers to use
> > ioremap(), too.)
>=20
> I don't think that uncached would work here either because the acpi
> driver will have already mapped some of these regions as write-back
> before this driver is loaded so the mapping will fail.

Presumably the ucsi driver is drivers/usb/typec/ucsi/ucsi_acpi.c? Is
that right? And on ACPI based systems is this I/O memory or just some
carved out memory region that is used to communicate something to the
ACPI firmware? From looking at the ucsi driver it seems like it should
be mapped with memremap() instead of ioremap() given that it's not
actual I/O memory that has any sort of memory barrier or access width
constraints. It looks more like some sort of memory region that is being
copied into and out of while triggering some DSM. Can it at least be
memremap()ed with MEMREMAP_WT?

It also looks like this sort of problem has come up before, see commit
1f9f9d168ce6 ("usb: typec: ucsi: acpi: Workaround for cache mode
issue"). Ugh.

>=20
> Perhaps the best way to make this work is to not call memremap at all
> in the probe function but instead call memremap and memunmap every
> time that data_read is called. memremap can take multiple caching mode
> flags and will try each until one succeeds. So if you call it with
> MEMREMAP_WB | MEMREMAP_WT in data_read it should succeed no matter how
> it has been mapped by other drivers which should already be loaded
> when it is called.

I've been wanting to change memremap() to be a "just give me memory"
type of API but haven't finished that task. It got hung up on mapping
memory specially for UEFI framebuffers to match whatever the UEFI mmap
table tells us.

