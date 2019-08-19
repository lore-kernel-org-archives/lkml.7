Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E28C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2723D22CE9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZXQXHf3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfHSRGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:06:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35888 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfHSRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:06:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so1565110pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=noWwDzTauAdH7voTFBad2AQ+Cey/02pIHdWu2pK4kc0=;
        b=ZXQXHf3fECWZ6874y/9eFxtHR7nlDZWmozaDYyeyZ3r2edyabgURa+4a3t78bWWZCf
         zklOLddKaSM/ym+eanLClrrGL48I+BcD9O9Nkhg3sp2QyV7s/TyxGSN+TiYUhphI4ntN
         BfPgcCj0Vv7FuNPLfQbQZocSf3epxfS9W3dek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=noWwDzTauAdH7voTFBad2AQ+Cey/02pIHdWu2pK4kc0=;
        b=dAaPo5XjIWe+SOtcB4jsOLz4+2iPeou9cbYgt45KqTeVy+SQCLzDraQCDU4bhljKuo
         sXClbUgT1Ug1aQzwORzzNbu8UlGseJKL9yT/V1UCUIQLYyUE4nznmwUupHq/ChS4/EDd
         wK+0gE0fMQjdoh65pNAa4SrzH61yirVf0bQ2hA//Wf6GpXbocCttWN47W1aoiNLIxVH6
         H/bYmOovdB99rrs53sHTL14lI4jXau6UCYdHfL8LEr3cbt+9pJtjInbpAmReSJKD2JJg
         l6iGyayBOVcy6pTcWO0+qNhX9j44fEEUDNCbVd8RSDxkbKbpkydaBBtDdSoO7ubdu0jG
         CunQ==
X-Gm-Message-State: APjAAAXQDJtVSYEQQnvrjJbEy7itdc4ZKPG8lI7b2wbeJwtCNFw4ZX4T
        oemFncx414roT9vHYYqEg/EDvg==
X-Google-Smtp-Source: APXvYqyeITMosBX3bm+TOl0/Eey6m2MRBX0G8Rrpmef5p/N26ikLmo4kr0YHi3JpYb1FWPxcZhnTqA==
X-Received: by 2002:a62:ac0d:: with SMTP id v13mr24650243pfe.129.1566234401869;
        Mon, 19 Aug 2019 10:06:41 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g36sm29128125pgb.78.2019.08.19.10.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:06:41 -0700 (PDT)
Message-ID: <5d5ad721.1c69fb81.6a514.e649@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819163240.vsgylmctemzgqd34@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org> <20190812223622.73297-3-swboyd@chromium.org> <20190819163240.vsgylmctemzgqd34@linux.intel.com>
Subject: Re: [PATCH v4 2/6] tpm: tpm_tis_spi: Introduce a flow control callback
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 10:06:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-19 09:32:40)
> On Mon, Aug 12, 2019 at 03:36:18PM -0700, Stephen Boyd wrote:
> > Cr50 firmware has a different flow control protocol than the one used by
> > this TPM PTP SPI driver. Introduce a flow control callback so we can
> > override the standard sequence with the custom one that Cr50 uses.
> >=20
> > Cc: Andrey Pronin <apronin@chromium.org>
> > Cc: Duncan Laurie <dlaurie@chromium.org>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/char/tpm/tpm_tis_spi.c | 55 +++++++++++++++++++++-------------
> >  1 file changed, 34 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_=
spi.c
> > index 19513e622053..819602e85b34 100644
> > --- a/drivers/char/tpm/tpm_tis_spi.c
> > +++ b/drivers/char/tpm/tpm_tis_spi.c
> > @@ -42,6 +42,8 @@
> >  struct tpm_tis_spi_phy {
> >       struct tpm_tis_data priv;
> >       struct spi_device *spi_device;
> > +     int (*flow_control)(struct tpm_tis_spi_phy *phy,
> > +                         struct spi_transfer *xfer);
> >       u8 *iobuf;
> >  };
> > =20
> > @@ -50,12 +52,39 @@ static inline struct tpm_tis_spi_phy *to_tpm_tis_sp=
i_phy(struct tpm_tis_data *da
> >       return container_of(data, struct tpm_tis_spi_phy, priv);
> >  }
> > =20
> > +static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
> > +                                 struct spi_transfer *spi_xfer)
> > +{
> > +     struct spi_message m;
> > +     int ret, i;
> > +
> > +     if ((phy->iobuf[3] & 0x01) =3D=3D 0) {
> > +             // handle SPI wait states
> > +             phy->iobuf[0] =3D 0;
> > +
> > +             for (i =3D 0; i < TPM_RETRY; i++) {
> > +                     spi_xfer->len =3D 1;
> > +                     spi_message_init(&m);
> > +                     spi_message_add_tail(spi_xfer, &m);
> > +                     ret =3D spi_sync_locked(phy->spi_device, &m);
> > +                     if (ret < 0)
> > +                             return ret;
> > +                     if (phy->iobuf[0] & 0x01)
> > +                             break;
> > +             }
> > +
> > +             if (i =3D=3D TPM_RETRY)
> > +                     return -ETIMEDOUT;
> > +     }
> > +
> > +     return 0;
> > +}
>=20
> AFAIK the flow control is not part of the SPI standard itself but is
> proprietary for each slave device. Thus, the flow control should be
> documented to the source code. I do not want flow control mechanisms to
> be multiplied before this is done.

Can you clarify this please? I don't understand what "the flow control
should be documented to the source code" means.

>=20
> The magic number 0x01 would be also good to get rid off.
>=20

Ok. What name should the #define be? I can make that another patch.

