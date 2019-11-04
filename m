Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B822FCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FC920848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfKDQWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:22:01 -0500
Received: from david.siemens.de ([192.35.17.14]:47346 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfKDQWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:22:01 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id xA4GLSU1016106
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Nov 2019 17:21:29 +0100
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xA4GKI3G003009;
        Mon, 4 Nov 2019 17:20:18 +0100
Subject: Re: [PATCH v2] platform/x86: pmc_atom: Add Siemens SIMATIC IPC227E to
 critclk_systems DMI table
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Henning Schild <henning.schild@siemens.com>
References: <c090302a-da38-5764-2a84-399ed6b333f5@siemens.com>
Message-ID: <16119dad-9597-ecdc-a0e7-e386030659ce@siemens.com>
Date:   Mon, 4 Nov 2019 17:20:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c090302a-da38-5764-2a84-399ed6b333f5@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.19 08:42, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The SIMATIC IPC227E uses the PMC clock for on-board components and gets
> stuck during boot if the clock is disabled. Therefore, add this device
> to the critical systems list.
> 
> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - fixed cut-off subject line (local tooling bug...)
> 
> Should go into stable as well, down to 4.19.

This one is in 5.4-rc now (as ad0d315b4d4e). Is it also queued somewhere
for stable kernels? IIRC, it's generally the privilege of the subsystem
maintainer to propose formally to stable.

I've received reports from users down at 4.14 with the need for it (4.9
is unaffected). And the same applies to f110d252ae79 ("platform/x86:
pmc_atom: Add Siemens SIMATIC IPC277E to critclk_systems DMI table").

TIA!
Jan

> 
>  drivers/platform/x86/pmc_atom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index aa53648a2214..9aca5e7ce6d0 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -415,6 +415,13 @@ static const struct dmi_system_id critclk_systems[] = {
>  			DMI_MATCH(DMI_BOARD_NAME, "CB6363"),
>  		},
>  	},
> +	{
> +		.ident = "SIMATIC IPC227E",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "6ES7647-8B"),
> +		},
> +	},
>  	{ /*sentinel*/ }
>  };
>  
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
