Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9FC5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 04:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F120838
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 04:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rl7EAg+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfF3EF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 00:05:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42447 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfF3EF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 00:05:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so5441254plb.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 21:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nZ4faO3Hxt6Vv9DkaePS/Kvvg767f3TOfeZ7FItgRpc=;
        b=rl7EAg+f3oXHBc8Pbo//vWa3my/Z7+d6GEro+N5fRkuf6eXL3Ar1+FGnrNGb58Nkyp
         c7f4MXGR0IHjlG7BmA/rmUzxOAnzGP6xMCHReP4yqY7rm3uihkIYFlHy3wUjZDJ+M/Zb
         I4I+XIWi4KVSVqdJxjdxlhdrAdIcqttsszNBUKYbP0wRubhUFc7zFvMQ4Icd1Vr/OWHA
         Q3y9oGRxxyPp07pxYRbtvqicG+f3Cwc8lH89BWEeheh3G9HiL3+ytCZtYrqHxKeNE6qj
         xFOCGAzC1hlSrLGFC34ZqTBi5S1XvC4x7RPzAUW2Pfb27bY6g4qhSCfWI/rBNsOVj4dh
         Ah/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nZ4faO3Hxt6Vv9DkaePS/Kvvg767f3TOfeZ7FItgRpc=;
        b=X16hc5a8lLG783dNMhU5xfeZ5wjWKqf8vs1dJnFFsj+BUx4yDbU3VPpub6KQr8UKPo
         LbkUpYct7oAWxgZOytD1GXfUnK7xq9oGqBCVxOrIj0jzE/J5YUxc4W9OuR2tQjUKm4dp
         nCCE+r5swJb74aohYkdoKdA/r5RHhep78Rp3lC0KkPCA+HYrh9I82PVwTHUbHEtYwrbk
         xIBY0k6a8MIeztVe92BvhXOmUrf9tyr3MKKl+uHdDDGFJADtscbJQDd3+eaefxjC7hcs
         Vg53tblfBNbMpP6wZ4nOn4zxO6nVLXa0ezoSSjA7/PJy7iin3INCjfOY38iEALXGvMG2
         PBQw==
X-Gm-Message-State: APjAAAWFQ6NEA40jHa3mfnMNy6U9gugUB92wI/AwerRIqO7HbJiFZ6b6
        gMG9dPEYqnLgfQIYUTJGKXDLPQ==
X-Google-Smtp-Source: APXvYqxg5hDllg1TQKAIWeDHYzxBnrioiXmu06H2WlpeMePI7Rp+znhieN/1bfFWv6zaE9kfcQ+ElA==
X-Received: by 2002:a17:902:a40c:: with SMTP id p12mr21215977plq.146.1561867525153;
        Sat, 29 Jun 2019 21:05:25 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z13sm6984605pjn.32.2019.06.29.21.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Jun 2019 21:05:24 -0700 (PDT)
Date:   Sat, 29 Jun 2019 21:05:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] hwspinlock: stm32: implement the relax() ops
Message-ID: <20190630040522.GA1263@builder>
References: <1551973336-23048-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551973336-23048-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Mar 07:42 PST 2019, Fabien Dessenne wrote:

> Implement this optional ops, called by hwspinlock core while spinning on
> a lock, between two successive invocations of trylock().
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Applied

Thanks,
Bjorn

> ---
>  drivers/hwspinlock/stm32_hwspinlock.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
> index 4418392..c8eacf4 100644
> --- a/drivers/hwspinlock/stm32_hwspinlock.c
> +++ b/drivers/hwspinlock/stm32_hwspinlock.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/hwspinlock.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -42,9 +43,15 @@ static void stm32_hwspinlock_unlock(struct hwspinlock *lock)
>  	writel(STM32_MUTEX_COREID, lock_addr);
>  }
>  
> +static void stm32_hwspinlock_relax(struct hwspinlock *lock)
> +{
> +	ndelay(50);
> +}
> +
>  static const struct hwspinlock_ops stm32_hwspinlock_ops = {
>  	.trylock	= stm32_hwspinlock_trylock,
>  	.unlock		= stm32_hwspinlock_unlock,
> +	.relax		= stm32_hwspinlock_relax,
>  };
>  
>  static int stm32_hwspinlock_probe(struct platform_device *pdev)
> -- 
> 2.7.4
> 
