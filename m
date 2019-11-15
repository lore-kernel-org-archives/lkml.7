Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44DBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9282E206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDUmX0KG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKOGce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:32:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37897 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfKOGce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:32:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so5960053pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 22:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q3ePoHPIIdr3W7D+aaS4Z60EnVlbf0EDqLIH1S2hQUU=;
        b=IDUmX0KGEbj6muhIKJyL7HEhTXwt+PkuOrsqDIMdJNfODpcksOOJ4zuhsAIsOr/Oce
         U27ZwTq8v6TVX2+Mm7OMb2JyPNhU+gFqNK6itxctNYK+T7Beoe3iwMML41GMjVpy7iRW
         p9QrS6/uZ7hhBUVoYO1vBF2n7h4u0ac3aKJM3Sv2mS82gGvsO9ZSsHCIng271RLEqKgc
         ussy0+OzHFTn9oj0QukKglzMDdkO5Xk8PZSKKceMb0VCOSrLdyAgGnyrSGxVbGhJW3kf
         iJ53JmuF4I2o6rTRRvcX3VwVUcWOuNhknIkWTpzAgKryWtidmIWwgK8nYkLweoAu4GC+
         4LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3ePoHPIIdr3W7D+aaS4Z60EnVlbf0EDqLIH1S2hQUU=;
        b=cT6HlKgppVYeW7uzjVzjQ/04pws7vUGuRVGSTFI3iv2UJx8uwwu/3dQjMYm6JgpevN
         2XA44/4nThF0tpM43FkVMZQQ3mfq52U69WbmIt2LOhJKsWT27w3d8eLnFg/LcaEXWsNz
         ZNXGhZ2jJM6gmzBSoJODwLgokrpG1s1xuAKVkhWJ3Cpy6czfeJaCDkHFCEoG+KtBs+rr
         N73rA/p27UoQjTnlDcb+6dX55Pi5/49uTcY0Z6e58MWw5frB5KYHVecAN0x8YQEBquHn
         kdYDL9F1ctOBA14sUAqBgpgl8t2D5+qFgTTU/fbRfQ7yh4KiF0BKNDlMavMRbqRbw1vi
         sJjg==
X-Gm-Message-State: APjAAAU+o6rgf01MlV7N5ACJ/kxBFQ5dwxEe2yCTfzlK0ef8xUHPkeSg
        l+AyK6JYoLa+AC6fOko7366TyQ==
X-Google-Smtp-Source: APXvYqwXmWhg5Qpo4vphioNQf1z/8vt/0yg96EIeaEoylI37/2yBLu1fWTS4R30QXtIhmfgqLJ6KzA==
X-Received: by 2002:a17:90a:bf16:: with SMTP id c22mr17129860pjs.83.1573799551704;
        Thu, 14 Nov 2019 22:32:31 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p16sm9058430pfn.171.2019.11.14.22.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 22:32:30 -0800 (PST)
Date:   Thu, 14 Nov 2019 22:32:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3] remoteproc: stm32: fix probe error case
Message-ID: <20191115063228.GS3108315@builder>
References: <1573635167-24590-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573635167-24590-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Nov 00:52 PST 2019, Fabien Dessenne wrote:

> If the rproc driver is probed before the mailbox driver and if the rproc
> Device Tree node has some mailbox properties, the rproc driver probe
> shall be deferred instead of being probed without mailbox support.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
> Changes since v2: free other requested mailboxes after one request fails
> Changes since v1: test IS_ERR() before checking PTR_ERR()
> ---
>  drivers/remoteproc/stm32_rproc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 2cf4b29..4b67480 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -310,7 +310,7 @@ static const struct stm32_mbox stm32_rproc_mbox[MBOX_NB_MBX] = {
>  	}
>  };
>  
> -static void stm32_rproc_request_mbox(struct rproc *rproc)
> +static int stm32_rproc_request_mbox(struct rproc *rproc)
>  {
>  	struct stm32_rproc *ddata = rproc->priv;
>  	struct device *dev = &rproc->dev;
> @@ -329,10 +329,16 @@ static void stm32_rproc_request_mbox(struct rproc *rproc)
>  
>  		ddata->mb[i].chan = mbox_request_channel_byname(cl, name);
>  		if (IS_ERR(ddata->mb[i].chan)) {
> +			if (PTR_ERR(ddata->mb[i].chan) == -EPROBE_DEFER) {
> +				ddata->mb[i].chan = NULL;

So this relies on the caller jumping to stm32_rproc_free_mbox() to
release a subset of ddata->mb[x].chan. While this works I find it error
prone and would prefer the idiomatic solution of cleaning things up, in
this function, before returning.

So, could you please goto a snippet that loops backwards from i-- to 0
calling mbox_free_channel() and then return -EPROBE_DEFER instead?

Thanks,
Bjorn

> +				return -EPROBE_DEFER;
> +			}
>  			dev_warn(dev, "cannot get %s mbox\n", name);
>  			ddata->mb[i].chan = NULL;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
> @@ -596,7 +602,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> -	stm32_rproc_request_mbox(rproc);
> +	ret = stm32_rproc_request_mbox(rproc);
> +	if (ret)
> +		goto free_mb;
>  
>  	ret = rproc_add(rproc);
>  	if (ret)
> -- 
> 2.7.4
> 
