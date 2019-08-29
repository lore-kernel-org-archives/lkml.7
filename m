Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BC6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C18215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfH2NPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:15:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:40675 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfH2NPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:15:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="197803586"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 06:15:48 -0700
Subject: Re: [PATCH 3/3] mmc: sdhci-cadence: override spec version
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Piotr Sroka <piotrs@cadence.com>, linux-kernel@vger.kernel.org
References: <20190829104928.27404-1-yamada.masahiro@socionext.com>
 <20190829104928.27404-3-yamada.masahiro@socionext.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8c0d5889-6850-077f-4928-5e4b7f115b4f@intel.com>
Date:   Thu, 29 Aug 2019 16:14:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829104928.27404-3-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/19 1:49 PM, Masahiro Yamada wrote:
> The datasheet of the IP (sd4hc) says it is compiatible with SDHCI v4,
> but the spec version field in the version register is read as 2
> (i.e. SDHCI_SPEC_300) based on the RTL provided by Cadence.
> 
> Socionext did not fix it up when it integrated the IP into the SoCs.
> So, it is working as SDHCI v3.
> 
> It is not a real problem because there is no difference in the program
> flow in sdhci.c between SDHCI_SPEC_300/400, but set the real version
> just in case.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-cadence.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 44139fceac24..9837214685b6 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -341,6 +341,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	unsigned int nr_phy_params;
>  	int ret;
>  	struct device *dev = &pdev->dev;
> +	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
>  
>  	clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(clk))
> @@ -370,6 +371,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;
>  	sdhci_enable_v4_mode(host);
> +	__sdhci_read_caps(host, &version, NULL, NULL);
>  
>  	sdhci_get_of_property(pdev);
>  
> 

