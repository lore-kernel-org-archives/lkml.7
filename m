Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A061ECE596
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529EC2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G1HPELi2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="umPFSm/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbfJJHHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:07:42 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:22231 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfJJHHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:07:42 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id E9C2BA39BF;
        Thu, 10 Oct 2019 09:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received; s=mail20150812; t=1570691255; bh=qtVeTLRbBe
        26U1OQjCON8/pEtKrsW3vc60rQbDWzF+E=; b=G1HPELi2LZJv6oCg4v18nkAytH
        W+jy+/CJEqHg3ekHNNSnKjPyLu2Dc30ugQEWd5Nelj9bs5o0kAX/ty/YA6pvazg7
        l/VKwb1Td7qZqBK/NjG6l73mgrg99k3SOrsS7LxTjc8bi4Fv970ANd7xM14dML2I
        pwNifh9J4JqWZFCkxRWOaKAW0AuOxTimXCGMGlpLUa2emh6XGP1ByGaCGHZQrlpq
        ARrB6xTrAUwiFYTztjmoL/3jW3wirlSsBzRTMxrYNxE4MdqKPH4QMtjpMyTA8rIL
        xxS9UmUWaUbfcwAplNQxHCFuTUlu3o6JrbVHiQdiiN7yPvHsB+quSn6gxL7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1570691256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zhn3q5nsgiRVkwwWOxv7smEUbI7j7vJ/K26dTBn8bx0=;
        b=umPFSm/5o458SA7f8HtkFII4KW14fZeelrGoO/mMNzF89yL2Ukys/O5lgR5y7IS9qWlVO1
        AvWAVUTNeN4uzAJuUGTAFZEGLDs4QN/vbLqnvkfzYtIvj59GIjYYbtCLAyxMZb15EjQSIS
        5A/HO0wOkWSrQEjv6RbDl55ZwzROVVstUKffvLcOu/oYDHVkquQ1LEo/QwUPjcon+ZWVNz
        QHWWS3C4aYv/hd/WRnWh4cuTjv5HarAUvzbqaI1azKoP9BfS9ZpRYb0nPoGRw3ErRbqU0B
        bBTIugpfWBk0LhiclBLZLnQr8NpB3JMOb1ZhzjZOq7qmDWM1EyEhczG54+0GiQ==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id KEmneR8j36iB; Thu, 10 Oct 2019 09:07:35 +0200 (CEST)
From:   Alexander Stein <alexander.stein@mailbox.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: bcm2835: Fix memory leak in bcm2835_register_pll
Date:   Thu, 10 Oct 2019 09:07:31 +0200
Message-ID: <1693637.czecojBbq0@ws-140106>
In-Reply-To: <20191010013101.5364-1-navid.emamdoost@gmail.com>
References: <20191010013101.5364-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thursday, October 10, 2019, 3:30:58 AM CEST Navid Emamdoost wrote:
> In the implementation of bcm2835_register_pll(), the allocated memory
> for pll should be released if devm_clk_hw_register() fails.
> 
> Fixes: b19f009d4510 ("clk: bcm2835: Migrate to clk_hw based registration and OF APIs")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 802e488fd3c3..99549642110a 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1320,8 +1320,10 @@ static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
>  	pll->hw.init = &init;
>  
>  	ret = devm_clk_hw_register(cprman->dev, &pll->hw);
> -	if (ret)
> +	if (ret) {
> +		kfree(pll);
>  		return NULL;
> +	}
>  	return &pll->hw;
>  }

Eh, is pll freed at all, even in successful case? I failed to find a corresponding kfree().
The pointer itself is lost once the function returns.
The solution would rather be to use devm_kzalloc instead of kzalloc, like the other clocks
in e.g. bcm2835_register_pll()

Best regards,
Alexander



