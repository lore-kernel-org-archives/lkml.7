Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8CBC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0D120828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZGIqytna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfF0Nrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:47:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46357 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0Nrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:47:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so2633668wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pibKCnI+c/rSlOBpb0r95ES5GvDfOsIXxIlsP9rgtNk=;
        b=ZGIqytnafn9W9KYHdRvIPI0mnz+wDCfqvovREHwYm2fi9m5/4xTx97D+OnH4DvFtG9
         IeddSszuzt6bcu0IrL8EMQ/p0xls7alc4GB0yjkOQ+lGtGFoZFWcn4inwOvzmfXRalDY
         D0tnk8eJ15qqAmI5OZynqo1Z+txwc7T7thL92PG2o69nAByEGwyN+PDuFsEVfbvy7l74
         eaj9iYj9d1RuzpuIEp7l6o/JSZCn1ghaIRWU4xhubctPxKYvABnsAhm9qcm0mkYWPTob
         j5lXCvBWCdncEICavkGfc6VtZCegNigooNRzP4HeXJIdDo6TZwN4d2MAUFXU8yACIZgX
         mhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pibKCnI+c/rSlOBpb0r95ES5GvDfOsIXxIlsP9rgtNk=;
        b=gszfLvUq6Aapw+kCBZ2C/QMa/AvDStmVxzGYc40XsxOpelevgf06F1AUK8GHD1w3ez
         +4vFbvuk9rxtkztEGexSCAaA0lblWRyqOwNNmwYYmT9PxW9CZ2H+KkZ5mQoCH7yBYkoJ
         iNySvUCrhLlNdQPGHuzXshUHz1Zg7j7LkTdZknH1M4mBEYmvXjCcKwzXF4BjyOfuYx2S
         ALQyNSCVWFcBhlyKJhdNUkCr3r1sEpoVorTsHdJWSjJCxsDYRmV3Aeb6jrhsVPFY9GZr
         yfD7/t+7QSBgJr2Su3eNtXtV+CCNb83fQhuxNWBBX/nBzlfvT6nmj2IQyoEHp8+byedl
         Mc/g==
X-Gm-Message-State: APjAAAVq15XCmPNomdDaRS0/alZjk75jNwSQh3C0ojNguDhBE2z6PlVo
        t+Wd8rlLW4lPTHR1bH7rX96vYcnkp98=
X-Google-Smtp-Source: APXvYqwp714jRoQiiBTfOVZdMMYMNpk0wu1ZV9lBtDnLP5BSZdcXUmTdATLmoLgA6vGxS7PjMRwJng==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr3398342wrp.277.1561643270675;
        Thu, 27 Jun 2019 06:47:50 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id j32sm4600419wrj.43.2019.06.27.06.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 06:47:50 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:47:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Chen Feng <puck.chen@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] mfd: hi655x-pmic: Fix missing return value check
 for devm_regmap_init_mmio_clk
Message-ID: <20190627134748.GG2000@dell>
References: <20190626133007.591-1-axel.lin@ingics.com>
 <40ae33d4-10fd-852a-30e6-db56d709ef1c@hisilicon.com>
 <CAFRkauDFf0qWpovNaaMkB48RXAsRsGEQ_=osSM7+Ze59C8DEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFRkauDFf0qWpovNaaMkB48RXAsRsGEQ_=osSM7+Ze59C8DEkw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019, Axel Lin wrote:

> Hi Chen,
> 
> Chen Feng <puck.chen@hisilicon.com> 於 2019年6月27日 週四 上午10:03寫道：
> >
> > Thanks
> I assume this is an Ack.
> If you can add your Acked-by in the reply, it's easier for maintainer to accept
> the patch.

Looks to me like he already Acked it.

Which is looks like you already applied?

> > On 2019/6/26 21:30, Axel Lin wrote:
> > > Since devm_regmap_init_mmio_clk can fail, add return value checking.
> > >
> > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > > Acked-by: Chen Feng <puck.chen@hisilicon.com>
> > > ---
> > > This was sent on https://lkml.org/lkml/2019/3/6/904
> > >
> > >   drivers/mfd/hi655x-pmic.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
> > > index 96c07fa1802a..6693f74aa6ab 100644
> > > --- a/drivers/mfd/hi655x-pmic.c
> > > +++ b/drivers/mfd/hi655x-pmic.c
> > > @@ -112,6 +112,8 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
> > >
> > >       pmic->regmap = devm_regmap_init_mmio_clk(dev, NULL, base,
> > >                                                &hi655x_regmap_config);
> > > +     if (IS_ERR(pmic->regmap))
> > > +             return PTR_ERR(pmic->regmap);
> > >
> > >       regmap_read(pmic->regmap, HI655X_BUS_ADDR(HI655X_VER_REG), &pmic->ver);
> > >       if ((pmic->ver < PMU_VER_START) || (pmic->ver > PMU_VER_END)) {
> > >
> >

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
