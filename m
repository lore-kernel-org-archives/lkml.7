Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C92CA9ED3
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6981214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 04:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olC2ceUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKCEpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 00:45:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41733 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKCEpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 00:45:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id p26so9869880pfq.8;
        Sat, 02 Nov 2019 21:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GL01rhxmBnK4Gz7D2X/Hg/HT/Hp846VpWEX1h6YqSe0=;
        b=olC2ceUKmmTNr69dJvXYONyXDaPJk2XHpK10lPOt7WyieEVP+1Q7tQ+3Uak1x2Ymte
         vUnHNvhX2dREl9b2tqyeXj3xAtbiwG9w3je6l6XZ586dsnFrHpLcbu/fRCJV6kw+7o3r
         H0GhlBmJs7k/3efKcfyMsCmJ6m4yYnHcszhAh6MOmGqDNcyomvD88mdO6TVXpDHV0v0s
         n3HhY+VvT5Xlc7kQFBUItyKASFx3AN5om9J71HtV3dXqynXRiG7uTl3ORpFGyWVhbd5S
         uu0ENOQdfA4hLi9XEdlNdIA6vDbUmyyhdAnnuatr/riLKc9HZdGSb8Bq838B3zbThY+d
         aA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GL01rhxmBnK4Gz7D2X/Hg/HT/Hp846VpWEX1h6YqSe0=;
        b=EHq//A3dAQ7auum8ZzGW720omYRnZGTnjhy3dCqIsC5c41UFLTNWEY39t2B/x3N6y3
         xt9i84qgko7YfkFyvDoydL07r4jaGxW3hm/A0OBV7X52cxW1f4H/hBmYHwo8PM+Unjj0
         NtD+GSHT4H9kLvS28DIs6NP/dqa3VN3NjADOtOFx7nWn8Ar4bxAWPIC4On6giAvZ3Pet
         LLUwyAUbWZ8Bfay/jvsGLJdL1VRe5wdNLZ+2w4VgJHsNsZlJRR77+1Ab8N/hCV7iNF08
         rYoMeWOyU/cT49LbZDSBMO9f1aCu8YEkalQuXyKskLtQl6Fzuq3jnLIUvKw8twfw1NeG
         U17g==
X-Gm-Message-State: APjAAAVIsXfUVoWEF9UBPwenVpi0bxp0675r2hwMcl8pSQb7V/rEynG4
        XlXo+kEcCeXLJvvGuB7NXg5wwuMDtzA=
X-Google-Smtp-Source: APXvYqwkqGNo/BCVYzdcEsNB9WDWjv8KKEwvpu5YJChb2Vzl8fu8tcPpSGd3KmwNMBDYm2yroteIuw==
X-Received: by 2002:a63:e84d:: with SMTP id a13mr21142178pgk.226.1572756303000;
        Sat, 02 Nov 2019 21:45:03 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id d9sm11209422pgc.80.2019.11.02.21.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Nov 2019 21:45:02 -0700 (PDT)
Date:   Sat, 2 Nov 2019 21:44:52 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v2 2/2] docs: hwmon: Document bel-pfe pmbus driver
Message-ID: <20191103044432.GA3364@taoren-ubuntu-R90MNF91>
References: <20191029182054.32279-1-rentao.bupt@gmail.com>
 <20191029182054.32279-3-rentao.bupt@gmail.com>
 <20191102153115.GA5205@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102153115.GA5205@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 08:31:15AM -0700, Guenter Roeck wrote:
> On Tue, Oct 29, 2019 at 11:20:54AM -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Add documentation for bel-pfe pmbus driver which supports BEL PFE1100 and
> > PFE3000 power supplies.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Applied after adding bel-pfe to index.rst.
> 
> Thanks,
> Guenter

Thank you Guenter. I didn't know index.rst needs to be updated; will
do it for my future doc patches.


Cheers,

Tao

