Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF01C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365922173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SkVTkmMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfH1Rg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:36:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42092 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfH1RgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:36:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so235372pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b+nZcDmATIUXaC+MxWCK15FJhIvbY93mi0/z+AOlbws=;
        b=SkVTkmMZ34QFhJ9x5Ip+Zoru+Cn2NCFv6G/wl3A2uakQYeESa6ywM95lIbWp5WSip3
         O88WNt0acCkGbH0JYdZB7suod8oT/iIxPOlrk78/fLmgXVI5MqMgluvalZ5ehmsLBXTo
         h8lnii+14xsUbvwCUg7NsvmutrPiETtxMU2es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+nZcDmATIUXaC+MxWCK15FJhIvbY93mi0/z+AOlbws=;
        b=YKKPpDFSNkJX8sJ6RkvZ+MIJisKF1VmO1OJjBe696uapIvMBcCWqxQ3rr4Hcdf1j3D
         iz68kIqsiXhYtVEUl+qqQEiT/4wbIFgHAdghtGTzHVM2iapj0LnoBaQN0WTi+8vLwjmX
         IdFfvH2nyRRwCevb+F/81PBVWUIiYvtw2WchFFIOd0Yv/we7A18pIifQp/mLJ1bV5OP3
         QswIWwhgIzIrcjNpjI44FTOc5/oU5U+t/LOsldm8LXOrmlLNs3/qiHndgwgpjlz/EnWB
         g5hfoDepfyou/H8yNOBX5TCUbcHccQ+aulcUxS8nuHUvi9kqzllSGaJiPqiaTjjxx7iJ
         DwAQ==
X-Gm-Message-State: APjAAAW227lLOiERdwZRmBeLDGzLApWkD8ov7iZ6IbjLt73XRU3D7AO3
        5cSRCTZsEvECR2g6pftwmOIdrQ==
X-Google-Smtp-Source: APXvYqwShiePGkdcfwoDRcKirKj6KnTdZut+/q6pByCMIH67Pdhni1n4s9cKRDL/kyWaPS6D+4m6RQ==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr4635504pgo.64.1567013784406;
        Wed, 28 Aug 2019 10:36:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j17sm3153701pff.50.2019.08.28.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:36:20 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:49:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Raul E Rangel <rrangel@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm/bugs: fix build error in lkdtm_EXHAUST_STACK
Message-ID: <201908271048.A14E3F4C3@keescook>
References: <20190827164414.122478-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827164414.122478-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:44:13AM -0600, Raul E Rangel wrote:
> Building an x86 64 bit kernel:
> 
> lkdtm/bugs.c:94:2: error: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Werror=format=]
>   pr_info("Calling function with %d frame size to depth %d ...\n",
>   ^
> 
> Fixes: 24cccab42c419 ("lkdtm/bugs: Adjust recursion test to avoid elision")
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Ah yes; thanks! I should build with W=1 more often. :)

Acked-by: Kees Cook <keescook@chromium.org>

Greg, can you take this into drivers/misc please?

-Kees

> ---
> 
>  drivers/misc/lkdtm/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 1606658b9b7e..bf945704f21a 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -91,7 +91,7 @@ void lkdtm_LOOP(void)
>  
>  void lkdtm_EXHAUST_STACK(void)
>  {
> -	pr_info("Calling function with %d frame size to depth %d ...\n",
> +	pr_info("Calling function with %lu frame size to depth %d ...\n",
>  		REC_STACK_SIZE, recur_count);
>  	recursive_loop(recur_count);
>  	pr_info("FAIL: survived without exhausting stack?!\n");
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 

-- 
Kees Cook
