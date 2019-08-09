Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5566BC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FD320C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw+oLUAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfHIT63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:58:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44469 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfHIT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:58:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so46355477pgl.11;
        Fri, 09 Aug 2019 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VCbCImaeM8b+lSq9b5GdAInVj6FUq3y4HZVgqjfUX78=;
        b=Kw+oLUAxF2xxa7RFNdoD7DmGpocjBPvMlHmmMmL5/etDe1Tt38kDjqNzn7BakcQozY
         hxSEPjM5Xm9RuXFZxikLSc712ri71mgNhwqMMCfZECvg5XFueWEjk+QBrjlJqvawY89w
         JVi+SILsovZ742bj7b6ctTI7RqJOMdc4N+qSmLINodL+CqdxPpFQyba7Dg1Veo8nxy89
         5g0lAZJkfGMsJi3MVaA71iAXyKgO2eo2fEe86jSPJzumEk90NqF1r35J3lhndVRigHvI
         1wfTydffNCtLrzfblDWprgfw5q82Y2pJpWtoln7iVuuKmCKAVE/ptSi3kvI9LiUpPOvW
         Ihig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VCbCImaeM8b+lSq9b5GdAInVj6FUq3y4HZVgqjfUX78=;
        b=NFjHv3+kDgw7ZUZ5KKbm9gDqL2LnekATKFJdQAtWB8aVUwp/QovFF7hH8mxh0rqDP7
         oTM3n8WrS45sMmq/jcUFAvTzwe5geqWwPFElYdQoDonZCjSuF1Wz7EC7J7YwBlXtXk56
         z4eAEJ+RaRNebrPFHjXazrBNoygcm/XJhEcB15hytkAbDVTzP/0CIe1LYUoljF5UTddb
         lFc5VyRhtOD3XEib0VyPTU7cI2J9B/g0L4OrqIA+cJFxwR4RjWoKRfEVB5ctF1dlBBTx
         VL2mZm4NQHR9kssYX8QkEJrkGgCLOTjPZZy7j1MDOoUILSpTOkTw+FUgRTIPOE1u63SS
         6Y2Q==
X-Gm-Message-State: APjAAAX/hkaKDAWfyjZm18Mjds/ZVjibVwBAkX4VaLaLjrYt8R2xuHyQ
        P4YZSuVHLsmLpavchgxo3wMv0OLT
X-Google-Smtp-Source: APXvYqwr8vYcmauTzmL6JZ6snH2j18Lcbrgl3NoEzcj7F6farIZmKNhOtBqj2Vm5a48ynNus84SThw==
X-Received: by 2002:a63:60d1:: with SMTP id u200mr18948265pgb.439.1565380707327;
        Fri, 09 Aug 2019 12:58:27 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id f197sm97530357pfa.161.2019.08.09.12.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 12:58:26 -0700 (PDT)
Date:   Fri, 9 Aug 2019 12:58:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl_esai: Add new compatible string for imx6ull
Message-ID: <20190809195812.GA8148@Asurada>
References: <1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com>
 <1565346467-5769-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565346467-5769-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 06:27:47PM +0800, Shengjiu Wang wrote:
> Add new compatible string "fsl,imx6ull-esai" in the binding document.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  Documentation/devicetree/bindings/sound/fsl,esai.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> index 5b9914367610..0e6e2166f76c 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> @@ -7,8 +7,11 @@ other DSPs. It has up to six transmitters and four receivers.
>  
>  Required properties:
>  
> -  - compatible		: Compatible list, must contain "fsl,imx35-esai" or
> -			  "fsl,vf610-esai"
> +  - compatible		: Compatible list, should contain one of the following
> +			  compatibles:
> +			  "fsl,imx35-esai",
> +			  "fsl,vf610-esai",
> +			  "fsl,imx6ull-esai",
>  
>    - reg			: Offset and length of the register set for the device.
>  
> -- 
> 2.21.0
> 
