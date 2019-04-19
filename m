Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10298C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33F7222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeQY8qwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfDSSWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:22:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44368 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfDSSWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:22:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so2871133pfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mwip4xZezPK38BfWEq5HR+HyqGo66D590Ox/hie+rI0=;
        b=SeQY8qwSDlpnGOISH0mOfevIBeUOKABdZwGg58V61jewHL90Zin0piuB9cXNkucHYB
         NjyqKWIGD8TOXK4SBfQKo//dTl5Mzrmcyex9yTzA3zlgfV7zJPF3adCqL1xLjyrDRTvQ
         RoiMuNuDmU6tvUDSmsYO4cXoDvGObu9Vg2QTTzbH9UlK8iyDtYSe4NCur9F/7kSR5C9T
         emJnwjm5lspYnxE9H0fk6P8AcD/iUT0VQpuBXRRULrhgdduJOsRT9KQAmBiiYem47GmO
         Fl5WvY9lp/tjOvgc261fc/K2Hlao5xws8CHm8wJgn4vhInVhYYKKAS3MWENqay3Q2KhQ
         t9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mwip4xZezPK38BfWEq5HR+HyqGo66D590Ox/hie+rI0=;
        b=HjEnkwKKsQ1FLoLLrEt+On+00DD3NvmKu5oOnvQPoiZmEAsbK/4dPsZldQsNDG+nQk
         oJbatxvO4tq45HZ/uIA6zMH2nPqT+1VsivClEfw4Rx0J01Y3yX9330fI6wXuQOEBQ6iu
         Bh3LT0eRN4FhiI1jABt8aO5ghOOaItYtrJutjmFgq14Z4FAq0rbAX2lFfxse4m5jREe1
         8qm0gGyCpBGtVEiwO1+VjvGtk3mjsOy91W8uphws2dvYQGLg604qCRex6F5uZWP/aLws
         RkP9aYJFNlETTXHf0ayK2R6zaogZ0O5An+pLTT0MAACeI2452XhtYWRbT84urH1Y9CTz
         Vbsw==
X-Gm-Message-State: APjAAAWy3k4bPein1MHGYCNm0F3JHcVRnZ/fmDDSoiEwxQ5IOcVnKbew
        cepyr0RuP0cCwWGvTJMWXYQ=
X-Google-Smtp-Source: APXvYqzZB8yVOx4IzLDEk4pmvt9DS1y2/Fdc1TFsCUfUddB0JE2Q5EkxCjILiX4x3A/yUhrzhwUJ6g==
X-Received: by 2002:a62:ee0a:: with SMTP id e10mr5392640pfi.6.1555698165677;
        Fri, 19 Apr 2019 11:22:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i15sm7397966pfd.162.2019.04.19.11.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 11:22:45 -0700 (PDT)
Date:   Fri, 19 Apr 2019 11:22:42 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190419182241.GB1136@Asurada-Nvidia.nvidia.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <0f7a6907c73e110c797b478fedaba2fc47b5e994.1555669068.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7a6907c73e110c797b478fedaba2fc47b5e994.1555669068.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:23:53AM +0000, S.j. Wang wrote:

> @@ -289,6 +318,12 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> +	ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);

Since the function always return 0, I am thinking of treating
this function as a lookup function, and then moving this call
right before the register settings -- as we have already made
sure that both inrate and outrate are supported.

> +	if (ret) {
> +		pair_err("No supported pre-processing options\n");
> +		return ret;
> +	}

And probably no longer need this error-out. If there's a new
limitation related to this function, I believe we can add it
to the rate validation section as we are doing now -- better
to have rate validation code at one place.

> @@ -380,8 +415,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	/* Apply configurations for pre- and post-processing */

Here:
-  	/* Apply configurations for pre- and post-processing */
+  	/* Select and apply configurations for pre- and post-processing */
+	fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
>  	regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
>  			   ASRCFG_PREMODi_MASK(index) |	ASRCFG_POSTMODi_MASK(index),
> -			   ASRCFG_PREMOD(index, process_option[in][out][0]) |
> -			   ASRCFG_POSTMOD(index, process_option[in][out][1]));
> +			   ASRCFG_PREMOD(index, pre_proc) |
> +			   ASRCFG_POSTMOD(index, post_proc));
