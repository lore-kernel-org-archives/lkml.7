Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A69C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA0E218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfDPIdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:33:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:8323 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfDPIdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:33:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 01:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="134742678"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga008.jf.intel.com with ESMTP; 16 Apr 2019 01:33:20 -0700
Subject: Re: [RFC] mmc: cqhci: clear pending interrupt and halt
To:     Peng Fan <peng.fan@nxp.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        BOUGH CHEN <haibo.chen@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
References: <DB7PR04MB44904965E8F1BF09A5C150B288240@DB7PR04MB4490.eurprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <83ba5bb2-2d59-1f67-b1a1-cb5e20985a1f@intel.com>
Date:   Tue, 16 Apr 2019 11:32:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB44904965E8F1BF09A5C150B288240@DB7PR04MB4490.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/19 10:27 AM, Peng Fan wrote:
> Hi Adrian,
> 
>>
>> On 16/04/19 9:48 AM, Peng Fan wrote:
>>> On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
>>> as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
>>> the 1st linux configure power/clock for the 2nd Linux.
>>>
>>> When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
>>> to destroy the 2nd linux, then restart the 1st linux, we met SDHCI
>>> dump as following, after we clear the pending interrupt and halt
>>> CQCTL, issue gone.
>>
>> I think it is better if the vendor driver does any necessary resets before
>> initialization.
> 
> In drivers/mmc/host/sdhci-esdhc-imx.c, there is a call to cqhci_init
> " 1525                 err = cqhci_init(cq_host, host->mmc, false);"
> 
> You mean I put the following piece code into sdhci-esdhc-imx.c?
> 
> "
>      status = cqhci_readl(cq_host, CQHCI_IS);
>      cqhci_writel(cq_host, status, CQHCI_IS);
>      cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
> "
> 
> How about the following patch?
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b8e11a77e274..f2e46ddf9695 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1435,6 +1435,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         struct cqhci_host *cq_host;
>         int err;
>         struct pltfm_imx_data *imx_data;
> +       u32 status;
> 
>         host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata,
>                                 sizeof(*imx_data));
> @@ -1542,6 +1543,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 err = cqhci_init(cq_host, host->mmc, false);
>                 if (err)
>                         goto disable_ahb_clk;
> +
> +               status = cqhci_readl(cq_host, CQHCI_IS);
> +               cqhci_writel(cq_host, status, CQHCI_IS);
> +               cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
> +
>         }
> 

It would be nicer to:
1. Define how CQHCI gets reset.  For example, with our controllers
SDHCI_RESET_ALL also resets CQHCI.
2. Define when CQHCI should be reset. e.g. using the ->reset() host op for
example.
3. Implement a patch that meets those requirements.
