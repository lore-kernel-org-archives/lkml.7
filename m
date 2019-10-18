Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCD4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9145320854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="De5hTX3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502302AbfJRQtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:49:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34313 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502179AbfJRQtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:49:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so3132920pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v+xlH4n34GpIF8eBLaea0CeqXTV/EF6VBM7h/r2d6pw=;
        b=De5hTX3JBN8Q7ACyfo1u7clSDEwrCzdRy5Xr7tZu8/ZEeYl2SDXKBq4FZZE8ONBzRk
         tcHVTQhRFPYHeu0d0KYiDxfy3e598jTbMP8P+/D3K0XMBANSO28aweiVBVROm35frY39
         7giwoc/mPVGMlgwGf30B9JImNpcjDajzm1X/6QzVlEX2sSg+lCxyXjSgWDkk5YPCwGp1
         uLDTfR1vR5mG8EmKPbKIg282L12cq9MLmC20Srn8H78b6g5Qejh8GAyqu4Ovg/iIOzqj
         c5GHP7ZizTZX3/pxkTgAnEddZN6iBSO0AUuRd9xspOBOTo/jeNFSCsBF+BiNmex6gBF+
         tXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v+xlH4n34GpIF8eBLaea0CeqXTV/EF6VBM7h/r2d6pw=;
        b=GuTE6avwkT9VPlPSgvlAUCVduJRXZb8W3hyloRO6O4G9xcgNdQTd7kyopJz1V/ifeF
         tjyILT9N0eDw9npyTmHVFXm9v9m30jydLlamEm0GmzdrDNn++xh2vvLUx39foNTnxdkd
         7upMrXqSYE5/Ncm8f31h8B14CWDmdKc7fy764CynP1ZMzXw0HeR0ff/Kafw5uFnaerrO
         reo7p5A1G5atyReAviE4PwiK0l2fdmXT6npPsb1U2j6fFC4M+uQfqvBhVGb29bhH4lyf
         puxAxNnX+qkogV/82btUelHYMAZeZmCod/EtR557eTLswwzqoGCSjbP1TsNHrSOIZdEN
         tkYw==
X-Gm-Message-State: APjAAAWoIVmJ1E8oxYJ8Mj0A7EjlPjCH1nW/xTRIRn8c1Q0MpTDFH18b
        K0rpLyp0bfw/ez0RcwINhXprFw==
X-Google-Smtp-Source: APXvYqxcNsgzf2s/TfKOdaEkn8qjpyFxXzFsL7/C6GIu4VsQgmDpxPUNU6tXa+mQfuPC/9jtCWUQ8g==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr3169206plz.264.1571417345139;
        Fri, 18 Oct 2019 09:49:05 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v19sm7239550pff.46.2019.10.18.09.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:49:04 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:49:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Add locking in icc_set_tag()
Message-ID: <20191018164901.GC1669@tuxbook-pro>
References: <20191018141750.17032-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018141750.17032-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18 Oct 07:17 PDT 2019, Georgi Djakov wrote:

> We must ensure that the tag is not changed while we aggregate the
> requests. Currently the icc_set_tag() is not using any locks and this
> may cause the values to be aggregated incorrectly. Fix this by acquiring
> the icc_lock while we set the tag.
> 
> Fixes: 127ab2cc5f19 ("interconnect: Add support for path tags")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/interconnect/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index e24092558c29..4940c0741d40 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -408,8 +408,12 @@ void icc_set_tag(struct icc_path *path, u32 tag)
>  	if (!path)
>  		return;
>  
> +	mutex_lock(&icc_lock);
> +
>  	for (i = 0; i < path->num_nodes; i++)
>  		path->reqs[i].tag = tag;
> +
> +	mutex_unlock(&icc_lock);
>  }
>  EXPORT_SYMBOL_GPL(icc_set_tag);
>  
