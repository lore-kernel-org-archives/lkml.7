Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD1AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F099205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNV0xk5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfJGQJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:09:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40692 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:09:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so8491206pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aBgqQxTSUrypIINp0CWdo9JqgkyiVA1d7jt/RqpRlPU=;
        b=dNV0xk5XmmtEjnnKPK4foXc9ByJV90H2Uz8o96rrYBbNIMOCYOeceGfhUOXS1ker5h
         +dNeMdpb90TzApZYzmG6NZ5YYgEt6yLgJeT1pjZMDo5R9zpRvKY6aLqo9V8nn+bWXMuw
         C+fYIBd+KainiWIm5N0ysMRDucAhMs2rw67FtwhPmyEcAzUSRUu4JUmUadEOKTdwha1x
         mpZB3qFzRKjH4nZmwtvEi7fQsksvjZiVcdkbQjSozxm6KZg29F/QvQgOcvU1kXn6bXLZ
         97+bBX4l4UoIMCj1YoLJRLLQG/3ln+uxnIX1w8vr98qqYF/T5RwNvq0etGq2TWc2wtLm
         puNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBgqQxTSUrypIINp0CWdo9JqgkyiVA1d7jt/RqpRlPU=;
        b=AT94kT9v+J1DVV80J6J0nuO1/faVmE4MLlU5bRqnOQhD3YtIqNl4ca7nYN5F26XAxF
         OESoS+8s1UDu2/MHLvmpI02xEElGaKztM8rrpR4QSaNqhoxrpzvEIcg831k455zM5y+k
         SzK1XxB9DR31AESi09UyiCLmRtiB4HFCEDBdtv5ZusPtlH+ZmihskzqAEIcfkDphiq6o
         0YlHCfiyeIbU0RYA+CGwtNxrzC7MTUU/VZXJH/iC/4cWTMXXw/LdMRrBqaqEI76d/+TP
         qL1sk/OdTNb5hc6i9nPNqXLu8NaRDfMPrstJ6gbP6j05mylSUANlku3JA3WtvGlSpk/h
         FuNg==
X-Gm-Message-State: APjAAAUrPWGmDQMpavZ7T/bQqp1XtYJV7EsTd62DeJ/WJg3IC59VeMip
        2KjRvX9DK84e35TXvbk5X7hl/HMiT8M=
X-Google-Smtp-Source: APXvYqzea5ibDvYZqN2MAn2BlMt02HhSOXkQyEnzAq5I/XmObJu1rcLlA9QSBrGJLpH2HcWmORsJnw==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr24350pjs.51.1570464511127;
        Mon, 07 Oct 2019 09:08:31 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e4sm15090747pff.22.2019.10.07.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:08:30 -0700 (PDT)
Date:   Mon, 7 Oct 2019 09:08:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robdclark@gmail.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] soc: qcom: ocmem: add missing includes
Message-ID: <20191007160828.GL6390@tuxbook-pro>
References: <20190901213037.25889-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901213037.25889-1-masneyb@onstation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 01 Sep 14:30 PDT 2019, Brian Masney wrote:

> The kbuild bot reported the following compiler errors when compiling on
> MIPS with CONFIG_QCOM_OCMEM disabled:
> 
>   In file included from <command-line>:0:0:
>   >> include/soc/qcom/ocmem.h:43:49: warning: 'struct device' declared
>      inside parameter list will not be visible outside of this
>      definition or declaration
>       static inline struct ocmem *of_get_ocmem(struct device *dev)
>                                                       ^~~~~~
>      include/soc/qcom/ocmem.h: In function 'of_get_ocmem':
>   >> include/soc/qcom/ocmem.h:45:9: error: implicit declaration of
>      function 'ERR_PTR' [-Werror=implicit-function-declaration]
>        return ERR_PTR(-ENODEV);
>               ^~~~~~~
>   >> include/soc/qcom/ocmem.h:45:18: error: 'ENODEV' undeclared (first
>      use in this function)
>        return ERR_PTR(-ENODEV);
> 
> Add the proper includes to fix the compiler errors.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reported-by: kbuild test robot <lkp@intel.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> My OCMEM series [1] hasn't landed upstream yet so let me know if you
> want me to squash this into the existing patch set. I made this a
> separate patch so that the Reported-by could be included. The kbuild
> report is at [2].
> 
> [1] https://lore.kernel.org/lkml/20190823121637.5861-1-masneyb@onstation.org/
> [2] https://lists.01.org/pipermail/kbuild-all/2019-August/063530.html
> 
>  include/soc/qcom/ocmem.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/soc/qcom/ocmem.h b/include/soc/qcom/ocmem.h
> index a0ae336ba78b..02a8bc2677b1 100644
> --- a/include/soc/qcom/ocmem.h
> +++ b/include/soc/qcom/ocmem.h
> @@ -9,6 +9,9 @@
>   * Copyright (C) 2015 Red Hat. Author: Rob Clark <robdclark@gmail.com>
>   */
>  
> +#include <linux/device.h>
> +#include <linux/err.h>
> +
>  #ifndef __OCMEM_H__
>  #define __OCMEM_H__
>  
> -- 
> 2.21.0
> 
