Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24A5C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715892146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0wL3sdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441994AbfIXUiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 16:38:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45571 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441977AbfIXUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:38:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id u12so1442755pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UZKL+542wWKMtqmPB6ZvBJSdUhAfyCh5/zN16bhGakE=;
        b=S0wL3sdM8d7Q+5AXyTcUlMHv1TTpJejEloFuec4WRpAkLmKcvHmgitE1IokWm23HwW
         r+9a9GSziwe0GDztbRTKWzAGkdkec6tLYLINYCNpRX4PHpC0cddz5w3l5+XtquS5NnVf
         fqZP5D1nV0ZUJ3VrRp4xuEQCDLBuOei31MZ46orV7epEfNhvEqwIQRRhQwUBcicvJemG
         GtcJW6qW0BukiLlU7p2kqS9cW28NB0Nc31/537h0CJ2uZgTBhbTcC1u/fcAjbn2qQr6R
         /IrlFVVrpBoMcVo6YOVTGQpYmQozhHHkxJOaefCm35jiP1t3VYNpqYcs7dvWrgZLHXrm
         Fn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UZKL+542wWKMtqmPB6ZvBJSdUhAfyCh5/zN16bhGakE=;
        b=rdjzhgd9G9RzmTMBliSZNI1VBHR8tPCThpnFnVjdjag1SzREVFu4r9gAZ/lUbdfL0L
         Ame5F65JMkQXn4Q8f1KwUoNdReF4li8NeBP5vJ0zq4bu7zEss+Fk+se0+Ud9rIFy3IcF
         ffWxvqcLRRhgUMz5FN1ATlNh79FAPlnQYV83vjFt4mJ7fDUemmTONXt9pbqEykX7xoGv
         JPRqfOuFX+E9edrnUhS6Byyh5ynp59ABN7DpyGJJxmuFfAXroJHXewayQWN5J4uLzQKp
         PrK25V4npr26timS9ZBFfAGzduxXqCjMhj2Ro+wpTPETpYaYhOQAT9tvNpDdUscsJAY/
         i02Q==
X-Gm-Message-State: APjAAAVVy/AYpi6K036jDA7Ft9Rv8SEdw6oQF/CvXr6+A+TPoVV3l0Bm
        WkDMAZAZRSDHmElDVN6RHgOApg==
X-Google-Smtp-Source: APXvYqys8CWbFt5YPo4VOMno8TMWKcB9zMouJBRLLd0jC5kTZUKLp1yNC4y6Yy2B+9rsAj0o0qbsHA==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr5302676plc.62.1569357531963;
        Tue, 24 Sep 2019 13:38:51 -0700 (PDT)
Received: from dell ([12.157.10.114])
        by smtp.gmail.com with ESMTPSA id p88sm865032pjp.22.2019.09.24.13.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 13:38:51 -0700 (PDT)
Date:   Tue, 24 Sep 2019 21:38:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com
Subject: Re: [PATCH] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20190924203848.GC4469@dell>
References: <1568801744-21380-1-git-send-email-gene.chen.richtek@gmail.com>
 <20190918105121.GB5016@dell>
 <CAE+NS37XG+kfbj6yJrL5A-d2O_aiRU90yV5TUk3Kfa0Rv7dWmw@mail.gmail.com>
 <20190919071828.GC5016@dell>
 <CAE+NS342Kn6OEz4D9Y0yfXStnW6KQ6N2yuQtgN2q2bXafofShg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS342Kn6OEz4D9Y0yfXStnW6KQ6N2yuQtgN2q2bXafofShg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019, Gene Chen wrote:

> 2019-09-19 15:18 GMT+08:00, Lee Jones <lee.jones@linaro.org>:
> > On Thu, 19 Sep 2019, Gene Chen wrote:
> >
> >> Lee Jones <lee.jones@linaro.org> 於 2019年9月18日 週三 下午6:51寫道：
> >> >
> >> > On Wed, 18 Sep 2019, Gene Chen wrote:
> >> >
> >> > > From: Gene Chen <gene_chen@richtek.com>
> >> > >
> >> > > Add mfd driver for mt6360 pmic chip include
> >> > > Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> >> > >
> >> > > Signed-off-by: Gene Chen <gene_chen@richtek.com
> >> > > ---
> >> >
> >> > This looks different from the one you sent before, but I don't see a
> >> > version bump or any changelog in this space.  Please re-submit with
> >> > the differences noted.
> >> >
> >>
> >> the change is
> >> 1. add missing include file
> >> 2. modify commit message
> >>
> >> this patch is regarded as version 1
> >
> > It's different to the first one you sent to the list, so it needs a
> > version bump and a change log.  There also appears to still be issues
> > with it, if the auto-builders are to be believed.
> >
> > Do ensure you thoroughly test your patches before sending upstream.
> >
> > Please fix the issues and resubmit your v3 with a nice changelog.
> >
> 
> thank you for suggestion
> may i ask how to disable kbuild test reboot for s390/x86_64/ia64?
> we want support only cross compiler =  aarch64-linux-gnu-
> and we have test build pass with our patch

You can't and we wouldn't want to.

If this driver should only be built/tested for AArch64, you need to
ensure the Kconfig represents that.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
