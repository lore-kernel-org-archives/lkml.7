Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310B92084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i3avGKMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbfCAQT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:19:56 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33147 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfCAQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:19:56 -0500
Received: by mail-yw1-f65.google.com with SMTP id i204so11926779ywb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyNvvLOrq4bS1vRrEN+IwY+NXTZUKqr6H8s9M2rYM1w=;
        b=i3avGKMKHqknwPf9BJCu69IfL9tZ0qg18zrtDFNbU3sJ4U9HItflZczodCiyCmob8K
         ir2dsep8yveNFNdcvsYSDogB5xEY/tM5Wu8ep1pB9BqjkqI3zAvgsHnsr7JKTZ/JqWKa
         UKQPUAYz5ZIVAlFIuDFn9kfdNsFQ7zXQUjrQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyNvvLOrq4bS1vRrEN+IwY+NXTZUKqr6H8s9M2rYM1w=;
        b=iOYbjEalJdgFUtN4wl2YcZjLVQ4Ut4tXEnPI7yYTT1mLkUlR2hQSWobfpMOsN1Hhrv
         Z/BY/M698NUl+4amot6+rZ5XFPsDNYamjbOTo1kPpYZRAJV3eFCSxjb4TzdpMolgYLHy
         3poPh6NAdYQYEM3LtG9Wn0QDmbs1hSObsrzJOG2WzjUJH+4++YjuQrI7h9s2bwNILo8k
         hw0AVUMNOd3tONHVD7+y9BHwWkNSePuOMxSCc2FumlDxArgzTLbMYwA9P1TMx58ZU7XI
         VWp+fFwNWNGTj3Cg+1w33oZeNQ6oGzcI/mZKZ4aEPbgN6WS5UI9u+S9Egqyu5z7BKRyK
         +K5Q==
X-Gm-Message-State: APjAAAVSYxv6lf2HRgaSsags5qVsVgMIKRMJM+RRVljYgRTVRZp21BG+
        k6qu6NrR8njZFS5fWXN3AFTKOCoa2J6g05uDPYZ4kA==
X-Google-Smtp-Source: APXvYqzxULbURa+dNCMv7eBxu+VsJVbRcRww6NuQGnBM7l7AwmmSCdm62TMpIoBjnQOcrFvjFkAsdJzU83PlicQ6EzA=
X-Received: by 2002:a25:c184:: with SMTP id r126mr4630890ybf.441.1551457195114;
 Fri, 01 Mar 2019 08:19:55 -0800 (PST)
MIME-Version: 1.0
References: <1551428454-596-1-git-send-email-rushikesh.s.kadam@intel.com> <18369e10-4611-2237-d58c-e6526dc74544@collabora.com>
In-Reply-To: <18369e10-4611-2237-d58c-e6526dc74544@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 1 Mar 2019 08:19:43 -0800
Message-ID: <CAMHSBOVrKCWzSPxH-EPqRZoZSWkX7S43rJ4vzWv38j1OKhvM3A@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: cros_ec: instantiate properly CrOS ISH MCU device
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jett Rink <jettrink@chromium.org>, andriy.shevchenko@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 1:50 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Rushikesh,
>
> On 1/3/19 9:20, Rushikesh S Kadam wrote:
> > Integrated Sensor Hub (ISH) is also a MCU running EC
> > having feature bit EC_FEATURE_ISH. Instantiate it as
> > a special CrOS EC device with device name 'cros_ish'.
> >
> > Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> > ---
> > v3
> > - Dropped "Intel" in commments in cros_ec header file. CrOS EC ISH
> >   device is a generic ISH. This was missed earlier.
> > v2
> > - Addressed review comments to term the CrOS EC device as a generic
> >   Integrated Sensor Hub.
> > v1
> > - Initial version.
> >
> >  drivers/mfd/cros_ec_dev.c            | 13 +++++++++++++
> >  include/linux/mfd/cros_ec.h          |  1 +
> >  include/linux/mfd/cros_ec_commands.h |  2 ++
> >  3 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index 2d0fee4..46963c2 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -415,6 +415,19 @@ static int ec_device_probe(struct platform_device *pdev)
> >       cdev_init(&ec->cdev, &fops);
> >
> >       /*
> > +      * Check whether this is actually an Integrated Sensor Hub (ISH)
> > +      * rather than an EC.
> > +      */
> > +     if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
> > +             dev_info(dev, "CrOS ISH MCU detected.\n");
> > +             /*
> > +              * Help userspace differentiating ECs from ISH MCU,
> > +              * regardless of the probing order.
> > +              */
> > +             ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
> > +     }
> > +
> > +     /*
> >        * Add the class device
> >        * Link to the character device for creating the /dev entry
> >        * in devtmpfs.
> > diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> > index de8b588..00c5765 100644
> > --- a/include/linux/mfd/cros_ec.h
> > +++ b/include/linux/mfd/cros_ec.h
> > @@ -24,6 +24,7 @@
> >
> >  #define CROS_EC_DEV_NAME "cros_ec"
> >  #define CROS_EC_DEV_PD_NAME "cros_pd"
> > +#define CROS_EC_DEV_ISH_NAME "cros_ish"
> >
> >  /*
> >   * The EC is unresponsive for a time after a reboot command.  Add a
> > diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> > index fc91082..43bee4f 100644
> > --- a/include/linux/mfd/cros_ec_commands.h
> > +++ b/include/linux/mfd/cros_ec_commands.h
> > @@ -856,6 +856,8 @@ enum ec_feature_code {
> >       EC_FEATURE_RTC = 27,
> >       /* EC supports CEC commands */
> >       EC_FEATURE_CEC = 35,
> > +     /* The MCU is an Integrated Sensor Hub */
> > +     EC_FEATURE_ISH = 40,
> >  };
> >
> >  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> >
>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>>
