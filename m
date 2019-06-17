Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAC9C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50791208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZoqSWmU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfFQQQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:16:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32831 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfFQQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:16:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so5966191pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zvibPhwENQ3qc2un3M/Q6u9vfA61QDqGf+AvuS+Jre0=;
        b=ZoqSWmU/lQLp0AxiYiOl4DnE8lGbhiLm4TaGaplykVD8NJT3wL2fFNQtVZ1rhnDefR
         BaZR79IvfuOD5CsEX5Gw7fbGTcYyajcJl9kBZ4M7KE9N1zgzsiE4tOPQV7Ij2cCHZ82h
         EeOCnc0aOXf5zaqOyTsOM7HB6gCUwOMLTttbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvibPhwENQ3qc2un3M/Q6u9vfA61QDqGf+AvuS+Jre0=;
        b=MYQ1Uwu5SdinCDaIvbhgleRBAmuZDn3yX4E5Amd7Z4eeB8YyPX7IxA2rHN2DdfVg6B
         ON0Sw9XxXv1Frtxkvvst1IvroMCz623w5Rt5xbvChiYAY9O+h76weXV9OL+CVD+X7p6s
         mH8RM2KOJmxiKCMfzUwcgCZa2KeMVBqot7hrGtT+nooQn5IRv8V4fn3Qg7EB6TNJl7Hx
         qHYETbffAmOXF5uWzUGl4H8cr7jVu/KktXWi9oqRU8mBWBMGsm6IioQIafveopPAat28
         9sLqJWHFeAYY2ZRC2lcp7+fbxghKLKGkJYA42lCQRF/qMBl5FRc46ESzzTt3CleaMgDV
         eK3w==
X-Gm-Message-State: APjAAAVQ9u5xGYhIXg0+lLgEdVx4aI9tXE3AwpS2hHrbL4l1QTuU0TTL
        Z4ubHjGSBXWDaes/vPtyNBS30A==
X-Google-Smtp-Source: APXvYqw3rc3Tet3QBs9yulULj2UwlZKr/1RY50orF99rzSnjjv2kEBXdw1GPW8ggnZq5hpDRRJ/YNg==
X-Received: by 2002:a17:90a:b908:: with SMTP id p8mr26903360pjr.94.1560788189915;
        Mon, 17 Jun 2019 09:16:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d12sm12846713pfd.96.2019.06.17.09.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 09:16:29 -0700 (PDT)
Date:   Mon, 17 Jun 2019 09:16:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] Revert "ARM: dts: rockchip: set PWM delay backlight
 settings for Minnie"
Message-ID: <20190617161625.GR137143@google.com>
References: <20190614224533.169881-1-mka@chromium.org>
 <20190616154143.GA28583@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190616154143.GA28583@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sun, Jun 16, 2019 at 05:41:43PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This reverts commit 288ceb85b505c19abe1895df068dda5ed20cf482.
> > 
> > According to the commit message the AUO B101EAN01 panel on minnie
> > requires a PWM delay of 200 ms, however this is not what the
> > datasheet says. The datasheet mentions a *max* delay of 200 ms
> > for T2 ("delay from LCDVDD to black video generation") and T3
> > ("delay from LCDVDD to HPD high"), which aren't related to the
> > PWM. The backlight power sequence does not specify min/max
> > constraints for T15 (time from PWM on to BL enable) or T16
> > (time from BL disable to PWM off).
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Enric, if you think I misinterpreted the datasheet please holler!
> 
> Was this tested?

I performed limited manually testing.

minnie ships with the Chrome OS 3.14 downstream, which doesn't include
this delay, to my knowledge there are no open display related bugs for
minnie. One could argue that a the configuration without the delay was
widely field tested

> Does patch being reverted actually break anything?

To my knowledge it doesn't really break anything, however there is a
short user perceptible delay between switching on the LCD and
switching on the backlight. It's not the end of the world, but if it's
not actually needed better avoid it.

> If so, cc stable?

I guess this is an edge case, were you could go either way. I'm fine
with respinning and cc-ing stable.
