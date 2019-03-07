Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B522083D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rBpD/N4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCGN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:28:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55000 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:28:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x27DRK3T075086;
        Thu, 7 Mar 2019 07:27:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551965240;
        bh=2jl26NXa78vK8repAdr5u7ONZqf+vRcUXL0n0GIDhkk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rBpD/N4ms227SSC7y92uPvR5yjX+HcTJv0l8MBtaP0ZWHlwvmXZVIqkkXhV6yfdqy
         iOEKCPX1l0kHzd5b4rScqu3SmAIOIRmUG2ewMh2+xopeTFSL6BRUqVQv4tW34iwxIv
         YDrj6WgV0QHhgWTd1O2X1o/wp7mQh1oShsANpVFY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x27DRKka059985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Mar 2019 07:27:20 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Mar 2019 07:27:20 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Mar 2019 07:27:20 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x27DRHre023498;
        Thu, 7 Mar 2019 07:27:17 -0600
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tony Lindgren <tony@atomide.com>,
        Kees Cook <keescook@chromium.org>,
        Vishal Thanki <vishalthanki@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20190307101145.636705-1-arnd@arndb.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <5674adc4-b4ee-36b0-3beb-812b75485f66@ti.com>
Date:   Thu, 7 Mar 2019 15:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190307101145.636705-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2019 12.11, Arnd Bergmann wrote:
> Building with clang shows a variable that is only used by the
> suspend/resume functions but defined outside of their #ifdef block:
> 
> sound/soc/ti/davinci-mcasp.c:48:12: error: variable 'context_regs' is not needed and will not be emitted
> 
> We commonly fix these by marking the PM functions as __maybe_unused,
> but here that would grow the davinci_mcasp structure, so instead
> add another #ifdef here.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Fixes: 1cc0c054f380 ("ASoC: davinci-mcasp: Convert the context save/restore to use array")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/ti/davinci-mcasp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index a3a67a8f0f54..9fbc759fdefe 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -45,6 +45,7 @@
>  
>  #define MCASP_MAX_AFIFO_DEPTH	64
>  
> +#ifdef CONFIG_PM
>  static u32 context_regs[] = {
>  	DAVINCI_MCASP_TXFMCTL_REG,
>  	DAVINCI_MCASP_RXFMCTL_REG,
> @@ -68,6 +69,7 @@ struct davinci_mcasp_context {
>  	u32	*xrsr_regs; /* for serializer configuration */
>  	bool	pm_state;
>  };
> +#endif
>  
>  struct davinci_mcasp_ruledata {
>  	struct davinci_mcasp *mcasp;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
