Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6562C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D5F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414926;
	bh=11SzsYRFB0GDLMTPFbsik0z5C6qlE36Wwo9bMaMNwUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KTiJfhyhe/ImTe3vvvfRjTZOYcngmPFKj376ZB84viyBZOz9bWpRui2JiRPz0ePx/
	 HlgYJJ7PB72tyBtw7lfGlodNYg4OVZhFodog4lhlWFqXpNzA8Hmf6QUHW/Gk5LGXSV
	 UJ17VTTPo0Yf8qavtOfRjw7xP6Mj+E+zxjnGrAZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCLSWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:22:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37756 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfCLSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:22:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id w66so2932279oia.4;
        Tue, 12 Mar 2019 11:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rguTurrJna+8BSqp49mlXLN0HCpHPcyyxJFG5nxAGS8=;
        b=Lp57G4k5ev0j5crZF5K2X5T5zT+cTEpliEpOMlISxKdqIxGa2fz0auhOpAfgso5et7
         7n6CGP+2dxqqx4lmMBXdb4TrPuUvVU73Nbz7TUqQdLO/Jyx723GmyfzDf+vHvi0jeqne
         FqrP3x2Z8t175RlIL4Vc39PUCyT3jBgU7TclSuQz45bkKX/22JdpVsO4liCiewlKdPCQ
         +q2e8rYoeXazIYgbv+J9g3LbTl3kz1EMchNanvWpWrYNM7UPghW5BjcxHmkBLFSU0uGf
         0hT2W3wAaQBUgEoNbEj3YB5l+JQfzx/RTi3+XHDjONJc86wKjHNayucJ1Z0Oul/mkAgz
         u5LA==
X-Gm-Message-State: APjAAAXhQVs3T/xvvrlY/VnaT2K3LTgeYnGUPtvEZdWalm7JfiOnY/AN
        rAwrstsG+Yy+FkOFsrdp2w==
X-Google-Smtp-Source: APXvYqwQIa0daORTx/syEQJunCO/5M6phMgbGl3Y59mpIjS/gUQnS4tmcRGM8UgLgIBCzqHb47b9LA==
X-Received: by 2002:aca:e690:: with SMTP id d138mr2635347oih.109.1552414923979;
        Tue, 12 Mar 2019 11:22:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i16sm3597245oto.77.2019.03.12.11.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:22:03 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:22:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: serial: sprd: Add dma properties to
 support DMA mode
Message-ID: <20190312182202.GA10396@bogus>
References: <cover.1551689518.git.baolin.wang@linaro.org>
 <5ef1bbcf1d78829f28377a599d81d0adc7d61ef1.1551689518.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ef1bbcf1d78829f28377a599d81d0adc7d61ef1.1551689518.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 16:58:23 +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@unisoc.com>
> 
> This patch adds dmas and dma-names properties for the UART DMA mode.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/serial/sprd-uart.txt       |    6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
