Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC60C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377C220717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9eRHG6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfLPPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:21:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfLPPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:21:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so7742965wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qLW85+iCakysrIL3d9ahlxs/+0bq3c8q3dQkkBI+mAY=;
        b=l9eRHG6cELj/1PPW5EMQL8KGSpML40lgI42oonoObgVkQJpwcUpAhOzugGJ1YzDVh/
         Xn+g5HPMl+dLsYUrlg7312P/+FNbj9QEnm2kVtOKCQdPOD447fXhj6oyX5lGi6hArYGI
         ORKa/zBvvQR/ijSqhhv+sdOOlpsJpm4PmFmwb3UgJplzSokAD8u8b9pQ7kaUsCXJ9f9m
         Lv/bhO/Swr+5cFJ21U8uk/Jd33llMPn0xeTlVRk8bVjXZJZrg3/QC8m5DHrKlgB4M0QV
         osHGkfb8Z2PSqzmCGeUX3qd3TpPIq2QDjMGPHvZoY2oInrkzLxNL6LEBL8zZzqTbZKg1
         pYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qLW85+iCakysrIL3d9ahlxs/+0bq3c8q3dQkkBI+mAY=;
        b=p9u/S9VGuyCdizR8Q6V8C9wpla5qcZWlmTg0qrmqRmt6L4RWf3E7ioSECXtzzIzv+Y
         7h4iKEzwbh30KRwXAE/yJV1RH081XQkoIkVVdrALUhzX4GaMi0ZEQaWrbtlIFbu/mTBN
         HxMegOYVWghtQdyPd6FEUpc/xOwPlLbIDJoJJ8ZTGxykFtSX+75JL4Uocv72UuqGJ55G
         zKupj3KQozo6/Rs+hPoXwt26sEzDyeEib144wOpSqb6vtiiBn3CfSVBrw24g673SspJN
         p1xOz8x+ehHLlnQVGnth7Crc1frseNtnbV0YQXkzu7j9CLz8Tlv3mjuXO4cFgSbUSMXA
         45Mw==
X-Gm-Message-State: APjAAAX0p2MZRYXMjW+Jll61QxxpjKa1TfwZqI82nFbc5erNE4PQORaf
        iMb4pB9rQ0zEPYabGoJsUc+S2w==
X-Google-Smtp-Source: APXvYqweC7S5MEqLKn13rfYs2+xIpXzL1Op8mNT8o+RON6KKvlXrllfQ92Cbjp2t7tj6nFBRu6VFaw==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr32672267wrt.100.1576509699617;
        Mon, 16 Dec 2019 07:21:39 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id x10sm22076901wrv.60.2019.12.16.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:21:39 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:21:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Ran Bi <ran.bi@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH v7 6/6] rtc: Add support for the MediaTek MT6358 RTC
Message-ID: <20191216152138.GF2369@dell>
References: <1576057435-3561-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1576057435-3561-7-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576057435-3561-7-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Hsin-Hsiung Wang wrote:

> From: Ran Bi <ran.bi@mediatek.com>
> 
> This add support for the MediaTek MT6358 RTC. Driver using
> compatible data to store different RTC_WRTGR address offset.
> 
> Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-mt6397.c       | 24 ++++++++++++++++--------

>  include/linux/mfd/mt6397/rtc.h | 16 +++++++++++++++-

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
