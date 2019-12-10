Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDACAC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19A820828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2LURZ9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfLJTLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:11:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34660 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfLJTLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:11:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so9358209pgf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 11:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wqyrsFbKvAgp1XOGnCH1wihydXPeMNhbMwSDb6gzLcg=;
        b=X2LURZ9NmX6JBqBK3oxesIlMMR02B+nouIyC4ZFJa8JQnpsZPNoDo7vG7uH78lI//0
         EHGMq5EtoA1LEtSTATvh53dflMWpvv4dxei5fiGtwxdumT6QTNN0f15rtqWFX+xqE8zT
         A94HXIB24npveHSn1Zh2MhQjUTjPQE1liCZAUP5F8Wcslb82YS9rLKhWGR9ms5pHmD3U
         5NbkIz7oKAvoN8FEUN7wNn+JO3ZMCTp23A2EZUOpWt/a6Wxmyr+b4/PrAzKmpZNpheSK
         e4UppKMOciQExedz02GtK+SmHVx8n1sKczl7Fws73NsMhE8t2lsvADK/n7JCEsnbISCD
         TVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wqyrsFbKvAgp1XOGnCH1wihydXPeMNhbMwSDb6gzLcg=;
        b=f0ozgKLxVPDsNcNw42/UIFeTODRWsJDyEsuzYnd8nOQDOs3AQvgoxEopFdJ7qcoypS
         vrqyibykNGWaEDqQXwwIh4mPVacfhz0wnk9IaUCk8rLMhx9Yo1RkYAddzjSP6bb+w8A2
         f4bFQ+ESqZuLWKXJ4UIjTpD8I/Jhsp74ScH0yTINg5wHSHGW6PnxrZIauGgUFrY4SkO1
         0H39Cq2wQIxsl/Nu0sBNVMsukc5TUw+qZZfMME1430G2VyBBcQH2tgRPdI4MMgnHB5P5
         ljI1F/Lbe+s23971Ajv/7LlL9kzn95DiBxqZlqxxEZjEl6Y0Ntl6ZlAykueR+0qLRSPn
         sW+A==
X-Gm-Message-State: APjAAAV4kFtxnR99BhHNFSgBIcAD3Pu0IdhGu/FgUMLAE0FHoslZGhHy
        g2LALSqhyclQWrsfa17qoV5K2Q==
X-Google-Smtp-Source: APXvYqyrDn4v27jGvSfMZp0Xc8hNq7oBuPploYRqtNc5nHYG0C8cSi5ilO4ThU7xeu5otzhHy6atng==
X-Received: by 2002:a63:496:: with SMTP id 144mr27081792pge.207.1576005106666;
        Tue, 10 Dec 2019 11:11:46 -0800 (PST)
Received: from yoga ([2607:fb90:8497:e902:4ce0:3dff:fe1c:88ba])
        by smtp.gmail.com with ESMTPSA id e10sm4574017pfm.3.2019.12.10.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 11:11:46 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:11:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] phy: qcom-qmp: Increase PHY ready timeout
Message-ID: <20191210191142.GF314059@yoga>
References: <20191107000917.1092409-1-bjorn.andersson@linaro.org>
 <20191107000917.1092409-3-bjorn.andersson@linaro.org>
 <CAE=gft5mLSqsJzj=DtesH3G68_wSKUr8rZ5iubOerimQmZKegA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft5mLSqsJzj=DtesH3G68_wSKUr8rZ5iubOerimQmZKegA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Dec 10:47 PST 2019, Evan Green wrote:

> On Wed, Nov 6, 2019 at 4:09 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > It's typical for the QHP PHY to take slightly above 1ms to initialize,
> > so increase the timeout of the PHY ready check to 10ms - as already done
> > in the downstream PCIe driver.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Tested-by: Evan Green <evgreen@chromium.org>
> 

Thanks.

> Should this have a Fixes tag for 14ced7e3a1ae9 ("phy: qcom-qmp:
> Correct ready status, again")?

For UFS it would be 885bd765963b ("phy: qcom-qmp: Correct READY_STATUS
poll break condition"), but I think that before the two we would exit
the poll immediately, so we would only hit the timeout in the "error"
case - where the PHY did come up in a timely fashion.

So I don't think there is a particular commit to "Fixes:"...


But given that this is no longer only needed for the (new) QHP PCIe
instance it would be reasonable to Cc: stable, to get it into v5.4

Regards,
Bjorn
