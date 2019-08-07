Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FF9C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7C92199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RwoY0vyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbfHGUPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:15:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45894 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbfHGUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:15:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so302841plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RU+mCl+d15cBnmP6BMoJqIyEACy478kUYuCNnNZJiqw=;
        b=RwoY0vyVibrSFxjnucYfjp+aWRh2NgUEtgqFYjY8w08e7aiLVLcxKn9RCWHq4b7SJk
         8FUeg3lCxv6f5agtWIgt/tatmSYIRk7tQRv0RZf4BH0NKtCUnT5xLuQvXFDvXqH0W8Ui
         PKtctk6GL5/3C3yNzZ90bt706+jZtcmRS4NJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RU+mCl+d15cBnmP6BMoJqIyEACy478kUYuCNnNZJiqw=;
        b=ggaDS07O+x+MvEJ0uz5ZrbZYAP1JENqL/5cauK5B8nU7uMFsxyCwFbT0x479y9eoVr
         jEsMVXrb8ag+xJUDXYUKjotADfopZgJa5wVNE3Nuf0IAPklprEqLMVvFgrYkg0cvoXPU
         5dQolRi8ln1yqzqU7pOAP9npBh4N/iXzryIAT4oOPP0dYP3IQy6w6dSE66a/RAoIypIy
         4jmjiCtgF8mLDnkHJj3v3fwRfI47paJoRGJfsURQLIrn8zbg92O93j/iuco1Apfoy9L3
         zffNg701s7kRCX5TsUNqCjQGkVjy1wfewZlTRlEKVHLA4Ve5q2L7pUc94u+o9e2SuevH
         Xcng==
X-Gm-Message-State: APjAAAVI0bG3wIhY8+1VtWEdrTxZ93UdvClEev5UvlwI+fbnzMAVdQRS
        i2mcbZVS0ft4idgwy25LRg7x4w==
X-Google-Smtp-Source: APXvYqzcVZwYo5rrOlwBwZoU659GCbZRYFCC2aSl+NJNpuqYHhxbX896kG9fN1cjA8EAoMnQE6+lFQ==
X-Received: by 2002:a17:902:b582:: with SMTP id a2mr10103527pls.128.1565208933200;
        Wed, 07 Aug 2019 13:15:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id w197sm116457813pfd.41.2019.08.07.13.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 13:15:32 -0700 (PDT)
Date:   Wed, 7 Aug 2019 13:15:28 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190807201528.GO250418@google.com>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190709190007.91260-3-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> Backlight brightness curves can have different shapes. The two main
> types are linear and non-linear curves. The human eye doesn't
> perceive linearly increasing/decreasing brightness as linear (see
> also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> linearly to human eye"), hence many backlights use non-linear (often
> logarithmic) brightness curves. The type of curve currently is opaque
> to userspace, so userspace often uses more or less reliable heuristics
> (like the number of brightness levels) to decide whether to treat a
> backlight device as linear or non-linear.
> 
> Export the type of the brightness curve via the new sysfs attribute
> 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> 'unknown'. For devices that don't provide information about the scale
> of their brightness curve the value of the 'scale' attribute is 'unknown'.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Daniel (et al): do you have any more comments on this patch/series or
is it ready to land?

Thanks

Matthias
