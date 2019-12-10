Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA54AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CBF20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrYDU4oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLJO1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:27:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25797 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727333AbfLJO1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575988055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzrfXrqS3i0iVxslRT9HAUzTMYttEiFFx6V9DjllFWk=;
        b=MrYDU4oJENAWReISd22FCyf/X2Ca2S4LZ4s3BGuI1N+i3F0CYJTQMTH4kwla6WcFHwbVqv
        G4PdSgq4IOaPt04lLpwbH7lwDo+dOy/Hy0Yb3hUA3EdV1rU0P/Ib2kpoYBj/gyFbUqW5ur
        jTFjmJ2xIf6nXC5uyfxd3HPPkvpMYbI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-xa7TZhTqO7Kb8n4BRlDJvw-1; Tue, 10 Dec 2019 09:27:34 -0500
Received: by mail-wm1-f70.google.com with SMTP id z2so663268wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 06:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X1lHEli2ZPEUphqWeLKjY7ANrLSq38w1XZiJ4O+hMh4=;
        b=DqaAsg/00GExja8cR0BMXey08ffbVHoq0x7ERiwCdn3OsFlsCR+T99J3bl8pFfCzPN
         nu6BGIAGg4z7+hxx6LcnrSZPYjGiBNSN3JtwNuay5Wyj9n2p2XcgUUdqi44kKyCr0Qzy
         vTJQNh08k1tBbuWqHvgD2740OfxxWWTuACINJNv8H8cfDQxcVUuE0X5yH9FNgMRRgUVn
         zubnI+njMsxnQxlpCZtlpAZocO0Gv9NQtIcmm0/42ojhzuA1Z8JCyjkLAIyZUCUKzLdh
         sVHJM5K7Ta+ifLQp01hWD5q/KOr1W5G+bR/uftdgqACE6zWQsAvSAbPxuV8pVTgHwNam
         mGow==
X-Gm-Message-State: APjAAAV0Ur886r7sYk+bR8woex3pyPDkjqdQq5gO8oflPwFwYWeNPHbk
        TLuiEyvSTAqANeSB49VyFw553XHn3vkqiJiraXF2xRidyjIjpBMe0N3aldA/4MqVRF172s+rbIP
        JouQPTdqW5HPDCG9rKAiZ2Gll
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr3443160wmj.36.1575988050871;
        Tue, 10 Dec 2019 06:27:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyORv9pUAClZj3uuRIeWG42TpWgdtau7zFiq4ztIMEHBp0R7wL6KdQcy5e01sv2Y+LjIftgSw==
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr3443140wmj.36.1575988050692;
        Tue, 10 Dec 2019 06:27:30 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id n1sm3420590wrw.52.2019.12.10.06.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:27:30 -0800 (PST)
Date:   Tue, 10 Dec 2019 09:27:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julio Faracco <jcfaracco@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, dnmendes76@gmail.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Shannon Nelson <snelson@pensando.io>,
        Martin Habets <mhabets@solarflare.com>
Subject: Re: [PATCH RFC net-next v8 1/3] netdev: pass the stuck queue to the
 timeout handler
Message-ID: <20191210092623-mutt-send-email-mst@kernel.org>
References: <20191203201804.662066-1-mst@redhat.com>
 <20191203201804.662066-2-mst@redhat.com>
 <CAMuHMdXDm0NiCk1pD_-wS9c-ErmRKkrqnPc_pGKzG=QB35mj9A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXDm0NiCk1pD_-wS9c-ErmRKkrqnPc_pGKzG=QB35mj9A@mail.gmail.com>
X-MC-Unique: xa7TZhTqO7Kb8n4BRlDJvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 08:40:06AM +0100, Geert Uytterhoeven wrote:
> Hi Michael,
>=20
> On Tue, Dec 3, 2019 at 9:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > This allows incrementing the correct timeout statistic without any mess=
.
> > Down the road, devices can learn to reset just the specific queue.
> >
> > The patch was generated with the following script:
>=20
> [...]
>=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> > --- a/drivers/net/ethernet/8390/8390p.c
> > +++ b/drivers/net/ethernet/8390/8390p.c
> > @@ -41,9 +41,9 @@ void eip_set_multicast_list(struct net_device *dev)
> >  }
> >  EXPORT_SYMBOL(eip_set_multicast_list);
> >
> > -void eip_tx_timeout(struct net_device *dev)
> > +void eip_tx_timeout(struct net_device *dev, unsigned int txqueue)
> >  {
> > -       __ei_tx_timeout(dev);
> > +       __ei_tx_timeout(dev, txqueue);
> >  }
> >  EXPORT_SYMBOL(eip_tx_timeout);
>=20
> On Mon, Dec 9, 2019 at 6:37 AM <noreply@ellerman.id.au> wrote:
> > FAILED linux-next/m68k-defconfig/m68k Mon Dec 09, 16:34
> >
> > http://kisskb.ellerman.id.au/kisskb/buildresult/14060060/
> >
> > Commit:   Add linux-next specific files for 20191209
> >           6cf8298daad041cd15dc514d8a4f93ca3636c84e
> > Compiler: m68k-linux-gcc (GCC) 4.6.3 / GNU ld (GNU Binutils) 2.22
> >
> > Possible errors
> > ---------------
> >
> > drivers/net/ethernet/8390/8390p.c:44:6: error: conflicting types for 'e=
ip_tx_timeout'
> > drivers/net/ethernet/8390/8390p.c:48:1: error: conflicting types for 'e=
ip_tx_timeout'
> > make[5]: *** [scripts/Makefile.build:266: drivers/net/ethernet/8390/839=
0p.o] Error 1
> > make[4]: *** [scripts/Makefile.build:503: drivers/net/ethernet/8390] Er=
ror 2
> > make[3]: *** [scripts/Makefile.build:503: drivers/net/ethernet] Error 2
> > make[2]: *** [scripts/Makefile.build:503: drivers/net] Error 2
> > make[1]: *** [Makefile:1693: drivers] Error 2
> > make: *** [Makefile:179: sub-make] Error 2
>=20
> Looks like you forgot to update the forward declaration in
> drivers/net/ethernet/8390/8390.h

Fixed now.

> There may be others...

Could not find any but pls do let me know.

> http://kisskb.ellerman.id.au/kisskb/head/6cf8298daad041cd15dc514d8a4f93ca=
3636c84e/
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

