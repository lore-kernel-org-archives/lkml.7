Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDAECA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C9B2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572525108;
	bh=3gC0c8xf4sCBaS5ebtExC9nC8bUlZk2zHzDGkJobUkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HpJGYAuqTTPknZzzABJxTFg4qm+4SNFFmyi3ubXQSpxioxrpTIQBdedXJAfk6tAMi
	 8NgpVzvs8itXxfOfnlaocOwd8WciIK0YnHvw1eJj/mu7oP1uS/jJAIR80c8UPvOMgv
	 GaCPnKegPN2zEvgTqscwzuN6SLx0xIGfzFAOX5Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJaMbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:31:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36470 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaMbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:31:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id f7so1524380edq.3;
        Thu, 31 Oct 2019 05:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vls7ZE/ReY4sJGi7uI5GGsGPMcKXRM5Mo/neO76jsVQ=;
        b=M9yJ+S1BxObJQHLnBu5f+lru0srve7kRgdcdJ2vxqjSzJezaRKp9oROYWOEQ8IXHV/
         LalHTP3uzA8G1vRzR2Afy7akgHzTfODf7fB9otnBnBYn/BlYufvoH4IdgRECbtFurc1y
         httZioRoq6vp3vXD7q9F+UVO+Ra+ty9Hxq3oti84WzRa2Qul4gu8a4DL4hihFDQM8q+n
         IB4APNdioDKfBqHVydKQZfYA+ZqLGW4ZKZigPginRfN/uSnUn02lktWEWUo29NVChRn9
         sviuhzWtFmfZ3ZfoByBVZRuPGU6UsIdxeHCTNRkrjKTxD98xNfZWxSB0F2ohuCuGdifj
         i6tg==
X-Gm-Message-State: APjAAAXAj7mhJD6Lkg+U7wVprbGF3MYeuPxs127RXFUTm6gxvwZBRocc
        DxrEgPkhx1tpTDyV5llfmAc=
X-Google-Smtp-Source: APXvYqxv+iB25I5NrbvVPiR7XWHGPnqcPx2J39IflRtWXVi/n7ge7s91adZiNxuKFrKu9WoulT7Cdw==
X-Received: by 2002:a05:6402:110c:: with SMTP id u12mr5701239edv.127.1572525104909;
        Thu, 31 Oct 2019 05:31:44 -0700 (PDT)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id s16sm57296edd.39.2019.10.31.05.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 05:31:44 -0700 (PDT)
Date:   Thu, 31 Oct 2019 13:31:42 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] ARM: dts: imx6ul-kontron-n6310: Move common SoM
 nodes to a separate file
Message-ID: <20191031123142.GA27967@pi3>
References: <20191029112655.15058-1-frieder.schrempf@kontron.de>
 <20191029112655.15058-2-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191029112655.15058-2-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:27:44AM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The Kontron N6311 and N6411 SoMs are very similar to N6310. In
> preparation to add support for them, we move the common nodes to a
> separate file imx6ul-kontron-n6x1x-som-common.dtsi.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../boot/dts/imx6ul-kontron-n6310-som.dtsi    |  95 +---------------
>  .../dts/imx6ul-kontron-n6x1x-som-common.dtsi  | 103 ++++++++++++++++++
>  2 files changed, 104 insertions(+), 94 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

