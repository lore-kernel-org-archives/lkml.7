Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76FEC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865C12467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576788072;
	bh=Kn9ApuXG3x4C8dVCuqXzHtJcrNaSMljuoiywDbjjy0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RM9s3POZKZBrRaFM4UqZr/DjZrjscM1mneuiqqpKe1tI9r2Rhg9+ySXsLFtbUChq9
	 DVsDBaEFB0sXhZmQSL9p1cJcmAYzIBQYPFkxOy6mzkLUwMvm1fuKLhtFtaDZOls4fs
	 5fC3bnlck9xT5cs8av5ODMfQpTgAXwuR0EwW4bgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLSUlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:41:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35612 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLSUlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:41:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id k16so4200649otb.2;
        Thu, 19 Dec 2019 12:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ByzWV9jQ42I8H61pJhTEJg2HQzKM8ixPWx+v2AukYEM=;
        b=YGaE4zcB9dhfJrrsFPlc/rGmAGykG8tf4Sb1iBfm14IqXGVY0a47qCUiNOlgsKIJTi
         FF7MAuMkHursrxZxET503MydjyhLWNA0YpDQOZVvuHImnt8CbA/Q0W92a3cqyKnaI2GC
         +Dankg2CRDzKGxHCjdUuSsDSGRCM1zAXE9PiQAkqbgaRPv1H0eWn1ZZqPaxxtH0BHn7C
         5mPSL7/PWrCuvlcnmYAYiVy+t7ZMSAYUbtBRk0w4SzQqBrghIe/+bnfFCfbotzElJhOa
         mwxidMUWqwUy6gNRFDrjdhZItnPutdxk44E78Z1T4iv5WI29tB4T+tbu9BGRilu8W6AI
         cLgw==
X-Gm-Message-State: APjAAAUWsAPGJS/hqWXbdDmbB0OAxzXLDKn2RHqSXksCJwIsr6TpEYoW
        DYHSlUcnjRjjYK1WNuctLQ==
X-Google-Smtp-Source: APXvYqyjooKf0liQejF9UvfBxpvsFYqG02ef2XIHLdG9X32cx+nGtgWDEym6T58BParbzR1dPtH5+A==
X-Received: by 2002:a9d:65da:: with SMTP id z26mr2006772oth.197.1576788070351;
        Thu, 19 Dec 2019 12:41:10 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id j23sm2333837oij.56.2019.12.19.12.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:41:09 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:41:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org, Dinh Nguyen <dinguyen@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: mtd: denali_dt: document reset
 property
Message-ID: <20191219204107.GA7670@bogus>
References: <20191211054538.8283-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211054538.8283-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 14:45:37 +0900, Masahiro Yamada wrote:
> According to the Denali NAND Flash Memory Controller User's Guide,
> this IP has two reset signals.
> 
>   rst_n:     reset most of FFs in the controller core
>   reg_rst_n: reset all FFs in the register interface, and in the
>              initialization sequencer
> 
> This commit specifies those reset signals.
> 
> It is possible to control them separately from the IP point of view
> although they might be often tied up together in actual SoC integration.
> 
> At least for the upstream platforms, Altera/Intel SOCFPGA and Socionext
> UniPhier, the reset controller seems to provide only 1-bit control for
> the NAND controller. If it is the case, the resets property should
> reference to the same phandles for "nand" and "reg" resets, like this:
> 
>     resets = <&nand_rst>, <&nand_rst>;
>     reset-names = "nand", "reg";
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>  - Split into two patches
> 
>  Documentation/devicetree/bindings/mtd/denali-nand.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
