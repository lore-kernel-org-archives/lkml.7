Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CA3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5340E2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OG0vgygz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKSUpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:45:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37700 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKSUpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:45:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id e187so19183720qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 12:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zoHvXClIsnXWrgdxu3K2jU5/KdggH/WhFo/M72uCAgw=;
        b=OG0vgygz+pz1si6C6obQtYr/Y8ubaS7TSijBKd6HNxscmu96GUD8rfxsHAss8vn9WO
         +fmU8irYX7vAD7XUouMMfdy+nd5Tu/He7KdY9EpKtMhTlCDm80g+Jbr7KI81alrGW80u
         zAcB0205ii26BFoenZ6aR8wUEG9+Ft1GxQK8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zoHvXClIsnXWrgdxu3K2jU5/KdggH/WhFo/M72uCAgw=;
        b=HQ1R1uTnS1N2oyZtfSJ61N/OTVgrLTvBkV0NCFnf4wRFtV0hflChkQ4aPLoS5R3fHD
         UbL+3Mi8P7IOv+sxSK99HVjUFYirIKQpOwgJlHJJG/P0hi52vRTM9Yv3ROzuVuXRR3kT
         B4fep7SDqze0qHa9sySvOUnrLN6Q+KcS+dMV42m/9EWb7opRRW1mCu14BS40NJkJ4wNM
         GQZ6me1/qXOw6T0fMVN0TJXYQ8nAHsbO3+XjcihPdB3lFKxBvxBB0LwLeB+1J3CGUUjq
         gHO4I6LsAdMuAca3bkrtU2F4UMVQG8ANbqatUxjGSa8finJG5um2JcocEmllmT/CGK1t
         iq+Q==
X-Gm-Message-State: APjAAAWjh1dqpR0S2SelJE3hr/2r/LVSQD9yC3XrqIMo+Hm/rXzm0zCF
        O1rUdubySZsN4Wyjz75Seyte0Qf/eBKM9Os81R15JA==
X-Google-Smtp-Source: APXvYqwkF8zKdheUZutDXGvomMKZgmnKZEPs1I3QnGWgJ9PSOIad16PyVEIIIUTKIpefAzU/9TTaITD1t72IMo2Ae4Y=
X-Received: by 2002:a37:d91:: with SMTP id 139mr28563973qkn.79.1574196343510;
 Tue, 19 Nov 2019 12:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
 <20191118110335.v6.4.I3e900de9478b68e5e4475e747d1c46fdd28313fa@changeid> <963EC7CC-B81D-4667-A681-2CE49D17CB1E@holtmann.org>
