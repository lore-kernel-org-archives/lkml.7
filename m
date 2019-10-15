Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0377ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27B02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfJOQ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:29:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:27855 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfJOQ3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:29:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 09:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="189396563"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.148.102]) ([10.249.148.102])
  by orsmga008.jf.intel.com with ESMTP; 15 Oct 2019 09:29:33 -0700
Subject: Re: [PATCH] PNP: fix unintended sign extension on left shifts
To:     Colin King <colin.king@canonical.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191014131608.31335-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <cda044bf-4aec-4423-007c-1d6cf6f0eecf@intel.com>
Date:   Tue, 15 Oct 2019 18:29:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014131608.31335-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2019 3:16 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Shifting a u8 left will cause the value to be promoted to an integer. If
> the top bit of the u8 is set then the following conversion to a 64 bit
> resource_size_t will sign extend the value causing the upper 32 bits
> to be set in the result.
>
> Fix this by casting the u8 value to a resource_size_t before the shift.
> Original commit is pre-git history.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Please resend this with a Cc to linux-acpi@vger.kernel.org for easier 
handling.


> ---
>   drivers/pnp/isapnp/core.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> index 179b737280e1..c947b1673041 100644
> --- a/drivers/pnp/isapnp/core.c
> +++ b/drivers/pnp/isapnp/core.c
> @@ -511,10 +511,14 @@ static void __init isapnp_parse_mem32_resource(struct pnp_dev *dev,
>   	unsigned char flags;
>   
>   	isapnp_peek(tmp, size);
> -	min = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
> -	max = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
> -	align = (tmp[12] << 24) | (tmp[11] << 16) | (tmp[10] << 8) | tmp[9];
> -	len = (tmp[16] << 24) | (tmp[15] << 16) | (tmp[14] << 8) | tmp[13];
> +	min = ((resource_size_t)tmp[4] << 24) | (tmp[3] << 16) |
> +              (tmp[2] << 8) | tmp[1];
> +	max = ((resource_size_t)tmp[8] << 24) | (tmp[7] << 16) |
> +              (tmp[6] << 8) | tmp[5];
> +	align = ((resource_size_t)tmp[12] << 24) | (tmp[11] << 16) |
> +              (tmp[10] << 8) | tmp[9];
> +	len = ((resource_size_t)tmp[16] << 24) | (tmp[15] << 16) |
> +              (tmp[14] << 8) | tmp[13];
>   	flags = tmp[0];
>   	pnp_register_mem_resource(dev, option_flags,
>   				  min, max, align, len, flags);
> @@ -532,8 +536,10 @@ static void __init isapnp_parse_fixed_mem32_resource(struct pnp_dev *dev,
>   	unsigned char flags;
>   
>   	isapnp_peek(tmp, size);
> -	base = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
> -	len = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
> +	base = ((resource_size_t)tmp[4] << 24) | (tmp[3] << 16) |
> +	       (tmp[2] << 8) | tmp[1];
> +	len = ((resource_size_t)tmp[8] << 24) | (tmp[7] << 16) |
> +              (tmp[6] << 8) | tmp[5];
>   	flags = tmp[0];
>   	pnp_register_mem_resource(dev, option_flags, base, base, 0, len, flags);
>   }


