Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80352C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F1F20820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+MxhXPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfHLKSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:18:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfHLKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:18:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so104056906wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7tZV/C+CttVM58WgI5MskpQ9uHYkdrjmm3CFUmvewno=;
        b=W+MxhXPlqRndnSDLfszOAzcHmVOW3zepwOG16SrxUolE+YVOJWBRuiuxxU4d/tK5ib
         eQc/dIBIFwTcCmLQhoZQwpHSv0Z9GeNPNm2xWCPE0fgp4Rh9yoW+7ATA94jKrSXX4WrQ
         0PUIZNkQIQMW0/ttZeHjwewCrBJc8dHUMnE8Cn+DuD1QiGxzXoM6iqtK0sO+mBwI+ZR7
         zwQC+FQ8Ksc9TIrTKQATDtnIIWAni1AXI50QDu2qvmTx5JqDjheXwahx+Ou0JnK5ao+T
         NOfUqJsGdgFTyM+0k1m2xkbZ6ucKIp08KA+67ZZzOLTy8Ejuzu78IbvQb3BAsjDxDHHV
         TuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7tZV/C+CttVM58WgI5MskpQ9uHYkdrjmm3CFUmvewno=;
        b=kBehkKh245Cs0TPZW/Nsgeb99i7OcjxhzVKT1hiOe6vho71D74GoAbbNlMqwVnyA8n
         ToYSDE/kUV39ZnI+Y8Apap6BN57LrP680hbLKwIDma3kpQ7imKP4zZsxZ23SHEe25VVc
         O2mpx3glsqv+Hw/rSI0mbSjRC9aoTT115pp2tUe3Dcgb8IoIyi2bQHDrneHVYTOy3XHg
         CKxWv36D2eo7HF+4Kn2kjiTJ/GmCKoOlx7AO6ghfKEHfwhZiqZDjZatpLhLmK72pE/Mg
         ijreWCax+nGfG8KXzaP2Snj34JgIr4CAByuHxPS8Ox2KGX30K1c55jlnhmHMhVrJ1drZ
         uovw==
X-Gm-Message-State: APjAAAUhpnZQEKjKkXXAqr7INGL4O7Xi/xytY0XHmWlLlVthbBVueDLD
        2sqZ13u2Dh/LRMdAER/E/HIxIA==
X-Google-Smtp-Source: APXvYqwaN+jzxqGhqbcsiExg1wesaEC2LCxVh6tSbvfJCScUe6zZHJ2RcSBvMSMOl0MzKlQhkyBhKw==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr37516277wrp.176.1565605120486;
        Mon, 12 Aug 2019 03:18:40 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id d20sm10642375wmb.24.2019.08.12.03.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 03:18:39 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:18:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: [PATCH v3 03/10] rtc: mt6397: move some common definitions into
 rtc.h
Message-ID: <20190812101838.GG26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-4-frank-w@public-files.de>
 <20190805134842.GG3600@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190805134842.GG3600@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Aug 2019, Alexandre Belloni wrote:

> On 29/07/2019 19:41:47+0200, Frank Wunderlich wrote:
> > From: Josef Friedl <josef.friedl@speed.at>
> > 
> > move code to separate header-file to reuse definitions later
> > in poweroff-driver (drivers/power/reset/mt6323-poweroff.c)
> > 
> > changes since v2: add missing commit-message
> 
> The changelog should be after the --- marker.
> > 
> > Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> > Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  drivers/rtc/rtc-mt6397.c       | 55 +-------------------------
> >  include/linux/mfd/mt6397/rtc.h | 71 ++++++++++++++++++++++++++++++++++

I think include/linux/rtc/mt6397.h would be better?

Certainly from a maintainance PoV, it would be better reviewed and
looked after by an RTC expert.

> >  2 files changed, 72 insertions(+), 54 deletions(-)
> >  create mode 100644 include/linux/mfd/mt6397/rtc.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
