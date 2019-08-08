Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6743AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3714D217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfHHHNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:13:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:36823 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730887AbfHHHNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:13:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 00:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="182512932"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2019 00:13:20 -0700
Subject: Re: [PATCH V5 2/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>
References: <1565212190-31562-1-git-send-email-shirley.her@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3135c16e-efe5-6937-28c5-b4f8f5f0b456@intel.com>
Date:   Thu, 8 Aug 2019 10:12:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565212190-31562-1-git-send-email-shirley.her@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/08/19 12:09 AM, Shirley Her (SC) wrote:
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift

Please change the patch subject and commit message to match what the patch
actually does.

> 
> Signed-off-by:Shirley Her <shirley.her@bayhubtech.com>
> ---
> change in V5:
>  1. split 2 patches into 3 patches
>  2. make dll_adjust_count start from 0
>  3. fix ret overwritten issue
>  4. use break instead of goto
> 
> change in V4:
>  1. add a bug fix for V3
> 
> change in V3:
>  1. add more explanation in dll_recovery and execute_tuning function
>  2. move dll_adjust_count to O2_host struct
>  3. fix some coding style error
>  4. renaming O2_PLL_WDT_CONTROL1 TO O2_PLL_DLL_WDT_CONTROL1
> 
> change in V2:
>  1. use usleep_range instead of udelay
>  2. move dll_adjust_count to sdhci-pci-o2micro.c
> 
> chagne in V1:
>  1. add error recovery function to relock DLL with correct phase
>  2. retuning HS200 after DLL locked
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 188 ++++++++++++++++++-----------------
>  1 file changed, 95 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index b3a33d9..c780888 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -58,6 +58,101 @@
>  
>  #define O2_SD_DETECT_SETTING 0x324
>  
> +static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u32 scratch32;
> +
> +	/* Wait max 50 ms */
> +	timeout = ktime_add_ms(ktime_get(), 50);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch32 = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
> +		    == (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
> +			break;
> +
> +		if (timedout) {
> +			pr_err("%s: Card Detect debounce never finished.\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		udelay(10);
> +	}
> +}
> +
> +static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u16 scratch;
> +	u32 scratch32;
> +
> +	/* PLL software reset */
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	scratch32 |= O2_PLL_SOFT_RESET;
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +	udelay(1);
> +	scratch32 &= ~(O2_PLL_SOFT_RESET);
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +	/* PLL force active */
> +	scratch32 |= O2_PLL_FORCE_ACTIVE;
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +	/* Wait max 20 ms */
> +	timeout = ktime_add_ms(ktime_get(), 20);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
> +		if (scratch & O2_PLL_LOCK_STATUS)
> +			break;
> +		if (timedout) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			goto out;
> +		}
> +		udelay(10);
> +	}
> +
> +	/* Wait for card detect finish */
> +	udelay(1);
> +	sdhci_o2_wait_card_detect_stable(host);
> +
> +out:
> +	/* Cancel PLL force active */
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> +	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> +}
> +
> +static int sdhci_o2_get_cd(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
> +		sdhci_o2_enable_internal_clock(host);
> +
> +	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> +}
> +
> +static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
> +{
> +	u32 scratch_32;
> +
> +	pci_read_config_dword(chip->pdev,
> +			      O2_SD_PLL_SETTING, &scratch_32);
> +
> +	scratch_32 &= 0x0000FFFF;
> +	scratch_32 |= value;
> +
> +	pci_write_config_dword(chip->pdev,
> +			       O2_SD_PLL_SETTING, scratch_32);
> +}
> +
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>  	u16 reg;
> @@ -136,19 +231,6 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	return 0;
>  }
>  
> -static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
> -{
> -	u32 scratch_32;
> -	pci_read_config_dword(chip->pdev,
> -			      O2_SD_PLL_SETTING, &scratch_32);
> -
> -	scratch_32 &= 0x0000FFFF;
> -	scratch_32 |= value;
> -
> -	pci_write_config_dword(chip->pdev,
> -			       O2_SD_PLL_SETTING, scratch_32);
> -}
> -
>  static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
>  {
>  	int ret;
> @@ -284,86 +366,6 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>  	host->irq = pci_irq_vector(chip->pdev, 0);
>  }
>  
> -static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
> -{
> -	ktime_t timeout;
> -	u32 scratch32;
> -
> -	/* Wait max 50 ms */
> -	timeout = ktime_add_ms(ktime_get(), 50);
> -	while (1) {
> -		bool timedout = ktime_after(ktime_get(), timeout);
> -
> -		scratch32 = sdhci_readl(host, SDHCI_PRESENT_STATE);
> -		if ((scratch32 & SDHCI_CARD_PRESENT) >> SDHCI_CARD_PRES_SHIFT
> -		    == (scratch32 & SDHCI_CD_LVL) >> SDHCI_CD_LVL_SHIFT)
> -			break;
> -
> -		if (timedout) {
> -			pr_err("%s: Card Detect debounce never finished.\n",
> -			       mmc_hostname(host->mmc));
> -			sdhci_dumpregs(host);
> -			return;
> -		}
> -		udelay(10);
> -	}
> -}
> -
> -static void sdhci_o2_enable_internal_clock(struct sdhci_host *host)
> -{
> -	ktime_t timeout;
> -	u16 scratch;
> -	u32 scratch32;
> -
> -	/* PLL software reset */
> -	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> -	scratch32 |= O2_PLL_SOFT_RESET;
> -	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -	udelay(1);
> -	scratch32 &= ~(O2_PLL_SOFT_RESET);
> -	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -
> -	/* PLL force active */
> -	scratch32 |= O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -
> -	/* Wait max 20 ms */
> -	timeout = ktime_add_ms(ktime_get(), 20);
> -	while (1) {
> -		bool timedout = ktime_after(ktime_get(), timeout);
> -
> -		scratch = sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1);
> -		if (scratch & O2_PLL_LOCK_STATUS)
> -			break;
> -		if (timedout) {
> -			pr_err("%s: Internal clock never stabilised.\n",
> -			       mmc_hostname(host->mmc));
> -			sdhci_dumpregs(host);
> -			goto out;
> -		}
> -		udelay(10);
> -	}
> -
> -	/* Wait for card detect finish */
> -	udelay(1);
> -	sdhci_o2_wait_card_detect_stable(host);
> -
> -out:
> -	/* Cancel PLL force active */
> -	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> -	scratch32 &= ~O2_PLL_FORCE_ACTIVE;
> -	sdhci_writel(host, scratch32, O2_PLL_DLL_WDT_CONTROL1);
> -}
> -
> -static int sdhci_o2_get_cd(struct mmc_host *mmc)
> -{
> -	struct sdhci_host *host = mmc_priv(mmc);
> -
> -	sdhci_o2_enable_internal_clock(host);
> -
> -	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
> -}
> -
>  static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>  {
>  	/* Enable internal clock */
> 

