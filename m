Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D58FC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBAC20675
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTGotLa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEIBo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:44:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41149 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfEIBo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:44:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id y10so665438oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QSowrtvBxHuy+9EtWeAofxxOlDhK9Glv13XxPGgRs0g=;
        b=FTGotLa6Bju72vqFYtTwvrZTvNQYiOOMZ8o54hYAiqK0uOAsAPU6VON80aO9vkjLYa
         3p36iyGFyGMmdjmtWezMbuNGmm4PJZc7fgr4OxSLHOoXPBTIpg7sCURZt1/+XMeYKRBR
         NGTKH6iXjpRw5d3JMYy9oQ3EtG87RB7qukZhTndr+vz7FUeOQKjWGooGsi73ybtKST9J
         FwJbyJmujVUKKizeBjDd4ax7kwcNa2SInbgwCc0gYSRif97Lmpo4JHO9kOyF5dPD0THU
         WoFQdJk0wAxMYuWmVJY7aOrQppqlhYN3ghgKHjohHV1AMNO+bWx0fwuSn+a8d4VUM2Yd
         Qs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QSowrtvBxHuy+9EtWeAofxxOlDhK9Glv13XxPGgRs0g=;
        b=IACqKzQKDblXH6APNvqJeHfUqxSR1YmWMsS+yiOKbIDc7X1bD5Nmyp5NDm9lMhgerW
         TJWnuDoc1bQ06GnhRXm79iZRS67CcLBWPCe2DekhXriIti5zGe3MWD6Tafgysui4fHFn
         GW93nWI8284DZBLwerPWsunmYpq1RIj7b5ZuzV0FqAKvQZEv6sMKkKP09RpY/lwvTF7o
         ww15tbyjsmC7am0n5etDb00GoRBrk/W1zgeEG6CWZwV+flG5cphhwnWiBGKSK8RTTrvu
         BOq9hhCus5Tep9SG8cn8NgHYOCvsWJfbHYjrIXA4h3djCQz9vFRuSx6+neUQqJCQBZrR
         wzkA==
X-Gm-Message-State: APjAAAVsUdRvTyXbV3sV2xiLqlaOFEkamkIKINZBb5R2uIgFjFcjAKwR
        zOn/SxzJdfw46ajWyRHyCZ3kunF6gDwYieHfOxk0vw==
X-Google-Smtp-Source: APXvYqzeAfiNSljb+terykWDGmzDf8vkicYkCQIEsAaSxE2qpBV2t5nSNufIAYmBBr/EXFEAH0HCtdLqIeY8uZ0KA/A=
X-Received: by 2002:aca:61c3:: with SMTP id v186mr569894oib.27.1557366266348;
 Wed, 08 May 2019 18:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1557206859.git.baolin.wang@linaro.org> <1ddb1abe8722154dd546d265d5c4536480a24a87.1557206859.git.baolin.wang@linaro.org>
 <8746a913-0014-7036-7fab-4e0dfab04e1b@gmail.com>
In-Reply-To: <8746a913-0014-7036-7fab-4e0dfab04e1b@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 9 May 2019 09:44:15 +0800
Message-ID: <CAMz4kuJaP2UGiqCRrRX=cwwyqfnmiJ0CG-BXBkTpwKE825xKsQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] soc: tegra: fuse: Change to the correct
 __dma_request_channel() prototype
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Zubair.Kakakhel@imgtec.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        jroedel@suse.de, Vincent Guittot <vincent.guittot@linaro.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 at 23:15, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 07.05.2019 9:09, Baolin Wang =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Since we've introduced one device node parameter for __dma_request_chan=
nel(),
> > thus change to the correct function prototype.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/soc/tegra/fuse/fuse-tegra20.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/=
fuse/fuse-tegra20.c
> > index 49ff017..e2571b6 100644
> > --- a/drivers/soc/tegra/fuse/fuse-tegra20.c
> > +++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
> > @@ -110,7 +110,7 @@ static int tegra20_fuse_probe(struct tegra_fuse *fu=
se)
> >       dma_cap_zero(mask);
> >       dma_cap_set(DMA_SLAVE, mask);
> >
> > -     fuse->apbdma.chan =3D __dma_request_channel(&mask, dma_filter, NU=
LL);
> > +     fuse->apbdma.chan =3D __dma_request_channel(&mask, dma_filter, NU=
LL, NULL);
> >       if (!fuse->apbdma.chan)
> >               return -EPROBE_DEFER;
> >
> >
>
> 1) Kernel should be kept bisect'able by not having intermediate patches
> that break compilation. Hence you should squash the changes into a
> single patch.
>
> 2) Better to replace __dma_request_channel() with dma_request_channel()
> since they are equal.

Good point. I'll change to use dma_request_channel() in next version
if no other objections. Thanks.

--=20
Baolin Wang
Best Regards
