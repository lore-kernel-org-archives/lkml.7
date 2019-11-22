Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D16C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6EF2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574455363;
	bh=9jUl9hYzeTjE4cdYpV/s+MeWKqCO1YmPWEPxwsM65fc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gOQz8OQbeoIJNHGs0qGsS6RlN+mgrfrID34GQZ2EeCyEfAN7gcLKT5qrH0ZmdD/JE
	 gcAoFXGRSjX8xUdI6cvhr3sm5tvmM2PI+RH8qXl9Pl3p5QtPAWzPM3YQ4a7ls3zpFn
	 ge1c2d2OINF6ChHXDLvL8c7TrehaDbWvUi0ai1GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKVUmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKVUml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:42:41 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E902071F;
        Fri, 22 Nov 2019 20:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574455360;
        bh=9jUl9hYzeTjE4cdYpV/s+MeWKqCO1YmPWEPxwsM65fc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=grvZmVnp3E4aSgHsuDL8R9hsxFoXmcVDe1FFYydprJZffl+G69JkxdyzngFxrcn9n
         tuZX8+loec9bMb6bUrnjv1LH6VWVodFipQ0gxLXNErnz2fqYd+g0jj/6o8URXNUw8q
         k8uOCOCL8DsGMYDbLbqgu/tEJWOgtmcrAsomh3Mg=
Received: by mail-qk1-f169.google.com with SMTP id i19so7505520qki.2;
        Fri, 22 Nov 2019 12:42:40 -0800 (PST)
X-Gm-Message-State: APjAAAVU5I8WO4l4eDS1ACPNiSfVcMHnw2TeOBPOsmoOJigbxRqiNSTv
        EqTbhw4x0Tb4b0JI3aQBtlr/mqrfVkGjDmqjxw==
X-Google-Smtp-Source: APXvYqzExydS4DW+2bikInq6s91Icq739PAoRhN/xA1oiv1V1aVfW6Akcvty1vRELGSZbb4NmevP6V97kU8lXmtYCVI=
X-Received: by 2002:a05:620a:205d:: with SMTP id d29mr15274456qka.152.1574455359578;
 Fri, 22 Nov 2019 12:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20191120071302.227777-1-saravanak@google.com> <CAL_Jsq+f1+xRv36z0o--u4SskTG-WxUdssJ-CP32RUZbtVuQ3w@mail.gmail.com>
 <CAGETcx-GV1kTAVbqcCLGVPoN16RpSrDw4gcxSgAVqWCb1NOzXA@mail.gmail.com>
In-Reply-To: <CAGETcx-GV1kTAVbqcCLGVPoN16RpSrDw4gcxSgAVqWCb1NOzXA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Nov 2019 14:42:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHGvSWsUrDJObLqCnnwe=pwWJpeXtToMj_sHgLQGev7A@mail.gmail.com>
Message-ID: <CAL_JsqLHGvSWsUrDJObLqCnnwe=pwWJpeXtToMj_sHgLQGev7A@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for
 interrupt-parent, dmas and -gpio(s)
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 1:34 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, Nov 22, 2019 at 5:35 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Nov 20, 2019 at 1:13 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Add support for creating device links out of more DT properties.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/of/property.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 0fa04692e3cc..dedbf82da838 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1188,7 +1188,11 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
> > >  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> > >  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> > >  DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
> > > +DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
> >
> > This one is not going to work most of the time (ignoring the fact that
> > the primary controller doesn't have a struct device) because the
> > interrupt-parent is typically in a parent node.
>
> Just to make sure, I'm not parsing this property incorrectly, right?
>
> Are you saying it's listed at the parent of a bunch of devices and the
> interrupt-parent is inherited and won't really create device links for
> those child devices?
> I mainly added this to make sure IRQ controllers are probed in the
> right order. Also, if this delays the parent device probe, by the time
> the child devices are added, the interrupt parent most likely would
> already be probed.
>
> > You could make it work
> > by specifying 'interrupt-parent' in every node, but that's not a
> > pattern I want to encourage.
>
> I'm trying to take care of the basic per-device properties first.
> Adding support for inherited properties isn't too difficult, I just
> need to get to those at some point. Also, for inherited properties, we
> can't really block probing because the child device might not depend
> on that resource. Inherited properties are mainly relevant only for
> sync_state() callbacks.

You're looking at the wrong property. You need to look for
'interrupts' and 'interrupts-extended'. Pretty good chance if the
device has interrupts, then it needs them. The latter is easy. It's
just like the others you have (phandle + cells). If you have
'interrupts' then you need to walk the interrupt tree the same way the
OF IRQ code already does.

> > There's also all the other ways the
> > parent can be determined. Any parent node with 'interrupt-controller'
> > or 'interrupt-map' property is the parent. And there's
> > 'interrupts-extended' too.
>
> Now I'm confused. Not sure if you are referring to actual device
> parent now or if you are talking about an "interrupt supplier".

Yes. both. The interrupt tree may or may not mirror the device node
tree. Or you could have a mixture. You've got to handle both cases.
But really, you just need to use the code that's already there to do
all that and deal with all these conditions. Essentially, you need to
copy of_irq_get(), but get the struct device from the irq_domain.

Rob
