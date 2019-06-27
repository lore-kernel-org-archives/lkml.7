Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE5C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27BF20828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ8xRApR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0HxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:53:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41522 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:53:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so1326099wrm.8;
        Thu, 27 Jun 2019 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLH1G/xrhuaSchHrCbt7xaDv1QIvzTYbR4ToRYC3nAM=;
        b=DQ8xRApRETpcFLzwK5rKCkAIi+vGxhFXPqVccou4Utrk8ApA7v96BExWn4/4acmFTQ
         7JuIWLycnRdxpKBEw4E7Ed5LJdsEg0k/iarcMDU97r1D1iDJyS6b68ZDqElHLTODU4CP
         e5jy5tQh782Rg1vjJrL2cQws5X+PBSmLoRsstne1qNeLEnFMHPTDijWauAAYENgROGOF
         hpagsUuFd35IOtOX2v5hyqv5zpspQHvLbuZ6qphGuAuKMQfaRoi66x6rRKjwCVgM5prd
         IvWfkLry+1GEnQL4Hx47zZVAeLGm3VCCdcYi1Vu3CqMQYJCYoYfzoJtS2neYH/yWK/Fw
         jkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLH1G/xrhuaSchHrCbt7xaDv1QIvzTYbR4ToRYC3nAM=;
        b=pCkPLDUVNKq7kKBJlmjVXFDyy2lhEs3gwSz4O+2iFnOi/SvIOK6oXUcCRies2qA/Hf
         tclO7FvS5Fud5htsN0apGrH8xpjFgk2l6upZB8GqZ3Vz2TOILJ6XB9Kb+fxP0PN46/ZH
         dbBat34buQQR9OF6TVjPjUrURfnhByEIZgiF2r3EmOithcVbhzqc9chwUiErAVRSZxZL
         Q7Tcqa88Y0ovAyTDOYEzaYsHFE918hPIEbT54JYNw21y0ThFhRcI6SzG/PR24/etDb6+
         MofDnLW6WJ1kfQUvuqMzHEHFflI2pS6HGxR/MbUXoqk/4dvQ+CEnPPEeAu7+BQADsEA2
         BiiA==
X-Gm-Message-State: APjAAAUzL1pEoYlLFF1QwIyqTgxgD2iJWQGvZp32K7w29v7WJDLHi8T9
        02dn0vs3Fu0ifb431PPcoQCIDVsRFP8VIQIHOzA=
X-Google-Smtp-Source: APXvYqyOMmxDqyz32IcJEYNiHUT1bm+99KTVYSEbMt7gw2e5jIgFT+aQ4ioTQhLLt++vcs1+vGuDkNmZklIp8DN0OCo=
X-Received: by 2002:a5d:6389:: with SMTP id p9mr2039270wru.297.1561621998678;
 Thu, 27 Jun 2019 00:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190522011504.19342-1-zhang.chunyan@linaro.org>
 <20190522011504.19342-2-zhang.chunyan@linaro.org> <20190626181637.CFA6321726@mail.kernel.org>
In-Reply-To: <20190626181637.CFA6321726@mail.kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 27 Jun 2019 15:52:42 +0800
Message-ID: <CAAfSe-v6F-8F5YtunuHVmZVrGh5vAAFbkYLP1kThqoJd04BmBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: sprd: Switch from of_iomap() to devm_ioremap_resource()
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 at 02:16, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chunyan Zhang (2019-05-21 18:15:01)
> > devm_ioremap_resources() automatically requests resources and devm_ wrappers
> > do better error handling and unmapping of the I/O region when needed,
> > that would make drivers more clean and simple.
> >
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>
> Applied to clk-next
>
> > diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
> > index e038b0447206..9ce690999eaa 100644
> > --- a/drivers/clk/sprd/common.c
> > +++ b/drivers/clk/sprd/common.c
> > @@ -50,7 +51,11 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
> >                         return PTR_ERR(regmap);
> >                 }
> >         } else {
> > -               base = of_iomap(node, 0);
> > +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +               base = devm_ioremap_resource(&pdev->dev, res);
> > +               if (IS_ERR(base))
>
> There's also devm_platform_ioremap_resource() if you want to save even
> more lines!

Yes indeed, thanks for the information.
Considering this patch was queued to your tree, I decide to use this
more integrated function later :)

Cheers,
Chunyan

>
> > +                       return PTR_ERR(base);
> > +
