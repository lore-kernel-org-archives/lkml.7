Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2994BC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7DB20863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HAUdFKJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfFQUDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:03:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35250 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFQUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:03:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so4580364plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+6f59ZFOs1PSocx1cXbKIlzxOSpO4grS25QzNht0IBo=;
        b=HAUdFKJJhiMKymZJQB2BDPSJoE/iyuSm4Zoz28SB10+kykqiY9fWV8m3ZhHifNYLQ0
         gianVGa6NRSwnraiQxQPnn47Y8vu2BUM9Ii2feCs9YyJI3a1/UdASYpWOtlBtcDsOoCE
         4wNhyON7emBZtf6bZmyiPF2newLP+1pJGDKwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+6f59ZFOs1PSocx1cXbKIlzxOSpO4grS25QzNht0IBo=;
        b=SVdJpMvkPm1ssmKKP0tE/f3myTnZBNdZ7syPdVt4XnxWpkMXtXKCxqWE028ZoslMgU
         WrRTtAy/9iXSL5v12pyJZe0K60qaWFRHncEUisJ3UYSMDnbUfNfmmiDOu1rVpZCemrFt
         accU64QfXNzLTSo3enOvm9sbyG6uIMllvE+mU8LA6rRR3zG01M/coQMHmpe/3UVuOuI3
         iLiC3liYfLwC5GDTgA/nlW+e1zDct7Tp9+64rXQBsgnkKZnK3YZ3oPrH6Da3QgarZXp5
         7RsmvgEVWrMvXmId5UA/k4URCxyAojatH29Mf7v/14DD7LlrCZ+WLeKoYDwXhvZMF700
         H6UQ==
X-Gm-Message-State: APjAAAXNh7/h7Eh+TtRyWRltCsJN9kTzRS7oRIcKrjqrmq9qxwdebIY0
        Oo8BSI+LneH5PHcrnV1FfudH6g==
X-Google-Smtp-Source: APXvYqwHSEuRqTDvpMokDsWAY4XbioaGwEV5S7azKc4M2N6fF8IpbDcv8EnRsu1EG2Q/oxRkJNkzXw==
X-Received: by 2002:a17:902:8c83:: with SMTP id t3mr82969184plo.93.1560801797840;
        Mon, 17 Jun 2019 13:03:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a3sm13221952pfo.49.2019.06.17.13.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:03:16 -0700 (PDT)
Date:   Mon, 17 Jun 2019 13:03:14 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Brian Norris <briannorris@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Guenter Roeck <groeck@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Subject: Re: [PATCH v3 3/4] backlight: pwm_bl: compute brightness of LED
 linearly to human eye.
Message-ID: <20190617200314.GT137143@google.com>
References: <20180208113032.27810-4-enric.balletbo@collabora.com>
 <20190607220947.GR40515@google.com>
 <20190608210226.GB2359@xo-6d-61-c0.localdomain>
 <20190610205233.GB137143@google.com>
 <20190611104913.egsbwcedshjdy3m5@holly.lan>
 <CA+ASDXOq7KQ+f4KMh0gaC9hvXaxBDdsbiJxiTbeOJ9ZVaeNJag@mail.gmail.com>
 <20190611223019.GH137143@google.com>
 <20190612110325.xdn3q2aod52oalge@holly.lan>
 <20190612192642.GK137143@google.com>
 <20190617130150.GA21113@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190617130150.GA21113@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, Jun 17, 2019 at 03:01:51PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Certainly "linear" (this device will work more or less correctly if the
> > > userspace applies perceptual curves). Not sure about logarithmic since
> > > what is actually useful is something that is "perceptually linear"
> > > (logarithmic is merely a way to approximate that).
> > > 
> > > I do wonder about a compatible string like most-detailed to
> > > least-detailed description. This for a PWM with the auto-generated
> > > tables we'd see something like:
> > > 
> > > cie-1991,perceptual,non-linear
> > > 
> > > For something that is non-linear but we are not sure what its tables are
> > > we can offer just "non-linear".
> > 
> > Thanks for the feedback!
> > 
> > It seems clear that we want a string for the added flexibility. I can
> > work on a patch with the compatible string like description you
> > suggested and we can discuss in the review if we want to go with that
> > or prefer something else.
> 
> Compatible-like string seems overly complicated.

I see the merit in the sense that it allows to provide more precision
for if userspace wants/needs it, without requiring userspace to know all
possible (future) options. If userspace wants to keep things simple it
can just check for check for "s == 'non-linear'" and
"s.ends_with(',non-linear')"

In any case, I posted a first version of the patch:

https://lore.kernel.org/patchwork/patch/1088760/

Maybe best to center the discussion there?

> > > Instead one valid value for the sysfs should be "unknown" and this be
> > > the default for drivers we have not analysed (this also makes it easy to
> > > introduce change here).
> > 
> > An "unknown" value sounds good, it allows userspace to just do what it
> > did/would hace done before this attribute existed.
> 
> What about simply not presenting the attribute when we don't have the
> information?

I'm open to either, I mentioned it earlier and Daniel seemed to prefer
the 'unknown' value so I went with it in the first version (it's also
slightly less code).

Cheers

Matthias
