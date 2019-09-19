Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C57C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F069320815
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1JvNLlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfISD2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:28:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37989 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbfISD2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:28:47 -0400
Received: by mail-io1-f68.google.com with SMTP id k5so4332280iol.5;
        Wed, 18 Sep 2019 20:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNbLf23EmCSrCvK1MZ3crIYt+lvIMsxQcCUGO2pJXfc=;
        b=k1JvNLlHbtZMs2Rd6GgQpe1doFKTTqCEiibUCJ/FSDH41thtmtzl+bAdhgZ+VKlyso
         aO/MfHLkYP8rKJT+JuRi23fomMk2bv3GIpPe6e77b5Uro6zuhhgh0U6PTfvkgMkgQfnf
         3iKcWGAN4IPYBOA8M0zZyOTRBVM2f3HwlLNuspX1a8SiEqLkGqOYBfRqFwRlTGnbV9gv
         lQQrhpPr/fRvg39G7YO7v24VQnhRzv0ePWwt5ulyBUTVupkb5BzDHtr2UrgK3j5Fi/G2
         wQ8X6lQcHv2/upSgJVANJ0o9fG8FuZNsRnpG3IMDS9TreK+fo9/p1DqxuvU37VTSK+Sp
         OTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNbLf23EmCSrCvK1MZ3crIYt+lvIMsxQcCUGO2pJXfc=;
        b=R/88pi4pm1UVuoFnTCW778NtLF1pdnkvnHfYKHmTc83+1MgiU+/Z4Grdr4BzCEp9hi
         NxqjOFoyXHZaAdXoXHLJ/ErnzyoHN5v3HgjMKzXEl8iAdGjlxVdaoSFTPtCSoRwk1jaM
         YeEBMuIUQleIbIK3AagmKX4+w12bQHxk9v6CTcsnDKboaYBC8yYrot6SyXTbYxuN4ln3
         pM+haff883uL4cEgjF/3EVkYfUWK/qq1eFQIh/8jiHQrvh+0OnovsaBMYM2+akZpgPuO
         Swh8rjsSyDCYJIMYhnCSQVM/nKZWv/Ik5BsrVsRHR39f0b/rkO+Vt+ldfieqjKrM69yi
         IP5g==
X-Gm-Message-State: APjAAAXsVmcy5553Ia6SAO/Zlo7nRGibGAn1lJNPhVlPwBYnQBS4i3f5
        A3CNGVJZm3MHfgHQOkTXJXt2uVtmAOY+Kf+79cQ=
X-Google-Smtp-Source: APXvYqzPTP4Dp9sgZd6PgvljuadFfBdfXebs8nrlxtOQggpHX4nAMMgryUdwkFF3YacEaj9vqxdZ4SLiXx8okL428VE=
X-Received: by 2002:a5d:9eca:: with SMTP id a10mr8986890ioe.180.1568863726773;
 Wed, 18 Sep 2019 20:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190812152022.27963-1-stillcompiling@gmail.com>
 <20190812152022.27963-4-stillcompiling@gmail.com> <CAMB+bfK9Oge1T96aJkuvpoAdUSsm+YxY1W70b62gUMMBKfD8vg@mail.gmail.com>
 <CAO-hwJLVS0G+TtShbBQ6j9_aCAKjb_AsvoN2HkR+zKpd98MKRw@mail.gmail.com>
In-Reply-To: <CAO-hwJLVS0G+TtShbBQ6j9_aCAKjb_AsvoN2HkR+zKpd98MKRw@mail.gmail.com>
From:   Joshua Clayton <stillcompiling@gmail.com>
Date:   Wed, 18 Sep 2019 23:28:35 -0400
Message-ID: <CAMB+bfL9RWzCs_FHrLRsQwsvBBSOBEiUq_ApniLpSUkiOtJvvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] HID: core: fix dmesg flooding if report field
 larger than 32bit
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!
It means a lot to have this accepted.
I actually started working on it, thinking "how hard can it be to
increase the size of a data structure"? It only has to be forward
compatible anyway.
My gut feeling is the existing code is working way too hard to do what
should be a memcpy, and the impulse to "fix" it is strong, despite my
absolute lack of usb-hid experience.

But the history of this little bit of code is already fraught with
complaints about big endian breakage.
I'm tempted to make it much simpler for size>32 bits (fix it only for
future users), or just way simpler for little endian,
But what do I know about usb and big endian? I sure don't have the
equipment to test it. And I worry a little I might be forgetting some
oddball non-byte-aligned data structure, which the spec would
theoretically allow.
Perhaps I'll have to time and courage to take another stab.

~Joshua

On Wed, Sep 18, 2019 at 11:35 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Thu, Aug 29, 2019 at 1:26 AM Joshua Clayton <stillcompiling@gmail.com> wrote:
> >
> > ping?
> > I'd love to see this get in.
> > with distro kernel I have effectively no dmesg due to this issue
>
> Apologies for the delay.
>
> I really thought we should find a better way of fixing this, until I
> got a laptop affected by it. This series is a must have.
>
> Applied to for-5.4/core
>
> Cheers,
> Benjamin
>
> >
> > On Mon, Aug 12, 2019 at 9:20 AM <stillcompiling@gmail.com> wrote:
> > >
> > > From: Joshua Clayton <stillcompiling@gmail.com>
> > >
> > > Only warn once of oversize hid report value field
> > >
> > > On HP spectre x360 convertible the message:
> > > hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (192) > 32! (kworker/1:2)
> > > is continually printed many times per second, crowding out all else.
> > > Protect dmesg by printing the warning only one time.
> > >
> > > The size of the hid report field data structure should probably be increased.
> > > The data structure is treated as a u32 in Linux, but an unlimited number
> > > of bits in the USB hid spec, so there is some rearchitecture needed now that
> > > devices are sending more than 32 bits.
> > >
> > > Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> > >
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 210b81a56e1a..3eaee2c37931 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -1311,8 +1311,8 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
> > >                         unsigned offset, unsigned n)
> > >  {
> > >         if (n > 32) {
> > > -               hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
> > > -                        n, current->comm);
> > > +               hid_warn_once(hid, "%s() called with n (%d) > 32! (%s)\n",
> > > +                             __func__, n, current->comm);
> > >                 n = 32;
> > >         }
> > >
> > > --
> > > 2.21.0
> > >
>
