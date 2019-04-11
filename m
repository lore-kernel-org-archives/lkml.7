Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C98EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633692146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfDKXJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:09:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58338 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDKXJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:09:25 -0400
Received: from 79.184.255.221.ipv4.supernova.orange.pl (79.184.255.221) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id abc5ed8e33eacacb; Fri, 12 Apr 2019 01:09:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] gpio: merrifield: Fix build err without CONFIG_ACPI
Date:   Fri, 12 Apr 2019 01:09:17 +0200
Message-ID: <2719325.nu6fPkO1U5@kreacher>
In-Reply-To: <20190405145009.GD9224@smile.fi.intel.com>
References: <20190404103925.25652-1-yuehaibing@huawei.com> <20190405142112.26592-1-yuehaibing@huawei.com> <20190405145009.GD9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 5, 2019 4:50:09 PM CEST Andy Shevchenko wrote:
> On Fri, Apr 05, 2019 at 10:21:12PM +0800, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> > 
> > When building CONFIG_ACPI is not set
> > gcc warn this:
> > 
> > drivers/gpio/gpio-merrifield.c: In function
> > mrfld_gpio_get_pinctrl_dev_name: drivers/gpio/gpio-merrifield.c:388:19:
> > error: dereferencing pointer to incomplete type struct acpi_device> 
> >    put_device(&adev->dev);
> >    
> >                    ^
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Fixes:d00d2109c367 ("gpio: merrifield: Convert to use
> > acpi_dev_get_first_match_dev()") Signed-off-by: YueHaibing
> > <yuehaibing@huawei.com>
> 
> Thank you for an update, I have a comment below, but before sending v3, let
> Rafael to have a chance to look at it.
> 
> >  #ifdef CONFIG_ACPI
> >  extern int acpi_platform_notify(struct device *dev, enum kobject_action
> >  action);> 
> > +
> > +static inline void put_acpi_device(struct acpi_device *adev)
> > +{
> > +	put_device(&adev->dev);
> > +}
> 
> This should probably go to acpi_bus.h under acpi_dev_get_first_match_dev().
> And talking to Mika we agreed that naming would be better as acpi_dev_put().

Agreed on both accounts.

Thanks!




