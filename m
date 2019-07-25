Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF24C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CE72238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gzmt01iV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfGYRRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:17:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43641 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGYRRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:17:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so16671048pld.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tPVqVnzmvlRxnAy1nlx0FuoHgdEqnAev2P/iqrvyRAA=;
        b=Gzmt01iVIH1Bred1XXVjQaOCqWazRRFK9XDsc7huxBWzN5+Wk20p62OgxhtyDEfCjH
         m4OjvYBjArWhuK+l4JVeBEcLcy1ACe9AyZBHhkrE8Zw9EbZjPhD/aFMWJQCRguVdoNfj
         Y2/KhTuUR487XJzbutf1bxfnR2xCz1ZysJxLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tPVqVnzmvlRxnAy1nlx0FuoHgdEqnAev2P/iqrvyRAA=;
        b=I2c4+Of45Aww5M5EDsoxhC5laUf0xfMel7gAcfnBDNWkiKRX4fSMjw4unS37AcRMmm
         N0F7BmxVt0JcbG/jUM4FwAyJkzjS6m9iAFHcpPvMKeyWxSpSdfKn1j1PtP86TI/XJ8bo
         4oDC7bEDF1gmyCSzOKHyXOHqwGlR759p5n9JFsW8MLwthalZkIE1dLTdCQhe6NaboTnW
         OScd1OvRcr+nqTTfGEnosMKU3Z8WAh3KBFpUH9RhMq+wXvHFTcsWBjfGFWba+Gu3eTXN
         +TwLe39GOsWP7ivYZ5MzSMJD8Nd2FVEuqI+eFlYsmxvXWS9VWZ09PqPYODit4snGDpzL
         0nfQ==
X-Gm-Message-State: APjAAAUAZLbsErYEmabwMR2OpIRlhFUPjeu02ACTeT3acak8Svz1DcbG
        ipFUh77eHu6MhsDHGM3ZY2+U8g==
X-Google-Smtp-Source: APXvYqws5odlydH4ebEFOkZgM8ILSO3F0QORLUvSUh4M4JwkPcu4YkyXn+XUbv1ErfBXv358RQkmHg==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr93724757plp.18.1564075050259;
        Thu, 25 Jul 2019 10:17:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q126sm6606292pfb.56.2019.07.25.10.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 10:17:28 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:17:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 0/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190725171726.GD250418@google.com>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190722235926.GA250418@google.com>
 <20190725111541.GA23883@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725111541.GA23883@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:15:41PM +0100, Lee Jones wrote:
> On Mon, 22 Jul 2019, Matthias Kaehlcke wrote:
> 
> > On Tue, Jul 09, 2019 at 12:00:03PM -0700, Matthias Kaehlcke wrote:
> > > Backlight brightness curves can have different shapes. The two main
> > > types are linear and non-linear curves. The human eye doesn't
> > > perceive linearly increasing/decreasing brightness as linear (see
> > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > linearly to human eye"), hence many backlights use non-linear (often
> > > logarithmic) brightness curves. The type of curve is currently opaque
> > > to userspace, so userspace often relies on more or less reliable
> > > heuristics (like the number of brightness levels) to decide whether
> > > to treat a backlight device as linear or non-linear.
> > > 
> > > Export the type of the brightness curve via a new sysfs attribute.
> > > 
> > > Matthias Kaehlcke (4):
> > >   MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
> > >   backlight: Expose brightness curve type through sysfs
> > >   backlight: pwm_bl: Set scale type for CIE 1931 curves
> > >   backlight: pwm_bl: Set scale type for brightness curves specified in
> > >     the DT
> > > 
> > >  .../ABI/testing/sysfs-class-backlight         | 26 ++++++++++++++
> > >  MAINTAINERS                                   |  2 ++
> > >  drivers/video/backlight/backlight.c           | 19 ++++++++++
> > >  drivers/video/backlight/pwm_bl.c              | 35 ++++++++++++++++++-
> > >  include/linux/backlight.h                     |  8 +++++
> > >  5 files changed, 89 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight
> > 
> > ping, any comments on v3?
> 
> Looks like PATCH 2/4 still needs seeing to.

The patch currently doesn't have any comments.

Do you see any specific things that need improvement? If so, could you
comment on the patch?

Thanks

Matthias
