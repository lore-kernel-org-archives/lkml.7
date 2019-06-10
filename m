Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1E6C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876182064A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560202953;
	bh=F+4V9SOVQ4v75Ak6utykZfRgzCBn/IT6mnI8WtAlVhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rMvSbJJ9nGD/Rq//cucZ80EXEJ/rBIT/bByIMlS1FW1dOXfbbFmpqGkXW8QsLPPvK
	 7Q0xp0HTTzCeZXz/oNZ1yg1GZpXunTjbWxPPASbczYPIoBNdbCluJ9uWgWb1chCD8f
	 lvUTn7UP5XltRJfppfOKLxmMQM+jVbo/RYUt+yIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbfFJVmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389362AbfFJVmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:42:32 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C882086A;
        Mon, 10 Jun 2019 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560202951;
        bh=F+4V9SOVQ4v75Ak6utykZfRgzCBn/IT6mnI8WtAlVhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ILfeiq9bDt9sa/mNU2tx1noF7fSXMAMayhPvei97KNxQJGUq9GwKX/Sli4Wwv/ptf
         Yb9IRFovTLfDL9cJk8YxSpo/p/WdAI2UX2fCiSh6o5Z5wrg7O/VBzKagLyChPhO9Q5
         p7nsIE90E4lr3+5/Lp2jm+L+Z9IE2FEd6+ARjJPI=
Received: by mail-qk1-f180.google.com with SMTP id r6so6387351qkc.0;
        Mon, 10 Jun 2019 14:42:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXh4yYsEeH6MgvUT4nBBeUO6JaXDFMbSCD2DEOlaF3OibE7EcCf
        X5q0C2NpRYcPpgDGG4igOhIc8XNsHB+sbRlwyw==
X-Google-Smtp-Source: APXvYqxCG6PLxtYipbTcy/F82w3PywXJMfmgHZG+LKSYUxD5Wl+vqLF/bPa9yqVS6XKUs9krDfuWVpe0odr5pfiYhMM=
X-Received: by 2002:a05:620a:13d1:: with SMTP id g17mr2403350qkl.121.1560202950612;
 Mon, 10 Jun 2019 14:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190603012747.38921-1-Anson.Huang@nxp.com>
In-Reply-To: <20190603012747.38921-1-Anson.Huang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 15:42:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+HsrQkJpL1hja=NxyQ6qC8tZBDxc9yxKSfSSBo_SrX5w@mail.gmail.com>
Message-ID: <CAL_Jsq+HsrQkJpL1hja=NxyQ6qC8tZBDxc9yxKSfSSBo_SrX5w@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: arm: imx: Add the soc binding for i.MX8MN
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        Bai Ping <ping.bai@nxp.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yang-Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 7:26 PM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> This patch adds the soc & board binding for i.MX8MN.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