> > ---
> >  No change in v2.
> > 
> >  Documentation/hwmon/bel-pfe.rst | 112 ++++++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >  create mode 100644 Documentation/hwmon/bel-pfe.rst
> > 
> > diff --git a/Documentation/hwmon/bel-pfe.rst b/Documentation/hwmon/bel-pfe.rst
> > new file mode 100644
> > index 000000000000..4b4a7d67854c
> > --- /dev/null
> > +++ b/Documentation/hwmon/bel-pfe.rst
> > @@ -0,0 +1,112 @@
> > +Kernel driver bel-pfe
> > +======================
> > +
> > +Supported chips:
> > +
> > +  * BEL PFE1100
> > +
> > +    Prefixes: 'pfe1100'
> > +
> > +    Addresses scanned: -
> > +
> > +    Datasheet: https://www.belfuse.com/resources/datasheets/powersolutions/ds-bps-pfe1100-12-054xa.pdf
> > +
> > +  * BEL PFE3000
> > +
> > +    Prefixes: 'pfe3000'
> > +
> > +    Addresses scanned: -
> > +
> > +    Datasheet: https://www.belfuse.com/resources/datasheets/powersolutions/ds-bps-pfe3000-series.pdf
> > +
> > +Author: Tao Ren <rentao.bupt@gmail.com>
> > +
> > +
> > +Description
> > +-----------
> > +
> > +This driver supports hardware monitoring for below power supply devices
> > +which support PMBus Protocol:
> > +
> > +  * BEL PFE1100
> > +
> > +    1100 Watt AC to DC power-factor-corrected (PFC) power supply.
> > +    PMBus Communication Manual is not publicly available.
> > +
> > +  * BEL PFE3000
> > +
> > +    3000 Watt AC/DC power-factor-corrected (PFC) and DC-DC power supply.
> > +    PMBus Communication Manual is not publicly available.
> > +
> > +The driver is a client driver to the core PMBus driver. Please see
> > +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> > +
> > +
> > +Usage Notes
> > +-----------
> > +
> > +This driver does not auto-detect devices. You will have to instantiate the
> > +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> > +details.
> > +
> > +Example: the following will load the driver for an PFE3000 at address 0x20
> > +on I2C bus #1::
> > +
> > +	$ modprobe bel-pfe
> > +	$ echo pfe3000 0x20 > /sys/bus/i2c/devices/i2c-1/new_device
> > +
> > +
> > +Platform data support
> > +---------------------
> > +
> > +The driver supports standard PMBus driver platform data.
> > +
> > +
> > +Sysfs entries
> > +-------------
> > +
> > +======================= =======================================================
> > +curr1_label		"iin"
> > +curr1_input		Measured input current
> > +curr1_max               Input current max value
> > +curr1_max_alarm         Input current max alarm
> > +
> > +curr[2-3]_label		"iout[1-2]"
> > +curr[2-3]_input		Measured output current
> > +curr[2-3]_max           Output current max value
> > +curr[2-3]_max_alarm     Output current max alarm
> > +
> > +fan[1-2]_input          Fan 1 and 2 speed in RPM
> > +fan1_target             Set fan speed reference for both fans
> > +
> > +in1_label		"vin"
> > +in1_input		Measured input voltage
> > +in1_crit		Input voltage critical max value
> > +in1_crit_alarm		Input voltage critical max alarm
> > +in1_lcrit               Input voltage critical min value
> > +in1_lcrit_alarm         Input voltage critical min alarm
> > +in1_max                 Input voltage max value
> > +in1_max_alarm           Input voltage max alarm
> > +
> > +in2_label               "vcap"
> > +in2_input               Hold up capacitor voltage
> > +
> > +in[3-8]_label		"vout[1-3,5-7]"
> > +in[3-8]_input		Measured output voltage
> > +in[3-4]_alarm           vout[1-2] output voltage alarm
> > +
> > +power[1-2]_label	"pin[1-2]"
> > +power[1-2]_input        Measured input power
> > +power[1-2]_alarm	Input power high alarm
> > +
> > +power[3-4]_label	"pout[1-2]"
> > +power[3-4]_input	Measured output power
> > +
> > +temp[1-3]_input		Measured temperature
> > +temp[1-3]_alarm         Temperature alarm
> > +======================= =======================================================
> > +
> > +.. note::
> > +
> > +    - curr3, fan2, vout[2-7], vcap, pin2, pout2 and temp3 attributes only
> > +      exist for PFE3000.
