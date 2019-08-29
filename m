Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70009C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DD920828
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfH2NKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:10:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:11999 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfH2NKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:10:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:10:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="197802055"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 06:10:38 -0700
Subject: Re: [PATCH 2/3] mmc: sdhci: constify references of parameters to
 __sdhci_read_caps()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Piotr Sroka <piotrs@cadence.com>, linux-kernel@vger.kernel.org
References: <20190829104928.27404-1-yamada.masahiro@socionext.com>
 <20190829104928.27404-2-yamada.masahiro@socionext.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a3500d7d-8b53-da7c-c279-799152cc2240@intel.com>
Date:   Thu, 29 Aug 2019 16:09:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829104928.27404-2-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/19 1:49 PM, Masahiro Yamada wrote:
> __sdhci_read_caps() does not modify *ver, *caps, or *caps1.
> 
> Probably, the caller of this function will want to constifythe
> parameters passed in.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a5dc5aae973e..08cc0792c174 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3565,7 +3565,8 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
>  	return ret;
>  }
>  
> -void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
> +void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
> +		       const u32 *caps, const u32 *caps1)
>  {
>  	u16 v;
>  	u64 dt_caps_mask = 0;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 902f855efe8f..81e23784475a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -738,8 +738,8 @@ static inline void *sdhci_priv(struct sdhci_host *host)
>  }
>  
>  void sdhci_card_detect(struct sdhci_host *host);
> -void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps,
> -		       u32 *caps1);
> +void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
> +		       const u32 *caps, const u32 *caps1);
>  int sdhci_setup_host(struct sdhci_host *host);
>  void sdhci_cleanup_host(struct sdhci_host *host);
>  int __sdhci_add_host(struct sdhci_host *host);
> 

