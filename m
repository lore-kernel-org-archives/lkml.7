Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550CEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F38233A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UY15Vp+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfIDJxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:53:47 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38873 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfIDJxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:53:46 -0400
Received: by mail-vk1-f196.google.com with SMTP id s72so2970551vkh.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXct7pWEfvwoWcItL0c45zsZ+8/Vb/ULgMjysfBFLqA=;
        b=UY15Vp+CxA0igqyci/uHkEwCvFmoljRXILYCYNV19VXmKLSKPoMmO1ogwQbSKYc1uH
         moFOCM9MDQsbXZbePVk+RPgLhRBfsD+H9f+2utqBfPv4oV3JcovLreEVpaW5rfVYdec3
         fooql/yU8T0IWCCfPjfe3fuPvYBnU6WCd6yRa4GtsAXLjCV2VFy3h3UKvCpkk+I8P808
         b6+1oueuOqOs6WLMEhe3VvtwjmcA6y6xTfU3vLbBeTz17wfFslFuNVpiyjEUjmvD9HPj
         nZgA9SaCgVVm1SOkoRRGT7vUMSN+S44nTgtGG0jM4yKZuWTkwfKfYFD7P348zOpbBgGX
         mktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXct7pWEfvwoWcItL0c45zsZ+8/Vb/ULgMjysfBFLqA=;
        b=XqcFgUAOMA7fFDhoprqvIs3KcBMbqCdk1fvNxK2l7QgTSBJPh28aFY5RbcYvJmVx3c
         adygiZBccJmcmnpNp9x+SB38Y5yJiaNpvj7esT5ig047Otdl23GC+SjLxCbJbVBWSWvt
         /BCL06xauhp7m+KRvyVzSyMMHCCb2Y3bgrexBjlO2w+x76j3/ZSCc/wvshEdcz+rExU7
         mb2ZaSP+xFo1B3YH3YhZyZo2S7W1POmQ1ibVxGvvqrtkvEWIFDiC0b7yFADhA7dY7mJM
         8HPfiB21QodlQ8BY699TFA7d4rX2a+st/NQ0qobHtNHgkqIYYnLou7vk9gSunPdGZpSK
         pD6w==
X-Gm-Message-State: APjAAAVwFPRMBwhiGAzqtonHDzhi9feoj8RRVJIQUl92nh1SR4yJxLOi
        Kxi3YQ68Nv6jcw9HRKFzL+wx/9sHnkcIrj1JJurxjQ==
X-Google-Smtp-Source: APXvYqw9E6CAf3iFxxXDlyKZh4dV3RoV3LnaH2kQBenOCdTbAa8OoBif++hdQwEzx3GSnW15rFWFksDMuxtjE05Jwa8=
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr2603374vkb.4.1567590825172;
 Wed, 04 Sep 2019 02:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <1566412784-6224-1-git-send-email-shirley.her@bayhubtech.com>
In-Reply-To: <1566412784-6224-1-git-send-email-shirley.her@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Sep 2019 11:53:07 +0200
Message-ID: <CAPDyKFqfX70JD1FXYU1B7diyD6qAAkPXtOxZJ+-LhpZ-XU+zsA@mail.gmail.com>
Subject: Re: [PATCH V8 3/3] mmc: sdhci-pci-o2micro: Fix O2 Host data
 read/write DLL Lock phase shift issue
