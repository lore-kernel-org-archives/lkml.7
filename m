Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1BDC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C65820675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gmNcJnhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfDQHHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:07:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53409 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfDQHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:07:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so2005446wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MagiVVsLv7f6Puj0uqCtZOjMbwEZE4eWEmRuawO2KC0=;
        b=gmNcJnhqCLVf299+IhArLUl0pb0EwTCniJyMdEMdQ63cKSqk4dX0eNNEpwH14gAVt+
         1dAhmG1Dof5h/DCG12z/WQrFDGPhYIY5uyG6l+tPwJzPFYk4/TA2aE6fPWkPiWllOixL
         FKzvdJUDGbs+5ikVfu+oIraZGbvquZE9BxVZlaPLhJEXla1ptjda8mGdyR5BVivy3CZn
         5r4OM1PEX7pebIjRoS2+phNAIh+ezErSm/y1D6OYnUW0ZRHQXCdP0SWNCjHvjY8BslVV
         Iw1orImf91wkR6bvnPSum+NU5IIiO601r/VmOGKmE7DgUGDfUVO45ifWdeAShceiLueA
         /CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MagiVVsLv7f6Puj0uqCtZOjMbwEZE4eWEmRuawO2KC0=;
        b=NCEkAxXzJvCwZrgLZtjhR/gF/cmxPAwZppVs9AoQaZS/h12FOZ/N7t1R+XUL0P9vN9
         OOwqLyXtqeQR2pfnZb9m5MwMCOJWeAFXomBpNuIjJhPbu8HF2WCBRJr4rutEzFcyC2z+
         KozeHeTLuNlbQLNrdXfxgVXUjwgQpltKYi5XhgYa36FLYqP4Hv57OMEJf7S8ynlL6NB+
         K9BMEQ3zv7PU6RV+UhDw2UHpwuqlZ8VgzpuWmIrMfR8iM9F65oWjYPMbI9CXOaYCh9rj
         8A9Xq7I3Duoc/+dL2mmCFgqZEYmlZm5FeivWbndTLnUkVlCZWoBCLx+2sc7APD59GSqT
         Fr1w==
X-Gm-Message-State: APjAAAWNxC8LpBuF0HgCqsl961o788YYlN5vL/CTyX6GgZ1odmO/UhtW
        ayLuyC6uD7rSEGz+U1dzHysMDg==
X-Google-Smtp-Source: APXvYqyFENtAPfteYb0wtz6TNBqryi7it7WwFiPYyckE6t7KumJf/r2ky87fPrBj/YfzTUV1hE+kxA==
X-Received: by 2002:a1c:c287:: with SMTP id s129mr31404681wmf.63.1555484835530;
        Wed, 17 Apr 2019 00:07:15 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w9sm6004866wmi.0.2019.04.17.00.07.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 00:07:14 -0700 (PDT)
Message-ID: <3eec8b122aa4912dfa67aeb37ad2c941c34c0a38.camel@baylibre.com>
Subject: Re: [PATCH 0/7] arm64: meson: g12a: add audio devices
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        patchwork-bot+notify@kernel.org
Date:   Wed, 17 Apr 2019 09:07:13 +0200
In-Reply-To: <CAOi56cU0dHoyRzTXeKGoiFwTms4WuJ7LV2EXTJLoEmOsC8OyrA@mail.gmail.com>
References: <20190412125136.28232-1-jbrunet@baylibre.com>
         <7h5zrdpytg.fsf@baylibre.com>
         <CAOi56cU0dHoyRzTXeKGoiFwTms4WuJ7LV2EXTJLoEmOsC8OyrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-16 at 12:22 -0700, Kevin Hilman wrote:
> On Tue, Apr 16, 2019 at 11:52 AM Kevin Hilman <khilman@baylibre.com> wrote:
> > Jerome Brunet <jbrunet@baylibre.com> writes:
> > 
> > > This patchset adds most the audio devices of the g12a SoCs.
> > > 
> > > Kevin, couple of things worth noting:
> > >  * This patch depends of the new audio clocks binding recently applied
> > >    by Neil [0].
> > 
> > Was this supposed to be part of the clk-headers dependency PR I
> > received?  /me looks... It looks like it's applied right after the tag I
> > pulled, so I doesn't look like it.
> > 
> > If I should queue $SUBJECT series up for 5.2, I'll need another stable
> > tag.
> 
> Also, this doesn't apply cleanly anymore to my v5.2/dt64 branch.  When
> the stable tag is ready, do you mind doing a rebase? (or telling me
> what it currently applies to, and I will do the rebase.)

Hi Kevin,

Until we have a solution for the drive strength in pinctrl, I won't be able to
submit the audio pins. I doubt it will happen in this cycle.

Without the pins, audio won't work anyway ... so no rush

If it is ok with you, I'll resend at the beginning of the next cycle. Clk and
ASoC deps will be merged by then, so things should be more straight forward.

> 
> Thanks,
> 
> Kevin


