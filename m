Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8883AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA09207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D42nakkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfIRPfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:35:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57862 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbfIRPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568820933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jl3xf+SlbbmgNVj3rIhprzvu6KTO4+fHOB8Vm/+azHE=;
        b=D42nakkj0tv+gCmACBmzDtIFSZ0gedpwg2e5eKbKlVCei3pFZp1QNmJwl2AitCOOX9rRTk
        zCc5+h3XY/fcgznEHbmXRWnyuQhGwVYRezQ75o3slqMAWsgYSrrQNLqvoVoxheqghRSO0T
        kV1DnoWZdukzgkcF3LFUb0PQ2zjkbVQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-EkRq5__COqK0WQEf5pVX2g-1; Wed, 18 Sep 2019 11:35:31 -0400
Received: by mail-qt1-f198.google.com with SMTP id z4so494462qts.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5euqK1Uayja2/4T0pIwBXXljs7m3c7t7lzxpmy9RYE=;
        b=d/E3OWGPvgKAtfeVSGMqh22rOo+SVX85/gdg/ILXiz+kQAqY92ksMcasBlOUlLwian
         Uds+oILxKFIWpf0xxNQdIDAEaVKyuQUFvZ0NWW8/wvKHRAG61zuVbw8eh/t1nkf2v9ZH
         MTxN8WhsaPOagEBWsjLeg0zm3rvNdNjG1XaAXAXXgsMuXWHcwj/OUrm8+0YbLloowQDl
         r2JBCafXZhxukvCydDhvEbMtocx9mc80tQVmdI03KuOYrCglufzWHhC+VPcg3h56zOkI
         zFtHEy/Zzfoy/D8HMMgAP9vy3YP/Mkda3JSkP3apb9cCCKilW03WR82XX414yLSSclGB
         X8bg==
X-Gm-Message-State: APjAAAUQbpnGRcfHinCB+YHnvWb4xmpZwTugSdxu2O7GaHpc2GHRY/VJ
        P6XVZpGF5Qror+Yip8d+lHrHv3rbc4+kcDAn3rs/eXErjJzLP3vYhj4kgGRxnwOOnURJ5VfBNP0
        I4kucHIgNEqpg7r+vD6DD5yQDEPbkyvhuG4I9dl5W
X-Received: by 2002:ac8:4251:: with SMTP id r17mr4751030qtm.260.1568820930807;
        Wed, 18 Sep 2019 08:35:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMAkC4LzPBLYmzrgRhTnQzsI/ZM7Fw1Sk0DnmqW0xRDSNMXxOjuj8sChl5/Ge6r4tOqKvUzYmuesragQTuOrU=
X-Received: by 2002:ac8:4251:: with SMTP id r17mr4751014qtm.260.1568820930584;
 Wed, 18 Sep 2019 08:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190812152022.27963-1-stillcompiling@gmail.com>
 <20190812152022.27963-4-stillcompiling@gmail.com> <CAMB+bfK9Oge1T96aJkuvpoAdUSsm+YxY1W70b62gUMMBKfD8vg@mail.gmail.com>
In-Reply-To: <CAMB+bfK9Oge1T96aJkuvpoAdUSsm+YxY1W70b62gUMMBKfD8vg@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 18 Sep 2019 17:35:19 +0200
Message-ID: <CAO-hwJLVS0G+TtShbBQ6j9_aCAKjb_AsvoN2HkR+zKpd98MKRw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] HID: core: fix dmesg flooding if report field
 larger than 32bit
To:     Joshua Clayton <stillcompiling@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
X-MC-Unique: EkRq5__COqK0WQEf5pVX2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 1:26 AM Joshua Clayton <stillcompiling@gmail.com> w=
rote:
>
> ping?
> I'd love to see this get in.
> with distro kernel I have effectively no dmesg due to this issue

Apologies for the delay.

I really thought we should find a better way of fixing this, until I
got a laptop affected by it. This series is a must have.

Applied to for-5.4/core

Cheers,
Benjamin

>
> On Mon, Aug 12, 2019 at 9:20 AM <stillcompiling@gmail.com> wrote:
> >
> > From: Joshua Clayton <stillcompiling@gmail.com>
> >
> > Only warn once of oversize hid report value field
> >
> > On HP spectre x360 convertible the message:
> > hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (=
192) > 32! (kworker/1:2)
> > is continually printed many times per second, crowding out all else.
> > Protect dmesg by printing the warning only one time.
> >
> > The size of the hid report field data structure should probably be incr=
eased.
> > The data structure is treated as a u32 in Linux, but an unlimited numbe=
r
> > of bits in the USB hid spec, so there is some rearchitecture needed now=
 that
> > devices are sending more than 32 bits.
> >
> > Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 210b81a56e1a..3eaee2c37931 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -1311,8 +1311,8 @@ u32 hid_field_extract(const struct hid_device *hi=
d, u8 *report,
> >                         unsigned offset, unsigned n)
> >  {
> >         if (n > 32) {
> > -               hid_warn(hid, "hid_field_extract() called with n (%d) >=
 32! (%s)\n",
> > -                        n, current->comm);
> > +               hid_warn_once(hid, "%s() called with n (%d) > 32! (%s)\=
n",
> > +                             __func__, n, current->comm);
> >                 n =3D 32;
> >         }
> >
> > --
> > 2.21.0
> >

