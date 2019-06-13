Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C3FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604332147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F0WKFhMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfFMU4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:56:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37706 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:56:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id d11so173235lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OG/AEL4164lJz8oHfLDPcpe5DZqMPpDHCdPhPKS91Q=;
        b=F0WKFhMFhS2BegVZPSNsLwWkxX9SY6SiLQByGCQ7xPVNbqBlv/KXU5Md2Vw0LJpS+s
         EAvlaksvmAlhwmDu+i63jx5U7ie2HMS7bZUiuJgPbucGIUJUYZsrEXioMrPkiYlgWXg5
         iO4WhOn1R5CfLvWDuK9CKIoaDHPFETvf5BvOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OG/AEL4164lJz8oHfLDPcpe5DZqMPpDHCdPhPKS91Q=;
        b=Mwjji1l8pE1KaL6SC/LDC+dGejB4pUh/oQJoaqwhemD+dUtOZXaBQLbC8Ouua12qAV
         H3O9RCZBfGg8xS5K2APJ+EYa+PWPHXwddQSdgUCmto3WNv566KvEzER5zqwcH+ck0kd1
         HPEiIeO+sNLyojoXytUTQ6RgJ9G/ckflCBDmReMgdJb22EBhJt7jYdpx7zV0hp/3vKlr
         /HoYYtVLJo+ZWjczSgk1ooFtkN6YwWOx4nC+DrLy+XM6GqoVT9iu4kITqVGWiOT191Wb
         LfmtMnQ9kCFlkYGJhDKXxBZLuuPaQVgWFOzL3LPyLYo8R+ADvwKbJg4rguobXHd7zNi1
         il5w==
X-Gm-Message-State: APjAAAXn8YrlsO8CLX2SbgUgMskdDiJIubrFLHeR//mOoTf4m1DTcZD/
        X8ak38a5Y2odJOrnuq1WJzHvlLhvis4=
X-Google-Smtp-Source: APXvYqyGXBziqRN40ixYsqsq1pz3weAKtYNrUHTN7kTSEW/MG8bQDfIoJMOSpJaKD8zcUYSVH25NRA==
X-Received: by 2002:a19:22d8:: with SMTP id i207mr42972371lfi.97.1560459401892;
        Thu, 13 Jun 2019 13:56:41 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id i2sm177988ljc.96.2019.06.13.13.56.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 13:56:40 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id v24so86443ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:56:40 -0700 (PDT)
X-Received: by 2002:a2e:6313:: with SMTP id x19mr40028599ljb.25.1560459400047;
 Thu, 13 Jun 2019 13:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190607210528.248042-1-evgreen@chromium.org> <797d3c44-cf30-678d-2622-6bd4a2e89b70@collabora.com>
In-Reply-To: <797d3c44-cf30-678d-2622-6bd4a2e89b70@collabora.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 13 Jun 2019 13:56:03 -0700
X-Gmail-Original-Message-ID: <CAE=gft427=fMGatFUkkOHpBvJa3n=Usi09aToqu=69bJZ_0uTQ@mail.gmail.com>
Message-ID: <CAE=gft427=fMGatFUkkOHpBvJa3n=Usi09aToqu=69bJZ_0uTQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Expose resume result via sysfs
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 9:37 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Evan,
>
> On 7/6/19 23:05, Evan Green wrote:
> > For ECs that support it, the EC returns the number of slp_s0
> > transitions and whether or not there was a timeout in the resume
> > response. Expose the last resume result to usermode via sysfs so
> > that usermode can detect and report S0ix timeouts.
>
> Looks more for a debugfs attribute instead of sysfs?
>
> I'd prefer have it in debugfs unless you have a good reason. As you probably
> know I'm not a big fan of having private interfaces and I'd like to maintain the
> minimum needed in sysfs.

That seems fine with me. It's easy enough to move it from debugfs to
sysfs later if needed, but much more difficult to go the other way.
I'll spin it for debugfs.

>
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> > Enric, I'm not sure if this conflicts with your giant refactoring.
> > I can rebase this on your series, but patchwork doesn't have patch
> > 2 of your series, so you'd have to point me to a tree.
> >
>
> Probably, but it's fine for now, so don't worry about it. The refactoring still
> needs more reviews from other people.

Ok. I'll base it on linux-next.

>
> > ---
> >  drivers/mfd/cros_ec.c                   |  6 +++++-
> >  drivers/platform/chrome/cros_ec_sysfs.c | 17 +++++++++++++++++
> >  include/linux/mfd/cros_ec.h             |  1 +
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > index bd2bcdd4718b..64a2d3adc729 100644
> > --- a/drivers/mfd/cros_ec.c
> > +++ b/drivers/mfd/cros_ec.c
> > @@ -110,12 +110,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >
> >       /* For now, report failure to transition to S0ix with a warning. */
> >       if (ret >= 0 && ec_dev->host_sleep_v1 &&
> > -         (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
> > +         (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> > +             ec_dev->last_resume_result =
> > +                     buf.u.resp1.resume_response.sleep_transitions;
> > +
> >               WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
> >                         EC_HOST_RESUME_SLEEP_TIMEOUT,
> >                         "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
> >                         buf.u.resp1.resume_response.sleep_transitions &
> >                         EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> > +     }
> >
> >       return ret;
> >  }
> > diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> > index 3edb237bf8ed..2deca98c7a7a 100644
> > --- a/drivers/platform/chrome/cros_ec_sysfs.c
> > +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> > @@ -308,18 +308,35 @@ static ssize_t kb_wake_angle_store(struct device *dev,
> >       return count;
> >  }
> >
> > +/* Last resume result */
> > +static ssize_t last_resume_result_show(struct device *dev,
> > +                                    struct device_attribute *attr, char *buf)
> > +{
> > +     struct cros_ec_dev *ec = to_cros_ec_dev(dev);
> > +     int ret;
> > +
> > +     ret = scnprintf(buf,
> > +                     PAGE_SIZE,
> > +                     "0x%x\n",
> > +                     ec->ec_dev->last_resume_result);
> > +
> > +     return ret;
> > +}
> > +
> >  /* Module initialization */
> >
> >  static DEVICE_ATTR_RW(reboot);
> >  static DEVICE_ATTR_RO(version);
> >  static DEVICE_ATTR_RO(flashinfo);
> >  static DEVICE_ATTR_RW(kb_wake_angle);
> > +static DEVICE_ATTR_RO(last_resume_result);
> >
>
> The attribute should be documented in
>
> Documentation/ABI/testing/sysfs-class-chromeos
>
> or
>
> Documentation/ABI/testing/debugfs-cros-ec ; yes I know this file does not exist,
> but we should add it :-)

Ok. Thanks for taking a look.
-Evan
