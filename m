Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F0C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3E02085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557781535;
	bh=/2sD6wnQr8i3pbkRay5w7Yft4AgIimBkaWU9cameuR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bgjOEJQPtPxiwYKXfSduSDoiF7MHJmqB2QqFhhHY6jLg7KpeWjIIBO60qzclVlask
	 xiYpyuNE/RxCds7c7RFZjzlZszdKpX0iC952EEpqyCcKqmvX5fiTVTrIqiB0lD01jO
	 1OGf014DvQvVA+crj6N3mEhZSMFdOroLIE0WXDno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEMVFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:05:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39272 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEMVFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:05:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id v2so7060866oie.6;
        Mon, 13 May 2019 14:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8igH6VcpOe4MJRusI7X36IMlgRJzi9m9KzOWRsS5pa4=;
        b=ThpQn6HHM1Dv5jVskiikf9NF363FlP9qbdJQpDQbGv6l0SNlyCTf9cvPDZo9BM7y2B
         tRx0SqQo/z384pSh6MyDC7XCPwurdfX2hagF2XE0DBK9Cpp+Lh48vuf317Hu9gV2sHRU
         5KBodo05WdJR2KASuraTRpV80tBIv0C8dvqy03N0sh9raCCx/JkkAWFI0Ckw3dmwMvEM
         fZ/iSMvGcVr/TnUkIEAzTrW9d27+wnH2NPUE1HcdHvWKsNMry6+bw9wYeKDC/9ZAz5s/
         GlBozlUpOm2TktDZy8Ev36WzKrEVyrHe6Lh39V/rEYKDVOgEYDAtshgDEvO4XV1pzoAg
         fV5Q==
X-Gm-Message-State: APjAAAVdhTBr+jo+gVmTkutYUAYmdHHQnm0yTsl4wql2XrfO+dluZ6L3
        UryXHowUPc3gFyKZwtZijQ==
X-Google-Smtp-Source: APXvYqxKflF7N+x1k0B3NpB3Xen8KZsgGRykLMEbCpQ44syZFjDZS8d2vIRTPJiuweyu7onVk6Xeew==
X-Received: by 2002:aca:4d48:: with SMTP id a69mr725895oib.113.1557781531618;
        Mon, 13 May 2019 14:05:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k65sm5561527oia.16.2019.05.13.14.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 14:05:30 -0700 (PDT)
Date:   Mon, 13 May 2019 16:05:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: fsl: scu: add ocotp binding
Message-ID: <20190513210530.GA30749@bogus>
References: <20190508030927.16668-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508030927.16668-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 02:56:02 +0000, Peng Fan wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller(SCU), the ocotp controller is being controlled
> by the SCU, so Linux need use RPC to SCU for ocotp handling. This
> patch adds binding doc for i.MX8 SCU OCOTP driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Aisheng Dong <aisheng.dong@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Anson Huang <anson.huang@nxp.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Move OCOTP to end, add example, add "scu"
> 
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
