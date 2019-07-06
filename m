Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F8DC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4970A20663
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL0TN+R2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGFREw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:04:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44405 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfGFREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:04:51 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so25632563iob.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRdcNruqA76PvTTNvSkstBbhHqFooZx9h+rPmzIDiw0=;
        b=kL0TN+R2uTLLzZeyoS2fdnPGHg/w7RNxUZj6aP7tA1EbEHALlzJ4Ev7GsPQQQqaLAp
         Hw4/1CmzzUKCMKJn1qHaSKbWoBD1YiA6oWgTdpYGbCzTNYe2JSl7y4d0s+cucfhMU6Wv
         m4+KSsRMj10djQ5Z4nveDf7BrmHruuDXLGmtM7wCFy004gxa8hjtco5nN+SEI9it7ixC
         synkCYHr02cQwpygSG2d5LUycaTE8egMyvRV52w+RFXnIRGUCmk29jqhn7ygKmpIzlD6
         CFdzPbOliqcBT8DH0lgz9qXtWtwev7sdTI/8rtPpCTjJiigQOmInepyHUmOb/a0lYbKZ
         fdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRdcNruqA76PvTTNvSkstBbhHqFooZx9h+rPmzIDiw0=;
        b=Voa/N7pNihtGgTLmWtD+SsK6t/pzlokmoG9ZonNgFjXZAFaiCHsYq1fmt6PIQ28c6G
         KGb5aIcpDZK2BWo6avK6QGxHa5W3d0NfVR7QbvEvj1wyYI3uKiV16ZddWiSuofUV3sJa
         38siNX8V53d0PYZQck6pGw2dPDkKkKrxp0cPU5WjFBe8j2h8oQ9DPqrJx6CSfT0mhaXh
         dX2SbCfRfUEBhG2D9knyNQI0bZ6fp9+w1DfnL1UKzHLS83GDKKXOdtxiWwCyFLbcFxFF
         CpXGsVW/VMSfUHOxDHQtWL3nQDmPAEHP/oNDyeevofQQ7qyb3brwdPwUNvXNjJWsC/6O
         0USw==
X-Gm-Message-State: APjAAAX6xrTTxFz1zlrvB7b81AcbemCZvju6UsM7JNp7gxvayzdqg2eT
        NtNEPiYEyeZMMD0ztP86NkQ3Ih119MYH7onuRd4=
X-Google-Smtp-Source: APXvYqzJhnGld4PM8Kjf2mnUUIfEg1+0geHoDgeYAWOs/cYjgxkVEu9rWnAUuS3ja6UqD2fwm3VZ+gZmD1oYXUpDHdg=
X-Received: by 2002:a5e:8508:: with SMTP id i8mr10710989ioj.108.1562432690512;
 Sat, 06 Jul 2019 10:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-2-gregkh@linuxfoundation.org> <20190704093200.GM13424@localhost>
 <20190704104311.GA16681@kroah.com> <20190704121143.GA5007@kroah.com>
 <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com> <20190706083251.GA9249@kroah.com>
In-Reply-To: <20190706083251.GA9249@kroah.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sat, 6 Jul 2019 10:04:39 -0700
Message-ID: <CAKdAkRQRdqRZXdkpLdTO0H8fSvy7x1sDNS4GxE0n8dxaLRDJzQ@mail.gmail.com>
Subject: Re: [PATCH 01/12 v2] Platform: add a dev_groups pointer to struct platform_driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, Jul 6, 2019 at 1:32 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 04, 2019 at 02:17:22PM -0700, Dmitry Torokhov wrote:
> > Hi Greg,
> >
> > On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > Platform drivers like to add sysfs groups to their device, but right now
> > > they have to do it "by hand".  The driver core should handle this for
> > > them, but there is no way to get to the bus-default attribute groups as
> > > all platform devices are "special and unique" one-off drivers/devices.
> > >
> > > To combat this, add a dev_groups pointer to platform_driver which allows
> > > a platform driver to set up a list of default attributes that will be
> > > properly created and removed by the platform driver core when a probe()
> > > function is successful and removed right before the device is unbound.
> >
> > Why is this limited to platform bus? Drivers for other buses also
> > often want to augment list of their attributes during probe(). I'd
> > move it to generic probe handling.
>
> This is not limited to the platform at all, the driver core supports
> this for any bus type today, but it's then up to the bus-specific code
> to pass that on to the driver core.  That's usually set for the
> bus-specific attributes that they want exposed for all devices of that
> bus type (see the bus_groups, dev_groups, and drv_groups pointers in
> struct bus_type).
>
> For the platform devices, the problem is that this is something that the
> individual drivers want after they bind to the device.  And as all
> platform devices are "different" they can't be a "common" set of
> attributes, so they need to be created after the device is bound to the
> driver.

I believe that your assertion that only platform devices want to
install custom attributes is incorrect. Drivers for devices attached
to serio, i2c, USB, spi, etc, etc, all have additional attributes:

dtor@dtor-ws:~/kernel/work (master *)$ grep -l '\(i2c\|usb\|spi\)'
`git grep -l '\(device_add_group\|sysfs_create_group\)' -- drivers` |
wc -l
170

I am pretty sure some of this count is false positives, but majority
is actually proper hits.

...

> >
> > We already emit KOBJ_BIND when we finish binding device to a driver,
> > regardless of the bus. I know we still need to teach systemd to handle
> > it properly, but I think it is better than sprinkling KOBJ_CHANGE
> > around.
>
> But the object's attributes did just change, which is what KOBJ_CHANGE
> tells userspace, so this should be the correct thing to say to
> userspace.
>
> And yes, ideally KOBJ_BIND would be handled, and it will be sent once
> the device's probe function succeeds, but we have to deal with old
> userspaces as well, right?

Not for the new functionality, I do not think so. Newer kernels should
be compatible with older userspace as it not breaking it, but new
functionality is not guaranteed to be available with older userspace.

Thanks.

-- 
Dmitry
