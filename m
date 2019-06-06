Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA88C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC6B20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559841655;
	bh=6YEYS2jdADr9Oq/g9NGffgzEuz06f2gVd4Lh8QYw1TU=;
	h=In-Reply-To:References:To:Subject:From:Cc:Date:List-ID:From;
	b=JsxxEcKxR4YAtyanV+KRFZhcgoR7pcMk0gBshQ0GksRK22qoxU2MpB61W/4ei7qub
	 uqsuvzzkGNOeTrzzqE0QrBj6ryykI8rFh7UQ2wGQW7zDWTVuSShQWnvEoGdJgLoe3w
	 NdzX4HmyW2Z2L3mJSn3mhBTB0EYri2DLee3qKa3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfFFRUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfFFRUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:20:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82E42083E;
        Thu,  6 Jun 2019 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559841653;
        bh=6YEYS2jdADr9Oq/g9NGffgzEuz06f2gVd4Lh8QYw1TU=;
        h=In-Reply-To:References:To:Subject:From:Cc:Date:From;
        b=VXzwjZh3p8VZPRX7PnXTwCco6S3FNWuYLO+sKtg5HELRMD6B9ePLckxb34uA2Cdf1
         E4h9AF7o7xvUfaf15aGV0oFVFX1Jn2Y9f99Ts1r8xIDiC7zJ0rX+eQ7RRT4EEmnlQC
         TLG6b1DoufRctlYPm6z9bbwhRwD2UcJiehne1uwM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2dd0a516bbfe6150112ec7dc5f7d4d85cbe3cd03.camel@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de> <20190606142255.29454-6-nsaenzjulienne@suse.de> <20190606170505.39C5B20693@mail.kernel.org> <2dd0a516bbfe6150112ec7dc5f7d4d85cbe3cd03.camel@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com
Subject: Re: [PATCH v2 5/7] clk: raspberrypi: register platform device for raspberrypi-cpufreq
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        ptesarik@suse.com, viresh.kumar@linaro.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 10:20:52 -0700
Message-Id: <20190606172053.C82E42083E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-06 10:16:56)
> On Thu, 2019-06-06 at 10:05 -0700, Stephen Boyd wrote:
> > Quoting Nicolas Saenz Julienne (2019-06-06 07:22:58)
> > > diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> > > raspberrypi.c
> > > index b1365cf19f3a..052296b5fbe4 100644
> > > --- a/drivers/clk/bcm/clk-raspberrypi.c
> > > +++ b/drivers/clk/bcm/clk-raspberrypi.c
> > > @@ -63,6 +63,8 @@ struct raspberrypi_firmware_prop {
> > >         __le32 disable_turbo;
> > >  } __packed;
> > > =20
> > > +static struct platform_device *rpi_cpufreq;
> >=20
> > Why can't this be stored in platform driver data?
>=20
> It actually could, I just followed the same pattern as the code found in =
patch
> #3. I'll update it in the next version if you prefer it.=20
>=20

Yes please. It reduces global state.