To:     "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019 at 20:39, Shirley Her (SC)
<shirley.her@bayhubtech.com> wrote:
>
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift
>
> Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> change in V8:
>  1. fix patch format error
>
> change in V7:
>  1. change subject
>  2. change the sdhci_o2_wait_dll_detect_lock_function
>  3. add suitable usleep_range() to detect dll lock status
>
> change in V6:
>  1. define constant by using array size
>  2. add more explanation for the code
>  3. fix loop forever code error
>
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
>  drivers/mmc/host/sdhci-pci-o2micro.c | 124 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 57c8b83..d879d91 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -11,6 +11,7 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>
>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
> @@ -55,9 +56,18 @@
>  #define  O2_PLL_FORCE_ACTIVE   BIT(18)
>  #define  O2_PLL_LOCK_STATUS    BIT(14)
>  #define  O2_PLL_SOFT_RESET     BIT(12)
> +#define  O2_DLL_LOCK_STATUS    BIT(11)
>
>  #define O2_SD_DETECT_SETTING 0x324
>
> +static const u32 dmdn_table[] = {0x2B1C0000,
> +       0x2C1A0000, 0x371B0000, 0x35100000};
> +#define DMDN_SZ ARRAY_SIZE(dmdn_table)
> +
> +struct o2_host {
> +       u8 dll_adjust_count;
> +};
> +
>  static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
>  {
>         ktime_t timeout;
> @@ -133,7 +143,8 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
>
> -       sdhci_o2_enable_internal_clock(host);
> +       if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
> +               sdhci_o2_enable_internal_clock(host);
>
>         return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
>  }
> @@ -152,6 +163,25 @@ static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>                                O2_SD_PLL_SETTING, scratch_32);
>  }
>
> +static u32 sdhci_o2_pll_dll_wdt_control(struct sdhci_host *host)
> +{
> +       return sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +}
> +
> +/*
> + * This function is used to detect dll lock status.
> + * Since the dll lock status bit will toggle randomly
> + * with very short interval which needs to be polled
> + * as fast as possible. Set sleep_us as 1 microsecond.
> + */
> +static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
> +{
> +       u32     scratch32 = 0;
> +
> +       return readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
> +               scratch32, !(scratch32 & O2_DLL_LOCK_STATUS), 1, 1000000);
> +}
> +
>  static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
>  {
>         u16 reg;
> @@ -189,6 +219,83 @@ static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
>         sdhci_reset_tuning(host);
>  }
>
> +/*
> + * This function is used to fix o2 dll shift issue.
> + * It isn't necessary to detect card present before recovery.
> + * Firstly, it is used by bht emmc card, which is embedded.
> + * Second, before call recovery card present will be detected
> + * outside of the execute tuning function.
> + */
> +static int sdhci_o2_dll_recovery(struct sdhci_host *host)
> +{
> +       int ret = 0;
> +       u8 scratch_8 = 0;
> +       u32 scratch_32 = 0;
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct sdhci_pci_chip *chip = slot->chip;
> +       struct o2_host *o2_host = sdhci_pci_priv(slot);
> +
> +       /* UnLock WP */
> +       pci_read_config_byte(chip->pdev,
> +                       O2_SD_LOCK_WP, &scratch_8);
> +       scratch_8 &= 0x7f;
> +       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +       while (o2_host->dll_adjust_count < DMDN_SZ && !ret) {
> +               /* Disable clock */
> +               sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +               /* PLL software reset */
> +               scratch_32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +               scratch_32 |= O2_PLL_SOFT_RESET;
> +               sdhci_writel(host, scratch_32, O2_PLL_DLL_WDT_CONTROL1);
> +
> +               pci_read_config_dword(chip->pdev,
> +                                           O2_SD_FUNC_REG4,
> +                                           &scratch_32);
> +               /* Enable Base Clk setting change */
> +               scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
> +               pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG4, scratch_32);
> +               o2_pci_set_baseclk(chip, dmdn_table[o2_host->dll_adjust_count]);
> +
> +               /* Enable internal clock */
> +               scratch_8 = SDHCI_CLOCK_INT_EN;
> +               sdhci_writeb(host, scratch_8, SDHCI_CLOCK_CONTROL);
> +
> +               if (sdhci_o2_get_cd(host->mmc)) {
> +                       /*
> +                        * need wait at least 5ms for dll status stable,
> +                        * after enable internal clock
> +                        */
> +                       usleep_range(5000, 6000);
> +                       if (sdhci_o2_wait_dll_detect_lock(host)) {
> +                               scratch_8 |= SDHCI_CLOCK_CARD_EN;
> +                               sdhci_writeb(host, scratch_8,
> +                                       SDHCI_CLOCK_CONTROL);
> +                               ret = 1;
> +                       } else {
> +                               pr_warn("%s: DLL unlocked when dll_adjust_count is %d.\n",
> +                                       mmc_hostname(host->mmc),
> +                                       o2_host->dll_adjust_count);
> +                       }
> +               } else {
> +                       pr_err("%s: card present detect failed.\n",
> +                               mmc_hostname(host->mmc));
> +                       break;
> +               }
> +
> +               o2_host->dll_adjust_count++;
> +       }
> +       if (!ret && o2_host->dll_adjust_count == DMDN_SZ)
> +               pr_err("%s: DLL adjust over max times\n",
> +               mmc_hostname(host->mmc));
> +       /* Lock WP */
> +       pci_read_config_byte(chip->pdev,
> +                                  O2_SD_LOCK_WP, &scratch_8);
> +       scratch_8 |= 0x80;
> +       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +       return ret;
> +}
> +
>  static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> @@ -203,7 +310,16 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
>                 return -EINVAL;
> -
> +       /*
> +        * Judge the tuning reason, whether caused by dll shift
> +        * If cause by dll shift, should call sdhci_o2_dll_recovery
> +        */
> +       if (!sdhci_o2_wait_dll_detect_lock(host))
> +               if (!sdhci_o2_dll_recovery(host)) {
> +                       pr_err("%s: o2 dll recovery failed\n",
> +                               mmc_hostname(host->mmc));
> +                       return -EINVAL;
> +               }
>         /*
>          * o2 sdhci host didn't support 8bit emmc tuning
>          */
> @@ -371,6 +487,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>         clk |= SDHCI_CLOCK_INT_EN;
>         sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>
> +       sdhci_o2_enable_internal_clock(host);
>         if (sdhci_o2_get_cd(host->mmc)) {
>                 clk |= SDHCI_CLOCK_CARD_EN;
>                 sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> @@ -396,12 +513,14 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_pci_chip *chip;
>         struct sdhci_host *host;
> +       struct o2_host *o2_host = sdhci_pci_priv(slot);
>         u32 reg, caps;
>         int ret;
>
>         chip = slot->chip;
>         host = slot->host;
>
> +       o2_host->dll_adjust_count = 0;
>         caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>
>         /*
> @@ -688,4 +807,5 @@ const struct sdhci_pci_fixes sdhci_o2 = {
>         .resume = sdhci_pci_o2_resume,
>  #endif
>         .ops = &sdhci_pci_o2_ops,
> +       .priv_size = sizeof(struct o2_host),
>  };
> --
> 2.7.4
>
