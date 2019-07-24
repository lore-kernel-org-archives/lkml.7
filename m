Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A14C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA3A21926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563995413;
	bh=esIJq4UKFmo/AFPOxaXUOoVqiee0ziEThR2SsEPoOlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N7lbkiOY1O6ovVL+4CKWYJKGVsKL9m1gk7eg3s6VuBAlpPAGUTWh8o0HFzJS724nn
	 DTqaR1OMU5LguA74s3itr/BYMf4p5SWyglL1xrrA7xfjgoPpMm3Q0VaZHk8i7n5JOK
	 KGvs3ToTaW2HgwDR/zCeXWd7DuQC/T/GcbH/vxfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfGXTKM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:10:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33332 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfGXTKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:10:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so48218602wru.0;
        Wed, 24 Jul 2019 12:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HSdo9ZmudjoY5QfVd80yVoDhymQ27WsVZ3uLmAFSang=;
        b=UQ6HCb0/f1XrGVWnQ40XkLGhlIU01u9FQrsfKnawPRRbBuY16J/QH2JzBwJAHgL0DO
         Ug2eMEw8Sb9WnAJs+hOkydXE90YuQlmBKVFxTBpTm58axGPVbTWSIJxdJEQAVxgNG96l
         ua9+c82futZonjh0nb73t4+vzIdgNyHW7itfIrL12WqogghfrnCgAhq9Dt4FifSCQl7u
         /Qu5mGwmpiwhcU8/3Ck6uGgL/f4CRRNUDpeiecNnkFff0uLLjbIHTMLRYmBY3uyy39d3
         tZ4SIXPMgqZup56+6xH39XYDfRzylaK9Qm5j0+1VPhupoYxwL70XkHGon9OyPAX0l2DW
         HWUA==
X-Gm-Message-State: APjAAAVK6/jarw+YTYNSrNzeAJY0B6Cg3I5c2xLHLgc0ScA9cFa6xDfi
        VGshgPIgOIKq6cbPmyhO94s=
X-Google-Smtp-Source: APXvYqyWQBOON9MCwlXaZ8Eic8a5Grk22K3A0wrcZg+IPuNCk48LkzoWpj7xmqjgI5qwVDbGSZBdAQ==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr6533715wru.27.1563995409586;
        Wed, 24 Jul 2019 12:10:09 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id v4sm44882540wmg.22.2019.07.24.12.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:10:08 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:10:06 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: Re: [RFC PATCH 03/11] devfreq: exynos-bus: Change goto-based logic
 to if-else logic
Message-ID: <20190724191006.GF14346@kozik-lap>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122024eucas1p1ff060d072132bfbc8a8a1d10fa1f90f8@eucas1p1.samsung.com>
 <20190723122016.30279-4-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190723122016.30279-4-a.swigon@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 02:20:08PM +0200, Artur Świgoń wrote:
> This patch improves code readability by changing the following construct:
> 
> >    if (cond)
> >        goto passive;
> >    foo();
> >    goto out;
> >passive:
> >    bar();
> >out:
> 
> into this:
> 
> >    if (cond)
> >        bar();
> >    else
> >        foo();
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)

Code looks much better:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
