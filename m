Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D5EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05471206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXu0iFWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfDQSjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:39:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37012 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDQSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:39:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so12505356pfr.4;
        Wed, 17 Apr 2019 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PBOQT6fkoE7GfjMsXFE/HyESKNpcEKYwhhA5gd7dzjg=;
        b=YXu0iFWDwN2v0wfNalRGqqqyv77fKNUiAQbAiXtx9OUKAYw+1Pgi5Kq2Ti0uCZf/+d
         O0Phy3cwWtk87rW93E+Y8xQNtZRYMSRF5Die9m+qoY6ZIlyiefIqjnbGmUi05wmApi3L
         dRaa1u3A2zmU8TYGyuXhKlEShUEZOcFnTtKN8ViN1M9HpNK1rrlM4G1k7W6M9F9bOmUS
         J0orT3J5vqdOMi7y3OVua0eg1HMxYJGHd3Is42QUubUxWC5FWu1xhZUDuxXjcP7pUGiU
         +n5jLA76IgbMov3OKHlcTRZfnTZMk473HfxOD6TnfHsCCGdWH2G/WNoBLpW2WwYnB96x
         P2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PBOQT6fkoE7GfjMsXFE/HyESKNpcEKYwhhA5gd7dzjg=;
        b=PigVZKaPehpg7VZpfIqAdpWIXPYO1G9uMJbWq23LydpySmU02QyxzR7kPnFiiIzfX1
         m/Wye8nMQzrPKIxaqmVdLYyxujvWWTF/jhlWQVDkG0xXY/BkNKPX/FD50R9U+vNHYNzE
         Rytkp3j5l/1nJCMHq/v4H02K0ay1HV1/I8AWjSPSXLu3xmEBw5kgsxfz/pbsAA8IufnE
         666cnwYkoQXg3e153a62gJcN1uKVX1C/tFUaSaHHczqgwfv70tYZ64s+6YNwUByFduNX
         jji4+6qcymqYeQq8PaDXaqA6hLnm9hZ0U+2gek6Ci4ZJF672Ilg1Ii2Ns7fPuRYLq0wA
         mt6w==
X-Gm-Message-State: APjAAAWtCMa8GaWQ76G0BT2CdvsDokWmknDyfOMn/gH7NJxKh+vz93lZ
        +7P4O9VhSEJDRDdj4ahMizBntijWcg8=
X-Google-Smtp-Source: APXvYqzFyTRYlghF/f7ZmXHJOzQFr9VecV1JCwU34JoY1FRDM+KAXDdkRiY1uU7WN/XXoWbESW4ESw==
X-Received: by 2002:aa7:8c13:: with SMTP id c19mr90321674pfd.225.1555526393111;
        Wed, 17 Apr 2019 11:39:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q128sm86364949pga.60.2019.04.17.11.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 11:39:52 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:39:50 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Add voltage conversion time settings
Message-ID: <20190417183949.GB5073@Asurada-Nvidia.nvidia.com>
References: <20190416235548.22733-1-nicoleotsuka@gmail.com>
 <1ad27385-e62a-d4f0-2590-c50458119f12@roeck-us.net>
 <2a193494-a33e-dac0-456a-241d7b3e59ad@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a193494-a33e-dac0-456a-241d7b3e59ad@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 07:04:09AM -0700, Guenter Roeck wrote:
> > > I am not quite sure if this update_interval is the best way to
> > > implement the conversion time settings but I can't find another
> > > common approach. This implementation certainly has drawbacks:
> > >   1) It can't configure Bus and Shunt conversion times separately
> > >      (Not crucial for me at this point as I set them equally)
> > >   2) Users need to calculate for the settings of conversion time
> > >   3) The ABI defines update_interval in msec while the hardware
> > >      and datasheet does in usec, and that generates rounding diff
> > >   4) The update_interval value would be spontaneously modified
> > >      everytime number of samples or number of enabled channels
> > >      gets changed. This might confuses users who tries to have
> > >      a fixed update_interval other than really merely setting
> > >      conversion time.
> > > 
> > > I see IIO subsystem have something like IIO_CHAN_INFO_INT_TIME
> > > for conversion time setting exclusively. Do we have something
> > > similar under hwmon?
> > > 
> > 
> > No. I think what you have should be good enough for now.
> > Please see comments below.

OK. I will go ahead with this approach then.

> > > +        /* Update Bus-voltage conversion time */
> > > +        ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
> > > +                     INA3221_CONFIG_VBUS_CT_MASK,
> > > +                     idx << INA3221_CONFIG_VBUS_CT_SHIFT);
> > > +        if (ret)
> > > +            return ret;
> > > +
> > > +        /* Update Shunt-voltage conversion time */
> > > +        ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
> > > +                     INA3221_CONFIG_VSH_CT_MASK,
> > > +                     idx << INA3221_CONFIG_VSH_CT_SHIFT);
> > > +        if (ret)
> > > +            return ret;
> > 
> > It should be possible to update both conversion times with a single call,
> > since both calls touch only one register. Something like
> > 
> >          ret = regmap_update_bits(ina->regmap, INA3221_CONFIG
> >              INA3221_CONFIG_VBUS_CT_MASK | INA3221_CONFIG_VSH_CT_MASK,
> >              (idx << INA3221_CONFIG_VBUS_CT_SHIFT) | (idx << INA3221_CONFIG_VSH_CT_SHIFT));
> > 
> > Granted, that is a bit long, but it saves an extra i2c write operation.

Will merge them.

> Thinking about it ... does it even make sense to cache reg_config twice,
> or would it be better to just update the local copy and use regmap_write()
> to send it to the chip ?

I remember the reason of adding the read-back was to prevent race
condition. But now we have mutex protections for all sysfs nodes,
maybe it's not necessary anymore. I will read the code carefully
and see if it's safe to remove it -- will do in a separate patch.

Thanks
Nicolin
