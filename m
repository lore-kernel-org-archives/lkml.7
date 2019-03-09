Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0774C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B046C20851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lVYAiqCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCIBqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:46:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36587 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfCIBqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 20:46:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id c2so12318310qkb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WPJ/Gy0efvkwS3HizeOBqIEIsyNGKlL1nve8rcV9wM=;
        b=lVYAiqCCVuiGhWY5rAZyaBzgWlKJ6ApaTI8mQQYJ57aFEdbNpSxV2MWem1HEQYgsRm
         SvaxwQh/Kz0aY9MOdImhZqf8hvZQkS5XCdwNn64RlGAapaECICjD46ex2qKRigbDCosh
         V88JE1RNNIF5MAK4wPuVrlRapp4wZIfoX5GPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WPJ/Gy0efvkwS3HizeOBqIEIsyNGKlL1nve8rcV9wM=;
        b=Mr/OHb3Xtj1cpaNvXrML/SSCetRCptA2LScAASkecGIy2qqhEW/mYt1g89lg0Q7hn9
         tUuB4WIuiGsUDuM9lEcLF9J48a3MBfoSNLA6Rn8bqfeiw3rMzrNcSjqJ3pjkd6GyeoiZ
         Rr1mzKDJYEpvdS9If5R0NJ0/TX+YNT3Y1dTfEzw9E2GPxnSq6QslJjGjexxw9xLtidFR
         cI+IX0VkgSZ91rkbugJxmsymSd7lntg5wVpmGWEaD9d7euLkavKWOJnkdtZ9dC3TPoor
         Ax8BQh6pD+yA55MKdPPzIwMs9OlxxOw0qswMpgubQGjnLHc2sYu6iEX4NhbZlRztLHuh
         rwfA==
X-Gm-Message-State: APjAAAU8IMzFIhP/pvB8FlVviFHF+fbov520HGtG0STx1vy9vTiRtNL4
        ePV8WHxL3dgOG2JfUGCdANj3ludh3yCWyobQKkmP7Q==
X-Google-Smtp-Source: APXvYqznQ97DnWAIDGLkjpXN7+gh2MVVQazwcPC1wYZpsPFt1UxdiS636oNfO9E2VqFntswudE1/SyE7P48Lfp+oTQM=
X-Received: by 2002:a37:4b4e:: with SMTP id y75mr16475938qka.158.1552096003348;
 Fri, 08 Mar 2019 17:46:43 -0800 (PST)
MIME-Version: 1.0
References: <CABXOdTdvMKGHoE5JQBLca_6V+ihRiUedgnyb2or8GraBDsKYWQ@mail.gmail.com>
 <20190305005300.129464-1-ravisadineni@chromium.org> <404dd7fe-23de-e5c4-48c2-5cd77a14e72b@collabora.com>
In-Reply-To: <404dd7fe-23de-e5c4-48c2-5cd77a14e72b@collabora.com>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Fri, 8 Mar 2019 17:46:32 -0800
Message-ID: <CAEZbON6xzRnxSLB8r-KGEtWWB2nv33eT7QTWwFwt3Hf+xPFYpw@mail.gmail.com>
Subject: Re: [PATCH V3] cros_ec: Expose sysfile to force battery cut-off on shutdown.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Todd Broch <tbroch@google.com>,
        Daisuke Nojiri <dnojiri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for the review.

On Thu, Mar 7, 2019 at 3:57 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi RaviChandra,
>
> Some few comments below ...
>
>
> On 5/3/19 1:53, RaviChandra Sadineni wrote:
> > On chromebooks, power_manager daemon normally shutsdown(S5) the device
> > when the battery charge falls below 4% threshold. Chromeos EC then
> > normally spends an hour in S5 before hibernating. If the battery charge
> > falls below critical threshold in the mean time, EC does a battery cutoff
>
> Be coherent using the same spelling along all the patch for cutoff.
Done.
>
>
> > instead of hibernating. On some chromebooks, S5 is optimal enough
> > resulting in EC hibernating without battery cut-off. This results in
>
> s/cut-off/cutoff/
Done.
>
> > battery deep-discharging. This is a bad user experience as battery
> > has to trickle charge before booting when the A.C is plugged in the next
> > time.
> >
> > This patch exposes a sysfs file for an userland daemon to suggest EC if it
> > has to do a battery cut-off instead of hibernating when the system enters
>
> s/cut-off/cutoff/
Done.
>
> > S5 next time.
> >
> > Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
> > ---
> >
> > V3: Make battery-cutoff generic and expose 'at-shutdown' flag.
> > V2: Use kstrtobool() instead of kstrtou8() and add documentation.
> >
> >
> > .../ABI/testing/sysfs-class-chromeos          | 10 ++++
> >  drivers/platform/chrome/cros_ec_sysfs.c       | 48 +++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documentation/ABI/testing/sysfs-class-chromeos
> > new file mode 100644
> > index 000000000000..d5ab22c44977
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-chromeos
>
> Please rebase the patch on top of chrome-platform for-next [1] or 5.1-rc1 when
> released, so it applies cleanly.
Done.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=for-next
>
> > @@ -0,0 +1,10 @@
> > +What:           /sys/class/chromeos/cros_ec/battery-cuttoff
>
> The name should match with the attribute name, so battery_cutoff in this case as
> you defined the attribute name as battery_cutoff
>
> Is this a common property for all the EC devices?
>
> Note that we have
>
> /sys/class/chromeos/<ec-device-name>/...
>
> where <ec-device-name> can be cros_ec|cros_pd and many others in the future
>
> On those devices that more than one EC is present we will have. E.g
>
>  cros_ec/battery_cutoff and cros_pd/battery_cutoff
>  cros_ec/battery_cutoff and cros_ish/battery_cutoff
>
> Which I think is not what you want. Ideally I'd like to see visible the
> attribute only on those ECs that support that feature. Is this command
> associated with an EC feature?
Yes with EC_FEATURE_BATTERY.  Now checking if EC supports EC_FEATURE_BATTERY.
>
> If that's not possible I can assume writing to battery_cutoff for ECs that don't
> implement it would return a protocol/command error.

