Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6212070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553613132;
	bh=9K2v4+21nGzr54bKaKVVw3DJ5qmgz5aJJ+PlNxUo4tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MbY/1VIgqporye9ZbDNWzFxDWD1aG5Wd8bV/9SGb1+JQZvYeCBrlPkZfJSvwm0rZh
	 hkzI8aeP4cB1nFl4yFTh+kjm7yHxlnp6DWz98aU0tm1DifZQhjaa26WQVg+XtAZgMM
	 /wzgaij2ivnPFbYNkGLnypBejhyBjLm3HxcAHGeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfCZPML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:12:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38809 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:12:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id w137so10181958oiw.5;
        Tue, 26 Mar 2019 08:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJb7ydaU8hTdfO/iMVhL/H+QruagqPyslzxtLe17XYY=;
        b=lB1wcWXNAT0png4DXFvtwy0XkHNFdmwgX4PsvMgsXD918szRojp1NFKresrKorW4j9
         X/2YjEsbn0t5rD5RgVmzfLaEv4Pr+3W6IaOce/y/Eeh/zdb2qcj3wov1JvEYpwf4XQJo
         KZOwawdhj/0+UD/18iUBDzBdbN04JrLy0NKnXUeYbMC53CefOAcMyxAhK3xEOezps839
         NvgVl/kOKkClNMpKOS8hRfpuFeiooAdomgGAYVBLWv+q1jSFOgTJJzcPXk8Ek8zw8ypm
         eowp0w/1UlLCYTlGNSUzT1b+irfve89LPML21AlnBjzIMNsALktQkKvpNfX2IzpEJK8n
         LPrw==
X-Gm-Message-State: APjAAAUtNcJbM9/MZSzoBLQIgV6mdhTw9h29hBWXqDUbWSYwLrW3aWl3
        D52eDONatwsQDsxG6JOtWEVfBKA=
X-Google-Smtp-Source: APXvYqwof3dapU2q+5bmoe+IXYJj/sPkPw5Q5N3NPNJA2gyQFPBHs4Mqt06cuMvJXnaA9PbRsBl9UA==
X-Received: by 2002:aca:4507:: with SMTP id s7mr5586456oia.127.1553613129940;
        Tue, 26 Mar 2019 08:12:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w141sm4818364oie.1.2019.03.26.08.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 08:12:09 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:12:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        broonie@kernel.org, bbrezillon@kernel.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, nagasuresh12@gmail.com,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: spi: Add device tree binding
 documentation for Zynq QSPI controller
Message-ID: <20190326151208.GA12727@bogus>
References: <1551337313-9499-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551337313-9499-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 12:31:53 +0530, Naga Sureshkumar Relli wrote:
> This patch adds the dts binding document for Zynq SOC QSPI
> controller.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
>  .../devicetree/bindings/spi/spi-zynq-qspi.txt      | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
