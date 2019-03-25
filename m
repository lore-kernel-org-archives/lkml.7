Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5763DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234352087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFPvFDh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfCYICP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:02:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35601 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbfCYICL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:02:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so7922202wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DtFA6qhgHmfe8jfD+WzaOVrPs09twP3dnTsyB25BXDA=;
        b=FFPvFDh6MIyj8SKRNQTwFecYOmUhv/XelXhgOIlin3zWhX+b+LUQ2zoR5L8vxphroo
         CmYRq2mxSjkDOM1ZxUM3q2OL8EZECNZGzWfjeQboagqUKpKCf/uDqIi9Seq2u6+ylY7u
         X84uOlBcBJXPBLl2Cntey0yFS6fU2TW1vftk+CDOtpDfgEvEF1s3VFXfQkFizhlfpWJD
         L4hJAaHpgUVM4qjHi9hVRN4woSu+4tx1oGzHKDuYw6Rbnuxy+YDF0O40Nr8KRrcL81at
         NcgTPIMh9aiyYCZRNH5+v+QSaunZdffg3c12a5LbC5rB5zuLkWAYt+orsB5EEAWjA221
         AH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DtFA6qhgHmfe8jfD+WzaOVrPs09twP3dnTsyB25BXDA=;
        b=FXm50H1oC94oyQGtl/XAKCYW0IsZFvJKgwgJbxWmAWEalbWZEYM0tCgKuz3C9Iqwh1
         LJnFeWHornX/RwpihxwoQKb89X2GqpntTyuZeSVfycSBOjzaq+L0JTMAzu5KaRBOGrZL
         hhuFRrRy9RP8J1rXUiFGU9hJ0DVkdT27jc2czrG11adAiuFDydzw2CdioFLI7kOGIEKa
         w1k5EWDXIC2NfIad5CVTQxauttRa8NrsCl5UMVm+7Fz8DE0OrNBrPtX/2wmfBezdpLwT
         jCLPVF9FWZuh645wS/8lk09dctlYtvbFcV0JxXpLBhbGVhuGSR7tXJpgDpy+ZkJrL7Mg
         YfgA==
X-Gm-Message-State: APjAAAUbQXMz6xw+hEVV/Lo1VG/xmkVF2X9e3vEL2U9gK3fBg+fNZl0h
        m+mFWQAfCdx5VxdrrsXCE1qsbQ==
X-Google-Smtp-Source: APXvYqxm/tyX+0u/SnSNLlV7ar2/RNF1sAHIamradKZlDr69QuEaX23uoT3kd3UwFD0tFLm+y+0zlg==
X-Received: by 2002:a1c:f510:: with SMTP id t16mr10157065wmh.105.1553500929763;
        Mon, 25 Mar 2019 01:02:09 -0700 (PDT)
Received: from dell ([2.27.167.37])
        by smtp.gmail.com with ESMTPSA id s130sm19477743wms.13.2019.03.25.01.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 01:02:09 -0700 (PDT)
Date:   Mon, 25 Mar 2019 08:02:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Message-ID: <20190325080206.GZ4731@dell>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
 <20190228081055.GL4118@dell>
 <20190228082248.GC3773@localhost.localdomain>
 <20190325073640.GB6208@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325073640.GB6208@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Matti Vaittinen wrote:

> Hello again Lee & all,
> 
> On Thu, Feb 28, 2019 at 10:22:48AM +0200, Matti Vaittinen wrote:
> > On Thu, Feb 28, 2019 at 08:10:55AM +0000, Lee Jones wrote:
> > > On Thu, 28 Feb 2019, Matti Vaittinen wrote:
> > > 
> > > > Hello Lee and Mark,
> > > > 
> > > > On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> > > > > Patch series introducing support for ROHM BD70528 PMIC
> 
> //snip
> 
> > > > 
> > > > The MFD part depends on the regmap-irq changes and I think that most
> > > > other subsystems want to have the MFD changes in before taking rest of
> > > > the driver in their trees. So it will be a while untill all the changes
> > > > are in. It would really be nice to have the drive in-tree sooner - hence
> > > > I ask if theres a way. (I don't want to push, just ask if it is possible :])
> > > 
> > > It's possible, so long as there aren't any build-time dependencies
> > > between the subsystems.  Immediate acceptance however isn't possible
> > > due to the impending merge-window which opens in 3 days.
> > 
> > Thanks for reply Lee. So merge-window is opening - meaning the 5.1 is
> > being baked now(?) 
> > 
> > Anyays to make it clear - there is build time dependency between MFD and
> > regmap-irq changes. MFD part won't compile without the changes in regmap
> > tree. And theres no new Kconfig to depend on or other compile time
> > checks. So REGMAP changes are required for this MFD portion to compile.
> 
> //snip
> 
> > Rest of the subsystems (regulator, clk, watchdog, gpio) do all depend on
> > MFD - but they should have 'depends on' KConfig to MFD meaning they
> > won't be built without MFD.
> 
> I see the 5.1-rc1 and 5.1-rc2 are out. Those contain the regmap-irq
> changes the BD70528 MFD driver depends on. Would you like me to rebase
> the series to some other tree (which tree/branch? I don't see updated
> for-mfd-next branch in kernel.org yet) and resend it? Original patch
> series was created on top of the regulator tree.

If you could rebase and resend, that would be great.

You should (very nearly) always base on an upstream tag, so v5.1-rc2
would be best in this case.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
