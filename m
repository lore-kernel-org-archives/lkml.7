Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F90CC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751F32465B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 13:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgmGlJgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLNNO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 08:14:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26198 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbfLNNOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 08:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576329294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tXUYo8Z/1wc5z0Jgm8edXNyqrl3xATvrCgL0TB1nk/w=;
        b=QgmGlJgk31M3cdPE5A04rioe+FYAY76MlL83lxm5/g1Oqd/tLnKlHImSEgBOGsm2mCg91D
        N3kEK6hv+JEXt1SkymJmr6hAPQP0GhPNPxQMTJYkscsbxTTRaWXPjAeqT4/jKwDe9/6ABD
        kZ6TvMD7Mps9pcBIZq24rL1N0t5gtA0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-vYXazDyDP2S-UDbDhWHZpw-1; Sat, 14 Dec 2019 08:14:50 -0500
X-MC-Unique: vYXazDyDP2S-UDbDhWHZpw-1
Received: by mail-lj1-f200.google.com with SMTP id y15so596303lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 05:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXUYo8Z/1wc5z0Jgm8edXNyqrl3xATvrCgL0TB1nk/w=;
        b=FBETb76HiaLN7rdhWBwk+08VSrUjFjUsFkOApXF8ZlA23IiNzmz44hwShuvFGCGgwT
         gwgiWBNIdX3/F6uyjfWcI2DMTqxnXe/T3YnZgjlxBBrEKw9dCxFB3t6Dfy04CVWblMSg
         O6u63hVVUhKY1cdlt31qG9SSjnbSCRVOoYooRn+49l0iiamPVuQH5zkZyPi9wngaRVAz
         FE/UcVMOHHGuYOq36iZ27I7LCQh3zImJ0sw7hJPDrAkPgIVWMSiAcmZK1pLIkV3sD9GP
         9jpRQ9w3OHX5ES7lQM2ZBmsiWoZqe0PEbBnaMAR4Vn3DmW1VXENJAagtN/AeG6mvbgsA
         yZxg==
X-Gm-Message-State: APjAAAVjNwGO3pQd3V/AF66wUb+7nFJBpQv/L3mSps1tIuxwMTjzurfq
        Zm+W0JImYlJkrmtz5Ib7JmmQmO5K76CYhOXOCfCnEDZ4Dkx1qVbf5YDWNKe6rGToYELpuwpc6pR
        cgvSC2kfTS+jn7n1wIIprEO3YanyPsC7jJModzrXq
X-Received: by 2002:a2e:824a:: with SMTP id j10mr13161576ljh.209.1576329289370;
        Sat, 14 Dec 2019 05:14:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZbGoEbpVT/4Wz1na9eFRLpPfqSek9IjoemkGbe1gb3IsBoF63dOqBqzFEQofQR68ctx7JMlHOmw1geb/Km1Q=
X-Received: by 2002:a2e:824a:: with SMTP id j10mr13161563ljh.209.1576329289135;
 Sat, 14 Dec 2019 05:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20191210152454.86247-1-mcroce@redhat.com> <20191213181051.0f949b17@cakuba.netronome.com>
In-Reply-To: <20191213181051.0f949b17@cakuba.netronome.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sat, 14 Dec 2019 14:14:13 +0100
Message-ID: <CAGnkfhwbp3ZzsMTSuAP9WQhs49PJmPimoX1D-M+0uWuUErO91A@mail.gmail.com>
Subject: Re: [PATCH net-next] bonding: don't init workqueues on error
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 3:11 AM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Tue, 10 Dec 2019 16:24:54 +0100, Matteo Croce wrote:
> > bond_create() initialize six workqueues used later on.
>
> Work _entries_ not _queues_ no?
>

Right

> > In the unlikely event that the device registration fails, these
> > structures are initialized unnecessarily, so move the initialization
> > out of the error path. Also, create an error label to remove some
> > duplicated code.
>
> Does the initialization of work entries matter? Is this prep for further
> changes?
>

Not a big issue, I just found useless to initialize those data and
free a bit later.
Just a cleanup.

> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index fcb7c2f7f001..8756b6a023d7 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -4889,8 +4889,8 @@ int bond_create(struct net *net, const char *name)
> >                                  bond_setup, tx_queues);
> >       if (!bond_dev) {
> >               pr_err("%s: eek! can't alloc netdev!\n", name);
>
> If this is a clean up patch I think this pr_err() could also be removed?
> Memory allocation usually fail very loudly so there should be no reason
> to print more errors.
>

Sure, I just didn't want to alter the behaviour too much.

> > -             rtnl_unlock();
> > -             return -ENOMEM;
> > +             res = -ENOMEM;
> > +             goto out_unlock;
> >       }
> >
> >       /*
> > @@ -4905,14 +4905,17 @@ int bond_create(struct net *net, const char *name)
> >       bond_dev->rtnl_link_ops = &bond_link_ops;
> >
> >       res = register_netdevice(bond_dev);
> > +     if (res < 0) {
> > +             free_netdev(bond_dev);
> > +             goto out_unlock;
> > +     }
> >
> >       netif_carrier_off(bond_dev);
> >
> >       bond_work_init_all(bond);
> >
> > +out_unlock:
> >       rtnl_unlock();
> > -     if (res < 0)
> > -             free_netdev(bond_dev);
> >       return res;
> >  }
> >
>
> I do appreciate that the change makes the error handling follow a more
> usual kernel pattern, but IMHO it'd be even better if the error
> handling was completely moved. IOW the success path should end with
> return 0; and the error path should contain free_netdev(bond_dev);
>
> -       int res;
> +       int err;
>
>         [...]
>
>         rtnl_unlock();
>
>         return 0;
>
> err_free_netdev:
>         free_netdev(bond_dev);
> err_unlock:
>         rtnl_unlock();
>         return err;
>
> I'm just not 100% sold on the improvement made by this patch being
> worth the code churn, please convince me, respin or get an ack from
> one of the maintainers? :)
>

ACK :)

-- 
Matteo Croce
per aspera ad upstream