>
>
> > +Date:           February 2019
> > +Contact:        Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > +Description:
> > +                cros_ec battery cuttoff configuration. Only option
> > +                currently exposed is 'at-shutdown'.
> > +
> > +                'at-shutdown' sends a host command to EC requesting
> > +                battery cutoff on next shutdown. If AC is plugged
> > +                in before next shutdown, EC ignores the request.
> > diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> > index f34a50121064..6ef6b860c818 100644
> > --- a/drivers/platform/chrome/cros_ec_sysfs.c
> > +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> > @@ -322,14 +322,62 @@ static ssize_t kb_wake_angle_store(struct device *dev,
> >       return count;
> >  }
> >
> > +/* Battery cut-off control */
>
> s/cut-off/cutoff/
Done.
>
> > +static ssize_t battery_cutoff_store(struct device *dev,
> > +                                 struct device_attribute *attr,
> > +                                 const char *buf, size_t count)
> > +{
> > +     struct ec_params_battery_cutoff *param;
> > +     struct cros_ec_command *msg;
> > +     int ret;
> > +     struct cros_ec_dev *ec =
> > +             container_of(dev, struct cros_ec_dev, class_dev);
>
> use to_cros_ec_dev instead of container_of
>
> > +     char *p;
> > +     int len;
> > +
> > +     msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
> > +     if (!msg)
> > +             return -ENOMEM;
> > +
> > +     param = (struct ec_params_battery_cutoff *)msg->data;
> > +     msg->command = EC_CMD_BATTERY_CUT_OFF + ec->cmd_offset;
> > +     msg->version = 1;
> > +     msg->outsize = sizeof(*param);
> > +     msg->insize = 0;
> > +
> > +     p = memchr(buf, '\n', count);
> > +     len = p ? p - buf : count;
> > +
> > +     if (len == 11 && !strncmp(buf, "at-shutdown", len)) {
> > +             param->flags = EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN;
> > +     } else {
> > +             kfree(msg);
>
> Use only one kfree, please. Remove this.
>
> > +             return -EINVAL;
>
>                 count = -EINVAL;
>                 goto exit;
>
> > +     }
> > +
> > +     ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> > +     kfree(msg);
>
> Only one point for kfree, please. Remove this.
>
> > +     if (ret < 0)
> > +             return ret;
>             count = ret;
>
> exit:
>         kfree(msg);
> > +     return count;
> > +}
> > +
> >  /* Module initialization */
> >
> >  static DEVICE_ATTR_RW(reboot);
> >  static DEVICE_ATTR_RO(version);
> >  static DEVICE_ATTR_RO(flashinfo);
> >  static DEVICE_ATTR_RW(kb_wake_angle);
> > +/*
> > + * Currently EC does not expose a host command to read the status of
> > + * battery cut-off configuration. Also there is no requirement to read
>
> s/cut-off/cutoff/
>
> > + * the status of these flags from userland. So marking this attribute as
> > + *  write-only.
> > + */
>
> Can you also specify that is WO in the sysfs documentation. I understand
> correctly that this command only applies when the device runs on battery? And
> that if AC is plugged the flag is reset?
Done.


Thanks,
Ravi


>
> > +static DEVICE_ATTR_WO(battery_cutoff);
> >
>
> Note that the name should match with the sysfs documentation.
>
> >  static struct attribute *__ec_attrs[] = {
> > +     &dev_attr_battery_cutoff.attr,
> >       &dev_attr_kb_wake_angle.attr,
> >       &dev_attr_reboot.attr,
> >       &dev_attr_version.attr,
> >
>
> Thanks,
>  Enric
