Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259E0C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD9C2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565989543;
	bh=OJ2EctDnX9RAHJNI9TlipPl0o7TDmEYj7cYpQ2aZIsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v8mO0iP+w6JEkVAT6ioIwssu28xSf5oHoklr0p0Vm8/13elddUA2QznAhgs5Yb2km
	 49ZOiIEXsM4dEFwEmLelPQUFsMGg5TdkCNmQxwnn4mLUBlMpMn1RK8PMAeXcJ+BXij
	 MKw7FI9ZKEIaUhWiOTOqWfNPTOQXroOCM+FOnoQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfHPVFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:05:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41484 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:05:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id g7so5770069oia.8;
        Fri, 16 Aug 2019 14:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6kp+ij4N1iYYKyYuo9EunRtogi2ASQGFtI485lqWlls=;
        b=XFS2vleIjNfu0rejmhhjuIrFErSW/p6pxj/xZ0f1Eynn9Dp1GmcAaBjfSHAuOhpj/z
         WiMAGfMZeRAIhfFFtXp0UG9QAQQMCqnbxZjtIJmw2MQGeGbLaudM6RuJDNBse5gqvtsT
         exTs6SWUqRi+m0iqfF3+6mZy8kT1mws277RU48dOUStUB60dEPPl24ViwWnhy5afioPe
         IXMZYWixOAjz+F1jUbxqjXEMDzI0ERJeV7H7egFPjKdQhvDYqjignfcUb6wm8Hozx58q
         QHQeHDBJkjsKqxw1tdZODAVh+YcHKPkGFxcKtD7i3FV4VZBWdDLMv35SiMMBFwwTyWkA
         5OZg==
X-Gm-Message-State: APjAAAVzMidwv/5req+liPzPKeVG65wNEyMm1MkUenSrFkrA2oPR896p
        ygDIkhthy/zvghZQr5Zj5Q==
X-Google-Smtp-Source: APXvYqw+eETBOOyhsRthMA4bW8QoOXtxOLorHNA4vbW23rMawYntr/qdLwx77Vpq/O2pTtew0gQhRQ==
X-Received: by 2002:aca:5f03:: with SMTP id t3mr6465798oib.18.1565989540442;
        Fri, 16 Aug 2019 14:05:40 -0700 (PDT)
Received: from localhost (ip-173-126-47-137.ftwttx.spcsdns.net. [173.126.47.137])
        by smtp.gmail.com with ESMTPSA id 132sm1818607oid.47.2019.08.16.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:05:39 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:05:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mischa Jonker <Mischa.Jonker@synopsys.com>
Cc:     Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        robh+dt@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mischa Jonker <Mischa.Jonker@synopsys.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: IDU-intc: Add support for
 edge-triggered interrupts
Message-ID: <20190816210538.GA30424@bogus>
References: <CY4PR1201MB0120EDD4173511912A9FC99EA1C60@CYPR1201MB0120.namprd12.prod.outlook.com>
 <20190724120436.8537-1-mischa.jonker@synopsys.com>
 <20190724120436.8537-3-mischa.jonker@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724120436.8537-3-mischa.jonker@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 14:04:36 +0200, Mischa Jonker wrote:
> This updates the documentation for supporting an optional extra interrupt
> cell to specify edge vs level triggered.
> 
> Signed-off-by: Mischa Jonker <mischa.jonker@synopsys.com>
> ---
>  .../interrupt-controller/snps,archs-idu-intc.txt      | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
