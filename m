Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D7B214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IVo+aFRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbfDRUqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:46:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34108 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732981AbfDRUqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:46:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id w16so4579223wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wficahtGGlEvfoZUHHveXjxRdIRK8DDrer2LkRlm6jU=;
        b=IVo+aFROZrxIuP0WLvA34sdd6tNipnqxs3zx06XiCOpH0m0LbJUIEyZSzwXYSa3IMf
         qa3P3kafPr232RfPWjYg4SMfFVoXAR3bkcSjyao58DruuxwCAwXMPI4N7b+NYfgH0Ca6
         DfCRkMtxzmRJ4Byo4NlFi7YhEucESYNLQKIIu09xkubJDIUz1BGyX2VEZClw73oa3SXD
         SM3Y1TIfOagsHyPzHrPrw8Wf6p5Opn+Xy1cL8JuHIzVd+4pgvesO1+orLeTPtr89VS78
         Lu67/Mw6az0BkHDwt6NHvPVqH7L+Q6D3LgXmMZR3LowoU9afb1axY6omlel9PUztTwMk
         010w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wficahtGGlEvfoZUHHveXjxRdIRK8DDrer2LkRlm6jU=;
        b=mPAN6vJzC06oV0S+iPj8zghg6Yans625Q2aPRRGMKVNLtFYoTdflrdPERxs3fe2I0B
         w7Zy7/E3UuIVfl/lQS7ZDd3zyiH5Pa3w27PAnlcEc3zgrlYJk/xtXgv/eeCl/QGdwRAw
         9lQVVJBh0IOV5pGrA6okwK4QffeRc+HDgLpDQ6UVzOeQ1W9aWJpnaJkF76rV0SphrX7m
         lZyxS5n2DBCJ/uFu1p6MgGX0uYVk53TPg3F5VG7gcxyzC/vPEVLk3AyzNSjFEX9nBuh8
         b5YXbfHbngsc3P1nYznvkhfJ/FOaeNqDb9j1P6KMURIoLypCUspFAEuWw9dq55vFss/9
         yuKg==
X-Gm-Message-State: APjAAAVK5GLvTZp8DAx+S7bLSC3G5VWVFFDPFui0G0UerF8oPVfCuk3B
        J4s/xG1JeQRI1enDVQx6JvYxfg==
X-Google-Smtp-Source: APXvYqyolIXXdwhRp4JJIvpOF5SlWArEQ2SZdjo8yhlqX7BQTkGpmPbd/dbtOXvPFzsim6faWixC+w==
X-Received: by 2002:adf:fc47:: with SMTP id e7mr141013wrs.100.1555620368407;
        Thu, 18 Apr 2019 13:46:08 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id l19sm4744601wrf.35.2019.04.18.13.46.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Apr 2019 13:46:07 -0700 (PDT)
Message-ID: <8316d7875bf0479e91cc11ce5fbf3b2e21f92a2c.camel@baylibre.com>
Subject: Re: [PATCH 5/7] mmc: meson-gx: avoid clock glitch when switching to
 DDR modes
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 18 Apr 2019 22:46:05 +0200
In-Reply-To: <CAFBinCCAbMpWYY6-W+909Q=jLpweC2F6ED6CVf6zVGrRiA1hxg@mail.gmail.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
         <20190417204355.469-6-jbrunet@baylibre.com>
         <CAFBinCCAbMpWYY6-W+909Q=jLpweC2F6ED6CVf6zVGrRiA1hxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-18 at 22:16 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > Activating DDR in the Amlogic mmc controller, among other things, will
> > divide the output clock by 2. So by activating it with clock on, we are
> > creating a glitch on the output.
> > 
> > Instead, let's deal with DDR when the clock output is off, when setting
> > the clock.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> it seems that this patch breaks SD card on my Khadas VIM and Khadas VIM2.

The error I see in your logs is with eMMC and hs200, not SD card.

Either way, There is something I don't really get. eMMC should not go through
any DDR mode to reach HS200 (which is an SDR mode), neither should SD to reach
HS.

All this does is flipping the DDR bit (when necessary) when clock if off for
the mmc device, avoiding a glitch on clk line. 

This patch should not make any difference for SDR only setup, Maybe I missed
something, but I don't see how it could make anything different for SDR only.

I (repeatedly) tested both vim1 and vim2, without seeing this issue, so I can't
debug this. I'll need more detail to progress, something does not make sense here.

> I used git bisect within this series to find that issue.
> applying your .dts patches on top doesn't fix it
> 
> two boot logs attached:
> * kvim-broken.txt has patches 1-5 (= including this patch) applied
> * kvim-working.txt has only patches 1-4 (= excluding this patch) applied
> 
> 
> Regards
> Martin