In-Reply-To: <963EC7CC-B81D-4667-A681-2CE49D17CB1E@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 19 Nov 2019 12:45:32 -0800
Message-ID: <CANFp7mX8zsFBjQ4pYyBnG4KbTv-0m004LPmYAtLmGRm3rkfoRA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] Bluetooth: hci_bcm: Support pcm params in dts
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 9:44 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Abhishek,
>
> > BCM chips may require configuration of PCM to operate correctly and
> > there is a vendor specific HCI command to do this. Add support in the
> > hci_bcm driver to parse this from devicetree and configure the chip.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v6:
> > - Added btbcm_read_pcm_int_params and change pcm params to first read
> >  the pcm params before setting it
> >
> > Changes in v5:
> > - Rename parameters to bt-* and read as integer instead of bytestring
> > - Update documentation with defaults and put values in header
> > - Changed patch order
> >
> > Changes in v4:
> > - Fix incorrect function name in hci_bcm
> >
> > Changes in v3:
> > - Change disallow baudrate setting to return -EBUSY if called before
> >  ready. bcm_proto is no longer modified and is back to being const.
> > - Changed btbcm_set_pcm_params to btbcm_set_pcm_int_params
> > - Changed brcm,sco-routing to brcm,bt-sco-routing
> >
> > Changes in v2:
> > - Use match data to disallow baudrate setting
> > - Parse pcm parameters by name instead of as a byte string
> > - Fix prefix for dt-bindings commit
> >
> > drivers/bluetooth/hci_bcm.c | 57 +++++++++++++++++++++++++++++++++++++
> > 1 file changed, 57 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> > index ee40003008d8..2ce3fac2c5dd 100644
> > --- a/drivers/bluetooth/hci_bcm.c
> > +++ b/drivers/bluetooth/hci_bcm.c
> > @@ -25,6 +25,7 @@
> > #include <linux/pm_runtime.h>
> > #include <linux/serdev.h>
> >
> > +#include <dt-bindings/bluetooth/brcm.h>
> > #include <net/bluetooth/bluetooth.h>
> > #include <net/bluetooth/hci_core.h>
> >
> > @@ -88,6 +89,7 @@ struct bcm_device_data {
> >  *    used to disable flow control during runtime suspend and system sl=
eep
> >  * @is_suspended: whether flow control is currently disabled
> >  * @no_early_set_baudrate: don't set_baudrate before setup()
> > + * @pcm_params: PCM and routing parameters
> >  */
> > struct bcm_device {
> >       /* Must be the first member, hci_serdev.c expects this. */
> > @@ -122,6 +124,8 @@ struct bcm_device {
> >       bool                    is_suspended;
> > #endif
> >       bool                    no_early_set_baudrate;
> > +
> > +     struct bcm_set_pcm_int_params   pcm_params;
> > };
> >
> > /* generic bcm uart resources */
> > @@ -541,6 +545,7 @@ static int bcm_flush(struct hci_uart *hu)
> > static int bcm_setup(struct hci_uart *hu)
> > {
> >       struct bcm_data *bcm =3D hu->priv;
> > +     struct bcm_set_pcm_int_params p;
> >       char fw_name[64];
> >       const struct firmware *fw;
> >       unsigned int speed;
> > @@ -594,6 +599,31 @@ static int bcm_setup(struct hci_uart *hu)
> >                       host_set_baudrate(hu, speed);
> >       }
> >
> > +     /* PCM parameters if any*/
> > +     err =3D btbcm_read_pcm_int_params(hu->hdev, &p);
> > +     if (!err) {
> > +             if (bcm->dev->pcm_params.routing =3D=3D 0xff)
> > +                     bcm->dev->pcm_params.routing =3D p.routing;
> > +             if (bcm->dev->pcm_params.rate =3D=3D 0xff)
> > +                     bcm->dev->pcm_params.rate =3D p.rate;
> > +             if (bcm->dev->pcm_params.frame_sync =3D=3D 0xff)
> > +                     bcm->dev->pcm_params.frame_sync =3D p.frame_sync;
> > +             if (bcm->dev->pcm_params.sync_mode =3D=3D 0xff)
> > +                     bcm->dev->pcm_params.sync_mode =3D p.sync_mode;
> > +             if (bcm->dev->pcm_params.clock_mode =3D=3D 0xff)
> > +                     bcm->dev->pcm_params.clock_mode =3D p.clock_mode;
>
> Frankly, I wouldn=E2=80=99t bother here. If the read HCI command failed, =
then we abort bcm_setup and fail the whole procedure. These commands have b=
een around the first Broadcom chips and you can assume they are present. An=
d if at some point they do fail, I want to know about it.
Ok -- will change to return error if it fails.

>
> > +
> > +             /* Write only when there are changes */
> > +             if (memcmp(&p, &bcm->dev->pcm_params, sizeof(p)))
> > +                     err =3D btbcm_write_pcm_int_params(hu->hdev,
> > +                                                      &bcm->dev->pcm_p=
arams);
> > +
> > +             if (err)
> > +                     bt_dev_warn(hu->hdev, "BCM: Write pcm params fail=
ed (%d)",
> > +                                 err);
> > +     } else
> > +             bt_dev_warn(hu->hdev, "BCM: Read pcm params failed (%d)",=
 err);
> > +
> > finalize:
> >       release_firmware(fw);
> >
> > @@ -1128,9 +1158,36 @@ static int bcm_acpi_probe(struct bcm_device *dev=
)
> > }
> > #endif /* CONFIG_ACPI */
> >
> > +static int property_read_u8(struct device *dev, const char *prop, u8 *=
value)
> > +{
> > +     int err;
> > +     u32 tmp;
> > +
> > +     err =3D device_property_read_u32(dev, prop, &tmp);
> > +
> > +     if (!err)
> > +             *value =3D (u8)tmp;
> > +
> > +     return err;
> > +}
>
> I think this really needs to be done in the generic property code if this=
 is wanted.
Yes, this should be device_property_read_u8. For some reason, I
thought that wasn't working before (I'll have to retest it with
straight integer values).

>
> > +
> > static int bcm_of_probe(struct bcm_device *bdev)
> > {
> >       device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_spee=
d);
> > +
> > +     memset(&bdev->pcm_params, 0xff, sizeof(bdev->pcm_params));
>
> Scrap this memset. We will read the values first.

I added this memset is bcm_of_probe occurs before patchram and without
setting some magic value in the pcm_params, we don't know which values
are valid (since 0 has some meaning in the params).
It doesn't make sense to me to read pcm params outside setup (I want
patchram to complete first) and it doesn't make sense to do property
reads inside setup.


>
> > +
> > +     property_read_u8(bdev->dev, "brcm,bt-sco-routing",
> > +                      &bdev->pcm_params.routing);
> > +     property_read_u8(bdev->dev, "brcm,bt-pcm-interface-rate",
> > +                      &bdev->pcm_params.rate);
> > +     property_read_u8(bdev->dev, "brcm,bt-pcm-frame-type",
> > +                      &bdev->pcm_params.frame_sync);
> > +     property_read_u8(bdev->dev, "brcm,bt-pcm-sync-mode",
> > +                      &bdev->pcm_params.sync_mode);
> > +     property_read_u8(bdev->dev, "brcm,bt-pcm-clock-mode",
> > +                      &bdev->pcm_params.clock_mode);
> > +
> >       return 0;
> > }
>
> Regards
>
> Marcel
>
