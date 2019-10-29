Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E21CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4021721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572385616;
	bh=gL4NEtXW6OnPlvHTWbM/6H8yMDB9+iEQYh+1Cy64Pkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FZ8PL+3GGOuk6/fAZbTo0CUqRmYRQP3kf3ivsxB49pXoYw6vw6fgrO9Pyi34LhX0s
	 cAwyjyYsFxASKkLmNYCc/DvRPETswENngEJfdEdOrDSOejKnozi+7qBYlRyJw5eaYT
	 G058aaxO/MjaFR0kqpzcCAdwfvc8JC73XzH7nv7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfJ2Vqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:46:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46392 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJ2Vqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:46:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id c2so152845oic.13;
        Tue, 29 Oct 2019 14:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ALIui8Hqesjcnb55YwwhQynmeSYlJfu7htCUAfgtTpE=;
        b=cLC4K6k3GvFxOT9/Ib+ZU1v+EvvKCGjsLI086h3e6sa2ih2YSw5XLflMCiu8i80+jV
         zZ6aAcgIq0hh4SMhlsGPcWUOcL7lbhbLmUHulnPbdx3jlFgsxd5GEjuCrbPIFyjB8sUB
         kBMUiavyJb5mmP5ToP34qrEadN8gDYDL9bokNwEC9cp9+eoelr8QYzMqgCM/vZqp30Hh
         gnp8rFj4JLbN7+1aAbqCpLlgP/7Wohf5JGYzlReqD9SLNjUNPSzYsCB/fuV9p69mF2bA
         fH8pThZnSi5UaityPz+hDlY44zWhLfqt8C/UwTJ31igd1YqveXu5BjmIXmExJW/y69jT
         9BfQ==
X-Gm-Message-State: APjAAAUgHtktq5FJrbaaWHdRZJ3wEnVRnkQaUH6To0WA4ESxlcyAgtty
        CozGFn36dvBLvbeHkBARoA==
X-Google-Smtp-Source: APXvYqzc/YNEjvH6prxzTLekXclhqdSh0nu5g1IFxo9X/gD0M/yx5Elmq/qLutCsqQeE6OHCqyHlyA==
X-Received: by 2002:aca:281a:: with SMTP id 26mr5820203oix.130.1572385612773;
        Tue, 29 Oct 2019 14:46:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c23sm12158oiy.20.2019.10.29.14.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:46:52 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:46:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH 2/5] dt-bindings: clk: sprd: rename the common file name
 sprd.txt to SoC specific
Message-ID: <20191029214651.GA24044@bogus>
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com>
 <20191025111338.27324-3-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025111338.27324-3-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 19:13:35 +0800, Chunyan Zhang wrote:
> 
> Only SC9860 clocks were described in sprd.txt, rename it with a SoC
> specific name, so that we can add more SoC support.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)
> 

Acked-by: Rob Herring <robh@kernel.org>
