Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4D2C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C9F215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 06:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbfJDGhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 02:37:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38113 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfJDGhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 02:37:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so5309601ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 23:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EYNMV6z6E9PNGCql76LzpfAoXqSPACISJaUyi2psgFs=;
        b=Vua8UjXGwvVeAQipNq1bwFREK18L1/mwmnWJgZkqgQJ69mNspUmTw3NdC45xW2OFfQ
         kio5Jh4QvDMo0eb3vh0nlocbzYopTz7ZLAZDzYQ5/2r0MQmZcbwdqG3VpEMVz5v4KyQN
         BsolTUF1mWbiNXz8Gw7ref5Ewy5VAEoNTe4d9yTOwpshRgHURZFkLH48ZuCmASqNSSRy
         g3dJzWspn3kcOpDAXCMBJtQs/vbh8P7yc8UCYQvoqfvxwq/TkI0DXj0WR4SECq0Qwtff
         +kJPJ4CkE0z3xGVrHFisXauQJ3nuwGnkCEhGg+k4Z/qYZFT5Yu0rglRjop0ixrxpALFg
         RzyA==
X-Gm-Message-State: APjAAAVhavZDdDrctFr0matX2wSc4jlvjN2LTiA0Ai6XeSc9DIyJjQcd
        x0ZqUYv4U39qLL3AaTPk41c=
X-Google-Smtp-Source: APXvYqw5oBe4uAsvNP5GVi5SD+27ZVSekCjgHqpGvwQVXCaGvKY45m7Opn2YGghOhgEZbaEDQMFHiA==
X-Received: by 2002:a2e:9159:: with SMTP id q25mr8515007ljg.225.1570171022671;
        Thu, 03 Oct 2019 23:37:02 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t16sm1023334ljj.29.2019.10.03.23.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 23:37:01 -0700 (PDT)
Date:   Fri, 4 Oct 2019 09:34:43 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191004063443.GA26028@localhost.localdomain>
References: <20190917154021.14693-2-m.felsch@pengutronix.de>
 <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk>
 <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
 <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
 <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho Peeps,

Long time no hear =)

On Tue, Oct 01, 2019 at 12:57:31PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Sep 27, 2019 at 1:47 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > > > It should be possible to do a regulator_disable() though I'm not
> > > > > > sure anyone actually uses that.  The pattern for a regular
> > > > > > consumer should be the normal enable/disable pair to handle
> > > > > > shared usage, only an exclusive consumer should be able to use
> > > > > > just a straight disable.
> >
> > In my case it is a regulator-fixed which uses the enable/disable pair.
> > But as my descriptions says this will not work currently because boot-on
> > marked regulators can't be disabled right now (using the same logic as
> > always-on regulators).
> >

I was developing driver for yet-another ROHM PMIC when I hit the
phenomena you have been discussing here (I think) :) I used regulator-boot-on
flag from DT in my test setup and then did a test consumer who does

regulator_get()
regulator_enable()
regulator_disable() pair.

As this 'test consumer' was only user for the regulator I expected the
regulator to be disabled after call to regulator_disable. But it was
not.

It seems to me that the use_count is incremented for boot-on regulators
before first call to regulator_enable(). So when the consumer does first
regulator_enable() the use_count will actually go to 2. Hence the
corresponding regulator_disable() won't actually disable the regulator
even though the consumer is actually only known user.

I did unbalanced regulator_disable() - which does disable the regulator
but it also spills the warning.

I did instrument the regmap helpers and regulator_enable/disable to
dump out the actual i2c accesses and use_counts. Regulator enable prints
use_count _before_ incrementing it.


Check enable state after regulator_get (calls regulator_is_enabled)
root@arm:/sys/kernel/mva_test/regulators# cat buck3_en 
[  123.251499] dbg_regulator_is_enabled_regmap: called for 'buck3'
[  123.257524] regulator_is_enabled_regmap_dbg: Reading reg 0x1c
[  123.267386] regulator_is_enabled_regmap_dbg: read succeeded, val 0xe

Enable regulator by test consumer (no i2c access as regulator is on)
1root@arm:/sys/kernel/mva_test/regulators# echo 1 > buck3_en 
[  171.438524] Calling regulator_enable
[  171.446324] Enable requested, use-count 1

/* disable regulator by consumer */
root@arm:/sys/kernel/mva_test/regulators# echo 0 > buck3_en                                                                                     
[  187.799956] Calling regulator_disable
[  187.805935] regulator disable requested, use-count 2, always-on 0

/* Unbalanced disble */
root@arm:/sys/kernel/mva_test/regulators# echo 0 > buck3_en 
[  207.832682] Calling regulator_disable
[  207.842949] regulator disable requested, use-count 1, always-on 0
[  207.849237] regulator do disable
[  207.852502] dbg_regulator_disable_regmap: called for 'buck3'
[  207.858272] regulator_disable_regmap_dbg: reg 0x1c mask 0x8 val 0x0, masked_val 0x0
[  207.909942] buck3: Underflow of regulator enable count
[  207.915189] Failed to toggle regulator state. error(-22)
bash: echo: write error: Invalid argument
root@arm:/sys/kernel/mva_test/regulators# 

> > > > > Ah, I see, I wasn't aware of the "exclusive" special case!  Marco: is
> > > > > this working for you?  I wonder if we need to match
> > > > > "regulator->enable_count" to "rdev->use_count" at the end of
> > > > > _regulator_get() in the exclusive case...
> >
> > So my fix isn't correct to fix this in general?
> 
> I don't think your fix is correct.  It sounds as if the intention of
> "regulator-boot-on" is to have the OS turn the regulator on at bootup
> and it keep an implicit reference until someone explicitly tells the
> OS to drop the reference.

Hmm.. What is the intended way to explicitly tell the OS to drop the
reference? I would assume we should still use same logic as with other
regulators - if last user calls regulator_disable() we should disable
the regulator? (I may not understand all this well enough though)
 
> > > > Yes, I think that case has been missed when adding the enable
> > > > counts - I've never actually had a system myself that made any
> > > > use of this stuff.  It probably needs an audit of the users to
> > > > make sure nobody's relying on the current behaviour though I
> > > > can't think how they would.
> > >
> > > Marco: I'm going to assume you'll tackle this since I don't actually
> > > have any use cases that need this.
> >
> > My use case is a simple regulator-fixed which is turned on by the
> > bootloader or to be more precise by the pmic-rom. To map that correctly
> > I marked this regulator as boot-on. Unfortunately as I pointed out above
> > this is handeld the same way as always-on.

Here I am again just a man in the middle as I am "only a component vendor"
and lack of complete system information. But I _think_ some of the users
of BD71827 and BD71847 PMICs do use setup where regulator-boot-on is
used to enable certain BUCKs to power some graphics chip at start-up. At
later stage it should be possible to cut the power in order to do power
saving or decrease heating when graphichs are not needed. So I think it
would be nice to fix this somehow.

> It's a fixed regulator controlled by a GPIO?  Presumably the GPIO can
> be read.  That would mean it ideally shouldn't be using
> "regulator-boot-on" since this is _not_ a regulator whose software
> state can't be read.  Just remove the property.

How should we handle cases where we want OS to enable regulator at
boot-up - possibly before consumer drivers can be load?


Br,
	Matti Vaittinen
-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
