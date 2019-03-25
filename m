Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B66020863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFejw81R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfCYQt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:49:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44936 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:49:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so217834pll.11;
        Mon, 25 Mar 2019 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cRN7VOh9L1wkyzHkDyYAB6NDqgSpzdOXz2/1ryeNu6M=;
        b=FFejw81R9AdsjB2uleTWWynA82/2PXFfn2kdJvbZrXFUMwGg6syEev2PTUPZUEEino
         MD6/mJaxfwvZ9+IR+zCdVi+7ahKqIrHMCIxpAcpbCngPb+g9s/R9sILyRJ6O5NZK/70n
         j6tYylJxvu1/H6+Z+DTU9NEGw/tCZRHJVZAyF5auzQZ+C8VURvTG9rcdOblCakyqZaBT
         NLSYem14fcMk6/ehZCPJBDg/kc+xsr+cVo/QaGq0FVnJvUwr7d4Nedidtci9KhjIs9Pc
         2WbYkqxJBtKw2jeNbUQp4y010qa5O9nmYom0YRo9Tc1r5iGZnUMTCJl8PKs3T1DEgPv9
         925w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cRN7VOh9L1wkyzHkDyYAB6NDqgSpzdOXz2/1ryeNu6M=;
        b=GGXrqTigXOkdCQzu1iO1GO+6Oc9NzdpAKiXQWReLyAMrIJbDOPNOWlnlhLFuwELgU1
         1BNETS/ZvrpDke/BF4v6mxIUyby1BdNRNkIDmSRU44rLMsJxmhgJJxQ/XQLiSxrfVwPA
         66ZUmgilZepld/g2BTlfBfUiC2BJAXg7CEsXO2Y/tuVw0gxAyEtsO+ICluw2G/4JdLyW
         KLdpN8XYxalx8xVgSvr8Kbn1GiFZSw74Iw67kmync+hAEJJFh870jTMAFAuUBsVaJpVe
         SwpjHP2YIlhPLTS3HYGf9yuRyBbkkLMzB44UYiUjl+FHcDHDHfYHVqkc5Y8z6Vvp2HGB
         AgQQ==
X-Gm-Message-State: APjAAAUyf2d1f0aTBO8B6M3oBLKcDgNzJcF2yXGTQldg+kY6ZOFScXaH
        iARard+fdA3RGgII8GAZIyg=
X-Google-Smtp-Source: APXvYqwLsMhdRy2EiO/6M29U1Mk5nn8ZqN8MMBWWajcCyU7PHhfRmFNKJ5AkSWp5H2WWnul5cjf6OQ==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10mr16018628plo.67.1553532566570;
        Mon, 25 Mar 2019 09:49:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17sm22902270pgt.0.2019.03.25.09.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:49:25 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:49:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Rosin <peda@axentia.se>
Cc:     Pradeep Srinivasan <pradeeps@cumulusnetworks.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ken Chen <chen.kenyy@inventec.com>
Subject: Re: [PATCH v2 5/5] i2c: mux: pca9541: add support for PCA9641
Message-ID: <20190325164925.GC28275@roeck-us.net>
References: <20190306231521.29367-1-peda@axentia.se>
 <20190306231521.29367-6-peda@axentia.se>
 <0105c583-6b33-066a-fefd-00c2a3090178@axentia.se>
 <CAPwEZY38PhUddxhbe_0qce_Ogj9wZXsC+0oB7_+gnkwuhO8Xnw@mail.gmail.com>
 <63e64b6a-5103-9cc2-b3d9-f7d00a333f86@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63e64b6a-5103-9cc2-b3d9-f7d00a333f86@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:01:21PM +0000, Peter Rosin wrote:
> On 2019-03-22 20:38, Pradeep Srinivasan wrote:
> > I have verified the changes on PCA 9541. May I know how you want the test results to be shared ? (newbie here; please bear with me)
> > 
> > root@cumulus:/home/cumulus# dmesg| grep "pca9541" | grep -v "pmbus"
> > [    2.922288] pca9541 1-0070: registered master selector for I2C pca9541
> > 
> > root@cumulus:/home/cumulus# cat /sys/class/i2c-dev/i2c-1/device/1-0070/name
> > pca9541
> 
> This only verifies that the probe works and that the chip is detected properly.
> It says nothing about if it works to communicate with whatever is beyond the
> PCA9541, and nothing on how the interaction with the "alien" other master
> connected to the PCA9541 is working. I don't know how I want this to be tested,
> but if you have a setup with a PCA9541 / PCA9641 I would assume that you
> have some kind of need for those chips and that you at least could report
> if basic xfers through them are working? I don't need to see actual commands
> that you have executed, I'm much more interested in some summary of what
> you did and what worked (or not).
> 
> E.g. if you have an eeprom beyond the master selector, you could read from
> it in a loop while doing something else from the alien master and check if
> it all works as expected? Perhaps try to verify timing if there are stalls
> and/or timeouts etc. Go wild! But if you don't know how or don't have the

