Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B1C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EE9214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gv+58ZdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfKGK7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:59:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46982 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:59:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so2436712wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jX1PhmjNScp3jK1QdS94+FmYelbSzRbuM5rLkgj2mRc=;
        b=gv+58ZdQhGmq+GSICmELQimLBk8wdLBnuM4sV5AYBI6PFK6R1q57SkLujuZFsqBbIW
         d4fvguep3DRTSE36XkyzSGdawGJvzJcnJsweoUsW1hT+gfrDaH7/oj5XV5BgJD/i/TSh
         cYZh23loP+Tpux0WccRjDYy2MhqgESdHzw006MnoAb8qYEFqsSSp4INY2zwoR8ffeBVt
         nCQOtUONYVcwNMYqFvT/8BFQN/R3/iUUmq5oe14x/FA3ILbBkaWej051Z0yiyCAY0lT8
         38lhC8DMG8rxb8/H5l5Ir8laLTPM2vEPeUceswAFLCIJ+I+He9suOmS8n4pVNVwsg3gf
         fuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jX1PhmjNScp3jK1QdS94+FmYelbSzRbuM5rLkgj2mRc=;
        b=gPSc7gzhVI3SmwTJeVaQU5JiMwhQJESpLYSeeQOC9t2/YfUL7iqLhO36KOdNs9N7RI
         NFNEAZVSubevMlhku+/+X4wjGBNe0KkTDGBx5YlE8DiIdvgqh7Ij9w1Si0Mf9IH60ymt
         kUq/4TSzB3zIoinXPLwp9k+UxA0XtJwNYqevDfWTzqrpwDuGzprqq88jX8SusNDi+B+i
         LXPnOtozyNhycz5ZmlnlntSlzbNBzzaxWGoAwUp3dlDioygk5ZzWl7UJ8Kxlto7Yuca8
         oZL5JE5s+TQoXRNrfz4kbp/OwhSMJEtYLQw8wCnXDRrjT8IY7Dwz2JA7hse1ZIgP/koP
         GWpg==
X-Gm-Message-State: APjAAAW4ZRZK8XjAr0Y1Pzwx8I/viTy+Qdy330XMaUZeN754YNdBb7yI
        EedKiXsyzcdyPX+WZ9t7riisqA==
X-Google-Smtp-Source: APXvYqwU4MnGMqehuKQuaV7oe8goOIQTO0A3B4MmI0/ehUPIDN+z0xgTieF9mKZvlobJENIScotayw==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr2444267wrj.84.1573124391594;
        Thu, 07 Nov 2019 02:59:51 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id b186sm1479648wmb.21.2019.11.07.02.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 02:59:50 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:59:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: bd70528: Fix hour register mask
Message-ID: <20191107105949.GA19195@dell>
References: <20191023114751.GA14100@localhost.localdomain>
 <20191105165317.GC8309@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105165317.GC8309@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Nov 2019, Alexandre Belloni wrote:

> On 23/10/2019 14:47:51+0300, Matti Vaittinen wrote:
> > When RTC is used in 24H mode (and it is by this driver) the maximum
> > hour value is 24 in BCD. This occupies bits [5:0] - which means
> > correct mask for HOUR register is 0x3f not 0x1f. Fix the mask
> > 
> > Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528 RTC")
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  include/linux/mfd/rohm-bd70528.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> Applied, thanks.

You have been duped. This is clearly not an RTC patch.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
