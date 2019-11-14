Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D6EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB4D206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SwkEFFrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKNBKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 20:10:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38271 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfKNBKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:10:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so3556113lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 17:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kl4nQeNloMTMEjJEkDtXqJI1OsofM7dTg/+AiRtKkXI=;
        b=SwkEFFrmzJsfZxQKKA1vDHvps64EZLBnuL9hiapzX9/nfWwHPJJTuRjeFpCdy4N9Fm
         R2c61nN/NuleHDgkjBjjxcV5yCbAeiJ5BjmvfpsCLTB5NNwfEm+oddOGYzcqTTD1L8KO
         OFqWZbXAHf0wc4SliMro9L6VHFt+y6RV7mn8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kl4nQeNloMTMEjJEkDtXqJI1OsofM7dTg/+AiRtKkXI=;
        b=Wy3A/U9fxLE+ulu2cZ8B36DAyOT1Vvj+VoZwXBlm+eCwf51NYRg+E1WUEjR9/kTTOl
         H1i8374ELrk4vLcz1RktG7iPFRwP+Frq/hsR8fRDwNJe2+xMakneG21AEwvxqHwwDLM6
         7DvYDeD0mIjtp/wWxtVxn13z/D4zrEHb/33dE5o/PqeWY3qT9rpz+Qj0VPH6na9wS913
         vPuNxxodin0ZxRfN1HSKJTGyGo5EQbdD8OSeydmfZAkvQ7QRyKvG5zas4UgxBG0BWFs/
         6HAKbTEhngT+gVCEquj1xhJzFFIb50X5oJry2qS1gyVwJ2rRkiVJpYxzj6IQwDKX+Mkj
         dr3g==
X-Gm-Message-State: APjAAAVrZ0aRxc0TxuYuSjYdor/DTOXmejhM/I+A+7eb1diBD4ojWw+5
        axsN5TYkziC3sj24XyhiEQyw5Cs0mEs=
X-Google-Smtp-Source: APXvYqyqUZiCd5eGGZjm2GfpQYJqL6HrzmRKy1xtKttKuvnlAnJeRWShB86ruwswQmtp5kjXyz5txw==
X-Received: by 2002:a19:ed12:: with SMTP id y18mr4453557lfy.151.1573693809885;
        Wed, 13 Nov 2019 17:10:09 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id p19sm1607239lji.65.2019.11.13.17.10.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 17:10:08 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id j14so3550468lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 17:10:08 -0800 (PST)
X-Received: by 2002:a19:895:: with SMTP id 143mr4539562lfi.158.1573693807974;
 Wed, 13 Nov 2019 17:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20191113031044.136232-1-jflat@chromium.org> <20191113175127.GA171004@google.com>
 <20191113182537.GC4013@kuha.fi.intel.com>
In-Reply-To: <20191113182537.GC4013@kuha.fi.intel.com>
From:   Jon Flatley <jflat@chromium.org>
Date:   Wed, 13 Nov 2019 17:09:56 -0800
X-Gmail-Original-Message-ID: <CACJJ=pxba6=SR=kWO-vgqU=wkj7gnVAm62b2tcYf2K+1ucySRg@mail.gmail.com>
Message-ID: <CACJJ=pxba6=SR=kWO-vgqU=wkj7gnVAm62b2tcYf2K+1ucySRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ChromeOS EC USB-C Connector Class
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@google.com>, Jon Flatley <jflat@chromium.org>,
        enric.balletbo@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>, groeck@chromium.org,
        sre@kernel.org, Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:25 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi guys,
>
> On Wed, Nov 13, 2019 at 09:51:27AM -0800, Benson Leung wrote:
> > Hi Jon,
> >
> > Thanks for posting this.
> >
> > Adding Heikki, the typec connector class maintainer, and Enric, co-maintainer
> > of platform/chrome.
>
> Thanks Benson.
>
> > On Tue, Nov 12, 2019 at 07:10:41PM -0800, Jon Flatley wrote:
> > > This patch set adds a basic implementation of the USB-C connector class for
> > > devices using the ChromeOS EC. On ACPI devices an additional ACPI driver is
> > > necessary to receive USB-C PD host events from the PD EC device "GOOG0003".
> > > Incidentally, this ACPI driver adds notifications for events that
> > > cros-usbpd-charger has been missing, so fix that while we're at it.
> >
> > > Jon Flatley (3):
> > >   platform: chrome: Add cros-ec-usbpd-notify driver
> > >   power: supply: cros-ec-usbpd-charger: Fix host events
> > >   platform: chrome: Added cros-ec-typec driver
> > >
> > >  drivers/mfd/cros_ec_dev.c                     |   7 +-
> > >  drivers/platform/chrome/Kconfig               |  20 +
> > >  drivers/platform/chrome/Makefile              |   2 +
> > >  drivers/platform/chrome/cros_ec_typec.c       | 457 ++++++++++++++++++
> > >  .../platform/chrome/cros_ec_usbpd_notify.c    | 156 ++++++
> > >  drivers/power/supply/Kconfig                  |   2 +-
> > >  drivers/power/supply/cros_usbpd-charger.c     |  45 +-
> > >  .../platform_data/cros_ec_usbpd_notify.h      |  40 ++
> > >  8 files changed, 696 insertions(+), 33 deletions(-)
> > >  create mode 100644 drivers/platform/chrome/cros_ec_typec.c
> > >  create mode 100644 drivers/platform/chrome/cros_ec_usbpd_notify.c
> > >  create mode 100644 include/linux/platform_data/cros_ec_usbpd_notify.h
>
> I'll go over these tomorrow, but I have one question already. Can you
> guys influence what goes to the ACPI tables?
>
> Ideally every Type-C connector is always described in its own ACPI
> node (or DT node if DT is used). Otherwise getting the correct
> capabilities and especially connections to other devices (like the
> muxes) for every port may get difficult.

Hey Heikki, thank you for your quick response!

In general we do have control over the ACPI tables and over DT. The
difference for ChromeOS is that the PD implementation and policy
decisions are handled by the embedded controller. This includes
alternate mode transitions and control over the muxes. I don't believe
there is any information about port capabilities in ACPI or DT, that's
all handled by the EC. With current EC firmware we are mostly limited
to querying the EC for port capabilities and state. There may be some
exceptions to this, such as with Rockchip platforms, but even then the
EC is largely in control.

I think you raise a valid point, but such a change is probably out of
scope for this implementation.

Thanks,
-Jon

>
> Br,
>
> --
> heikki
