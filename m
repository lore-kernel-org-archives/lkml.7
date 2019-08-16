Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4A4C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1050320665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dzBCnLLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfHPRxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:53:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39435 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfHPRxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:53:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so3294662pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qj+FqdPY7E+evYAajO1pGkO3Jxq482Q+PVPBi3aWl84=;
        b=dzBCnLLWXkS4Ws52BWzTOeqaC5aRUz5q2pg8F0eAd5SdnxF3jZGdMmM4k7+pbM4cIy
         HFdX+vc2Ll7YBxNtOVC6nR4VfPlZbR1gPHuO2FCfrh49LSO6E+8jtbOv1VsY/io0Q/qF
         Tuh6jQsfKZuGDOeVmqR2t4wOkS67aa0Q91mLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qj+FqdPY7E+evYAajO1pGkO3Jxq482Q+PVPBi3aWl84=;
        b=bF7uBUGRcjWEoUiURY3xNsWedCLcK2WpAjTpvn8CKNnKiqyAS9zVcqEg3Z2gxz0BDz
         5uJM8qnseuRlGswRrFtXdFU2ujDHfRkaCTHz9BuoMnFCsc1CZSuEEtYsd+HRlHm82HMQ
         jz2BXU3cmWoIT71n6hS9aymXP1QJXmsB3Kwn34o7WXBJvOFphEDLQ4kgboba72DtUWSQ
         bEgISjxbTmXQVduR+zTK4EoMjfI2YQC7bE8YUeAxixiC0/jcUqfuysoSFCm2+Cls3RM2
         nRf53XAFUCNdppVEry9/KBm89EJ5chJDwjuXNm0zayq5ox0OcpTk66ak/FU3aM+qfN/W
         GgEg==
X-Gm-Message-State: APjAAAVi/f6E1YKUkJHYZZRumFq7SPbqU7SfTZL5z5Hzer++hnHeQ43F
        fw6MlTLU/K/qnR0AxWXGvSQzCg==
X-Google-Smtp-Source: APXvYqzTIq0zTOTZXmt8ILZwmsbuiDzRx2Ft09CbHR4OyhK8UqKzWfU17MizJnJeqdWUnX7nUxPe8Q==
X-Received: by 2002:a63:1046:: with SMTP id 6mr9033102pgq.111.1565978000238;
        Fri, 16 Aug 2019 10:53:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g10sm7048716pfb.95.2019.08.16.10.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 10:53:19 -0700 (PDT)
Date:   Fri, 16 Aug 2019 10:53:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190816175317.GU250418@google.com>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190807201528.GO250418@google.com>
 <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 04:54:18PM +0100, Daniel Thompson wrote:
> On 07/08/2019 21:15, Matthias Kaehlcke wrote:
> > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > > Backlight brightness curves can have different shapes. The two main
> > > types are linear and non-linear curves. The human eye doesn't
> > > perceive linearly increasing/decreasing brightness as linear (see
> > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > linearly to human eye"), hence many backlights use non-linear (often
> > > logarithmic) brightness curves. The type of curve currently is opaque
> > > to userspace, so userspace often uses more or less reliable heuristics
> > > (like the number of brightness levels) to decide whether to treat a
> > > backlight device as linear or non-linear.
> > > 
> > > Export the type of the brightness curve via the new sysfs attribute
> > > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > > 'unknown'. For devices that don't provide information about the scale
> > > of their brightness curve the value of the 'scale' attribute is 'unknown'.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > 
> > Daniel (et al): do you have any more comments on this patch/series or
> > is it ready to land?
> 
> I decided to leave it for a long while for others to review since I'm still
> a tiny bit uneasy about the linear/non-linear terminology.
> 
> However that's my only concern, its fairly minor and I've dragged by feet
> for more then long enough, so:
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks!

If you or someone else has another suggestion for the terminology that
we can all agree on I'm happy to change it.
