Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F01C04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A5126368
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ji0kqvdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFDCSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:18:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41345 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFDCSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 22:18:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id 107so12268619otj.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1l+D3rSEai4qzn+TyHSQz7IIWfxK6zl3YHxlBM75Sxk=;
        b=ji0kqvdjzqwIUAMrKo44/NCdPxG7kCOt7Hn0ZEmNeX4IylO3gLu2LJSi/pElY7IIbM
         HN5nagHzCYI8L27LLselXWAYkf6bFKXGIxq2Vctezw/AB8zsC8WOydU92z/XH/2aoK2A
         yh2lvRhAVbV8FPmdWiyypeA6uHZAXIx5pvFi+Ct0Kh7I0FAf64XN2E/BwPIBb0bcHdSX
         0Gta6gcFmqEcmnp9kCfe3nLwyWf+SbQ1Nw+DlL57VPLsJeN/JiL8rhTgp1JmmBtAQZsF
         I1fiAFO0iWTIN38nBkT3M8I9T/Fupjok5DxcRbIXHTx7RIXemRNu1Cdirlm7sqCCiuyq
         CTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1l+D3rSEai4qzn+TyHSQz7IIWfxK6zl3YHxlBM75Sxk=;
        b=F+zbp4SWcdJjg7HpOeJn1Kz39wqmeOg1ppZhFoWasLvioOF9YENuMHB0qTaf3jWfrB
         Vr+TGN+rT65qqmT+ZrW4U3piv5ifVjJMO8zcZgXmn8RiZyDR+JlvGTUXqUjnXUNOoC7t
         mQqBOffBDMGaLr4MeVdjp/jSRyBHk4gf3NpesRfAFSjXK8FK50Gbxdd6YfrLi56U4YTz
         PNgki6CS2+eOB07TMq+VECJsmapIhRcRwD68SMPLUJhxxMWvnvl7dsr7+BlUUXNEh26Y
         2oZbgeSjaujj1IgJDr+41VQ6p0JV04cej0B8gxTTsBP+5BJz3elyWmGRS7OkIPkhR4WE
         hwwQ==
X-Gm-Message-State: APjAAAV44hsHlBZninsaQFwq8wAVr/iyUa8NfmHaC0MEsalby43mLnzV
        YAXqgficsg/FpuKjL7AwPcFcLqVPrQVfZKu4fFq4iw==
X-Google-Smtp-Source: APXvYqyRqFO8DnlUxTuulaeN51Ccoi/wNUL1xOjgvaLRhN641y5Hw/UsspKPB9nl9NukmCmvcMaNWtuiBw6YLY/JcLo=
X-Received: by 2002:a9d:10c:: with SMTP id 12mr3560362otu.123.1559614730649;
 Mon, 03 Jun 2019 19:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org> <aafceaeb2fc7e9d103d1d7a19cdae97759dd1500.1558346019.git.baolin.wang@linaro.org>
 <6b539c8b-c2fd-6c37-d645-ef714c0e29c9@intel.com>
In-Reply-To: <6b539c8b-c2fd-6c37-d645-ef714c0e29c9@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 4 Jun 2019 10:18:39 +0800
Message-ID: <CAMz4kuKXqTWfH0d=4hV_+k8ukYhihQP4QcqFQ+jpiQSu21TQ3g@mail.gmail.com>
Subject: Re: [PATCH 8/9] mmc: sdhci-sprd: Add PHY DLL delay configuration
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, 3 Jun 2019 at 21:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/05/19 1:12 PM, Baolin Wang wrote:
> > Set the PHY DLL delay for each timing mode, which is used to sample the clock
> > accurately and make the clock more stable.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> One comment, nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  drivers/mmc/host/sdhci-sprd.c |   51 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index e6eda13..911a09b 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -29,6 +29,8 @@
> >  #define  SDHCI_SPRD_DLL_INIT_COUNT   0xc00
> >  #define  SDHCI_SPRD_DLL_PHASE_INTERNAL       0x3
> >
> > +#define SDHCI_SPRD_REG_32_DLL_DLY    0x204
> > +
> >  #define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET     0x208
> >  #define  SDHCIBSPRD_IT_WR_DLY_INV            BIT(5)
> >  #define  SDHCI_SPRD_BIT_CMD_DLY_INV          BIT(13)
> > @@ -72,6 +74,24 @@ struct sdhci_sprd_host {
> >       struct clk *clk_2x_enable;
> >       u32 base_rate;
> >       int flags; /* backup of host attribute */
> > +     u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
> > +};
> > +
> > +struct sdhci_sprd_phy_cfg {
> > +     const char *property;
> > +     u8 timing;
> > +};
> > +
> > +static const struct sdhci_sprd_phy_cfg sdhci_sprd_phy_cfgs[] = {
> > +     { "sprd,phy-delay-legacy", MMC_TIMING_LEGACY, },
> > +     { "sprd,phy-delay-sd-highspeed", MMC_TIMING_MMC_HS, },
>
> Did you mean MMC_TIMING_SD_HS

Ah, yes, my copy mistake and will fix it in next version.
Thanks for your reviewing and comments.

-- 
Baolin Wang
Best Regards
