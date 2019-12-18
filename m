Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E08FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E530524682
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576704648;
	bh=Aaw8bqeuwKLaKaus7/9b7wfhyqb7XTKUGuC14jgVL8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ulvDE54mn/n2/duw9+CnZb7iBoLzDkuvKfas0AFScussvvXHctFTACyPR+9x0eWt0
	 eJhlQLUumiQFmah8ygKsk1LUEFuCZWzw44NylEfMm61IHvhpliak8/clorkP08/oJ/
	 nn5zkfKXXveqP9uMYXxmXGj6S89u4D2NhiT6KKcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfLRVaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:30:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46337 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfLRVaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:30:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id p67so1942879oib.13;
        Wed, 18 Dec 2019 13:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MAoxs8ntWk0tuyEX1F/HNeRjYT+BiD3Hf+/ykUWAb54=;
        b=ZBnmVtosmTOr63G6gBzBgWNMsBdNPxWgvjnAK9hMEUpp+Rk9qFsTOc8nkY2PHJeBuB
         J5VVUWTbT9BPZVy2T4A526eu3hcrABioonSI0kPUqo9hfIAy27K7pBRMFUoE+3/oX0Mt
         647KB6MwllpLxsUVC4BF/gwcjtbKK2L0phwL/HD2O32XsfGeF+thBOFVbBk9rWx85wke
         9KcxiAjHEPxqVsmd+CljNc8uKb050XhqMi608e1BulfqtHgoNAGbWIW8tyRgc6tAtHOK
         s4D2fCm9+l+IVYlxmDha2fwvbOv8dZ23WCQCj7BBSYkOvahDn7qn9+Qvkn31+5ho8C3A
         G5Hg==
X-Gm-Message-State: APjAAAUnQa72J/btkEIyqK4fbcTRodF9C9yr7LMGzRBZI2cU7r/HQYt4
        ITPGD88OvT3nu+epeK+cjA==
X-Google-Smtp-Source: APXvYqzOYIrbh00w5+gVGRTKTGRbuD3LSauqvU4OsBqaFaSbAlhvR5QTPyYYcWRiv1nhJulPpHUTDg==
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr1427670oif.55.1576704645338;
        Wed, 18 Dec 2019 13:30:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t196sm999034oie.11.2019.12.18.13.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:30:44 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:30:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        spujar@nvidia.com, josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/19] dt-bindings: soc: tegra-pmc: Add id for Tegra
 PMC 32KHz blink clock
Message-ID: <20191218213044.GA20965@bogus>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-8-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576613046-17159-8-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 12:03:54 -0800, Sowjanya Komatineni wrote:
> Tegra PMC has blink functionality that allows 32KHz clock out to
> blink pin of the Tegra.
> 
> This patch adds id for this blink clock to use for enabling or
> disabling blink output through device tree.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/soc/tegra-pmc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
