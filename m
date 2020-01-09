Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA07C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF66206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dPz0K3KY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgAIFF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:05:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5380 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgAIFFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:05:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e16b4820000>; Wed, 08 Jan 2020 21:05:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Jan 2020 21:05:24 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 08 Jan 2020 21:05:24 -0800
Received: from [10.24.44.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jan
 2020 05:05:22 +0000
Subject: Re: [PATCH v2] regmap: add iopoll-like atomic polling macro
To:     <broonie@kernel.org>
CC:     <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1578546077-764-1-git-send-email-spujar@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <9dced231-0392-5ac2-d4a2-e176e8cebba5@nvidia.com>
Date:   Thu, 9 Jan 2020 10:35:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1578546077-764-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578546306; bh=9pxIGRcRpFz5U1sIQ7X+fvwdOF3ktVPzrYBjiWdP/dg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=dPz0K3KYgKwBBZmOvg95lnp1dNox43hJV8C7KclZOlOAbEoqSCA7qsJsvOSZQts89
         JHUeosGzW2WmSRuq+qStTB59JxN6zGUi/3E+HPLsNgINstsgxjV0D+4nnbVhffpJMh
         UO3hBwT9FnouIx4mo30OPf9OMPSVz4/e+/xzerWZ/ipOk+5h8+/T4S9xjbmApx+/7a
         jcjiloye7mQKCYA5QbG9VGPkGbAYrYAgq1GlJ492LXW7FRw/bprjQFshlgiXd+LI58
         234WUcLx6Fu416lnguI9aZVFe1DNxDGD/qMhwWPuucw2W2FJHirdmMvtrksex0NfZy
         oEcIXYIeJsFjA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/2020 10:31 AM, Sameer Pujar wrote:
> This patch adds a macro 'regmap_read_poll_timeout_atomic' that works
> similar to 'readx_poll_timeout_atomic' defined in linux/iopoll.h; This
> is atomic version of already available 'regmap_read_poll_timeout' macro.
>
> It should be noted that above atomic macro cannot be used by all regmaps.
> If the regmap is set up for atomic use (flat or no cache and MMIO) then
> only it can use.
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>   include/linux/regmap.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index dfe493a..aaf0ed1 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -119,6 +119,10 @@ struct reg_sequence {
>    * from atomic context if sleep_us or timeout_us are used.
>    *
>    * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
> + *
> + * Note: In general regmap cannot be used in atomic context. If you want to use
> + * this macro then first setup your regmap for atomic use (flat or no cache
> + * and MMIO regmap).

oops! Sorry!
Wrong place, will fix in next revision.

>    */
>   #define regmap_read_poll_timeout(map, addr, val, cond, sleep_us, timeout_us) \
>   ({ \
> @@ -145,6 +149,47 @@ struct reg_sequence {
>   })
>   
>   /**
> + * regmap_read_poll_timeout_atomic - Poll until a condition is met or a timeout occurs
> + *
> + * @map: Regmap to read from
> + * @addr: Address to poll
> + * @val: Unsigned integer variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @delay_us: Time to udelay between reads in us (0 tight-loops).
> + *            Should be less than ~10us since udelay is used
> + *            (see Documentation/timers/timers-howto.rst).
> + * @timeout_us: Timeout in us, 0 means never timeout
> + *
> + * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
> + * error return value in case of a error read. In the two former cases,
> + * the last read value at @addr is stored in @val.
> + *
> + * This is modelled after the readx_poll_timeout_atomic macros in linux/iopoll.h.
> + */
> +#define regmap_read_poll_timeout_atomic(map, addr, val, cond, delay_us, timeout_us) \
> +({ \
> +	u64 __timeout_us = (timeout_us); \
> +	unsigned long __delay_us = (delay_us); \
> +	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> +	int __ret; \
> +	for (;;) { \
> +		__ret = regmap_read((map), (addr), &(val)); \
> +		if (__ret) \
> +			break; \
> +		if (cond) \
> +			break; \
> +		if ((__timeout_us) && \
> +		    ktime_compare(ktime_get(), __timeout) > 0) { \
> +			__ret = regmap_read((map), (addr), &(val)); \
> +			break; \
> +		} \
> +		if (__delay_us) \
> +			udelay(__delay_us); \
> +	} \
> +	__ret ?: ((cond) ? 0 : -ETIMEDOUT); \
> +})
> +
> +/**
>    * regmap_field_read_poll_timeout - Poll until a condition is met or timeout
>    *
>    * @field: Regmap field to read from
