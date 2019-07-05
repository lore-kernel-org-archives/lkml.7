Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB8C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEDB2184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfGEPre convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:47:34 -0400
Received: from mailout02.agenturserver.de ([185.15.192.33]:46386 "EHLO
        mailout02.agenturserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbfGEPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:47:34 -0400
Received: from mail02.agenturserver.de (mail02.internal [172.16.51.35])
        by mailout02.agenturserver.de (Postfix) with ESMTP id 1AA7B1240ED;
        Fri,  5 Jul 2019 17:47:30 +0200 (CEST)
Received: from localhost (ac02.internal [172.16.51.82])
        by mail02.agenturserver.de (Postfix) with ESMTP id 08E9080758;
        Fri,  5 Jul 2019 17:47:30 +0200 (CEST)
Received: from mail.agenturserver.de ([172.16.51.35])
        by localhost (ac02.mittwald.de [172.16.51.82]) (amavisd-new, port 10026)
        with ESMTP id a934Vr1f9rZE; Fri,  5 Jul 2019 17:47:29 +0200 (CEST)
Received: from karo-electronics.de (unknown [89.1.81.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lw@karo-electronics.de)
        by mail.agenturserver.de (Postfix) with ESMTPSA;
        Fri,  5 Jul 2019 17:47:28 +0200 (CEST)
Date:   Fri, 5 Jul 2019 17:47:27 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error
 path
Message-ID: <20190705174727.30c616aa@karo-electronics.de>
In-Reply-To: <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
References: <20190624140731.24080-1-TheSven73@gmail.com>
        <20190705072847.GA2911@vkoul-mobl>
        <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Jul 2019 08:26:12 -0400 Sven Van Asbroeck wrote:
> Hi Vinod,
> 
> On Fri, Jul 5, 2019 at 3:32 AM Vinod Koul <vkoul@kernel.org> wrote:
> >  
> > > +             if (ret)
> > > +                     dev_warn(&pdev->dev, "failed to get firmware name\n");  
> >
> > if should have braces!
> > Applied after fixing braces!  
> 
> checkpatch.pl output after adding braces:
> 
> WARNING: braces {} are not necessary for single statement blocks
> #102: FILE: drivers/dma/imx-sdma.c:2165:
> + if (ret) {
> + dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
> + }
> 
You changed the braces in the wrong place!
The comment applied to the previous 'if (ret)' which has an else clause
with braces, so the if clause needs braces too.


Lothar Waßmann
