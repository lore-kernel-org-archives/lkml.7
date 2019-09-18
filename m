Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3813C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BEA21897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTbKJvaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfIRUdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:33:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43492 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfIRUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:33:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so622465lfl.10;
        Wed, 18 Sep 2019 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mj0JLnG/Gj5s9C+Mvzy5ZfCZ+8JKvmbM7r6y58/cS08=;
        b=TTbKJvaQRNR0VTDS6Kp8rQXgToZB5in/YATUJFRi/4W6THNXSR2qut9sFwvVn5aFoJ
         D4HP3oH2k7PcDQmjPhM/TJ5xiGmRXlFV+b/d/Czl9o4Tt+93rNrOgjNh0jhNTU80Yrwi
         /3pYzD8xhbC/Wsbxs9FWo6jr+jJ361Jp5nzwucV5/InYhSveZA/s4XQyEqQ9GV24lcPm
         RPHrtNcnk8tQmWeM9J4ajdzagXgqeVPDHemkFyy/PWn6Z/PWDFcdW4oHVXDEp53XIq8j
         j073YApe7nwWkTVv3bUU07LdiL+riRVyVlFzci1Et2YEua7qEsj1C7ajpK2t0XeRYP1X
         cqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mj0JLnG/Gj5s9C+Mvzy5ZfCZ+8JKvmbM7r6y58/cS08=;
        b=BE9xui8T7XNlqbBm8DOfHx2BcwiGLuVZfSF+kxAtM+tKdc2dzqZ5W/6c8y2VwyqeLK
         xGcewBGMEMUMzMRYIEkj+A/nr8DX+vQ3XYPogzKI9xQNlAZtmAeYhqxoegRsVDzFK9XG
         3B9qvoOoVJU2019XouQruXXDDsj/Vit3Avj1cfHxrRHfgWvmAvsmDs3EZ4N/Vli70y7U
         95usUU5YHUOjeJhimc6RZqi4IL7EN6WglfR0aG7DJaLEIWYRMhmGJBm6efKmuVpPjxTY
         3O44YFyfQGQ6ERWysNcNTF2R4oRDOGf2QzaCrWjhyPGoTC8K3EPM05jhYtO7Q0yVE585
         4Iag==
X-Gm-Message-State: APjAAAUmNJo+04KzYI4rB7/t18bPsr8Ehctfm8lobkukkauZ/kY1k+N6
        kGW5SoE7NrKPdPjdTXTHln+2sZEq
X-Google-Smtp-Source: APXvYqw8mAQWIgarA5ZVraMsRHd9FYUpcMj8v2cO+kXMp5jqKK1ONJY2uZSBOnDdJjU4bNPz4elwvA==
X-Received: by 2002:a19:3f47:: with SMTP id m68mr3032058lfa.108.1568838812431;
        Wed, 18 Sep 2019 13:33:32 -0700 (PDT)
Received: from localhost.localdomain ([46.216.138.44])
        by smtp.gmail.com with ESMTPSA id o5sm1159355lfn.42.2019.09.18.13.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 13:33:31 -0700 (PDT)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iAgdo-0001Uf-Qg; Wed, 18 Sep 2019 23:33:32 +0300
Date:   Wed, 18 Sep 2019 23:33:32 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH v2 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 TypeB and TypeC variants
Message-ID: <20190918203332.GA4859@jeknote.loshitsa1.net>
References: <20190917194507.14771-1-jekhor@gmail.com>
 <20190917194507.14771-2-jekhor@gmail.com>
 <f578a65b-af02-5fe8-dd59-9918c000da64@redhat.com>
 <20190918114224.GA23318@jeknote.loshitsa1.net>
 <029c7865-b9b3-1e58-7092-6d8495de0116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029c7865-b9b3-1e58-7092-6d8495de0116@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:12:43PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 18-09-2019 13:42, Yauhen Kharuzhy wrote:
> > On Wed, Sep 18, 2019 at 11:20:21AM +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 17-09-2019 21:45, Yauhen Kharuzhy wrote:
> > > > Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
> > > > hardware has TypeC connector and register related devices described as
> > > > I2C connections in the _CRS resource.
> > > > 
> > > > There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with micro
> > > > USB B connector exists. It has INT33FE device in the DSDT table but
> > > > there are only two I2C connection described: PMIC and BQ27452 battery
> > > > fuel gauge.
> > > > 
> > > > Splitting existing INT33FE driver allow to maintain code for USB type B
> > > > (AB) connector variant separately and make it simpler.
> > > > 
> > > > Split driver to intel_cht_int33fe_common.c and
> > > > intel_cht_int33fe_{typeb,typec}.c. Compile all this source to one .ko
> > > > module to make user experience easier.
> > > > 
> > > > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > > 
> > > Thank you for doing this, this version looks much better IMHO.
> > > 
> > > Note that this does not apply to Linus' current master, please
> > > rebase. Specifically this conflicts with this patch:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78cd4bf53635d3aeb73435bc89eb6eb39450f315
> > > 
> > > Which just got merged. Instead of rebasing on Linus' master
> > > (which is always a bit adventurous to use during the merge window)
> > > you can also cherry-pick that single commit on top of v5.3
> > > and use that as a base.
> > > 
> > > Note that that patch makes changes to struct cht_int33fe_data
> > > specifically it drops the:
> > > 
> > > 	struct fwnode_handle *mux;
> > > 
> > > Member, so when rebasing you should drop that in the new
> > > version of the struct on common.h .
> > > 
> > > Besides that this need a rebase, overall this looks good, I have some
> > > small remarks inline:
> > 
> > Arghh.. OK, I have rebased the patch but at current torvalds kernel
> > i2c_acpi_new_device() fails with -EPROBE_DEFER at my hw, so I cannot check if it
> > is fully working. But I will resend patch anyway soon, this error should
> > not be related to the patch content.
> 
> Are you sure it is not working? -EPROBE_DEFER is normal(ish) it just means
> that the i2c-controller driver for the bus has not initialized yet.
> 
> If you are building the i2c_designware or acpi_lpss drivers as module, or if
> you are building the intel_cht_int33fe code into the kernel, then this
> is more or less expected to happen.

I would agree but i2cdetect/i2cget works for this bus as expected. I
remember that I met this bug at one of previous iterations, hm... As I remember
it was caused by this commit:
00500147cbd3fc51353d0d003eaa9d31c72c0d50 drivers: Introduce device lookup variants by ACPI_COMPANION device.

This needs to be investigated.

> You can do "ls /sys/bus/i2c/devices" to check if it did succeed on
> later re-probe attempts (the fuel-gauge device should be there if
> things succeeded).
> 
> And you should probably do one more version, suppressing the dev_err
> on -EPROBE_DEFER like e.g. this snippet from the typec code:

OK, -EPROBE_DEFER was unexpected here for me...

 

-- 
Yauhen Kharuzhy
