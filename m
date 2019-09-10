Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39F3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF74208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbfIJMNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:13:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38192 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731434AbfIJMNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:13:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id a23so14620462edv.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 05:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:cc:references:to:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uFMOe1LnEqUawwztyUU1ZpfJ1IRlSRADXkmJLyXBo2s=;
        b=Zve/sYNxUR77R2SyNVW20IInapV6yRh41pQdn3PgjmEjq113nF6MfXzhzwZmsBH9os
         VHuSx92QtICsKsIviGtaLbEiM1KM2eo06rGAtEjEPDpUGBjmHY5hNS1qQxpjfhQLiafn
         l48XQhAvJ3t9QF5VX97TblALKpzPZVeabLJy2wmuvn6cXeYZXXmUehp0T0iV1ZI9meS/
         tdLdQZfJqZtI4pixCCXNrw2ecOf7BtbKQzMLVr9mQlezNdUFfM+2xf4t63ZaGw7qqPzy
         ykDHSUIb+7gohk9ufs3+dsFyO1QL8RknjVgu4tmsVSjDvsKchrvFF5OtqaoneenRBXlH
         /OgQ==
X-Gm-Message-State: APjAAAWU9joDtujRGzwaoE4xTIbKw1hAqBLD/eqrxg01Uv52iZtOks7Y
        jThANlThsVEnd2wUSlfVKgc=
X-Google-Smtp-Source: APXvYqwOc/IAft9KgpCo1qy4hOEYMNkkKk0Mgjxjdqq1yIv5r8UMFOqn2M/FDblfPEUqPsw/vjWkkw==
X-Received: by 2002:a17:906:cf8a:: with SMTP id um10mr23698832ejb.310.1568117598796;
        Tue, 10 Sep 2019 05:13:18 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id bt11sm3479664edb.65.2019.09.10.05.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 05:13:18 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH] lib/lz4: remove the exporting of LZ4HC_setExternalDict
Cc:     Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Bongkyu Kim <bongkyu.kim@lge.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20190708151555.8070-1-efremov@linux.com>
To:     Andrew Morton <akpm@linux-foundation.org>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <10d12447-7b67-466e-5ab3-3d28256f0621@linux.com>
Date:   Tue, 10 Sep 2019 15:13:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190708151555.8070-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Andrew Morton <akpm@linux-foundation.org>,
     Masahiro Yamada <yamada.masahiro@socionext.com>

Hi,

On 7/8/19 6:15 PM, Denis Efremov wrote:
> The function LZ4HC_setExternalDict is declared static and marked
> EXPORT_SYMBOL, which is at best an odd combination. Because the function
> is not used outside of the lib/lz4/lz4hc_compress.c file it is defined in,
> this commit removes the EXPORT_SYMBOL() marking.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  lib/lz4/lz4hc_compress.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
> index 176f03b83e56..1b61d874e337 100644
> --- a/lib/lz4/lz4hc_compress.c
> +++ b/lib/lz4/lz4hc_compress.c
> @@ -663,7 +663,6 @@ static void LZ4HC_setExternalDict(
>  	/* match referencing will resume from there */
>  	ctxPtr->nextToUpdate = ctxPtr->dictLimit;
>  }
> -EXPORT_SYMBOL(LZ4HC_setExternalDict);
>  
>  static int LZ4_compressHC_continue_generic(
>  	LZ4_streamHC_t *LZ4_streamHCPtr,
> 

Andrew, could you please look at this patch and accept it if everybody agrees?
static LZ4HC_setExternalDict will trigger a warning after this check
will be in tree https://lkml.org/lkml/2019/7/14/118

There is also a different fix by Arnd Bergmann with making this function non-static:
https://lkml.org/lkml/2019/9/6/669

But since there is no uses of this EXPORT_SYMBOL in kernel and LZ4HC_setExternalDict
is indeed static in the original library https://github.com/lz4/lz4/blob/dev/lib/lz4hc.c#L1054
we came to the conclusion that it will be better to simply unexport the symbol.

Thanks,
Denis
