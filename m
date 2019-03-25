Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64308206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553553035;
	bh=rOtJxdmhnaEaBn6oZpTzGQfR/BrregQvBi+ujajOrXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gfssJbrO8rcO18TYac4SDr2D2408dKGPS1ZqziiCevQJSBQU7CGr7odng1nGmQrBL
	 qVZeUYMs8QxUQuh4Vj4WXMclZCGXsT+QjEIELbWMO4cqCLWPzaJ9SKRxgZmpdjweQe
	 J0HfVl4uI9JVY0QvXg5RJRzypYktaipSQCM560oI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfCYWae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:30:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37444 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfCYWae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:30:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so9649968otn.4;
        Mon, 25 Mar 2019 15:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GsGYe5V1VViY6vQfPEUD+WJk1lcYn9lcSZgLixaQZiU=;
        b=aE4+a9RjdAgD8Zu1Zgb7I8H5EZ+tan9StVCArL2VvNWBw6yIFvIy0x9R/2fnAtEYZw
         z052808eaiCjMLJc8vJtC9eLrnyglTWo9DE2+qYmHSkxQSiPbOQwjnfmd8w069xixpes
         6aXWp7b0crwWZsLaYrGdHjNkeFbrU8MJp1k2ssl7JE5JeJlS6RKQH57gHMRoZJqiy0+o
         9IOKzvQXRqFBporrUKVPqVZ46WGSGGCwxk+ZQ9UNzKS+xsY1ZM50taoF0T9WdG+lwxS/
         1DJqbh7ntD+4nJSFlaM0U0yD0d8iFSyW7Oytn7nz8hnE3vo9IMLXAIKqcGDFnD9rtEK1
         9DKA==
X-Gm-Message-State: APjAAAVPmcHp4hM7kAYzeVExyb8OA0rtGyHzsb7hN/n7pKPIzLBaBZJC
        Oi3SnZX0fcWZR1aG8JJFXg==
X-Google-Smtp-Source: APXvYqw/FenOuv9IUj0YRaOWOcW+hcb35Jj9V2uHi1cs/g8UX/GegWF34Wy6vgkgeb/6T/+D+AMbaA==
X-Received: by 2002:a9d:7306:: with SMTP id e6mr19082631otk.79.1553553033082;
        Mon, 25 Mar 2019 15:30:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e12sm6871036otl.61.2019.03.25.15.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 15:30:32 -0700 (PDT)
Date:   Mon, 25 Mar 2019 17:30:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] dt-bindings: imx: update scu resource id headfile
Message-ID: <20190325223031.GA22935@bogus>
References: <1550663846-22698-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550663846-22698-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 12:01:59 +0000, Anson Huang wrote:
> Update i.MX SCU resource ID table according to latest
> system controller firmware.
> 
> Latest system controller firmware removes below resources
> which are never be used:
> 	IMX_SC_R_DC_0_CAPTURE0
> 	IMX_SC_R_DC_0_CAPTURE1
> 	IMX_SC_R_DC_0_INTEGRAL0
> 	IMX_SC_R_DC_0_INTEGRAL1
> 	IMX_SC_R_DC_0_FRAC1
> 	IMX_SC_R_DC_1_CAPTURE0
> 	IMX_SC_R_DC_1_CAPTURE1
> 	IMX_SC_R_DC_1_INTEGRAL0
> 	IMX_SC_R_DC_1_INTEGRAL1
> 	IMX_SC_R_DC_1_FRAC1
> 	IMX_SC_R_GPU_3_PID0
> 	IMX_SC_R_M4_0_SIM
> 	IMX_SC_R_M4_0_WDOG
> 	IMX_SC_R_M4_1_SIM
> 	IMX_SC_R_M4_1_WDOG
> 
> and also add below resources to support new features:
> 	IMX_SC_R_PERF
> 	IMX_SC_R_OCRAM
> 	IMX_SC_R_DMA_5_CH0
> 	IMX_SC_R_DMA_5_CH1
> 	IMX_SC_R_DMA_5_CH2
> 	IMX_SC_R_DMA_5_CH3
> 	IMX_SC_R_ATTESTATION
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes since V1, just update the commit message to provide more detail info.
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 39 +++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
