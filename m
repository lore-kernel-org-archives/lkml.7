Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D40C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D248214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJ4FxnH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfHLLZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:25:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45817 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfHLLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:25:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so13967515wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=49CBW8Jmx90YcYNx8wReWcg2SN7UmhhfHSj1OE9VGKY=;
        b=nJ4FxnH+8fGcZOZSrqQVAYBMKxnGE4IOx3TnqukSR1QQoo0UyYYxDXtMV35wZjt1T1
         kOiRqFryRBep6h9A+GS0gUtCjdc29Cw9Zn0te2tYLhcDO6+yWJLE0Q8M2UfOZnm6N1+k
         9A/Jm1GA87/N6JAYm+u0a8MTphDzyByR51rMQzKJJF1EEfcESoB6h02+UME8QDWsSxL/
         nZCt75lbnJWXN6gdUUyEnE8RuOjewzGhcv9xMe0lDG6r4ylRrRLNF5fNITAf2pQDYeYZ
         eAK4CwWpXLSMAW7mmqFTRgeCIng78potcp33k04z6fQ825NXNrbb7L8Jb+y4V0KG7UA9
         hBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=49CBW8Jmx90YcYNx8wReWcg2SN7UmhhfHSj1OE9VGKY=;
        b=nZGDgYjfz/baE2YYFC4tfsPOdbWH8uDxGQzRtF8S/HjhwFlE7TItphWlPN4Hh2nVVL
         E076h6rOkutgj2/KMSaPbWvQnGc4bx8LGqHIwIKa/oZkqICpt6PjXPvzmYG3L6pAfZI5
         /BRy9prTZgtOyJ5SRpdeA5yUXAp4fkKpywrBMwouBgiO/pppd35VdsSB9UA+MWjDaLoG
         9SlIa2PPol/LQC2HJFFyft31lSV7amHdYS3Ry0UepmDik5jgj12dvfuCBr5BCTCTxTJz
         hPW8/Iaz3hAudlUVQKk0j71FstQmovlHpqZuYpmvNQIP5maZmISUqn+xVP0SXeXRWClp
         5CmQ==
X-Gm-Message-State: APjAAAVBK1s8oI3fKlXBZy+R5No5lGheZGzmPE9ltdCENd/5KBOeR1Km
        +L8O2S6nAj0ChYird7fl3H/IdQ==
X-Google-Smtp-Source: APXvYqy6WbRf37/8vVpsj8slsd6qhrcT26PVhm1zZSyanYDyMDDJ2/CALUfqVjfjKV/6kEIUhtVDLA==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr42749044wro.284.1565609127998;
        Mon, 12 Aug 2019 04:25:27 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id o17sm13057600wrx.60.2019.08.12.04.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 04:25:27 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:25:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
Subject: Re: Re: [PATCH v3 01/10] dt-bindings: add powercontroller
Message-ID: <20190812112507.GR26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-2-frank-w@public-files.de>
 <20190812102035.GH26727@dell>
 <trinity-a6c06411-16d3-40ab-a4fb-3494131c8ed6-1565608221532@3c-app-gmx-bs80>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-a6c06411-16d3-40ab-a4fb-3494131c8ed6-1565608221532@3c-app-gmx-bs80>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Frank Wunderlich wrote:

> > Gesendet: Montag, 12. August 2019 um 12:20 Uhr
> > Von: "Lee Jones" <lee.jones@linaro.org>
> 
> > > --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> ...
> > > +	For details, see Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> >
> > Please use relative paths.
> >
> > E.g: ../bindings/rtc/rtc-mt6397.txt
> 
> Hi,
> 
> as we are in Documentation/devicetree/bindings/mfd/ it should be
> ../../bindings/..., right? or ../rtc/rtc-mt6397.txt ?

It was an example (hence the "E.g.").

You will need to adapt it depending on where the file ends up.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
