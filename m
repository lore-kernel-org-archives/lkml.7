Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD03CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBB1206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RuGtcHgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKMVWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:22:44 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41543 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:22:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id m125so3116252qkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5D+0l5YX7kW94tdUvORkwws9N/E0rSMWEMH/aWYGCM=;
        b=RuGtcHgyES0alZRPSvzuMKMS1akTNwu8rQqiiE0qNV3Qy3YnFzheMDE/xjJqUpG0n9
         EVGOjLnrQWIDNgAX0oTU7HKxDB6xJU2s7+XLerRGujebZFWK6n24xMEEQRgdD1lViHwG
         w8kUz0mo1XPBJQgPuFeKE7ef3jqWCBWgufGZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5D+0l5YX7kW94tdUvORkwws9N/E0rSMWEMH/aWYGCM=;
        b=Wo5c1O8eCIQWY0QdTqPAFq0rln3jyMasd7k34olK18XM5G3oskNJ/WxlhW3Ef9f+0x
         Kl+4kpSbL3S9F9ain0dO+6OTGhjymq9MsFpjJPjIXt5blvL9yN4jiOoD+m3OLncKoWZ8
         nN1shBR34Q+j89UbwxaoaTVaHMZJnEJSMYi4x6jysZhJ/NF2GDNbAhI7y0JNHGkuChvz
         HWxXgZZ6TpldqOnY09vJfiDMjzAvxLqWIRTUM/RyG0f2sM+cOGTsRhof2A9N3jwSAitv
         DfxAK1PIT5aohTqrqgF02TrWOHEHsIOcNG2VFuoY58vL3kb0kAHRlG+vDaB1SaMnSXa/
         i/sA==
X-Gm-Message-State: APjAAAVRyIoYtSEALq75Wsam8cxoYyYvsjLqwtm0wt3bmqnVOaoGYpUv
        zTbGFMXcnrk7igXme5BPUQ4RV8s31lQUeUAB8IZaQrSz
X-Google-Smtp-Source: APXvYqxiGunaKyUs/he4AdfvGfT2knL19MLF8BA0pVlIy1AoRxGy5c5Y/AE0teKVLEm1WL8traRZ3T2koVDdsnAhKoM=
X-Received: by 2002:a05:620a:1032:: with SMTP id a18mr3070746qkk.305.1573680162664;
 Wed, 13 Nov 2019 13:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
 <20191112230944.48716-4-abhishekpandit@chromium.org> <DCCD0A71-D696-4701-9BBB-ED6D8FECC7FB@holtmann.org>
In-Reply-To: <DCCD0A71-D696-4701-9BBB-ED6D8FECC7FB@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 13 Nov 2019 13:22:31 -0800
Message-ID: <CANFp7mX0tXmBdJOkBUbar6Niwv9D60Fo9CvAcUkEKZKLnt--hQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] Bluetooth: hci_bcm: Support pcm params in dts
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,



On Tue, Nov 12, 2019 at 4:18 PM Marcel Holtmann <marcel@holtmann.org> wrote:
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
> > Changes in v4: None
> > Changes in v3: None
> > Changes in v2: None
> >
> > drivers/bluetooth/hci_bcm.c | 32 ++++++++++++++++++++++++++++++++
> > 1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> > index 6134bff58748..4ee0b45be7e2 100644
> > --- a/drivers/bluetooth/hci_bcm.c
> > +++ b/drivers/bluetooth/hci_bcm.c
> > @@ -88,6 +88,8 @@ struct bcm_device_data {
> >  *    used to disable flow control during runtime suspend and system sleep
> >  * @is_suspended: whether flow control is currently disabled
> >  * @disallow_set_baudrate: don't allow set_baudrate
> > + * @has_pcm_params: whether PCM parameters need to be configured
> > + * @pcm_params: PCM and routing parameters
> >  */
> > struct bcm_device {
> >       /* Must be the first member, hci_serdev.c expects this. */
> > @@ -122,6 +124,9 @@ struct bcm_device {
> >       bool                    is_suspended;
> > #endif
> >       bool                    disallow_set_baudrate;
> > +
> > +     bool                            has_pcm_params;
> > +     struct bcm_set_pcm_int_params   pcm_params;
> > };
> >
> > /* generic bcm uart resources */
> > @@ -596,6 +601,16 @@ static int bcm_setup(struct hci_uart *hu)
> >                       host_set_baudrate(hu, speed);
> >       }
> >
> > +     /* PCM parameters if any*/
> > +     if (bcm->dev && bcm->dev->has_pcm_params) {
> > +             err = btbcm_set_pcm_int_params(hu->hdev, &bcm->dev->pcm_params);
> > +
> > +             if (err) {
> > +                     bt_dev_info(hu->hdev, "BCM: Set pcm params failed (%d)",
> > +                                 err);
> > +             }
> > +     }
> > +
> > finalize:
> >       release_firmware(fw);
> >
> > @@ -1132,7 +1147,24 @@ static int bcm_acpi_probe(struct bcm_device *dev)
> >
> > static int bcm_of_probe(struct bcm_device *bdev)
> > {
> > +     int err;
> > +
> >       device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
> > +
> > +     err = device_property_read_u8(bdev->dev, "brcm,bt-sco-routing",
> > +                                   &bdev->pcm_params.routing);
> > +     if (!err)
> > +             bdev->has_pcm_params = true;
>
> I think in case of HCI as routing path, these should be using the default or zero values as defined by Broadcom.

I'm not sure what these default values should be. Wouldn't it be
reasonable to expect the user/developer to set the various brcm
parameters in device tree?
If unset, it's just 0.

>
> > +
> > +     device_property_read_u8(bdev->dev, "brcm,pcm-interface-rate",
> > +                             &bdev->pcm_params.rate);
> > +     device_property_read_u8(bdev->dev, "brcm,pcm-frame-type",
> > +                             &bdev->pcm_params.frame_sync);
> > +     device_property_read_u8(bdev->dev, "brcm,pcm-sync-mode",
> > +                             &bdev->pcm_params.sync_mode);
> > +     device_property_read_u8(bdev->dev, "brcm,pcm-clock-mode",
> > +                             &bdev->pcm_params.clock_mode);
> > +
>
> I would add some sanity checks here.
>
> Regards
>
> Marcel
>
