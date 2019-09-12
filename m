Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DAAC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A42206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mwj32CQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfILOlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:41:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38877 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbfILOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:41:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id d10so13611732pgo.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r10XxYo64h7WhrgLMhjzdHqV1PkZ/x1I9tqJZeKTMc4=;
        b=Mwj32CQaEx1C6jSYjkvSBFB9XLBwRzlQNF4YPTVHp/4BLY45eXByAwlwqQeUVzEl4e
         xIDDW/JwGQvwGUONObe9X1YPZlxxNi3e5MGidT4kWtbuxGYF+F1vKflxYaeJ2fSUGI+d
         S6Ak3qU4hF1Ah3k9lQAC1JwQgyXRUFLPGmUU/GoLmUZfGAovKhRELGPQkDxuVuvJMRtl
         D7rU4n1yjuXXaJxUCL0fkKrPF+aV6IanCL+h76GlY7BcK5RiPHJMrEb6YCPPF9U/eFqZ
         X6ww+U0H0hn85vYUOmwR9Mqh/k3GiFdBkgDe/lCGvnSmn/1WKifFLr66NEy0Vm4An0+w
         hrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r10XxYo64h7WhrgLMhjzdHqV1PkZ/x1I9tqJZeKTMc4=;
        b=aL04q35Po3HKTr7Sqr3CFsdm1p0p7hVCdVfzkuTySraGkDkX0BUojcv+fdD+Wk7u4r
         XT0VVIz8tSEzPozk1gsbcsS8/TmBrJA1mCLUapqVyqhmjcou6MFeUfFbY1KdOdWpG0MI
         +QDEZrVKJ3D5TcsIO3plxHyrCVrxCeWsr04PenwqBu9sbfIJ+CunLlCetJnM9cPNwu4y
         zEx9RY3Yb4QDSkccfxz9ZguuHmAXdXojl3Dncmmk6jFZyYcuNMj35/zfRKDVqplmMcTv
         PDaooImkPqCSWBZjlyKKE5ROsmCNVSRbuxDm0Q2nvUDMNkuo53NgYRA28+T9ySotxCVX
         1JlA==
X-Gm-Message-State: APjAAAWyNfp1LpEL3CLTyNNapSPBEMMr9UtNIdbwKbX8PnEHdgQhQaRH
        UflrI8bR86J8IP9DQ5lk48sbng==
X-Google-Smtp-Source: APXvYqwequlIpbX+PrCQEr/G2Xun6w8GjZ/REjd2nI410kBksQEDDgQ9WIHogZAWQxThN3ALcVXt7Q==
X-Received: by 2002:a17:90a:b63:: with SMTP id 90mr440396pjq.96.1568299297139;
        Thu, 12 Sep 2019 07:41:37 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w26sm27201591pfi.140.2019.09.12.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 07:41:36 -0700 (PDT)
Date:   Thu, 12 Sep 2019 07:41:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: socinfo: add sdm845 and sda845 soc ids
Message-ID: <20190912144134.GA7468@tuxbook-pro>
References: <20190912091056.5385-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912091056.5385-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12 Sep 02:10 PDT 2019, Srinivas Kandagatla wrote:

> This patch adds missing soc ids for sdm845 and sda845
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soc/qcom/socinfo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 855353bed19e..8dc86a74559b 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -198,6 +198,8 @@ static const struct soc_id soc_id[] = {
>  	{ 310, "MSM8996AU" },
>  	{ 311, "APQ8096AU" },
>  	{ 312, "APQ8096SG" },
> +	{ 321, "SDM845"},
> +	{ 341, "SDA845"},
>  };

Added a space before the '}' and picked this up.

Thanks,
Bjorn

>  
>  static const char *socinfo_machine(struct device *dev, unsigned int id)
> -- 
> 2.21.0
> 