Something like that is what I did to test the original implementation: Access
all chips behind the mux from both ends continuously. Let that run for an hour
or so and declare it a success if there is no error. Usually, while the code
was still buggy, errors would show up within minutes, if not seconds.

Guenter

> time, I'd be happy with a report on basic functionality (but a little bit
> more than probe-ok would be nice though), because the code affecting the
> PCA9541 is probably not broken subtly, it either works as it did before or
> it doesn't work at all. And any problem with the PCA9641 side of things
> will not be a regression and therefore not a big problem...
> 
> Cheers,
> Peter
> 
> > I need to do the same on PCA 9641. If the above is sufficient, I will grab a switch with PCA 9641 and check if the driver works .
> > 
> > 
> > Thanks
> > Pradeep
> > 
> > On Thu, Mar 7, 2019 at 1:16 PM Peter Rosin <peda@axentia.se <mailto:peda@axentia.se>> wrote:
> > 
> >     Hi!
> > 
> >     I should have read Kens code more carefully, before signing off on it...
> > 
> >     Review comments inline...
> > 
> >     On 2019-03-07 00:15, Peter Rosin wrote:
> >     > Heavily based on code from Ken Chen <chen.kenyy@inventec.com <mailto:chen.kenyy@inventec.com>>.
> >     >
> >     > Signed-off-by: Peter Rosin <peda@axentia.se <mailto:peda@axentia.se>>
> >     > ---
> >     >  drivers/i2c/muxes/Kconfig           |   6 +-
> >     >  drivers/i2c/muxes/i2c-mux-pca9541.c | 137 ++++++++++++++++++++++++++++++++++--
> >     >  2 files changed, 136 insertions(+), 7 deletions(-)
> >     >
> >     > diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> >     > index 52a4a922e7e6..8532841de5db 100644
> >     > --- a/drivers/i2c/muxes/Kconfig
> >     > +++ b/drivers/i2c/muxes/Kconfig
> >     > @@ -55,10 +55,10 @@ config I2C_MUX_LTC4306
> >     >         will be called i2c-mux-ltc4306.
> >     > 
> >     >  config I2C_MUX_PCA9541
> >     > -     tristate "NXP PCA9541 I2C Master Selector"
> >     > +     tristate "NXP PCA9541/PCA9641 I2C Master Selectors"
> >     >       help
> >     > -       If you say yes here you get support for the NXP PCA9541
> >     > -       I2C Master Selector.
> >     > +       If you say yes here you get support for the NXP PCA9541/PCA9641
> >     > +       I2C Master Selectors.
> >     > 
> >     >         This driver can also be built as a module.  If so, the module
> >     >         will be called i2c-mux-pca9541.
> >     > diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> >     > index 5eb36e3223d5..5d4e0c92e978 100644
> >     > --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> >     > +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> >     > @@ -1,5 +1,5 @@
> >     >  /*
> >     > - * I2C multiplexer driver for PCA9541 bus master selector
> >     > + * I2C multiplexer driver for PCA9541/PCA9641 bus master selectors
> >     >   *
> >     >   * Copyright (c) 2010 Ericsson AB.
> >     >   *
> >     > @@ -28,8 +28,8 @@
> >     >  #include <linux/slab.h>
> >     > 
> >     >  /*
> >     > - * The PCA9541 is a bus master selector. It supports two I2C masters connected
> >     > - * to a single slave bus.
> >     > + * The PCA9541 and PCA9641 are bus master selector. They support two I2C masters
> >     > + * connected to a single slave bus.
> >     >   *
> >     >   * Before each bus transaction, a master has to acquire bus ownership. After the
> >     >   * transaction is complete, bus ownership has to be released. This fits well
> >     > @@ -63,6 +63,33 @@
> >     >  #define PCA9541_BUSON        (PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
> >     >  #define PCA9541_MYBUS        (PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
> >     > 
> >     > +#define PCA9641_ID                   0x00
> >     > +#define PCA9641_ID_MAGIC             0x38
> >     > +
> >     > +#define PCA9641_CONTROL                      0x01
> >     > +#define PCA9641_STATUS                       0x02
> >     > +#define PCA9641_TIME                 0x03
> >     > +
> >     > +#define PCA9641_CTL_LOCK_REQ         BIT(0)
> >     > +#define PCA9641_CTL_LOCK_GRANT               BIT(1)
> >     > +#define PCA9641_CTL_BUS_CONNECT              BIT(2)
> >     > +#define PCA9641_CTL_BUS_INIT         BIT(3)
> >     > +#define PCA9641_CTL_SMBUS_SWRST              BIT(4)
> >     > +#define PCA9641_CTL_IDLE_TIMER_DIS   BIT(5)
> >     > +#define PCA9641_CTL_SMBUS_DIS                BIT(6)
> >     > +#define PCA9641_CTL_PRIORITY         BIT(7)
> >     > +
> >     > +#define PCA9641_STS_OTHER_LOCK               BIT(0)
> >     > +#define PCA9641_STS_BUS_INIT_FAIL    BIT(1)
> >     > +#define PCA9641_STS_BUS_HUNG         BIT(2)
> >     > +#define PCA9641_STS_MBOX_EMPTY               BIT(3)
> >     > +#define PCA9641_STS_MBOX_FULL                BIT(4)
> >     > +#define PCA9641_STS_TEST_INT         BIT(5)
> >     > +#define PCA9641_STS_SCL_IO           BIT(6)
> >     > +#define PCA9641_STS_SDA_IO           BIT(7)
> >     > +
> >     > +#define PCA9641_RES_TIME             0x03
> > 
> >     This appears to be the same thing as PCA9641_TIME above. The
> >     register is called PCA9641_RT in my data sheet.
> > 
> >     > +
> >     >  /* arbitration timeouts, in jiffies */
> >     >  #define ARB_TIMEOUT  (HZ / 8)        /* 125 ms until forcing bus ownership */
> >     >  #define ARB2_TIMEOUT (HZ / 4)        /* 250 ms until acquisition failure */
> >     > @@ -73,6 +100,7 @@
> >     > 
> >     >  enum chip_name {
> >     >       pca9541,
> >     > +     pca9641,
> >     >  };
> >     > 
> >     >  struct chip_desc {
> >     > @@ -102,6 +130,21 @@ static bool pca9541_busoff(int ctl)
> >     >       return (ctl & PCA9541_BUSON) == PCA9541_BUSON;
> >     >  }
> >     > 
> >     > +static bool pca9641_lock_grant(int ctl)
> >     > +{
> >     > +     return !!(ctl & PCA9641_CTL_LOCK_GRANT);
> >     > +}
> >     > +
> >     > +static bool pca9641_other_lock(int sts)
> >     > +{
> >     > +     return !!(sts & PCA9641_STS_OTHER_LOCK);
> >     > +}
> >     > +
> >     > +static bool pca9641_busoff(int ctl, int sts)
> >     > +{
> >     > +     return !pca9641_lock_grant(ctl) && !pca9641_other_lock(sts);
> >     > +}
> >     > +
> >     >  /*
> >     >   * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
> >     >   * as they will try to lock the adapter a second time.
> >     > @@ -256,6 +299,86 @@ static int pca9541_arbitrate(struct i2c_client *client)
> >     >       return 0;
> >     >  }
> >     > 
> >     > +/* Release bus. */
> >     > +static void pca9641_release_bus(struct i2c_client *client)
> >     > +{
> >     > +     pca9541_reg_write(client, PCA9641_CONTROL, 0);
> > 
> >     Should this release bus function really "clobber" the control bits
> >     PCA9641_CTL_IDLE_TIMER_DIS, PCA9641_CTL_SMBUS_DIS, PCA9641_CTL_PRIORITY?
> >     Yes yes, the driver never sets these bits so they are likely zero. But
> >     the driver doesn't reset the chip either, so some bootstrap code might
> >     have configured those bits...
> > 
> >     Also related to bus release, since the driver does not touch the
> >     reserve time register, and then clears the above bits, the only way
> >     to release the bus is if everything continues to work and the above
> >     pca9641_release_bus is in fact happening. But if the kernel crashes
> >     while hogging the bus, and fails to come up, then the other master
> >     has no way of stealing the ownership. I really feel that the driver
> >     should make use of the timers so that the arbiter releases the bus
> >     automatically on catastrophic failure. But maybe I plain and simple
> >     just misunderstand the datasheet?
> > 
> >     > +}
> >     > +
> >     > +/*
> >     > + * Channel arbitration
> >     > + *
> >     > + * Return values:
> >     > + *  <0: error
> >     > + *  0 : bus not acquired
> >     > + *  1 : bus acquired
> >     > + */
> >     > +static int pca9641_arbitrate(struct i2c_client *client)
> >     > +{
> >     > +     struct i2c_mux_core *muxc = i2c_get_clientdata(client);
> >     > +     struct pca9541 *data = i2c_mux_priv(muxc);
> >     > +     int reg_ctl, reg_sts;
> >     > +
> >     > +     reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
> >     > +     if (reg_ctl < 0)
> >     > +             return reg_ctl;
> >     > +     reg_sts = pca9541_reg_read(client, PCA9641_STATUS);
> >     > +
> >     > +     if (pca9641_busoff(reg_ctl, reg_sts)) {
> >     > +             /*
> >     > +              * Bus is off. Request ownership or turn it on unless
> >     > +              * other master requested ownership.
> >     > +              */
> >     > +             reg_ctl |= PCA9641_CTL_LOCK_REQ;
> >     > +             pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> >     > +             reg_ctl = pca9541_reg_read(client, PCA9641_CONTROL);
> >     > +
> >     > +             if (pca9641_lock_grant(reg_ctl)) {
> >     > +                     /*
> >     > +                      * Other master did not request ownership,
> >     > +                      * or arbitration timeout expired. Take the bus.
> >     > +                      */
> >     > +                     reg_ctl |= PCA9641_CTL_BUS_CONNECT |
> >     > +                             PCA9641_CTL_LOCK_REQ;
> >     > +                     pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> >     > +                     data->select_timeout = SELECT_DELAY_SHORT;
> >     > +
> >     > +                     return 1;
> >     > +             }
> >     > +
> >     > +             /*
> >     > +              * Other master requested ownership.
> >     > +              * Set extra long timeout to give it time to acquire it.
> >     > +              */
> >     > +             data->select_timeout = SELECT_DELAY_LONG * 2;
> >     > +
> >     > +             return 0;
> >     > +     }
> >     > +
> >     > +     if (pca9641_lock_grant(reg_ctl)) {
> >     > +             /*
> >     > +              * Bus is on, and we own it. We are done with acquisition.
> >     > +              */
> >     > +             reg_ctl |= PCA9641_CTL_BUS_CONNECT | PCA9641_CTL_LOCK_REQ;
> >     > +             pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> >     > +
> >     > +             return 1;
> >     > +     }
> >     > +
> >     > +     if (pca9641_other_lock(reg_sts)) {
> >     > +             /*
> >     > +              * Other master owns the bus.
> >     > +              * If arbitration timeout has expired, force ownership.
> >     > +              * Otherwise request it.
> > 
> >     This comment is stale. Reading the data sheet, I find no way to force
> >     ownership with the PCA9641 (as indicated above in the release_bus
> >     review comment). But I have only browsed the data sheet so I could
> >     easily be mistaken...
> > 
> >     [time passes]
> > 
> >     Ahhh, wait, it could reset the chip to get a new chance to get ownership.
> >     But that will reset all registers for the other master as well, since I
> >     read it as if the reset is chip-global and not master-local with minimal
> >     effects on the other master. So, a big hammer indeed.
> > 
> >     Cheers,
> >     Peter
> > 
> >     > +              */
> >     > +             data->select_timeout = SELECT_DELAY_LONG;
> >     > +             reg_ctl |= PCA9641_CTL_LOCK_REQ;
> >     > +             pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
> >     > +     }
> >     > +
> >     > +     return 0;
> >     > +}
> >     > +
> >     >  static int pca9541_select_chan(struct i2c_mux_core *muxc, u32 chan)
> >     >  {
> >     >       struct pca9541 *data = i2c_mux_priv(muxc);
> >     > @@ -295,10 +418,15 @@ static const struct chip_desc chips[] = {
> >     >               .arbitrate = pca9541_arbitrate,
> >     >               .release_bus = pca9541_release_bus,
> >     >       },
> >     > +     [pca9641] = {
> >     > +             .arbitrate = pca9641_arbitrate,
> >     > +             .release_bus = pca9641_release_bus,
> >     > +     },
> >     >  };
> >     > 
> >     >  static const struct i2c_device_id pca9541_id[] = {
> >     >       { "pca9541", pca9541 },
> >     > +     { "pca9641", pca9641 },
> >     >       {}
> >     >  };
> >     > 
> >     > @@ -307,6 +435,7 @@ MODULE_DEVICE_TABLE(i2c, pca9541_id);
> >     >  #ifdef CONFIG_OF
> >     >  static const struct of_device_id pca9541_of_match[] = {
> >     >       { .compatible = "nxp,pca9541", .data = &chips[pca9541] },
> >     > +     { .compatible = "nxp,pca9641", .data = &chips[pca9641] },
> >     >       {}
> >     >  };
> >     >  MODULE_DEVICE_TABLE(of, pca9541_of_match);
> >     > @@ -392,5 +521,5 @@ static struct i2c_driver pca9541_driver = {
> >     >  module_i2c_driver(pca9541_driver);
> >     > 
> >     >  MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>");
> >     > -MODULE_DESCRIPTION("PCA9541 I2C master selector driver");
> >     > +MODULE_DESCRIPTION("PCA9541/PCA9641 I2C master selector driver");
> >     >  MODULE_LICENSE("GPL v2");
> >     >
> > 
> 
