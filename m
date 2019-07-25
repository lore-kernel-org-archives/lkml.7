Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A683C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B7B21850
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tevdOS7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGYTSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:18:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34224 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfGYTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:18:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so49090798ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0fd0oFEswecqBPEcu1bWdGlSLirs/xBYI2LmiXMzD5U=;
        b=tevdOS7EgwvLUt2GYEGrIP+UkxhaT+RcznLU3j2QtNfKhTTcUDCpOglktQURMIJWRa
         hC/919IZuLQ3lATeoY/J3NMvQollICqlRIx+Qh7gtIntvFMX3EufAH7feU6Ey76IQx0p
         NfafUiQNdAx6hbmbhNXBDgXRGftvmjQRHatQ7QE9zTFEjy/bO9WWTJFhE8WiVUfhSJfL
         sE6opc8JuDL3J7sh+LPmG95hswgPsvr9Pr9ZaQpbtZ0yLZKokgEyTaqnd3efJFSRZdMi
         vtPyMOOdzMo9HVj8ndOpOQ7xIa8B8VYYirNMza9bkwzf8cKBZMA1ua2hFFw4C+iwXWu9
         D6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0fd0oFEswecqBPEcu1bWdGlSLirs/xBYI2LmiXMzD5U=;
        b=dLyKZXdF1gdGHuulzIYmt2/I41VPIU7NhIsUZ66Huu2Ovez4JD99g54LwyvfMpWyfm
         HDjJ0cYaEG6IrxpuLSFGvV6jhSKEqRB0dIX7Fm0HuNDfxIP7jr00LC1h3nhnNmlQu1HY
         5wBA/uUwz7E0IRkgFCx8uOmsnMWMA6iWQgheflvS5VaNqV+SJ0wzPLZguLExLZBb8N+Y
         JjgaIB7PQoiqGBpc4KUSHMSe10dGz6+qPVTggjLCp2WnHCugiuV4sDawTNxy5zw3l+pU
         yBTgupOQpP0BlaqzJGqDOswYtzMSJ3/gotTScLvKf8x2VkoZy4lu+KFntixVSWy02KAC
         gDfg==
X-Gm-Message-State: APjAAAV5PYGMl/RYEO5ju0EhOIKm6MwmeD9gXw+vBPX4e4nZqT2hMhZ+
        gYLMYmbX9lAkVeSIALdpEco=
X-Google-Smtp-Source: APXvYqzwvhTYt7jcJu0dtrEOrBvHnymQ+WL7244G4orT6qubk5a+arihD3zzDAvFOxDxL5C87sG2kw==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr46849482ljb.211.1564082314929;
        Thu, 25 Jul 2019 12:18:34 -0700 (PDT)
Received: from localhost ([188.170.223.67])
        by smtp.gmail.com with ESMTPSA id v2sm7674016lfi.3.2019.07.25.12.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 12:18:34 -0700 (PDT)
Date:   Thu, 25 Jul 2019 22:18:31 +0300
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 01/12 v2] Platform: add a dev_groups pointer to struct
 platform_driver
Message-ID: <20190725191831.GB884@penguin>
References: <20190704121143.GA5007@kroah.com>
 <CAKdAkRQ4W7wjYjZcBn4_s+PD26pv_8mrjUt-ne24GkimGEXoiA@mail.gmail.com>
 <20190706083251.GA9249@kroah.com>
 <CAKdAkRQRdqRZXdkpLdTO0H8fSvy7x1sDNS4GxE0n8dxaLRDJzQ@mail.gmail.com>
 <20190706171948.GA23324@kroah.com>
 <CAKdAkRR=fG3i32cY69skYHYmwiT-qQ5pNAzqGkTjisKp9D7teg@mail.gmail.com>
 <20190719115220.GD20044@kroah.com>
 <20190720043857.GA14290@penguin>
 <20190725134411.GE11115@kroah.com>
 <ea210d4d-45ec-4d06-c68d-6a2374e978f9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea210d4d-45ec-4d06-c68d-6a2374e978f9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Thu, Jul 25, 2019 at 02:02:03PM -0500, Richard Gong wrote:
> Hi Greg,
> 
> On 7/25/19 8:44 AM, Greg Kroah-Hartman wrote:
> > On Sat, Jul 20, 2019 at 07:38:57AM +0300, Dmitry Torokhov wrote:
> > > On Fri, Jul 19, 2019 at 08:52:20PM +0900, Greg Kroah-Hartman wrote:
> > > > On Sat, Jul 06, 2019 at 10:39:38AM -0700, Dmitry Torokhov wrote:
> > > > > On Sat, Jul 6, 2019 at 10:19 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > 
> > > > > > On Sat, Jul 06, 2019 at 10:04:39AM -0700, Dmitry Torokhov wrote:
> > > > > > > Hi Greg,
> > > > > > > 
> > > > > > > On Sat, Jul 6, 2019 at 1:32 AM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > 
> > > > > > > > On Thu, Jul 04, 2019 at 02:17:22PM -0700, Dmitry Torokhov wrote:
> > > > > > > > > Hi Greg,
> > > > > > > > > 
> > > > > > > > > On Thu, Jul 4, 2019 at 5:15 AM Greg Kroah-Hartman
> > > > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > > > 
> > > > > > > > > > Platform drivers like to add sysfs groups to their device, but right now
> > > > > > > > > > they have to do it "by hand".  The driver core should handle this for
> > > > > > > > > > them, but there is no way to get to the bus-default attribute groups as
> > > > > > > > > > all platform devices are "special and unique" one-off drivers/devices.
> > > > > > > > > > 
> > > > > > > > > > To combat this, add a dev_groups pointer to platform_driver which allows
> > > > > > > > > > a platform driver to set up a list of default attributes that will be
> > > > > > > > > > properly created and removed by the platform driver core when a probe()
> > > > > > > > > > function is successful and removed right before the device is unbound.
> > > > > > > > > 
> > > > > > > > > Why is this limited to platform bus? Drivers for other buses also
> > > > > > > > > often want to augment list of their attributes during probe(). I'd
> > > > > > > > > move it to generic probe handling.
> > > > > > > > 
> > > > > > > > This is not limited to the platform at all, the driver core supports
> > > > > > > > this for any bus type today, but it's then up to the bus-specific code
> > > > > > > > to pass that on to the driver core.  That's usually set for the
> > > > > > > > bus-specific attributes that they want exposed for all devices of that
> > > > > > > > bus type (see the bus_groups, dev_groups, and drv_groups pointers in
> > > > > > > > struct bus_type).
> > > > > > > > 
> > > > > > > > For the platform devices, the problem is that this is something that the
> > > > > > > > individual drivers want after they bind to the device.  And as all
> > > > > > > > platform devices are "different" they can't be a "common" set of
> > > > > > > > attributes, so they need to be created after the device is bound to the
> > > > > > > > driver.
> > > > > > > 
> > > > > > > I believe that your assertion that only platform devices want to
> > > > > > > install custom attributes is incorrect.
> > > > > > 
> > > > > > Sorry, I didn't mean to imply that only platform drivers want to do
> > > > > > this, as you say, many other drivers do as well.
> > > > > > 
> > > > > > > Drivers for devices attached
> > > > > > > to serio, i2c, USB, spi, etc, etc, all have additional attributes:
> > > > > > > 
> > > > > > > dtor@dtor-ws:~/kernel/work (master *)$ grep -l '\(i2c\|usb\|spi\)'
> > > > > > > `git grep -l '\(device_add_group\|sysfs_create_group\)' -- drivers` |
> > > > > > > wc -l
> > > > > > > 170
> > > > > > > 
> > > > > > > I am pretty sure some of this count is false positives, but majority
> > > > > > > is actually proper hits.
> > > > > > 
> > > > > > Yeah, I know, we need to add this type of functionality to those busses
> > > > > > as well.  I don't see a way of doing it other than this bus-by-bus
> > > > > > conversion, do you?
> > > > > 
> > > > > Can't you push the **dev_groups from platform driver down to the
> > > > > generic driver structure and handle them in driver_sysfs_add()?
> > > > 
> > > > Sorry for the delay, got busy with the merge window...
> > > > 
> > > > Anyway, no, we can't call this then, because driver_sysfs_add() is
> > > > called before probe() is called.  So if probe() fails, we don't bind the
> > > > device to the driver.  We also should not be creating sysfs files for a
> > > > driver that has not had probe() called yet, as internal structures will
> > > > not be set up at that time.
> > > 
> > > Ah, yes, I got confused by the fact that driver_sysfs_remove is called
> > > early. Anyway, I think you want something like this:
> > 
> > Ah, nice, this looks good.  Let me try this and see how it goes...
> > 
> 
> I tried Dmitry's patch on Intel Stratix10 platform and it works.
> 
> I added one minor change on the top of Dmitry's patch, since I think we need
> add one additional check prior to device_add_groups().

sysfs_create_groups() returns success when NULL is passed, and
device_add_groups() is a simple wrapper around it.

If anything I'd prefer to codify the behavior of
device_add_groups()/sysfs_create_groups() via comments rather than
adding unneeded checks.

Thanks.

-- 
Dmitry
