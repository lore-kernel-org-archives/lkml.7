Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A72C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADF3217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJdzIHsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKKo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:44:57 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34072 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfDKKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:44:56 -0400
Received: by mail-vk1-f196.google.com with SMTP id x84so1264364vkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmbYNwk/BToueVkk6zjjfn9Lg174Qghxz1ndPR67zNY=;
        b=MJdzIHslHpYaLGPKynjtFcMkkgfFOL+bMGBe/FQg2xuQ83BatywX16rFi4pAv6vZa8
         NzAIZwSvd6uX4edDQcn5meZKQKfbwtg+/qaNU3HVVKsf/YtPnYLFsUjWQMmpyADTg7yC
         5TcOjLwHkn6Yfdr8/ilbfOjShzyvVWJquAjEPp1OrB4GhCNswQ279EiF3xH554twby/3
         5+Go417pZSRkw9FWK0vdfTEsAYjcohQKV4Ej5g3Vc3ZoyG/D3Ykq+CfyR3n9nwlddhQN
         OKHLixRHoR1rpARbV6R6EULPkd5SFaG7vfLqP8iBpQrMJyJL51xRWHPUvUpcaLksiSKO
         dA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmbYNwk/BToueVkk6zjjfn9Lg174Qghxz1ndPR67zNY=;
        b=Vf3ALqb+H3grV5TTWCSzJGAbzP54mv9RVLvjlAowDGDEu8OrJBGHyQhQycunlhkjn5
         YK7PyWrlTVltkxWiMUhYwwUIPpZOVDDN8OHNahLtgsvhMEpf9p4Tk74tBLvhVBH0cElF
         8SZq7+PL9QEIZd/FqsSgPVimCVmGyNUFZw34kUn6xbZkc9VUPyhFQcb7LbDBWLmPP3EW
         G2IiViltXHLkDiAzm9BeUkHwJ2hUMHZQd/wESMM37tHPpKEDIr53XsB5RkJHhn8zL96u
         kHOJAGUs1A7ZR/Hkp9OK1KVNnRM/KzS2yFPGN7zoK2SNs7xOnQmxU6VWsR6OzQ7o+zI5
         +JRw==
X-Gm-Message-State: APjAAAV2TCqd8V7LBdkncb8iZUltRqnchQJ/AvY8aAtx5XqS02Lod/eo
        d2Q6U3OFOVw2vtkCoHfRAAMagyzBzcb/pHYJM7r1himG
X-Google-Smtp-Source: APXvYqx6AJCGzTxaBIQanjFPqbdWOaHHLZZn041wZxxuyz2FYf/n4rGwQ4BAY7xrxSGKvJQOx5kz/cD78JmXnpbDkO4=
X-Received: by 2002:a1f:8f0d:: with SMTP id r13mr26374081vkd.63.1554979495686;
 Thu, 11 Apr 2019 03:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190411085937.633-1-faiz_abbas@ti.com>
In-Reply-To: <20190411085937.633-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 12:44:19 +0200
Message-ID: <CAPDyKFpbNNX8=w1xKZNFhaxkRWTsY58tsQ+NEw_nZqVe0+fPig@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci-omap: Don't finish_mrq() on a command error
 during tuning
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>, Kishon <kishon@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 11:00, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
> callback") skips data resets during tuning operation. Because of this,
> a data error or data finish interrupt might still arrive after a command
> error has been handled and the mrq ended. This ends up with a "mmc0: Got
> data interrupt 0x00000002 even though no data operation was in progress"
> error message.
>
> Fix this by adding a platform specific callback for sdhci_irq. Mark the
> mrq as a failure but wait for a data interrupt instead of calling
> finish_mrq().
>
> Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
> callback")
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>
> Tested with 100 times boot tests on dra71x-evm, dra72x-evm and
> dra7xx-evm.
>
> v6:
> Changed return value to u32 to fix the build warning.
>
> v5:
> Drop patch 1 and replace call to sdhci_finish_command() with
> host->cmd = NULL
>
> v4:
> Fixed commit description for patch 1.
> Added SDHCI_INT_TIMEOUT to CMD_ERR_MASK in patch 2.
>
> v3:
> Removed the command error specific callback and using the already
> existing sdhci_irq callback instead. No measurable drop in performance.
>
> v2:
> Added EXPORT_SYMBOL_GPL for sdhci_cmd_err and sdhci_send_command to fix
> errors when built as module.
>
>  drivers/mmc/host/sdhci-omap.c | 38 +++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 5bbed477c9b1..9f20fff9781b 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -797,6 +797,43 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>         sdhci_reset(host, mask);
>  }
>
> +#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX |\
> +                     SDHCI_INT_TIMEOUT)
> +#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
> +
> +static u32 sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (omap_host->is_tuning && host->cmd && !host->data_early &&
> +           (intmask & CMD_ERR_MASK)) {
> +
> +               /*
> +                * Since we are not resetting data lines during tuning
> +                * operation, data error or data complete interrupts
> +                * might still arrive. Mark this request as a failure
> +                * but still wait for the data interrupt
> +                */
> +               if (intmask & SDHCI_INT_TIMEOUT)
> +                       host->cmd->error = -ETIMEDOUT;
> +               else
> +                       host->cmd->error = -EILSEQ;
> +
> +               host->cmd = NULL;
> +
> +               /*
> +                * Sometimes command error interrupts and command complete
> +                * interrupt will arrive together. Clear all command related
> +                * interrupts here.
> +                */
> +               sdhci_writel(host, intmask & CMD_MASK, SDHCI_INT_STATUS);
> +               intmask &= ~CMD_MASK;
> +       }
> +
> +       return intmask;
> +}
> +
>  static struct sdhci_ops sdhci_omap_ops = {
>         .set_clock = sdhci_omap_set_clock,
>         .set_power = sdhci_omap_set_power,
> @@ -807,6 +844,7 @@ static struct sdhci_ops sdhci_omap_ops = {
>         .platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
>         .reset = sdhci_omap_reset,
>         .set_uhs_signaling = sdhci_omap_set_uhs_signaling,
> +       .irq = sdhci_omap_irq,
>  };
>
>  static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
> --
> 2.19.2
>
