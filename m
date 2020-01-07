Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3B0C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7CE206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwggVHZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgAGGPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:15:52 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34298 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgAGGPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:15:52 -0500
Received: by mail-pj1-f65.google.com with SMTP id s94so4983896pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 22:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MBx9eiA7wdbP2nqN4M3UGU6OsOENkr/rr6Is0HWpxds=;
        b=XwggVHZcy506JAqUq09CKNV1Rb6ZxjlDDbchXEKlCSq2v9z6sbN7x9ChC7vhJu5tJN
         VF1NLx39RLNhMmGlyM6FY/sPShVoMT4z6umO7Bjp5uPp7iEzh2WtgatpVi3LEGnDMEwc
         abNdlnv5rG5VoFcD7GmuLivlrvsZ/ZZZWcLxMEp26QOJRRKy1j1uIgZtf7+OUlx5BEHl
         1Tvxq/ysrSQAsOrz9WVci7aUjB6VPcCYsvYrjoXX9zJo//iK8GRU8Dg5a9cNy8jcirfG
         0H602t4Y18Dq2X+DstmoGCaERbSZcP90Lx4CwtW80u739330aoV2aIgnkfPDhO5LF2bL
         +zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MBx9eiA7wdbP2nqN4M3UGU6OsOENkr/rr6Is0HWpxds=;
        b=ZI6papXFVoQGHq0q0MOZpKUSMHniXt6QTJ+zBILr9Se/Xf6YGAhxmZ2GZp02+y+2Bg
         84lnU/CLiSMu6MJyWyz3LXN1Pug4I7Bs67DXFksLouD2VYBW0KD0P20IVE+CGnhaHtLr
         C0VthTtgkUd1zMtfyK3OFNZaPjSzf+07rQcfsucROGKMIZ82d0uWEAOeVZ5QewJ9v2co
         oXMFwFRD7zCsSIA0N7vuNm2e1WvFkzDvp5Chr631+kms5/nHuFpDEeVomf35gpG8KqK1
         hHfeJa2rD70D9Bijk/uWxQ0debtJ0SoA31Y1ocYqR3xkwkqiJm/fCJYMao/95oIb6QZU
         W/Vg==
X-Gm-Message-State: APjAAAX4U0YlcmCuO0E83nScWY1JTxjnI2JR6qntPX3lruUs9xyH0Biw
        xRyJtK+FoBRJpwNSUyJ2FDe1VQ==
X-Google-Smtp-Source: APXvYqwyDYa50TpzPvKGvUa/ah7QsaRLTzy0lR6hpMbfVCtnPhOf1OCj7psBYGjh7/IeGvosgHflQA==
X-Received: by 2002:a17:90a:cb83:: with SMTP id a3mr46740958pju.80.1578377751772;
        Mon, 06 Jan 2020 22:15:51 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q7sm26643097pjd.3.2020.01.06.22.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 22:15:51 -0800 (PST)
Date:   Mon, 6 Jan 2020 22:15:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        jcrouse@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: Check for valid path in icc_set_bw()
Message-ID: <20200107061548.GC716784@yoga>
References: <20200106172746.19803-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106172746.19803-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Jan 09:27 PST 2020, Georgi Djakov wrote:

> Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v2:
> - Use WARN_ON() instead of pr_err() (Bjorn)
> 
>  drivers/interconnect/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 63c164264b73..d2ba5ae7d25b 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -495,9 +495,12 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  	size_t i;
>  	int ret;
>  
> -	if (!path || !path->num_nodes)
> +	if (!path)
>  		return 0;
>  
> +	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
> +		return -EINVAL;
> +
>  	mutex_lock(&icc_lock);
>  
>  	old_avg = path->reqs[0].avg_bw;
