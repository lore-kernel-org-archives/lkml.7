Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE7E20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lx5UkpFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDCD1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:27:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45146 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCD1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:27:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so7280385plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aN2nUZbYrLPSi9woO1MGkb56oeda1mmCOKrumBSs38k=;
        b=lx5UkpFq4bxhzU+gfwfcAIJZYekO26wIi83ouraof5omWUAqdonvvoriJBDdFgf6Jj
         PQEbtfSIBBwHE3JclKPF4kq4oFrSVPqZghsj67bgwf/s46+A9E7DPh7VLhtpqjLkG/2h
         GGGfCfSOeUYZan8C6/FEoi8hFA+ze5x8eSn4gnsiUuP2TF1dTaNcjsFRsy4gQcksnhwP
         HUTU7+hGQ2if+TuZ0FmFwM3C67a+SsXhs0peNFt5ce0PjfM1sGIblx10uXMhIuqii8Vz
         3m13sQW5qYyHOgnJW+DIAzmcGBvwukdblyPy433ls7JXMgZd87wAKY7FlRiUVZefYgWE
         gHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aN2nUZbYrLPSi9woO1MGkb56oeda1mmCOKrumBSs38k=;
        b=PqknVMI1KkE5YC8krRTnF8iGwuK1dGPumK6tAuHZtlzkV2aX5dEiw+4yLqPcN1CWmT
         OIXTcQ2uMYrD+R2fMSrMa5amAQAaPa+kpvSqp3m9XVUUaCo0pE7HJh/gs86jLmKNO714
         WFJyoVzhWYhC+WEsGsKcWo3hhy2Irwx7A+Q2S6/flklvNBdWyvfvhhx26Is15+5fI1Ae
         g1mQ5GqmIazZ2jHe2Iq5tNd1zvuATXPt12qHouQ513FbHgN9Thew9V6fm2wa78jGpSUa
         cToXgo72qjlRkPG1L/hE4gncT0l1inTyA9FoazwYpao0dpVRkRdGBzmbalt5KXOZAcJm
         xU/Q==
X-Gm-Message-State: APjAAAV0c5VqASyuLzvjjPSmth4VJomOcUxtcBlHSMw+75pRlZzGf9BZ
        rSJYUGnxpoH0FL6pqjpFBCtbOA==
X-Google-Smtp-Source: APXvYqySCRh+y4A04z3w6zLsa2xmhgS9jDegn1QkKC8mcolgS9bq0ydbnMfZX7nw3jQLpIoUc/P2sQ==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr74568465plh.140.1554262033303;
        Tue, 02 Apr 2019 20:27:13 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id p26sm29115090pfa.49.2019.04.02.20.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 20:27:12 -0700 (PDT)
Date:   Wed, 3 Apr 2019 04:27:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH 1/2] mfd: cros_ec: instantiate properly CrOS FP MCU device
Message-ID: <20190403032707.GH4187@dell>
References: <20190307175253.14785-1-enric.balletbo@collabora.com>
 <20190307175253.14785-2-enric.balletbo@collabora.com>
 <20190402040137.GK4187@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190402040137.GK4187@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Apr 2019, Lee Jones wrote:

> On Thu, 07 Mar 2019, Enric Balletbo i Serra wrote:
> 
> > From: Vincent Palatin <vpalatin@chromium.org>
> > 
> > Support Fingerprint MCU as a special of CrOS EC devices. The current FP
> > MCU uses the same EC SPI protocol v3 as other CrOS EC devices on a SPI
> > bus.
> > 
> > When a MCU has fingerprint support (aka EC_FEATURE_FINGERPRINT), it is
> > instantiated as a special CrOS EC device with device name 'cros_fp'. So
> > regardless of the probing order between the actual cros_ec and cros_fp,
> > the userspace and other kernel drivers should not confuse them.
> > 
> > Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > 
> >  drivers/mfd/cros_ec_dev.c   | 10 ++++++++++
> >  include/linux/mfd/cros_ec.h |  1 +
> >  2 files changed, 11 insertions(+)
> 
> Applied, thanks.

Looks like this depends on:

  mfd: cros: Update EC protocol to match current EC code

Removing until it's applied.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
