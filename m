Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DA2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63872184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPfi7HGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbfDRI4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:56:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40402 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfDRI4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:56:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so1925091wmi.5;
        Thu, 18 Apr 2019 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ofNGuqVkXEACpHHyAM4G39jY0P/rZkaXHRRNgIeZlhs=;
        b=UPfi7HGQnM/LWDKeVS7R96CbdOOxoHn8+Izsqqs5xgIdEnXjK4SOKJrXR7yN3z2sf0
         jpTuEW26KoW/u8j1iRZlseQqbApX9MeM+4eeY6Gb2wQf3Yr7mcyYB11x6gEMwbrTBkrt
         nSzNoVlZlZAX1v7QscdqHybclWMZRfExGOZUwVGAd9zOWDiTZLeyGHfOOEAg6dOx5NMC
         YyBvASu/O1ham7gyNDAT/dMGuhvSUpj9/JPGZkbKSPNUJdLXojgDTl/eDNHOMb9q+FtK
         LglxhgZzNCcV8SaNpkH8v4tRFPLlpZgQmFqtxVb7HqfBTG3hWWAtFVGgkcTCwM5bA4P+
         HX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ofNGuqVkXEACpHHyAM4G39jY0P/rZkaXHRRNgIeZlhs=;
        b=Swazuhox/y+JhkZ6kDl1yv9JeijxBg4iW3YaTvpi7NTe9FHFnlP0k4GtCyjuFlOYc5
         dQwkQiQ7bX60x80YHz0odR9IrDK4W2Hm68AGNEH6XnRXIkIrkYal2Hh1hestMJ3iQ/fj
         MCUsqlE/SdTCUGo7yJOf0hr+L+TJzXKkiU9sN0ZxdQJmGu8bZ3ePh+5KoyntCQe6L/cf
         lk/2W7nHP49sm/u5DfYnjTnNs8rNK7Uhai+nuBFPXD3biBEI6n6755PxYJAZvtqkFzMm
         j/eqjP2Yquawgp3izUdchXKyMtMl/8ASLr53C5W9PjVZfq9BWDDNWn4PcBvHBJkiTCbc
         iKfw==
X-Gm-Message-State: APjAAAUt8NXspHCnWZu7E+eThI6gEBu+Sz/X2+AZKtg/lurbnOSVLjoo
        17HrF54b9hRdrv4GELwOWOMedFlUVLP6YLu02OU=
X-Google-Smtp-Source: APXvYqzLncgW5IfzmieoWF4g3K7QQmWeAF4OSxWVwxg2KNG5zsoaKn6z4F2qgb0BfXul7zawJloPMFkSnS8Ov0rzi9k=
X-Received: by 2002:a1c:9ad6:: with SMTP id c205mr2149508wme.46.1555577788984;
 Thu, 18 Apr 2019 01:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190416104748.26942-1-stefanha@redhat.com> <c18ed846-940b-0b10-3d40-639b1f8dc499@redhat.com>
In-Reply-To: <c18ed846-940b-0b10-3d40-639b1f8dc499@redhat.com>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Thu, 18 Apr 2019 09:56:17 +0100
Message-ID: <CAJSP0QX_daRKAoXY2_w4Bmxv-fo5Kw1DgvYz7AUwJxGdEdw9Xg@mail.gmail.com>
Subject: Re: [PATCH] vhost/scsi: drop unnecessary smp_mb__after_atomic()
To:     Jason Wang <jasowang@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, kvm <kvm@vger.kernel.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 6:57 AM Jason Wang <jasowang@redhat.com> wrote:
> On 2019/4/16 =E4=B8=8B=E5=8D=886:47, Stefan Hajnoczi wrote:
> > The vhost_scsi.ko code used several atomic variables at one point.
> > Later they were dropped or converted to regular ints protected by a
> > mutex.
> >
> > The commit that made these changes left an unused smp_mb__after_atomic(=
)
> > in vhost_scsi_set_endpoint().  It was previously used after incrementin=
g
> > vhost_scsi->vhost_ref_cnt but this field has been dropped:
> >
> >    -     atomic_inc(&vs->vhost_ref_cnt);
> >          smp_mb__after_atomic_inc();
> >
> > Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Fixes: 101998f6fcd680 ("tcm_vhost: Post-merge review changes requested =
by MST")
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   drivers/vhost/scsi.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 618fb6461017..c090d177bd75 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -1443,7 +1443,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
> >                       tpg->tv_tpg_vhost_count++;
> >                       tpg->vhost_scsi =3D vs;
> >                       vs_tpg[tpg->tport_tpgt] =3D tpg;
> > -                     smp_mb__after_atomic();
> >                       match =3D true;
> >               }
> >               mutex_unlock(&tpg->tv_tpg_mutex);
>
>
> Looks like Paolo has sent an identical patch before this one.

Yes, Paolo's patch is fine.

Stefan
