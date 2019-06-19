Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1C1C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F1E2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560967464;
	bh=x5KiDzUgSK7qZcJ/as2Il4NNuMtV1bicMfPBCU1HXB4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xp2157ZC/iuHRKoo9ZaWunalWjF0qKi0mns0a+AB/79NEIUQbZnOPNm8tFEz92LFh
	 yiMjY0izDV59PSVjwhzONcITEWHWKtfuLJSqRHgN03DsqQthOHeSPhaCXvkWuB3Qn2
	 3GVs28ii0ZYNege27o7wqEAbTzC2iv5DSWedDqg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfFSSEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:04:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37380 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:04:22 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so120056iok.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bY2Pdgxjl8QBtsjUINphEntPK3jfC/Ak6GNxyygmigo=;
        b=VkybdO5szSQoqsCVNU3CNvztJwBLITMX5WwtErnOYPP33xZQZA9gVzz6aeV21kCbn5
         ObwWjqDCTa2/Bb2qCTbAbK6xqxkdiHO/Mwj3z8YEH/KyXQrkohwjDJjxkKABz0ZhAhkW
         RpTbQvkIB8kS8Zn2Qbo1olUPr8yqDON/ekOis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bY2Pdgxjl8QBtsjUINphEntPK3jfC/Ak6GNxyygmigo=;
        b=W3mTvAVbdUeDVH8TpmNvcFRePcH6OwljMNfHBNuFXn8fVKU2Ffp/WjrWhKFmZKQQLb
         zvmXJJYqt/7LbtveAui1HjoBNwry2BsPVfADuG6iULMXXDh2IVGSXVTQ6427ApPeh/ic
         QEe+uvsxrMqPlFPRrq9wTR1ssfyX3trvqE09YthVYuTxPwY7b0c3ZYXXZB3UIErxWWZW
         ayHVVRzeQbka0Y9mKhAaaphYT9TfH4AwzM2rWCkldCOq5Rz952vp4MxpyXx8J7HsFB2K
         dXOBivysP/+wztkGvWEkDuvt3d76zuZQoPSPC+7I/kdQNaxYqHY11LNaKOSgY9w7Gtf5
         lpEQ==
X-Gm-Message-State: APjAAAXN+rOMlb9CVnu6h/YNykoWxYQ2mHNhzBceGHkc+GQCq4JFaRpe
        VhEs4GcvRKJaEIc2zKJcD5eoZkg59oM=
X-Google-Smtp-Source: APXvYqw4Tz4USEoEvxV705R5eyOixcvvXbf7l0fifGzCyJPxmQS1jpqwotommwl09kmMHgcdPEDAXg==
X-Received: by 2002:a6b:b40b:: with SMTP id d11mr3987486iof.122.1560967461187;
        Wed, 19 Jun 2019 11:04:21 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y20sm17970542iol.34.2019.06.19.11.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 11:04:20 -0700 (PDT)
Subject: Re: [PATCH] net: fddi: skfp: Include generic PCI definitions from
 pci_regs.h
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190619174556.21194-1-puranjay12@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e49daf89-1bf0-77e8-c71f-ec0802f25f6c@linuxfoundation.org>
Date:   Wed, 19 Jun 2019 12:04:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619174556.21194-1-puranjay12@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/19 11:45 AM, Puranjay Mohan wrote:
> Include the generic PCI definitions from include/uapi/linux/pci_regs.h
> change PCI_REV_ID to PCI_REVISION_ID to make it compatible with the
> generic define.
> This driver uses only one generic PCI define.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   drivers/net/fddi/skfp/drvfbi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/fddi/skfp/drvfbi.c b/drivers/net/fddi/skfp/drvfbi.c
> index bdd5700e71fa..38f6d943385d 100644
> --- a/drivers/net/fddi/skfp/drvfbi.c
> +++ b/drivers/net/fddi/skfp/drvfbi.c
> @@ -20,6 +20,7 @@
>   #include "h/supern_2.h"
>   #include "h/skfbiinc.h"
>   #include <linux/bitrev.h>
> +#include <uapi/linux/pci_regs.h>
>   
>   #ifndef	lint
>   static const char ID_sccs[] = "@(#)drvfbi.c	1.63 99/02/11 (C) SK " ;
> @@ -127,7 +128,7 @@ static void card_start(struct s_smc *smc)
>   	 *	 at very first before any other initialization functions is
>   	 *	 executed.
>   	 */
> -	rev_id = inp(PCI_C(PCI_REV_ID)) ;
> +	rev_id = inp(PCI_C(PCI_REVISION_ID)) ;
>   	if ((rev_id & 0xf0) == SK_ML_ID_1 || (rev_id & 0xf0) == SK_ML_ID_2) {
>   		smc->hw.hw_is_64bit = TRUE ;
>   	} else {
> 

Why not delete the PCI_REV_ID define in:

drivers/net/fddi/skfp/h/skfbi.h

It looks like this header has duplicate PCI config space header defines,
not just this one. Some of them are slightly different names:

e.g:

#define PCI_CACHE_LSZ   0x0c    /*  8 bit       Cache Line Size */

Looks like it defines the standard PCI config space instead of
including and using the standard defines from uapi/linux/pci_regs.h

Something to look into.

thanks,
-- Shuah





