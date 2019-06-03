Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED26C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E512146E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i336iScQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfFCMxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:53:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41682 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfFCMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:53:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so11944845wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mJzvhiGffEycEWujL+bss26vNVFhjmchmuQXEPVt3OI=;
        b=i336iScQCfCZvbvTGweyXXgI7STx9ES6GbBUErWAbm2GYjsrk15DzygvtflxAU75bw
         7zytegesZVYlVbKGZQl2/uIhWWJLVtIB42A7hmZakjv5JVueeBrWMm6YSSJtVlMdtPEu
         6BS5T8Nzfd4M/xL4YMfXi7rwAtZ+RcQH5RAVDIramgsZf91yFBzp7pqCwOhqc+14iMv2
         k6i1pJeIxiMLnLrjUBpYDHmESWhAfOV6uapL12RaqR4azwGZxYYhiO+BCDffN6O90661
         6HD5JtgDf3Vn7KATsxAB91xl0IhFjSUR8bnZnOe3m9rHBgba5fZbGmYl6BbASR1XySRS
         JaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mJzvhiGffEycEWujL+bss26vNVFhjmchmuQXEPVt3OI=;
        b=jhoepZElXzSMnoft3cQM0SRN+sEk1srxhFoXBCraTSUKkyfA5cycpYikoTWJVMqXJG
         I7mcrEsoqH3xgCq6EOrQXi+3Rv8vLlwPG5zgBEJeUFUh3RVyZm+c+Gcn5haa/X3mdBx9
         q1ml4fhx1sGKeEv6ECtlW6PKohfLLVZs2IN06mKgTnublY18m+Rm9RqgC2Afd9l8Wsoh
         0tM/7vm6zyV9BU24l2rX7OCevou9l3sKBqAnzY5Xx81u8fKJyLNwqKcYMoJFFjYiNXEU
         Gh8mtE0HjUePSfjg/OswgVtHXUR2Z0usxJJ9kIEVr2VpTAjXH27unl4ISAwRlszV9S1K
         0tBA==
X-Gm-Message-State: APjAAAUz2EOfFkRNzTwBsOBgQfhiWi5Wz0IrUNkAwsmu6w3mFpy3s+8W
        izO01lkUbm8U6BVt1rP0JZNUxg==
X-Google-Smtp-Source: APXvYqxFE0118CiSNYTdmHv39GS0d43c8AFGtSRqVsdLZ2291NPcyMYGAd6S+TG69G1rOWsB4WIMmg==
X-Received: by 2002:a5d:6849:: with SMTP id o9mr2541732wrw.196.1559566395383;
        Mon, 03 Jun 2019 05:53:15 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id g8sm1176779wmf.17.2019.06.03.05.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 05:53:14 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:53:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, broonie@kernel.org,
        cychiang@chromium.org, tiwai@suse.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190603125313.GU4797@dell>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 May 2019, Gwendal Grignou wrote:

> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.
> 
> The source of thruth is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> 
> That include file is converted to remove ACPI and Embedded only code.
> 
> From now on, cros_ec_commands.h will be automatically generated from
> the file above, do not modify directly.
> 
> Fell free to squash the commits below.
> 
> Changes in v3:
> - Rebase after commit 81888d8ab1532 ("mfd: cros_ec: Update the EC feature codes")
> - Add Acked-by: Benson Leung <bleung@chromium.org>
> 
> Changes in v2:
> - Move I2S changes at the end of the patchset, squashed with change in
>   sound/soc/codecs/cros_ec_codec.c to match new interface.
> - Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Gwendal Grignou (30):
>   mfd: cros_ec: Update license term
>   mfd: cros_ec: Zero BUILD_ macro
>   mfd: cros_ec: set comments properly
>   mfd: cros_ec: add ec_align macros
>   mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
>   mfd: cros_ec: use BIT macro
>   mfd: cros_ec: Update ACPI interface definition
>   mfd: cros_ec: move HDMI CEC API definition
>   mfd: cros_ec: Remove zero-size structs
>   mfd: cros_ec: Add Flash V2 commands API
>   mfd: cros_ec: Add PWM_SET_DUTY API
>   mfd: cros_ec: Add lightbar v2 API
>   mfd: cros_ec: Expand hash API
>   mfd: cros_ec: Add EC transport protocol v4
>   mfd: cros_ec: Complete MEMS sensor API
>   mfd: cros_ec: Fix event processing API
>   mfd: cros_ec: Add fingerprint API
>   mfd: cros_ec: Fix temperature API
>   mfd: cros_ec: Complete Power and USB PD API
>   mfd: cros_ec: Add API for keyboard testing
>   mfd: cros_ec: Add Hibernate API
>   mfd: cros_ec: Add Smart Battery Firmware update API
>   mfd: cros_ec: Add I2C passthru protection API
>   mfd: cros_ec: Add API for EC-EC communication
>   mfd: cros_ec: Add API for Touchpad support
>   mfd: cros_ec: Add API for Fingerprint support
>   mfd: cros_ec: Add API for rwsig
>   mfd: cros_ec: Add SKU ID and Secure storage API
>   mfd: cros_ec: Add Management API entry points
>   mfd: cros_ec: Update I2S API
> 
>  include/linux/mfd/cros_ec_commands.h | 3658 ++++++++++++++++++++------
>  sound/soc/codecs/cros_ec_codec.c     |    8 +-
>  2 files changed, 2915 insertions(+), 751 deletions(-)

Okay, I'm ready to apply this now.  Could you collect all of the Acks
you received and submit a RESEND please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
