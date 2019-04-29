Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235C3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAF0215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Hp0RwA9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfD2SuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:50:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32851 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfD2SuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:50:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so17623294wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 11:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=k/tSEEpVfOTB3sYTDNontQ33XbDgKI57+ULaEZv4d0I=;
        b=Hp0RwA9MDJhr1O3TwRGn/bnp3v62pTPI/CtBqfDHIvIwusCU1OYSfeT7NcenDp74V7
         VjRuqamza0i9YBnJHiZsXSjPee1Q+bGNaccy1km/4616cIOJEKHeeC9QXPIGKJDtSUdH
         XOVpHBwdPAut5rmYw7xje1F57QLN9vcpkds5ZS9MZzNVjdAEurN/fKQ7hJxJLy2YbVAF
         f7g+ZTSUz3he+pRySAv1u0dJkZb5IoxDTHOmvNesZn+EjnE2TZeyUvmVzHw+AMt/BVyr
         xsjwSqmJ//Imh3aPRsCyL4lr1sr1IPPDg0DWyFxCkjse0EgqASEk2sgRyPDKzIDUfR2i
         jwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=k/tSEEpVfOTB3sYTDNontQ33XbDgKI57+ULaEZv4d0I=;
        b=TKfpzfQAmBsFQUAwhtqoDYSH+8KeuiKA9GmHfpuA3/KLoLUtggr6TZX0+N/Wxv1rrV
         x4lPV2p0LJLl8DVxMQWbmFbFzkG0tzJP9TSNm0Y39pCMaTrA3KGHeXWgjCDcwKf5J9Qf
         LL1Vv8rEhLqux02FNEglh1arLjpzQfOl2dsFklBAo86PRthTKH2J77Ea7egdUi88S15g
         1Wm+mEKg7WrO0lqcPY783My8suyyUB/cQX6oXmzAmShT4mzWnrnWAT6IA34RwNj2xUKZ
         XcatOYqqXpmgb6TGWtrYfzgkndzAIl5lC+/dmNkpCunwlQVi739P3+l+Y6EjNjCmn9U5
         gZ8A==
X-Gm-Message-State: APjAAAX6LeLqttd2S3lwWoMk8ZqMPMFHT3A8ajqqrlVPfnrhHD3Lf1LL
        Pr+56HbxUrzKQMjs+JkAS8TACQ==
X-Google-Smtp-Source: APXvYqy1qSw7xJpnL+ItwcmEzPn9HqZCdtxUSBbM+PQjPmQa9utQ/PeKtDN91CzsMyhLLRhCwxcfKQ==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr7747408wrp.290.1556563821390;
        Mon, 29 Apr 2019 11:50:21 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id t76sm442176wmt.8.2019.04.29.11.50.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Apr 2019 11:50:20 -0700 (PDT)
Message-ID: <936229765eac2bcdacf9a53925bb17c38ea18e3a.camel@baylibre.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Apr 2019 20:50:18 +0200
In-Reply-To: <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
         <20190423090235.17244-5-jbrunet@baylibre.com>
         <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
         <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
         <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-29 at 20:31 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Mon, Apr 29, 2019 at 10:29 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > On Sat, 2019-04-27 at 22:02 +0200, Martin Blumenstingl wrote:
> > > Hi Jerome,
> > > 
> > > On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> > > > been unsuccessful or unreliable. Until we can figure out how to enable this
> > > > mode safely and reliably, let's force it off.
> > > last year I have seen issues with HS400 on my Khadas VIM2: [0]
> > > have you tested all other patches from this series and HS400 is still
> > > not working for you?
> > 
> > Because HS400 was never really stable to begin with.
> > It was a mistake to enable it on the VIM2
> > 
> > > I'm curious because this patch is early in the series and all the
> > > tuning fixes and improvements are after this patch.
> > 
> > There are several reasons why this new tuning won't solve the HS400 problem:
> > - Signal resampling tuning granularity gets worse when rate rises. The resampling
> > is done using the input frequency. We can basically resample up to the value of
> > internal divider.
> > 
> > In HS200 - Fin is 1GHz, Fout is 200MHz (1/5) so the resample range is [0, 4]
> > In HS400 - Fin should be fdiv5 (400MHZ) and in such case, no resampling is
> >            possible (internal div = 1)
> >            Even if we keep 1GHz, then out is 333MHz max giving a range of [0, 2]
> >            that's not enough to tune
> this limitation would be great to have in the description of patch 7
> from this series

That's not really a limitation. I should probably not have mentioned as it it seems to
have made things even more unclear. I disabled HS400 before introducing the new tuning on
purpose. Any comment regarding hs400 does not belong in patch 7 IHMO. If you want
to add comment regarding hs400, I think it belongs here

> 
> > Going further, tuning the Rx path does not make much sense in HS400 since we
> > should be using the data strobe signal to account for the round trip delay of
> > the clock and correctly sample Rx. AFAICT, If there is a tuning to be done for
> > HS400, it is most likely linked to the data strobe.
> it would be great to have a better description as part of the commit
> message - with that you can add my:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> my proposal for an update patch description (apologies I have
> incorrectly summarized your findings):
> "
> At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> been unsuccessful or unreliable:
> - signal resampling without delay adjustments and phase tuning for the
> RX and TX clocks (this caused CRC errors and hangs even without HS400
> mode, for example on the Khadas VIM, Khadas VIM2 and libretech-cc
> boards)
> - signal resampling without delay adjustments and RX clock phase
> tuning (some HS200 and HS400 eMMC chips were not recognized, for
> example on the Khadas VIM and Khadas VIM2 boards)
> - signal resampling tuning with delay adjustments only (works fine for
> HS200 and UHS modes but doesn't fix HS400 eMMC chips, for example on
> Khadas VIM2)
> 
> Further improvements for the HS400 mode are likely to be linked to the
> data strobe signal.
> Until we can figure out how to enable this mode safely and reliably,
> let's force it off.
> "

Thanks for effort but all this just maintain the blur around HS400 on amlogic.

Let me rephrase it:
Tuning (phase or resampling) is meant to compensate the clock round trip in UHS
and HS200 modes. In HS400, this should be taken care of by the data strobe.
But we have not been to enable this reliably enable this on amlogic chipset ...

... and I believe we are back to the original commit message.

That's my understanding of the hs400 problem.

> 
> This whole series is a good step forward.
> also thank you for this additional explanation!
> 
> 
> Regards
> Martin


