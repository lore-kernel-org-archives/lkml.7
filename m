Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6EEC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2A020659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="XdU6/ypk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfLEUqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:46:18 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33962 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbfLEUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:46:18 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so5096392iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 12:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=humTQycd0vFrkIxQZiWiqgySySbeGFmTzkUhXf3KboE=;
        b=XdU6/ypkhmReLxd03n6s8HpHulakpvc3pASxdTKIXH5An0XRvRpiR5gmD8jxcctCtu
         AZ1hpqEmX4HDZOW36C/slJrG6ubHNk+86q7aGjG8lowWjq77rYGQtIffDTiLvwr5fz2X
         hwEAbOrYCHKci7lvtvy4hU6VjIYmeZLACNF2KEJSM2ULPOd9XZsWwwgCsuktqFOhSXqV
         6l26BDcvq/AIf4qgZsSjRnYm3f5T2Mpy3MY215s7XVGWsn0E8PW8g4FHLQRhawKHmCdQ
         cMISuBMCKa6YMp2kZnqgIJ9nmsLIcf4uACpYaNEVYws2f5xAhk0ed6bLJ78sgl+dT+xi
         dBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=humTQycd0vFrkIxQZiWiqgySySbeGFmTzkUhXf3KboE=;
        b=iak3RVtuiSXoy7tfU4TQlmdSEDoNB4WMMqMVo9//mfYXDsROm/+sor7qQE5OlgQnug
         XVIXqzCET7mkdrqPTwd/+QVafsfddlx5Wotns+wfTMT857yWLr97qbnKWfdoLoPZs19t
         mnKOZfD9b9OtfAeVgCGgpKgaAnbSAkGmG8YCDq6qKBAbWd/9Dk5BiL+5DxopSe8yiiQ0
         UTiIqgUcTdNoeu9Xfdaz/RUMJphGi2lbdoat9PKvBBmVIXd+3DsrUmvuEAc/Q73HAb4t
         fayber1gQqNFJ62pkba4sljoNoal0ErSi92AHpzP31I0dPXfsBcYbH0g7wZmfU0A1d+H
         8+pg==
X-Gm-Message-State: APjAAAWRCa4OiEhSNPYgggIuTJHiszkS5wNNQytjkCTr+JxvhFGHV9ok
        VXvXfCXbfQKQpvhOiGoX4zpkDlE8rt8YUkHWBZ0g2A==
X-Google-Smtp-Source: APXvYqz7Sg7e83fq0vHcuOBJBouB7Eicn+xN/Pzkb8SFrEF/cGfUJr2/1zhC8EK8+W4Iqy3mBKDJlZEWDlP9p4WjktI=
X-Received: by 2002:a02:6a2f:: with SMTP id l47mr10252363jac.132.1575578777145;
 Thu, 05 Dec 2019 12:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20191021205426.28825-1-rjones@gateworks.com> <CALAE=UAEFobA2SXOTJWAqexg+VNN_VTXGLGH+VwqqjKkuFwddg@mail.gmail.com>
 <20191204113307.GH3365@dragon>
In-Reply-To: <20191204113307.GH3365@dragon>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Thu, 5 Dec 2019 12:46:06 -0800
Message-ID: <CALAE=UBFWvBpxODRgzM0YiM2uaBefCTvGjYj4Se=ZUU8g5fihg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: ventana: add fxos8700 on gateworks boards
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 3:33 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Thu, Nov 07, 2019 at 11:10:19AM -0800, Bobby Jones wrote:
> > Hello Shawn,
> >
> > I just wanted to follow up with this and see if you had a chance to
> > look at this. I submitted this after responding to Marco on my initial
> > submission but haven't heard anything since and didn't want it to fall
> > through the cracks. It may be worth mentioning that both the bindings
> > for the fxos8700 and lsm9ds1 have been accepted by iio.
> >
> > In addition to this submission I have the following that I'd like to
> > check in on as well:
> >
> > [PATCH] ARM: dts: imx: imx6qdl-gw553x.dtsi: add lsm9ds1 iio imu/magn support
> > [PATCH] ARM: dts: imx: Add GW5907
> > [PATCH] ARM: dts: imx: Add GW5912
> > [PATCH] ARM: dts: imx: Add GW5913
> > [PATCH] ARM: dts: imx: Add GW5910
> >
> > Please let me know if there's anything I can do. Thanks!
>
> Hmm, did you copy me on those patches?  I cannot find them in my
> mailbox.

I just double checked and they all have you in the recipient list.
However I just had my coworker check who's also subscribed to
linux-arm-kernel and he's only seeing this thread and the "add lsm9ds1
iio imu/magn support" thread. Maybe something funny with our mail
server.

Interestingly enough they appear on the marc.info archive for Oct 3rd:
https://marc.info/?a=147430901100002&r=1&w=2

I'm not sure what happened but I'll send them out again now.

Thanks,
Bobby
