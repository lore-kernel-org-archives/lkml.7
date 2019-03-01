Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6CB20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfCADTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:19:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:50616 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfCADTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:19:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 19:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="151004936"
Received: from rajeev-desktop.iind.intel.com (HELO intel.com) ([10.223.84.39])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2019 19:19:43 -0800
Date:   Fri, 1 Mar 2019 08:49:01 +0530
From:   Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Jett Rink <jettrink@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] cros_ec: instantiate properly Intel ISH MCU device
Message-ID: <20190301031901.GA27120@intel.com>
References: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CAFqH_53uR6fJepJ7s9gYBFSE=0oviaFOgn=h0KcEjKwiTu+Btw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_53uR6fJepJ7s9gYBFSE=0oviaFOgn=h0KcEjKwiTu+Btw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Enric, Jett, Gwendal & Andy for taking timeout to review
the patch & provide detailed inputs.

Couple of acks below.


On Thu, Feb 28, 2019 at 01:33:09PM +0100, Enric Balletbo Serra wrote:
> Hi,
> 
> Based on the discussion we had, only some few comments.
> 
> Missatge de Rushikesh S Kadam <rushikesh.s.kadam@intel.com> del dia
> dg., 24 de febr. 2019 a les 10:15:
> >
> > Intel Integrated Sensor Hub (ISH) is also a MCU running EC
> > having feature bit EC_FEATURE_ISH. Instantiate it as a special
> > CrOS EC device with device name 'cros_ish'.
> >
> > Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> > ---
> >  drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
> >  include/linux/mfd/cros_ec.h          |  1 +
> >  include/linux/mfd/cros_ec_commands.h |  2 ++
> 
> Better if you use the "mfd: cros_ec:" prefix in the next version so
> it's clear that this should go through the MFD tree.

Ok, will do.

> 
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index 2d0fee4..be499b8 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -414,6 +414,16 @@ static int ec_device_probe(struct platform_device *pdev)
> >         device_initialize(&ec->class_dev);
> >         cdev_init(&ec->cdev, &fops);
> >
> > +       /* check whether this is actually a Intel ISH rather than an EC */
> 
> "Check whether this is actually an Integrated Sensor Hub (ISH) rather
> than an EC"?

Ack.

> 
> > +       if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
> > +               dev_info(dev, "Intel ISH MCU detected.\n");
> 
>  dev_info(dev, "CrOS ISH MCU detected.\n"); ?

Ack.

> 
> > +               /*
> > +                * Help userspace differentiating ECs from ISH MCU,
> > +                * regardless of the probing order.
> > +                */
> > +               ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
> > +       }
> > +
> >         /*
> >          * Add the class device
> >          * Link to the character device for creating the /dev entry
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
> > index fc91082..9276c3c 100644
> > --- a/include/linux/mfd/cros_ec_commands.h
> > +++ b/include/linux/mfd/cros_ec_commands.h
> > @@ -856,6 +856,8 @@ enum ec_feature_code {
> >         EC_FEATURE_RTC = 27,
> >         /* EC supports CEC commands */
> >         EC_FEATURE_CEC = 35,
> > +       /* The MCU is an Intel Integrated Sensor Hub */
> > +       EC_FEATURE_ISH = 40,
> 
> Just a note that we will have a trivial conflict to solve with
> https://lkml.org/lkml/2019/2/27/723

Thanks

Rushikesh

> 
> >  };
> >
> >  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> > --
> > 1.9.1
> >
> 
> Best regards,
> Enric

-- 
