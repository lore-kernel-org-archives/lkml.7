Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5662FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 13:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B492190F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 13:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfHaNgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 09:36:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:15641 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbfHaNgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 09:36:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2019 06:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,451,1559545200"; 
   d="scan'208";a="198242460"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 31 Aug 2019 06:36:17 -0700
Received: by lahna (sSMTP sendmail emulation); Sat, 31 Aug 2019 16:36:16 +0300
Date:   Sat, 31 Aug 2019 16:36:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: intel-spi: add support for Intel
 Cannon Lake SPI flash
Message-ID: <20190831133616.GQ3177@lahna.fi.intel.com>
References: <6cc18e41-82a6-942b-6d91-6297f73a33da@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc18e41-82a6-942b-6d91-6297f73a33da@fortanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jethro,

On Sat, Aug 31, 2019 at 05:50:34AM +0000, Jethro Beekman wrote:
> (apologies, resending without S/MIME signature)
> 
> Now that SPI flash controllers without a software sequencer are
> supported, it's trivial to add support for CNL and its PCI ID.
> 
> Signed-off-by: Jethro Beekman <jethro@fortanix.com>
> ---
>    drivers/mtd/spi-nor/intel-spi-pci.c     |  5 +++++
>    drivers/mtd/spi-nor/intel-spi.c         | 11 +++++++++++
>    include/linux/platform_data/intel-spi.h |  1 +
>    3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/intel-spi-pci.c 
> b/drivers/mtd/spi-nor/intel-spi-pci.c
> index b83c4ab6..195a09d 100644
> --- a/drivers/mtd/spi-nor/intel-spi-pci.c
> +++ b/drivers/mtd/spi-nor/intel-spi-pci.c
> @@ -20,6 +20,10 @@ static const struct intel_spi_boardinfo bxt_info = {
>    	.type = INTEL_SPI_BXT,
>    };
>    +static const struct intel_spi_boardinfo cnl_info = {

Looks like some white space damage. There are couple of similar below as
well.

> +	.type = INTEL_SPI_CNL,
> +};
> +
>    static int intel_spi_pci_probe(struct pci_dev *pdev,
>    			       const struct pci_device_id *id)
>    {
> @@ -67,6 +71,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
>    	{ PCI_VDEVICE(INTEL, 0x4b24), (unsigned long)&bxt_info },
>    	{ PCI_VDEVICE(INTEL, 0xa1a4), (unsigned long)&bxt_info },
>    	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
>    	{ },
>    };
>    MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
> diff --git a/drivers/mtd/spi-nor/intel-spi.c 
> b/drivers/mtd/spi-nor/intel-spi.c
> index 195cdca..91b7851 100644
> --- a/drivers/mtd/spi-nor/intel-spi.c
> +++ b/drivers/mtd/spi-nor/intel-spi.c
> @@ -108,6 +108,10 @@
>    #define BXT_FREG_NUM			12
>    #define BXT_PR_NUM			6
>    +#define CNL_PR				0x84

Here.

> +#define CNL_FREG_NUM			6
> +#define CNL_PR_NUM			5
> +
>    #define LVSCC				0xc4
>    #define UVSCC				0xc8
>    #define ERASE_OPCODE_SHIFT		8
> @@ -344,6 +348,13 @@ static int intel_spi_init(struct intel_spi *ispi)
>    		ispi->erase_64k = true;
>    		break;
>    +	case INTEL_SPI_CNL:

And here.

> +		ispi->sregs = NULL;
> +		ispi->pregs = ispi->base + CNL_PR;
> +		ispi->nregions = CNL_FREG_NUM;
> +		ispi->pr_num = CNL_PR_NUM;

Does CNL really have a different number of PR and FR regions than the
previous generations?

> +		break;
> +
>    	default:
>    		return -EINVAL;
>    	}
> diff --git a/include/linux/platform_data/intel-spi.h 
> b/include/linux/platform_data/intel-spi.h
> index ebb4f33..7f53a5c 100644
> --- a/include/linux/platform_data/intel-spi.h
> +++ b/include/linux/platform_data/intel-spi.h
> @@ -13,6 +13,7 @@ enum intel_spi_type {
>    	INTEL_SPI_BYT = 1,
>    	INTEL_SPI_LPT,
>    	INTEL_SPI_BXT,
> +	INTEL_SPI_CNL,
>    };
>     /**
> -- 
> 2.7.4
> 
> 
