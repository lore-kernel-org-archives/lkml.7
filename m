Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA48C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C21922CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdVMTEFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfHULz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:55:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35005 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfHULz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:55:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so1855297wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 04:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KcUkbB1oJAzAeUPVtJdwFSVIzZDZ5ZeL5UV3cYaJ4Uo=;
        b=sdVMTEFZMbSfY285XeoA6H7quYwLJdPYIKQmnG7KUeYKqYiD2iy8LdwWG1VqWhZYr5
         DGjCZpvV97yFFsDkrm/9rcQ5fTO/SUNwA9FXGdBlAUhlo6ir8uZfv7fJeg8N6TCw2uqa
         niPWPvEXoAfftj+IarHWB8eXj+XtfCKe1J3mm+ddPyDo6prlL+rSWW8ejDbPBdDA4K/2
         70vUw5FxcaUx4P9ved1IuitGn8S3uJmns5h5hd/lIrgF3wJcedyPekDg63GWwl6zh6Z9
         IVDI39+vHNdc5bQao1LmsSpUUtxRDQAicTAcfvRltSBqfgJpV0GvXibqDEZJ1gL2ApPf
         Fmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KcUkbB1oJAzAeUPVtJdwFSVIzZDZ5ZeL5UV3cYaJ4Uo=;
        b=DySDjeH58+v2RqIj9XWw3OlVbIrj7vGrK6uEQ7G3KJJsUyFup2NOfk1kNWZbwBMqLi
         hzeBtdt3e63J6Kl3swlqrB23C6/WYVjQoEPq2Pywi/GZi5PFCw9DZ3u4MhqRWSFAHimA
         xemBNvhq2+BK1jkUki+H53VqANSB5haB8I5nbHcBGdemkAL6+/5EdQJpRg3V/hmecKmt
         J+YMIWgR2BXWIo/DH1mORPMSxjWPk1JjUEgVDVZ2XnUcqaaSM4ETCIPsdqZEeLTFb/1f
         z+1BtTMg1qXlmEx1fIboAaR1+5wjOuqQAFgusCnsZYyL1IsnXmAxYgqn8EA+/z7qdSUX
         GpBg==
X-Gm-Message-State: APjAAAXRwyl18n0ggqQ5v7R4ydoBzKuI4gfdS7rFuz7rFVnCTU2KAHLp
        BDfzUIUOJ9MqZly6WgsYb0o=
X-Google-Smtp-Source: APXvYqwunuwr2KDBPIxE6ORT5hP4MncsNPzCGpYDpTideW+0/Ep7oYAVY9cvDl3PxN9oqw7yNLeNbA==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr6063320wmj.25.1566388526985;
        Wed, 21 Aug 2019 04:55:26 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id o16sm28419234wrp.23.2019.08.21.04.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 04:55:25 -0700 (PDT)
Date:   Wed, 21 Aug 2019 13:55:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ben Skeggs <skeggsb@gmail.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-graphics-maintainer@vmware.com,
        Ben Skeggs <bskeggs@redhat.com>,
        spice-devel@lists.freedesktop.org
Subject: Re: [Nouveau] [Intel-gfx] [PATCH v6 08/17] drm/ttm: use gem vma_node
Message-ID: <20190821115523.GA21839@ulmo>
References: <20190805140119.7337-1-kraxel@redhat.com>
 <20190805140119.7337-9-kraxel@redhat.com>
 <20190813151115.GA29955@ulmo>
 <20190814055827.6hrxj6daovxxnnvw@sirius.home.kraxel.org>
 <20190814093524.GA31345@ulmo>
 <20190814101411.lj3p6zjzbjvnnjf4@sirius.home.kraxel.org>
 <CACAvsv5Rar9F=Wf-9HBpndY4QaQZcGCx05j0esvV9pitM=JoGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <CACAvsv5Rar9F=Wf-9HBpndY4QaQZcGCx05j0esvV9pitM=JoGg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 04:33:58PM +1000, Ben Skeggs wrote:
> On Wed, 14 Aug 2019 at 20:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > > Changing the order doesn't look hard.  Patch attached (untested, have no
> > > > test hardware).  But maybe I missed some detail ...
> > >
> > > I came up with something very similar by splitting up nouveau_bo_new()
> > > into allocation and initialization steps, so that when necessary the GEM
> > > object can be initialized in between. I think that's slightly more
> > > flexible and easier to understand than a boolean flag.
> >
> > Yes, that should work too.
> >
> > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Ben Skeggs <bskeggs@redhat.com>

Thanks guys, applied to drm-misc-next.

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1dMSYACgkQ3SOs138+
s6H8fQ/9F4UBF0EhVBpcsMNo5HI1kJ8KEkbiNqUWwZEh/kPLyWXoFWSWvA5FG+rP
521CfufMmyezTHxOkPww6VEUsgaV9yEl00jqIhclgA43sBeDziR4XGzGmA/hpdpc
ky8L49+C8mfoICLHeBjOSbSHoPhv7EqS1w8CtZkCZkf1nApk/R71bbYk6iz8zCCY
dhZo6PGTJMpOoEQtryLjL2NJxvJe57zzsltRKxl9uEnjeDF0LRzqHYZ1Lt/mvRMn
hXMXC1H+jOtP4p7OtP8zE6oM7desaJ2h4jXF1v1/AZHNUxQYtRohHNrYXBDqfQF5
stLLdOjynZ8rcjhObmi3GeLbVeD2wEQJ7Qp7OgTwqbHnE4wXmAYD4KuKboJrQI8t
0Hd25epBD/CHDgn7Kqoj8DRy5NArmeCGRDHVuFYF45utaectO7IzaxRD5zLRs6Q5
vAA0fiy8JVs6ppQ6B9GtlQcXEKbmywLhBAzHb/Q7hukhppOhS+BxZO0FASdPmPnH
0kjoVG0oz9oH8X/ciqubGIAUkrq+SP+OnPVvg1zGfAkxLSUTDKMZ4ZmP2vlrRzaf
KFbFX02Gu+VDe/o7Pcf9F8pDlWS+jQL6KN+PFo2tkGP8HvouRsIagyzY/AJD0xuP
Bb3DKPgm8W5/ggiLoiTbXz+CUWR25Hm2vBU/CZ9Uv9KBPgv95bA=
=lGaC
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
