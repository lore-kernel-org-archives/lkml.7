Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8BBC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E063206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbfFMPrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:47:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35401 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbfFMJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:32:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so21749321qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 02:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/0wpLIS7FS7jhfZMMu4pHMqQtu6yoM37ibHoRt1LgU=;
        b=Ji7c5zHL7MNL4WMMr85kiClsMo5Kr1PRabDnQ/VrcjpCI/0K/8ZWs4VujJ1bG3cXWl
         BTT8/lQlWwyHUZOSFcfZIB9wMR4G4N+GM0tuBKwZMeRg4L5OPMFJiaVtDaPVlHhJ9rt3
         DOmYRglRPj3ZLysnuBKWC4LkTQCnQiefIQXUVmGVVVukjibu5hdcGuQdVBgd3Z+5sSlB
         e+o1udLayhYWcbubKuj3JcFKOJNmZekQgQipa4rw0m+3I/hiBngWxgdozExrZCL//kRF
         FAQYywh7M5XpovMNRXt193LSFLsncvFh5VECBkjTrUqjalRl3Vi6s5icOS52H3veZiWP
         iWVg==
X-Gm-Message-State: APjAAAVe66yi+hubpiUg0ZBfATRPWSI2+/Ec2jF2lXg5lJrxXnvbAJ4L
        zqxy+WZeLCYNo58R5D6KIzU2ZoipUquQXtkKPn2H4Q==
X-Google-Smtp-Source: APXvYqw/sQ5mcSwPf8226TuS+vkXk4CpLpVjnLElzksMN1ydqMV4lnQn38CN7pVjb+V0MEL78hfXr9xatbC4c+/4rMI=
X-Received: by 2002:ac8:224d:: with SMTP id p13mr54002135qtp.154.1560418378757;
 Thu, 13 Jun 2019 02:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
 <20190611123101.25264-5-ckeepax@opensource.cirrus.com> <20190612152718.GC2640@lahna.fi.intel.com>
 <20190613084858.GU28362@ediswmail.ad.cirrus.com>
In-Reply-To: <20190613084858.GU28362@ediswmail.ad.cirrus.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 13 Jun 2019 11:32:47 +0200
Message-ID: <CAO-hwJL-U0n5oFP-QXX8rD2Fxt9mDOKp-AknRN6QwXEhZsUBYg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Jim Broadus <jbroadus@gmail.com>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:49 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Wed, Jun 12, 2019 at 06:27:18PM +0300, Mika Westerberg wrote:
> > On Tue, Jun 11, 2019 at 01:30:58PM +0100, Charles Keepax wrote:
> > > In preparation for more refactoring make i2c_acpi_get_irq available
> > > outside i2c-core-acpi.c.
> > >
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >
> > > Changes since v3:
> > >  - Move the change to use the helper function from i2c-core-base into its own patch.
> > >
> > > Thanks,
> > > Charles
> > >
> > >  drivers/i2c/i2c-core-acpi.c | 15 +++++++++++++--
> > >  drivers/i2c/i2c-core.h      |  7 +++++++
> > >  2 files changed, 20 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> > > index 7d4d66ba752d4..35966cc337dde 100644
> > > --- a/drivers/i2c/i2c-core-acpi.c
> > > +++ b/drivers/i2c/i2c-core-acpi.c
> > > @@ -144,8 +144,17 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
> > >     return 1; /* No need to add resource to the list */
> > >  }
> > >
> > > -static int i2c_acpi_get_irq(struct acpi_device *adev)
> > > +/**
> > > + * i2c_acpi_get_irq - get device IRQ number from ACPI
> > > + * @client: Pointer to the I2C client device
> > > + *
> > > + * Find the IRQ number used by a specific client device.
> > > + *
> > > + * Return: The IRQ number or an error code.
> > > + */
> > > +int i2c_acpi_get_irq(struct i2c_client *client)
> > >  {
> > > +   struct acpi_device *adev = ACPI_COMPANION(&client->adapter->dev);
> >
> > Is this adev checked for being NULL somewhere below before it is being
> > dereferenced?
> >
> > It could explain the issue Benjamin is seeing.
> >
>
> Yeah could be that or just for some reason this isn't returning
> the same adev as we previously had. I will do some digging see if
> I can find any likely culprits.

That was almost the culprit: client is NULL here.
So the call of i2c_acpi_find_client_by_adev(adev) fails.

I guess this explains why the next commit is also not working :)

Cheers,
Benjamin
