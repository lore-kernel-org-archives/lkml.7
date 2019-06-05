Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B2C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8919620874
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVvw4L2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFERri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:47:38 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55954 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfFERri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:47:38 -0400
Received: by mail-it1-f194.google.com with SMTP id i21so4814804ita.5;
        Wed, 05 Jun 2019 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfpNMs0qBdZunrudW5P8w9zGiTn2bNjLPMUaDAOngOU=;
        b=HVvw4L2TsO9UjjSdDA8eu7X54+P/JDP8YBeUbQ0yebOV2wR4NyeF2OQrrbr47SfJju
         g4vEN9Lc0d7E9Bok6ZSSxYoscWdjXGy/v+X0tyuUG4GAjchlx7RICUsHlGHXpCZLspwb
         o9lfNVsPZypxhh4Jf5ZvKcBSJKPZ55vPB3rO1Ch7/FTjBm+h4XgweOFsst6w6yw8J/yk
         HF4BiZK+P9hpNqWSZQHDjpSgU2l9BYy/zRDefAImPIH+uo14Of4AJRoAU0w6YcATTrs/
         3I6uo2/dO6ZKN+QG06chHXPV4PCJqh3bYsnplDZb2++Ibbf82iwviMDSZQcX+6hSPwYk
         FpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfpNMs0qBdZunrudW5P8w9zGiTn2bNjLPMUaDAOngOU=;
        b=d4OhyAdA80869JChxUxc1qbLEqVOJeKoaTzXzQ2dLoy6hqTzk4vepxwaIa91wf6mZb
         wPuXHU3e1CXVUZjnT/kMoG0TLRMi5kKPfaXjXaz1zABMexNPGGlRgbOMa7AHdRo/5Ndh
         Wc/GL82Q3EaHy5LSWV0RNMiY3NGeSXNILdlOK09pqnHRfhSo3VTuNc9k4f5SXrS6jhlQ
         B1x0oGvsF+d+xy8lpoW4vpyywZlKv8x7BqIkXDLLqjrxlLGq+4OaTJWvGREFm1Y2wu/G
         PB74bpNMjzmHr9zFukbRZhspxxrFHECYMygFZyjxuHUUrLWSZIphPILmdOiXvXoQoXDE
         2/tQ==
X-Gm-Message-State: APjAAAUv2cAlGIMhuoedhrAeX1La4Cw4M2Kb1/kBDMueC5re59ewjKj7
        UEoCzG6UdGVfyrkHaPqPhS1seLOxKS/XB5cgj9c=
X-Google-Smtp-Source: APXvYqxt7DqRNjArzM8BhzTRDyq29yQ2jvADsKdaAoED/EHBfCAEeDAUuwOID6CHQCQB76ei9HH56xI+9jp5iv/c5JM=
X-Received: by 2002:a24:c0c2:: with SMTP id u185mr13228186itf.2.1559756856877;
 Wed, 05 Jun 2019 10:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190605072323.21990-1-andrew.smirnov@gmail.com>
 <20190605072323.21990-3-andrew.smirnov@gmail.com> <d9d8b0c4-e9f4-5a92-3832-3449153f807d@ti.com>
In-Reply-To: <d9d8b0c4-e9f4-5a92-3832-3449153f807d@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 5 Jun 2019 10:47:25 -0700
Message-ID: <CAHQ1cqFRVmZvcFyV93udAHEwZG8NhtM350BSm7JcchNFiqZDjA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] power: supply: ucs1002: Add HWMON interface
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 9:26 AM Andrew F. Davis <afd@ti.com> wrote:
>
> On 6/5/19 3:23 AM, Andrey Smirnov wrote:
> > Expose current sensors found on UCS1002 via HWMON.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Cory Tusar <cory.tusar@zii.aero>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >   drivers/power/supply/ucs1002_power.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> > index 677f20a4d76f..a4b6b37549cf 100644
> > --- a/drivers/power/supply/ucs1002_power.c
> > +++ b/drivers/power/supply/ucs1002_power.c
> > @@ -571,6 +571,12 @@ static int ucs1002_probe(struct i2c_client *client,
> >               return ret;
> >       }
> >
> > +     ret = devm_power_supply_add_hwmon_sysfs(info->charger);
>
> Could this be added to the core power supply framework on registering so
> all devices get this, vs each driver having to add this line?
>

I'd say it is up to Sebastian to decide if this should be opt-out
rather than opt-in. I have no objections to either approach.

Thanks,
Andrey Smirnov
