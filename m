Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9501FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD4821530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXeyXO6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfEHIQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:16:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37862 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEHIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:16:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so15840086wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAXYVm9NcX/2LS+PAeOz79lHGPmC519ptueWLbeJo8k=;
        b=oXeyXO6C0pw6WvX5xZqKPgGsXKCY0G9zfoXSWEV79JmfIgrUqcvThF3c1YIifzZWLG
         kx1W7KwZYeRCMKXKrM0K09z2V3abI581w9sZsEWhfIe14Bn9LTQT+MbvqpYNctqZQQ8n
         mlTc+hcrWbSh7g5ECWlxDYTcM2tbaELh7qwtazUS4EW+WxxyVL65gaLOVogQ+75hxVtp
         jQql/ObUJjEsKllPLxEwhc6R+s41C43RWWcjxDKsu6x8zZJd1pVmbddxfNCPF0/wbSyG
         dSYgZyROGY5LAcxiJLbpVoF5AHTWJiBXzrcdlr5NUki/Et8NFNKpSW9opSp1vcUWp1sO
         hlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAXYVm9NcX/2LS+PAeOz79lHGPmC519ptueWLbeJo8k=;
        b=Xgj9xm4JEB7La0p6B4knLDeOC7PzziOOI7cVxTynj/GjDuty5r+RKcpMPa2xvnuhLu
         v3Lwntfd7HwweZ4J441jvP/o/G4JrUFfVYO+N/IHRes/bchEbvUvut36QKbNRfC/TfTx
         FKxSo6Zcl7UHHcYerANVHrm82GzLSllHTOIm1c/zY5ztzQgAKYJZtMRs+NbQ+XY0zMqB
         uZZzfeRTpqSEBiwUrEDVVN4IUFYK2FPdlucvH2rBWarlpwkZtigwTihM5wSWycbom1v/
         qqdX0RJH3cSyvn42OrwGy5FVxpBuwgXme3OB7Uwt4SQ2YxTUur6eKOLWuIRzI1soIIcm
         2SDA==
X-Gm-Message-State: APjAAAWN6oYYZYzzzTXFZwcxr3sf4DFtiPr9FkGttFC4rSfaOUnfim/w
        FZc1CQy0k3jzsc/QqtaxVTHVeQ==
X-Google-Smtp-Source: APXvYqyG1HAsV02i0U4ENltrjiHr5I37VaEzMpOv2ZB+S/cXkDHWabqASHuRwZ0rv35Yf2my3nSLlw==
X-Received: by 2002:a5d:4f88:: with SMTP id d8mr10862408wru.34.1557303403211;
        Wed, 08 May 2019 01:16:43 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m17sm3556067wmi.27.2019.05.08.01.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:16:42 -0700 (PDT)
Date:   Wed, 8 May 2019 09:16:40 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wenlin Kang <wenlin.kang@windriver.com>
Cc:     jason.wessel@windriver.com, prarit@redhat.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix bound check compiler warning
Message-ID: <20190508081640.tvtnazr4tf5jijh7@holly.lan>
References: <1557280359-202637-1-git-send-email-wenlin.kang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557280359-202637-1-git-send-email-wenlin.kang@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 09:52:39AM +0800, Wenlin Kang wrote:
> The strncpy() function may leave the destination string buffer
> unterminated, better use strlcpy() instead.
> 
> This fixes the following warning with gcc 8.2:
> 
> kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
> kernel/debug/kdb/kdb_io.c:449:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
>    strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
> ---
>  kernel/debug/kdb/kdb_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 6a4b414..7fd4513 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -446,7 +446,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>  char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
>  {
>  	if (prompt && kdb_prompt_str != prompt)
> -		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> +		strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);

Shouldn't that be strscpy?


Daniel.

>  	kdb_printf(kdb_prompt_str);
>  	kdb_nextline = 1;	/* Prompt and input resets line number */
>  	return kdb_read(buffer, bufsize);
> -- 
> 1.9.1
> 
