Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694CBCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402F020848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yp07K186"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfKDTCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:02:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35638 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfKDTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:02:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id n16so15133311oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHvMybYCPvLOcRHqCBZyxUzdSqz4vFyRg5UuR2Ahyew=;
        b=Yp07K186DuxwZHZLbvAqheApB9VC785SKUV264EeioFCjyGfcjLdY6R/3zrMgomkf6
         iAZvA//p0ACWZZZ3ru+YoQPAaSdy/Xlgq54DG1DBJstqJwrKEytiSDPVksn0ov45SfdD
         BCFimiCInTI1x7cgvt5ZjyaN1j8gS0PElAUlt0ZdXktta6B1w1k9aWa0G//JRs4OPz/w
         uFfV+z0dtmAsPluS3BtHOHYUih5RlVD/Iye9TuroC7Idm1Sf9+t+oXEiqGh9H42x39OC
         Yn/yxRPTZP0PZnBKSsF3rABozZBCYGOdtbSQvyphlHyFlPtmDv33p5yAYOiS4SBY7HAV
         1vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHvMybYCPvLOcRHqCBZyxUzdSqz4vFyRg5UuR2Ahyew=;
        b=auQaVQ+jwKeGLXIWr2X9wG0O5NtsKU+yzxwTrCjGXWmqUTNXC2sOsgWyHP4ZG/0sen
         PeSSdeJ18bOZEBJK8EIwgdBQAhCH9l8ZVUhc/jS2pPBEiG9Ffl2EKX6GW1K8RbHIwyK5
         ytRxYGntPlt+Y72hE+UQ4DCYON0o4fyQ7EUFZ+/TSBzgNCgKVbtKt9IgDToZMUmV85WM
         sKo6TkiRA4hH5TNIodiUljhVcR2mo5eLdnd16xMbMA02ZCKEYakxpJ6yuxPK6OZsJrQO
         pOD3SB0V4HRLPEfLlS/XK08uvBm/+DOkpIruQjIvp0HASdPRFm6nT1xlunMyL8uNBEr0
         bP1Q==
X-Gm-Message-State: APjAAAVKSEVapU9b64FazaGYarRo4aZ6SH4JHvTMBegEzD/hyjm7XVd+
        4RXj6OcVIVMslDeLvUszqtpBZLLvl/JDjbtB/wJAlQ==
X-Google-Smtp-Source: APXvYqxvMsCRsWBIDZ0SqDKRbA2a2jcPrtgP2JA+jl0La2OLtVPkdITmiBc0BO/x8fRSa547Hk9FSYYdLVC57gQLkRs=
X-Received: by 2002:aca:f408:: with SMTP id s8mr482330oih.69.1572894140243;
 Mon, 04 Nov 2019 11:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <20191028220027.251605-6-saravanak@google.com>
 <CAL_Jsq+obCEeaNjpvJ6VvO6b2F6A5oHcRD8PYAifUvBQHbQ_Og@mail.gmail.com>
In-Reply-To: <CAL_Jsq+obCEeaNjpvJ6VvO6b2F6A5oHcRD8PYAifUvBQHbQ_Og@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 4 Nov 2019 11:01:44 -0800
Message-ID: <CAGETcx_CL9P3svctyDuGpavG4Ykd+o2G-rxDAE5OUvxL+sj6xA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] of: property: Skip adding device links to
 suppliers that aren't devices
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 7:18 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Oct 28, 2019 at 5:00 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Some devices need to be initialized really early and can't wait for
> > driver core or drivers to be functional.  These devices are typically
> > initialized without creating a struct device for their device nodes.
> >
> > If a supplier ends up being one of these devices, skip trying to add
> > device links to them.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/property.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index f16f85597ccc..21c9d251318a 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1038,6 +1038,7 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> >         struct device *sup_dev;
> >         int ret = 0;
> >         struct device_node *tmp_np = sup_np;
> > +       int is_populated;
> >
> >         of_node_get(sup_np);
> >         /*
> > @@ -1062,9 +1063,10 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> >                 return -EINVAL;
> >         }
> >         sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> > +       is_populated = of_node_check_flag(sup_np, OF_POPULATED);
> >         of_node_put(sup_np);
> >         if (!sup_dev)
> > -               return -EAGAIN;
> > +               return is_populated ? 0 : -EAGAIN;
>
> You're only using the flag in one spot and a comment would be good
> here, so I'd just do:
>
> if (of_node_check_flag(sup_np, OF_POPULATED))
>         return 0; /* Early device without a struct device */

Hi Rob,

Thanks for the review.

I'm using the flag to keep the error handling code simple/cleaner. I
can't do the check like that after I do a put on the sup_np.

Yeah, I was actually planning to add a dev_dbg() message when this
happens and returning a -EINVAL (that'll be ignored by the caller)
instead of -EAGAIN (that's NOT ignored by the caller).

Looks like these changes go pulled into driver-core-next. So I'll send
a delta patch to add the dbg message and also address you nit on the
other patch.

Thanks,
Saravana
