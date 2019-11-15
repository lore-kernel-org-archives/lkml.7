Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C99C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C662073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="EKU8Yavv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKOM5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:57:47 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:39680 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbfKOM5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:57:46 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 26AEA411F8;
        Fri, 15 Nov 2019 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1573822664; x=1575637065; bh=QeijnkT3SOw/daHURBDhLCLSR
        5tzZMfBzaBd9ltBxX8=; b=EKU8YavvosEYSvUbEDPS9hiu7i23N/cqdGiI8hNWf
        zrE8b0EX5r50SWlPf9gj2FhnnQMGPCPsIoUgUoRFbLTScEcMZSM4itcjnbjvEZAU
        qwbAkyOEig6onc8OipQDA7DoLEFqtpB7BS4wLVKg4uks5df1/pY8ItdQXU2EN4n7
        As=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BDyr-ZM6IAI0; Fri, 15 Nov 2019 15:57:44 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 532F6411D9;
        Fri, 15 Nov 2019 15:57:41 +0300 (MSK)
Received: from localhost.localdomain (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 15 Nov 2019 15:57:41 +0300
Message-ID: <221381ebad0236625775bda5655fcd7c78455e6f.camel@yadro.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-aspeed: add inversion signal
 presence
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Date:   Fri, 15 Nov 2019 15:56:54 +0300
In-Reply-To: <d177ef37-643e-442d-d536-750e0bb5e86d@intel.com>
References: <20191114125435.27756-1-i.mikhaylov@yadro.com>
         <20191114125435.27756-3-i.mikhaylov@yadro.com>
         <fcb5f8b5-40b9-6497-b24d-0b73e2525949@intel.com>
         <b443738f5e2a3c7ba96b329a8347374f7f934483.camel@yadro.com>
         <d177ef37-643e-442d-d536-750e0bb5e86d@intel.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.15.69]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 09:20 +0200, Adrian Hunter wrote:
> On 14/11/19 7:19 PM, Ivan Mikhaylov wrote:
> > On Thu, 2019-11-14 at 15:10 +0200, Adrian Hunter wrote:
> > On 14/11/19 2:54 PM, Ivan Mikhaylov wrote:
> > > > Change the default .get_cd callback. Add inverted signal card detection
> > > > check.
> > > > 
> > > > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > > > 
> > > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c
> > > > b/drivers/mmc/host/sdhci-of-
> > > > aspeed.c
> > > > index 8962f6664381..186559ee8fcc 100644
> > > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > > > @@ -143,6 +143,19 @@ static inline int
> > > > aspeed_sdhci_calculate_slot(struct
> > > > aspeed_sdhci *dev,
> > > >  	return (delta / 0x100) - 1;
> > > >  }
> > > >  
> > > > +static int aspeed_get_cd(struct mmc_host *mmc)
> > > > +{
> > > > +	struct sdhci_host *host = mmc_priv(mmc);
> > > > +
> > > > +	int present = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
> > > > +			 & SDHCI_CARD_PRESENT);
> > > > +
> > > > +	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
> > > > +		present = !present;
> > > 
> > > Perhaps safer to flip the bit using CONFIG_MMC_SDHCI_IO_ACCESSORS and
> > > ->readl() callback
> 
> 
> > Sorry, don't quite understand what you're saying. You want to instantiate
> > '.read_l' callback instead of '.get_cd' in sdhci_ops and substitute the real
> > value?
> > 
> > res = readl(base, reg);
> > if (reg == SDHCI_PRESENT_STATE)
> > 	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
> > 		return !res;
> 
> Presumably just flip the SDHCI_CARD_PRESENT bit i.e.
> 
> 		return res ^ SDHCI_CARD_PRESENT;
> 
> > return res;
> > 
> > Something like this?
> 
> Yes
> 

Don't you think it will bring a little overhead on any sdhci_readl plus
sdhci_readl will not get the real value in case of inverted signal which seems
is not right from communication fairness between hw and sw? I took that approach
with .get_cd from variety of drivers in host/mmc but if you think it will be
better and safer with .read_l - I'll do that way. 

Sorry for the link in subject, didn't notice that I put it in previous message
somehow.

Thanks.

