Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3275217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cK2XokVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfEJUX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 16:23:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32842 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfEJUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 16:23:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so3540471pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hnsEOtZUe8FJnEfNKVhXMIrHa1KhnNCENToE54mzqug=;
        b=cK2XokVUUCVhQ/FGj4M8aPYamNv86OpFxB0vCqs0ukb3SVTaguNp1hXqTrFpYNQKtc
         hxfiLc69rv4r3XmE7zzoezLbsAZTxDaVJ6bJR+X0c9LD1VTqA14Zv0+8gMIxSQ8Y1/Lv
         4rXhIKHcDQkrJFwhpJdcJ7FE+EnggGJQa/hzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hnsEOtZUe8FJnEfNKVhXMIrHa1KhnNCENToE54mzqug=;
        b=o76ZmeDUPDxGmPP6X5WuhZExqRjiugG0WhN3PDpcIkuMjTuL98sSBN+4o8uClpA4KX
         QsGDfZbHasafdmzM7BMvzvyrqXX/CnSjsHVnAROLJFOIp3v523USTqguW2HyaBTJzI3E
         lJwGYsjWaY9NgUdmYPEtScCsG1zVxuz7It7KsarZdZ4HCt6wwL3g4q6+psve8nys9bg5
         0Qqn8i20PAqL66uHWK1Boqqius57nQApcFmzMVLD05rxespmGB9g69che5US3v8Gao7F
         yISvvAPbV74Z44iHSA6FA2DtaNQGyL7iHKFkQoMRqZc9Gp/FOR+EL5jyH4sXNvYDH//B
         S2vA==
X-Gm-Message-State: APjAAAUtmK7frv2aRlJqAu4MSzMR53kbxqk4j1mNqKfsaoDk3JgmTtSG
        y0lUypAGLhfPW2veHYhi838oCw==
X-Google-Smtp-Source: APXvYqxpr4wd/Z7iIJFFCvjs9GVV2R6oPWspwBFAShKC9zjxr7Xu19JweCrS/THwVUDeh+cEDCAPYQ==
X-Received: by 2002:a63:804a:: with SMTP id j71mr16475539pgd.68.1557519806949;
        Fri, 10 May 2019 13:23:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e184sm11835000pfc.102.2019.05.10.13.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 13:23:25 -0700 (PDT)
Date:   Fri, 10 May 2019 13:23:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] gcc-plugins: arm_ssp_per_task_plugin: Fix for older GCC
 < 6
Message-ID: <201905101322.BEDE5CC@keescook>
References: <20190510090025.4680-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510090025.4680-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 09:00:25PM +1200, Chris Packham wrote:
> Use gen_rtx_set instead of gen_rtx_SET. The former is a wrapper macro
> that handles the difference between GCC versions implementing
> the latter.
> 
> This fixes the following error on my system with g++ 5.4.0 as the host
> compiler
> 
>    HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c:42:14: error: macro "gen_rtx_SET" requires 3 arguments, but only 2 given
>           mask)),
>                ^
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c: In function ‘unsigned int arm_pertask_ssp_rtl_execute()’:
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c:39:20: error: ‘gen_rtx_SET’ was not declared in this scope
>     emit_insn_before(gen_rtx_SET
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Thanks for this! It seems correct to me. Ard, any thoughts? I can send
it to Linus next week...

Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
Cc: stable@vger.kernel.org

-Kees

> ---
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
> index 89c47f57d1ce..8c1af9bdcb1b 100644
> --- a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
> +++ b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
> @@ -36,7 +36,7 @@ static unsigned int arm_pertask_ssp_rtl_execute(void)
>  		mask = GEN_INT(sext_hwi(sp_mask, GET_MODE_PRECISION(Pmode)));
>  		masked_sp = gen_reg_rtx(Pmode);
>  
> -		emit_insn_before(gen_rtx_SET(masked_sp,
> +		emit_insn_before(gen_rtx_set(masked_sp,
>  					     gen_rtx_AND(Pmode,
>  							 stack_pointer_rtx,
>  							 mask)),
> -- 
> 2.21.0
> 

-- 
Kees Cook
