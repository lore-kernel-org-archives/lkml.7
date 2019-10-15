Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F99ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54CB2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571178344;
	bh=Xsf3guoUud8iWBZbnGRMUuEUq8NaKhvHxI1wkJ/kosw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FMoOoUeXs6aRMMXjFJ0WESciDHmV3QsdXFF3fBls7iOW7iYnPpdJJJjTUyoJcyuyS
	 ABC7NxyKMLUMHkuMM8QVqg7Lvfe+rfMMpnXzwevfcWxt/qx3kMm7x+glK3/RsyzlBQ
	 epSiLdtwYr1r101Vz35NwaY+yDz6lBkr4uD/caxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbfJOWZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:25:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32773 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbfJOWZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:25:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id a15so18319880oic.0;
        Tue, 15 Oct 2019 15:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tpZzHubzWvtT+e+zyO26iki0QI2tO46rJ2oh72lmgVs=;
        b=EkGxJ2sBlLZC6If4f71niSgGD9CN19yN4qz3iAY/p5fd32Y8zC9fEQ28AgAWb1YZv8
         mOtVVkvYuDdx5hBFJEGAwllolsjDzjUfz6lRj5s+PpOiw/mZOOCITNLNa3gQUCWsByIf
         +MpxW864sISM9MP7TJJyr6zc47N5+o8egSHtnGIEIzRkIOE7BvnE6DE4+6xg6soQd6Nm
         UKL1s5GG+IsonDmYi/k8d9H2VphXsP+uKCc4VD2bfOTabrFEA6bK/e/68D/ngYnEbWkZ
         Mn3cZRSsS+zsDU1+I49eGipby2GaJm/dOKt8dxTUroEjQOc8BgShizZBgO+ZeLCCgv75
         tJoA==
X-Gm-Message-State: APjAAAWtVJo4lDcW3/q6xyAO3rUSP8rXQ029tFTVNbF1gKJZgyps26/k
        n/4t4h8wuIc9DKN3dbkBSA==
X-Google-Smtp-Source: APXvYqzXJ6yRVpNf0oqDJd6fjxHnHGZXaCrTI1YnhJhr065Sbh5/U0tQmOOWaN3izrkWT3c6WMXQMg==
X-Received: by 2002:aca:fc41:: with SMTP id a62mr783767oii.92.1571178341934;
        Tue, 15 Oct 2019 15:25:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 36sm7085167ott.66.2019.10.15.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:25:41 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:25:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 1/2] dt-bindings: sdhci-of-at91: add the
 microchip,sdcal-inverted property
Message-ID: <20191015222540.GA13117@bogus>
References: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 14:34:31 +0200, Nicolas Ferre wrote:
> Add the specific microchip,sdcal-inverted property to at91 sdhci
> device binding.
> This optional property describes how the SoC SDCAL pin is connected.
> It could be handled at SiP, SoM or board level.
> 
> This property read by at91 sdhci driver will allow to put in place a
> software workaround that would reduce power consumption.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
