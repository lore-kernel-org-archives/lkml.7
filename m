Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B27C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E244B223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V6bw7CVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbfGWQoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:44:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42942 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbfGWQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:44:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so31602781qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pK8CIOFMnNifLkIhBAeejdoJ2bA8zraNSvCuPhnep9Y=;
        b=V6bw7CVuYeNR/YODnrtQKNxsd9QJ/DpWK67IB2bJLXXwWdYX+1JLYQf2hR8B7vOlYj
         JmOtWeuLGBEae1nubjFfv1R7dCxROppqSCgOpe7aiv3nsxOweZByo4L2Kwob9rrqq4mk
         vI+krMDVa15DFtATV5ZDVE7pg54rpwNU2mSv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pK8CIOFMnNifLkIhBAeejdoJ2bA8zraNSvCuPhnep9Y=;
        b=W4CEf74x7gae7/+r/Wn7wZsRnZ9RaSHzC1z2zVvez6Of7djSmK8boCHYx/5BbL2rre
         mL/Bgl8VrElA0OoibP/FiyE27ZHvMIXUwpTp0W8eLtAmalN6hyciPQ8TU+C/w46Lv4mX
         BWeB9ulf7OYCl0mkzUwvJz8i6viiL4BfhnoYelmgVuJCVxXlx3N+BbBadHnBoubkJ9Aw
         B3MG80x1bHM0B9EnGEqAlEz/7uRy+bu9diYjIaaZhTZgCMHLSviK2hi3EFuBznE9IgNG
         rQ0jndwi8nNKJZLgyP6+YbtytmLMjYbKFX0FciuNV+RZS3HnLYk1DbdsDM5x5Q+fm2J5
         SU0Q==
X-Gm-Message-State: APjAAAWfCU1+HMYSsgeaK7hXwJVBy0PQUY08hdgcnCwEJrLpB8pvW9o9
        VNSabQkRRODMkBoK6v6WYqpxQWpZKzkDgSxcu0N8ow==
X-Google-Smtp-Source: APXvYqy+b/WtRqn8IV5ZtY0UMswMJFLuvW3rpFO26sRq92mF3k51b251/oCEdZ491LFl1ApT5fCDyu9pMmNkaoFhUqs=
X-Received: by 2002:a37:a70c:: with SMTP id q12mr47335946qke.118.1563900246212;
 Tue, 23 Jul 2019 09:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190722180258.255949-1-ravisadineni@chromium.org> <20190722182252.GA24412@kroah.com>
In-Reply-To: <20190722182252.GA24412@kroah.com>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Tue, 23 Jul 2019 09:43:55 -0700
Message-ID: <CAEZbON6tukf5hTgpiNcUAQ5owf4KddHWFP5ubaeLU02Rmd-Zpw@mail.gmail.com>
Subject: Re: [PATCH] power:sysfs: Expose device wakeup_event_count.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Todd Broch <tbroch@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jul 22, 2019 at 11:22 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 22, 2019 at 11:02:58AM -0700, Ravi Chandra Sadineni wrote:
> > Device level event_count can help user level daemon to track if a
> > praticular device has seen an wake interrupt during a suspend resume
> > cycle. Thus expose it via sysfs.
> >
> > Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > ---
> >  Documentation/ABI/testing/sysfs-devices-power | 11 ++++++++++
> >  drivers/base/power/sysfs.c                    | 20 +++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
> > index 1ca04b4f0489..344549f4013f 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-power
> > +++ b/Documentation/ABI/testing/sysfs-devices-power
> > @@ -89,6 +89,17 @@ Description:
> >               attribute is not present. If the device is not enabled to wake
> >               up the system from sleep states, this attribute is empty.
> >
> > +What:                /sys/devices/.../power/wakeup_event_count
> > +Date:                July 2019
> > +Contact:     Ravi Chandra sadineni <ravisadineni@chromium.org>
> > +Description:
> > +             The /sys/devices/.../wakeup_event_count attribute contains the
> > +             number of signaled wakeup events associated with the device.
> > +             This attribute is read-only. If the device is not capable to
> > +             wake up the system from sleep states, this attribute is not
> > +             present. If the device is not enabled to wake up the system
> > +             from sleep states, this attribute is empty.
>
> The attribute is not "empty" it returns just an empty line.
Corrected the description.
>
> Is that really a good thing if you are expecting a number?
This is to adhere to the convention as described in
base/power/sysfs.c. Hope this is o.k
>
> > +
> >  What:                /sys/devices/.../power/wakeup_active_count
> >  Date:                September 2010
> >  Contact:     Rafael J. Wysocki <rjw@rjwysocki.net>
> > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > index f42044d9711c..8dc1235b9784 100644
> > --- a/drivers/base/power/sysfs.c
> > +++ b/drivers/base/power/sysfs.c
> > @@ -357,6 +357,25 @@ static ssize_t wakeup_count_show(struct device *dev,
> >
> >  static DEVICE_ATTR_RO(wakeup_count);
> >
> > +static ssize_t wakeup_event_count_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf)
> > +{
> > +     unsigned long count = 0;
> > +     bool enabled = false;
> > +
> > +     spin_lock_irq(&dev->power.lock);
> > +     if (dev->power.wakeup) {
> > +             count = dev->power.wakeup->event_count;
> > +             enabled = true;
> > +     }
> > +     spin_unlock_irq(&dev->power.lock);
>
> Why do you need to lock?  The state and count can change right after the
> lock, so what does this help with?
power.wakeup can be NULL (device_wakeup_detach ()) if wakeup is
disabled for a particular device.
>
> > +     return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
>
> Use a real if statement please.
>
> > +}
> > +
> > +static DEVICE_ATTR_RO(wakeup_event_count);
> > +
> > +
> > +
>
> too many empty lines :)
Removed the empty lines.
>
> thanks,
>
> greg k-h

Thanks,
Ravi
