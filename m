Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682ADC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4018B207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbfISH4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:56:38 -0400
Received: from david.siemens.de ([192.35.17.14]:51090 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbfISH4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:56:38 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x8J7uAXm003815
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 09:56:11 +0200
Received: from [167.87.3.151] ([167.87.3.151])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x8J7u9wC019552;
        Thu, 19 Sep 2019 09:56:09 +0200
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Siemens SIMATIC IPC2x7E to
 critclk_systems DMI table
To:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        dvhart@infradead.org, andy@infradead.org
Cc:     Cedric_Hombourger@mentor.com, Srikanth_Krishnakar@mentor.com
References: <20190919074556.25691-1-Srikanth_Krishnakar@mentor.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0e511b90-314d-1724-a046-d2efe26b3b96@siemens.com>
Date:   Thu, 19 Sep 2019 09:56:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919074556.25691-1-Srikanth_Krishnakar@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.19 09:45, Srikanth Krishnakar wrote:
> The SIMATIC IPC227E and IPC277E uses the PMC clock for on-board components
> and gets stuck during boot if the clock is disabled. Therefore, add this
> device to the critical systems list.
> 
> The Board revision does vary in some instances and hence use PRODUCT_NAME
> to allow the boards to boot with identical names.
> 
> Tested on SIMATIC IPC227E and IPC277E.
> 
> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> CC: Jan Kiszka <jan.kiszka@siemens.com>
> CC: Cedric Hombourger <Cedric_Hombourger@mentor.com>
> Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
> ---
>   drivers/platform/x86/pmc_atom.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index 9aca5e7ce6d0..1e48c2ec684e 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -419,7 +419,14 @@ static const struct dmi_system_id critclk_systems[] = {
>   		.ident = "SIMATIC IPC227E",
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "6ES7647-8B"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "SIMATIC IPC227E"),

NACK, this is breaking platform variant detection.

> +		},
> +	},
> +	{
> +		.ident = "SIMATIC IPC277E",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "SIMATIC IPC277E"),

Let us clarify internally if we need to match on the same substring length as 
for the 227E.

Jan

>   		},
>   	},
>   	{ /*sentinel*/ }
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
