Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A09DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357C7214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551364272;
	bh=m2pDxgNGkgk70lhzRJY6tIpOwh3xJ7oNqiILk2vCkrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LQ3iHBPUySOsXHg6RIfotqc01r0sBMpQNsflKC6LDuhWXbIwNdQG9yjEnrRg9pP+5
	 i6+ihcYIpj+VBu1f3B5x6Wx5JuWGHqWynY7dyfyDI9BqGgrqUokH4Fm0+RugnajPa2
	 W2ve8faf1XRIBM0NE6yV8vy+O/LkZjdC19dXb90U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfB1ObL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:31:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41033 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1ObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:31:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id t7so17782018otk.8;
        Thu, 28 Feb 2019 06:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CO5FZ7Mv+gBeyW3C8Yob2MZh6+++sAh8fpCvr4zsm6k=;
        b=sjvG9XLmnanw6waZNQw1z7QxcuZODUisMUpPouBjP2Zalk6Hzn0WB3RdlLE4sufGit
         QwZwV8r5TZ+d/bYAG99F2dMb1hzFWI3IitJ8nVnZ3kevtTCncd9cIl0WPgagzxircMHZ
         X8xlHQOf59nj5zn2rtDYVKsgIfNcRo2x6OI7Hvlcdc7AoboIdDVNmljGOufQr0MfZKm9
         /JmF9cAtUyt5Y8i4ntwl7/n/Y5n5TWV8o1yVWn/uf99hQhd1u7p9K86mndXaS/mo+bdA
         4wrcUhdhWR0GYIcClYgbbhjIc6ohiBEfeEZB2o4xaTpAvtkpbhnEbBOXlVvTg6xQ2xOR
         1m3Q==
X-Gm-Message-State: AHQUAubM3Tm03QF0VGDVx+CjR/VCR/OcM0Z7RE7zGa+G1dwhgtcR95A5
        4yng6kgCjRVNHxAfojpXwA==
X-Google-Smtp-Source: AHgI3IZJ0fEs3HevduUcuwqjcWR+5pMbHq59t35aILn697/Ku3ARHxS8i6plSnh90AxwOn4oB1yldQ==
X-Received: by 2002:a9d:6ac1:: with SMTP id m1mr5534029otq.246.1551364269439;
        Thu, 28 Feb 2019 06:31:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u79sm4226546oia.45.2019.02.28.06.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:31:08 -0800 (PST)
Date:   Thu, 28 Feb 2019 08:31:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v4 2/5] bindings: fsl-imx-sdma: Document fsl,imx8mq-sdma
  compatbile string
Message-ID: <20190228143108.GA16838@bogus>
References: <20190227063737.24445-1-daniel.baluta@nxp.com>
 <20190227063737.24445-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227063737.24445-3-daniel.baluta@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 06:38:11 +0000, Daniel Baluta wrote:
> Add imx8mq sdma support.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
