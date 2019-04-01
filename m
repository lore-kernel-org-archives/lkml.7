Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABADC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B15F2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dRpTY7tL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbfDAIkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:40:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37951 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfDAIka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:40:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so10825145wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=a6Pz+a4CrehPUESoevuJ9/2TnfPF2w/JEefGMGx65p0=;
        b=dRpTY7tLZ2cjxOKz6NCZaaCLNCIOjg5IeckqDGCnoj7CKd2niqCMYz1Kfd4myYLD+U
         BP1iFnsjCie+/pv200U7z9c5FmbhwYEPhPelAfv92vCG4SuAT+a882ZlJDwIopcPXJNV
         N4oDStJPpVKi3w07X8NbDy5T5pEpJ2qtn3c52us7BREeV8OcKCmDvsSUXjQGe337HCaW
         vJPMUTEI9AoPPlKLqTNUKXb/xK2y+r+EzdmwFleNH23F6CwCgQCQLsyYTNy3V945ZUcY
         kYCOQ8bhqnSht1rn+Rg4/jhwe1PR+GtGq6dQyI2FAW5nBJzsJlagCYqgGElvCnHYqE2T
         BHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=a6Pz+a4CrehPUESoevuJ9/2TnfPF2w/JEefGMGx65p0=;
        b=A6nIWmG0DXvNKrDvPssAhc+WoU5RB/WpR4VjXTXwy6IWBJhHhEYZJQdBvFRTE77yfJ
         cjM+eiq8HieEmIDLnnKLQ8wPm1NOYGzlA3ye0YFElVEzFWeKI+Z0Rvhay0IBnEeLAfr8
         hmKwy6Ln1Zd0wUqKLXjXh7d3bo3cbwikla9dXlHPdJlaezWNDqdC/7m1UCDYYbM06cCC
         vnucO0+FtmIUezeAGn37nMCOkGBg47hkoj+o9q+aK5D1aBTRVgt18YPhJtPHVJqywAE2
         TottiNupLcvSrSWrw3BQStOXnXfrKMIBCh30pSeMW2DO3vZlMNPJ0e2w2JuXOkBErqw8
         bMPw==
X-Gm-Message-State: APjAAAU1BJl8IpxkkGps1xZqhCttvq74dMKe9v1JShoE7KHapOi+y5yc
        HD8ZCsKcce2l4wx/ZuX5YTEA1w==
X-Google-Smtp-Source: APXvYqz7cYz0Oi9E4zKeh6gVNHKD9M+hGJ7K/pttWe34kXBVRyjpM+OFwc/y3zkv3fMatPtR20melw==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr1453490wrx.76.1554108028832;
        Mon, 01 Apr 2019 01:40:28 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id d14sm13706835wro.79.2019.04.01.01.40.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 01:40:28 -0700 (PDT)
Message-ID: <e9a3a5327712d61390b671729ada1ff3b3a1b7eb.camel@baylibre.com>
Subject: Re: [PATCH 0/3] clk: meson: fix mpll jitter
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Apr 2019 10:40:26 +0200
In-Reply-To: <CAFBinCCSoJYnSt5L07aK4+wmU54soFxRODuHbxaAqcJpmOL+fg@mail.gmail.com>
References: <20190329153325.23869-1-jbrunet@baylibre.com>
         <CAFBinCCSoJYnSt5L07aK4+wmU54soFxRODuHbxaAqcJpmOL+fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-30 at 16:58 +0100, Martin Blumenstingl wrote:
> On Fri, Mar 29, 2019 at 4:34 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > As reported on this [0] mpll series, We are observing a lot of jitter
> > on the MPLL outputs of the g12a. No such jitter is seen on gx family.
> > On the axg family, only MPLL2 seems affected.
> > 
> > The jitter can be as high as +/- 4%.
> > 
> > This is a problem for audio application. This may cause distortion on
> > i2s and completely break SPDIF.
> > 
> > After exchanging with Amlogic, it seems he have activated (by mistake)
> > the 'spread spectrum' feature.
> > 
> > This patchset properly set the bit responsible for the spread spectrum
> > in the mpll driver and add the required correction in the related clock
> > controllers.
> > 
> > Jerome Brunet (3):
> >   clk: meson: mpll: properly handle spread spectrum
> this depends on a patch from your other series "clk: meson: fixup g12a
> mpll": [0]
> personally I would base the other series on this one because this one
> contains a "Fixes" that (meaning that the patch will get backported
> and that's easier if there aren't any conflicts)

1) The other series [0] had been submitted before we knew about the fix which
is why this one is based on it.
2) Considering the amount of work that went through since the fixed commit, I
doubt it makes much of a difference.

I might do it if both series require a resend.

> 
> 
> Regards
> Martin
> 
> 
> [0] https://patchwork.kernel.org/patch/10868837/


