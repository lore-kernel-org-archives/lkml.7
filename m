Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DFCC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A943521479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Be2niih7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfEHKda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:33:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36700 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfEHKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:33:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so2586336wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u09Da640KqSkrdZYs8DECu/Bzf+Ww59St0M09Us2fGQ=;
        b=Be2niih7B4DByVjdgqX+dg8QTAY8Kl8RXd3+z3W7jO+u03cYq6rYg77pxVVRvc1gLs
         4q0+k92qjcG0AP4WDyOU2JZhtNExs2NFCLW9y93VhjQ5/74gyKDnog9Uw0p0hmRLfoRG
         rAE5CxebdSHujZRmA4JnWWXKdX1nWN9qynCy8jyyp1vxILbIiYiaSEKv4Ho4AScJ8/H5
         g2rA0ovrD/RBxSfSPu8JYX/m7UKVweSmv2yU/3Ao3Ctc9VMZDfPEwegdlMxj0k30aNql
         HMtttT8QBuvd8pRKyiuSRnqjbXxEW0UX7XwzgGkXRG0YAKaSEVV0OLDvYFP/KmbgnmUv
         JXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u09Da640KqSkrdZYs8DECu/Bzf+Ww59St0M09Us2fGQ=;
        b=H6VDB+eUrwB+VUnRP5KhSZVeM2/eXNRGMOjThRrW6X+2pkNRPQ14hqg9Hoaq8eq68d
         +mkLqbNa3nnm6o2/eL71JkwO8iZ1blaCPyLATlrgHHv3vvSFvtKX8P8xetPvFmyoJTNc
         K9v4xvewMKMD4C93OUzFTbZGsfGokePBWX+7uCFx+f8l5lXAtKqpLstGbyTtj8WMKDlr
         nxZWiNGttgQbVrG/vQ4CTCe6lZv5Rspolh8rJptfu+DgY2Hh9TIg1Tzjj9TKFO69mZUW
         5aUrZ+nZbRSlOWsiKb3J3E5nDkTc0PFM0ycWCJXrTFVUc/iVa5PUE1egKk8yZbiH0aDx
         6tIQ==
X-Gm-Message-State: APjAAAU6/IoUbt6kXu6he+STWDhAOrY6dGo3M8NZTzEXKT9ph3Pg+48r
        38HFJn9zKrS0Yad/BnM4gCjHRA==
X-Google-Smtp-Source: APXvYqzxuJ2KqqN6NrV+qd2Pme1JUODqn+ZhWzdvhIb81eMIsZTmWyibQ7wk7+LslTUXyNmsTHTu3Q==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr2477222wmj.139.1557311607739;
        Wed, 08 May 2019 03:33:27 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id t18sm33811390wrg.19.2019.05.08.03.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 03:33:27 -0700 (PDT)
Date:   Wed, 8 May 2019 11:33:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Su Bao Cheng <baocheng.su@siemens.com>
Subject: Re: [PATCH] mfd: intel_quark_i2c_gpio: Adjust IOT2000 matching
Message-ID: <20190508103325.GL3995@dell>
References: <06b89c06-462a-788e-20f9-aa71ac1507b4@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06b89c06-462a-788e-20f9-aa71ac1507b4@siemens.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, Jan Kiszka wrote:

> From: Su Bao Cheng <baocheng.su@siemens.com>
> 
> Since there are more IOT2040 variants with identical hardware but
> different asset tags, the asset tag matching should be adjusted to
> support them.
> 
> For the board name "SIMATIC IOT2000", currently there are 2 types of
> hardware, IOT2020 and IOT2040. Both are identical regarding the
> intel_quark_i2c_gpio. In the future there will be no other devices with
> the "SIMATIC IOT2000" DMI board name but different hardware. So remove
> the asset tag matching from this driver.
> 
> Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 10 ----------
>  1 file changed, 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
