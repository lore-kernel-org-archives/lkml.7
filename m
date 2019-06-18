Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91149C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682DB20863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bm7i7c5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfFRSfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:35:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44842 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfFRSe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:34:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so8133332pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6kNZlMyc+BT+bVh0V15w4cgbur+weciC7/ZsAv2IV7U=;
        b=bm7i7c5f2/GAPKW27PQz1CiDRmYmVVba0JO3/GX7R8G+fkjmqzIIjlSd4nI38HMNiO
         JG+isnGj0iq6Ofd/6L/6Az0kLFKN3KBe+DUwfNJZrmXGBX8SDqz9yFi5xBVYZhRXZvx8
         pJQsKXZRSuhhm6WH3KSC1QPvrSbAjRWmtJKOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6kNZlMyc+BT+bVh0V15w4cgbur+weciC7/ZsAv2IV7U=;
        b=mdQVfL2kz7w4hMCiBxRn9KcL26kWVlAFYylIBek4KNliJrEZZ8/ll/Ap2aDB6Luv3C
         46+6OArHkOd/c317mmtYACGv82CLUWA9LREo6iC/B5lgJ7L87nQPvmwteFUWfwZq7HIX
         FpdIsXJysDZjybb5nxxh9xfaqBL6i2U1gbw8Z+dIhK4nRLZyfT5+GU9zfQ5QCAUxCwVU
         QLz+9ie6iqwl3hJ2S76FoA9RwxvKxNaFloVP0DJOci4+dBIqOwFeQT8Z4bo3XdhwwFxX
         VbnMXj0s08ihBl/kPtH4ob8r97QgMbJz90djVXRqjuPz037/O0sfvJt6wCin6YunvawU
         r7lg==
X-Gm-Message-State: APjAAAWCFu4WjNzIiln6suYl2BSGt3zKiZAlSVxxZhSt+l9N674fYaMZ
        nMNxpI0GB83JYBkIOgPtDc5rEQ==
X-Google-Smtp-Source: APXvYqy+QvRjs4Drmi2FUQIv8wv4fenqIqrDebMofryze6kGt+JsmRV9NB16VTZPs4PMvqJusTHJsA==
X-Received: by 2002:a65:654f:: with SMTP id a15mr3860571pgw.73.1560882898990;
        Tue, 18 Jun 2019 11:34:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e16sm22768169pga.11.2019.06.18.11.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:34:58 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:34:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] Revert "ARM: dts: rockchip: set PWM delay backlight
 settings for Minnie"
Message-ID: <20190618183455.GU137143@google.com>
References: <20190614224533.169881-1-mka@chromium.org>
 <45f94c6a-5bd7-92b0-d23f-ae7e0481935f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45f94c6a-5bd7-92b0-d23f-ae7e0481935f@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Tue, Jun 18, 2019 at 10:21:52AM +0200, Enric Balletbo i Serra wrote:
> Hi Matthias,
> 
> On 15/6/19 0:45, Matthias Kaehlcke wrote:
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
> 
> Could you point from where the confusion comes from? I think will be helpful for
> the record. B101EAN01.8 vs B101EAN01.1

sounds good

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> With the above added:
> 
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks!
