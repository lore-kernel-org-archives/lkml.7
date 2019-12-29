Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C53C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 23:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D31207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 23:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qEqcxGvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfL2XTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 18:19:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44213 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfL2XTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 18:19:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so31227264edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 15:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxSZstiEaMg+m65lDkW2E8KdL5f2Kpio4F4xfu4/sKE=;
        b=qEqcxGvrL6Xx0mQ/8Z3GHtEKOGcTeVvqVgOM2yp8DAnAgG0eVY8UHkYkhMS07BxKzY
         WqQXGPhS2yeWl3144e7q6YMX/2OJQ9VDtqy2K16OhSEm8Cx0elYHZlEEeJL060DazFvT
         vskiCsMN0M1sPeQSpUPBZNb/LILTYVqOKdfmj/3wCIXX6bcsFHh7fQicz3v4/CUVoAeM
         QjiDh5N+scPktd1DVSvLqHyyYn2nNMr9YZRXPnbQ+9JFpbj3LVgXrGntEW0846Qb28ex
         NU1dwyNKr4E/RoF919Qr3QM6N0DQvEA3nByGuaBvSldBPXa+StlqqGTxCTXW8mwpfLwO
         ec3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxSZstiEaMg+m65lDkW2E8KdL5f2Kpio4F4xfu4/sKE=;
        b=T1Xf9Bg+Db/HYqdZUdS00xB6A99QRGpeqQqRIhICEg2oM2578Z9DsaNK5+3mqHTnvy
         26FtM0SDWMQz6dpUiSJY531LgsouAJUPjiTx2jkMiDptSJPo0V9LvVu8pksKjXyXWJf/
         hEUt5ppMGd0G9ESoVLICo1NS1GoRQvqJlWdH7L7IeYMZsX3dKAt6VkrP9MsFkRYnjh9o
         WJCDSASRfslmFx4UBLN+XI7CWw0Xo7GkY7nu4B6SZ6tvHK4GELTqPz5rIIdektAqRN9N
         EyAklHqZZy0fg8usEfUVN0sMOH6ZiHwYR1AWP3lqImgszrSn/wImcGxhUiEqTlYP5V/U
         OUvA==
X-Gm-Message-State: APjAAAUklkYdXczdbN25kRSfIrtMgjUZ9cafCWqYbOcmZ5LnhtME6AML
        eyhLE3xzv8IXedDrIEvrnakVgNcWVohu64AScgI=
X-Google-Smtp-Source: APXvYqx5hpszRc1esYWuJMYLxjiI1twZUv4Oyfi4w8d8PUEWWIYhTywMgOhwl9CLM8r56NOREovBKjh3zWBx5AgNoQ4=
X-Received: by 2002:a17:906:cc8b:: with SMTP id oq11mr67972062ejb.193.1577661561171;
 Sun, 29 Dec 2019 15:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20191227173707.20413-1-martin.blumenstingl@googlemail.com>
 <20191227173707.20413-2-martin.blumenstingl@googlemail.com> <dd38ff5c-6a14-bb6a-4df5-d706f99234e9@arm.com>
In-Reply-To: <dd38ff5c-6a14-bb6a-4df5-d706f99234e9@arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 30 Dec 2019 00:19:10 +0100
Message-ID: <CAFBinCDs3a8TJcQKgHUkDvssMR6Y2Kys38p50P0q=2KOiDTNHg@mail.gmail.com>
Subject: Re: [RFC v2 1/1] drm/lima: Add optional devfreq support
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     yuq825@gmail.com, dri-devel@lists.freedesktop.org, robh@kernel.org,
        tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        alyssa.rosenzweig@collabora.com, daniel@ffwll.ch,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Sun, Dec 29, 2019 at 11:58 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Martin,
>
> On 2019-12-27 5:37 pm, Martin Blumenstingl wrote:
> > Most platforms with a Mali-400 or Mali-450 GPU also have support for
> > changing the GPU clock frequency. Add devfreq support so the GPU clock
> > rate is updated based on the actual GPU usage when the
> > "operating-points-v2" property is present in the board.dts.
> >
> > The actual devfreq code is taken from panfrost_devfreq.c and modified so
> > it matches what the lima hardware needs:
> > - a call to dev_pm_opp_set_clkname() during initialization because there
> >    are two clocks on Mali-4x0 IPs. "core" is the one that actually clocks
> >    the GPU so we need to control it using devfreq.
> > - locking when reading or writing the devfreq statistics because (unlike
> >    than panfrost) we have multiple PP and GP IRQs which may finish jobs
> >    concurrently.
>
> I gave this a quick try on my RK3328, and the clock scaling indeed kicks
> in nicely on the glmark2 scenes that struggle, however something appears
> to be missing in terms of regulator association, as the appropriate OPP
> voltages aren't reflected in the GPU supply (fortunately the initial
> voltage seems close enough to that of the highest OPP not to cause major
> problems, on my box at least). With panfrost on RK3399 I do see the
> supply voltage scaling accordingly, but I don't know my way around
> devfreq well enough to know what matters in the difference :/
first of all: thank you for trying this out! :-)

does your kernel include commit 221bc77914cbcc ("drm/panfrost: Use
generic code for devfreq") for your panfrost test?
if I understand the devfreq API correct then I suspect with that
commit panfrost also won't change the voltage anymore.

this is probably due to a missing call to dev_pm_opp_set_regulators()
which is supposed to attach the regulator to the devfreq instance.
I didn't notice this yet because on Amlogic SoCs the voltage is the
same for all OPPs.

I'll debug this in the next days and send an updated patch (and drop
the RFC prefix if there are no more comments).


Regards
Martin
