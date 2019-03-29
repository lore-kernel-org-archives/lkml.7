Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB64C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31F72184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KkTtldlW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jErErcb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfC2U1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:27:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54580 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfC2U1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:27:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6F2376087F; Fri, 29 Mar 2019 20:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553891242;
        bh=H+AqADjiFgVNVwUfC56fZtiDkhNO3BWn2kahfXt+VJo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KkTtldlWnuUxl7e2ndqqyNVZL5q1/1oX9cT7KcXRdOemO3+YICdviQJ/YpiqJ4oo0
         x1VWqHWhWPrGM/Y29r8m8lZzVqU83VHwM7y0BS/+V8+lVDUADevoVgiUcJUjHlUawi
         OFZN0rOLVS/m9lC9iN8whlRv5B/M53nV4tU3tbaQ=
Received: from [10.79.168.116] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2396A60735;
        Fri, 29 Mar 2019 20:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553891241;
        bh=H+AqADjiFgVNVwUfC56fZtiDkhNO3BWn2kahfXt+VJo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jErErcb3zyLQpQ0gSv4Wqa/yAy2Nx4ILsCORlv/LpqPOPnONt2zPobwgxzPtZ4dlI
         nNqlkZVAsur84AIskwScDyfOTidCbiF2AmYdjTGDBV1KjSy7FqcBVAWYoYRuwRKdPC
         olCccnbIww+68A+69mH66gw1IdN7aJHqIeflUsCE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2396A60735
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2 4/4] x86/uaccess: Fix implicit cast of __user pointer
To:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qiaowei Ren <qiaowei.ren@intel.com>
References: <20190329163047.223508-1-jannh@google.com>
 <20190329163047.223508-4-jannh@google.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <dd654d81-7c04-91a9-7e78-f0e83e41f5f9@codeaurora.org>
Date:   Sat, 30 Mar 2019 01:57:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329163047.223508-4-jannh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 10:00 PM, Jann Horn wrote:
> The first two arguments of __user_atomic_cmpxchg_inatomic() are:
>
>   - `uval` is a kernel pointer into which the old value should be stored
>   - `ptr` is the user pointer on which the cmpxchg should operate
>
> This means that casting `uval` to `__typeof__(ptr)` is wrong. Since `uval`
> is only used once inside the macro, just get rid of __uval and use `(uval)`
> directly.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Looks good to me.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   arch/x86/include/asm/uaccess.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 1954dd5552a2..a21f2a2f17bf 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -585,7 +585,6 @@ extern void __cmpxchg_wrong_size(void)
>   #define __user_atomic_cmpxchg_inatomic(uval, ptr, old, new, size)	\
>   ({									\
>   	int __ret = 0;							\
> -	__typeof__(ptr) __uval = (uval);				\
>   	__typeof__(*(ptr)) __old = (old);				\
>   	__typeof__(*(ptr)) __new = (new);				\
>   	__uaccess_begin_nospec();					\
> @@ -661,7 +660,7 @@ extern void __cmpxchg_wrong_size(void)
>   		__cmpxchg_wrong_size();					\
>   	}								\
>   	__uaccess_end();						\
> -	*__uval = __old;						\
> +	*(uval) = __old;						\
>   	__ret;								\
>   })
>   
