Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF54C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65D02077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfHPTyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:54:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43784 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHPTyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:54:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id e12so10601921otp.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 12:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhk98FXxFRQ9VzMWkuvWVr9LbIZw8iDdkRwGMQbAjYc=;
        b=LSk5bNhT1TRhGJRB3+O1EmgDOIVa4LcomOEDVhe/FDmPcKD9DGRnM4uKlqS7bUBNIg
         0SDafWuOP1ol0f1weZnoXmKWjaXkebC+1P8Yfg8KrYN7UHXnDsO9ydPiuTVPIk+xgNOQ
         TjnAIbLPCH71UAbWlhcudDkAI3RCbe+KkemnnPHcvA2/aa06syI+/k1QmhmLxOokIYxc
         Rnur3gi3zfgrkMKxeygfbp/GjAtMukS1AAaA1qd9qCuVAKDUQzjveQymExruL7oYmLq/
         Zt+FdcGf3VJilYd694E3ezvTqluDiDBdCPw8l3BeLKpWHnFIFiNqYT4xeQtUvRPmGXSZ
         Msiw==
X-Gm-Message-State: APjAAAUgr63Iv8/A86GROjeWQCFvCAJCKUNh13nK9IWDrgJVeWugolOn
        zdbUHSxLHqdkjyXodZxmtlbmvXGR7Sw=
X-Google-Smtp-Source: APXvYqxXpO1CCmopz2lXKzn86UudfVxoy+X2agP8mvDt1A4wvB7pnKk4f0t3QGI+5UsMrZqrXiBykw==
X-Received: by 2002:a05:6830:1e0c:: with SMTP id s12mr8916379otr.262.1565985258937;
        Fri, 16 Aug 2019 12:54:18 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id t81sm1675700oie.48.2019.08.16.12.54.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 12:54:18 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id p124so5649012oig.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 12:54:18 -0700 (PDT)
X-Received: by 2002:aca:4c2:: with SMTP id 185mr6282741oie.154.1565985258261;
 Fri, 16 Aug 2019 12:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
 <1562165800-30721-2-git-send-email-ioana.ciornei@nxp.com> <CADRPPNQDRhocXmpA08rEBqpFBrm1ub9z3+r74GNcMs6bqUL8OA@mail.gmail.com>
 <VI1PR04MB5134343A13244638431C3975ECAF0@VI1PR04MB5134.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5134343A13244638431C3975ECAF0@VI1PR04MB5134.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 16 Aug 2019 14:54:07 -0500
X-Gmail-Original-Message-ID: <CADRPPNR5osgG-bnDB-dtN77GJizeEYZKaSuP5uwi+jZ4_tCL4Q@mail.gmail.com>
Message-ID: <CADRPPNR5osgG-bnDB-dtN77GJizeEYZKaSuP5uwi+jZ4_tCL4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] bus: fsl-mc: remove explicit device_link_del
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 1:04 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
> Hi Leo,
>
> > -----Original Message-----
> > From: Li Yang <leoyang.li@nxp.com>
> > Sent: Friday, August 16, 2019 2:13 AM
> > To: Ioana Ciornei <ioana.ciornei@nxp.com>
> > Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>; Roy Pledge
> > <roy.pledge@nxp.com>; lkml <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 1/3] bus: fsl-mc: remove explicit device_link_del
> > Importance: High
> >
> > On Wed, Jul 3, 2019 at 9:58 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
> > >
> > > Starting with commit 72175d4ea4c4 ("driver core: Make driver core own
> > > stateful device links") stateful device links are owned by the driver
> > > core and should not be explicitly removed on device unbind. Delete all
> > > device_link_del appearances from the fsl-mc bus.
> > >
> > > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> >
> > Hi Laurentiu,
> >
> > What do you think of this patches?  I can take it through fsl/soc if
> > you can ACK it.
>
> Looks good to me, so for the whole series:
>
> Acked-By: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Thanks.  Applied for next.


>
> > Regards,
> > Leo
> >
> > > ---
> > >  drivers/bus/fsl-mc/fsl-mc-allocator.c | 1 -
> > >  drivers/bus/fsl-mc/mc-io.c            | 1 -
> > >  2 files changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-
> > mc/fsl-mc-allocator.c
> > > index 8ad77246f322..cc7bb900f524 100644
> > > --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > > +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > > @@ -330,7 +330,6 @@ void fsl_mc_object_free(struct fsl_mc_device
> > *mc_adev)
> > >
> > >         fsl_mc_resource_free(resource);
> > >
> > > -       device_link_del(mc_adev->consumer_link);
> > >         mc_adev->consumer_link = NULL;
> > >  }
> > >  EXPORT_SYMBOL_GPL(fsl_mc_object_free);
> > > diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
> > > index 3ae574a58cce..d9629fc13a15 100644
> > > --- a/drivers/bus/fsl-mc/mc-io.c
> > > +++ b/drivers/bus/fsl-mc/mc-io.c
> > > @@ -255,7 +255,6 @@ void fsl_mc_portal_free(struct fsl_mc_io *mc_io)
> > >         fsl_destroy_mc_io(mc_io);
> > >         fsl_mc_resource_free(resource);
> > >
> > > -       device_link_del(dpmcp_dev->consumer_link);
> > >         dpmcp_dev->consumer_link = NULL;
> > >  }
> > >  EXPORT_SYMBOL_GPL(fsl_mc_portal_free);
> > > --
> > > 1.9.1
> > >
