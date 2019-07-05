Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8876C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14B521850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRDlErc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfGENK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:10:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46378 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfGENKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:10:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so9217278ljg.13;
        Fri, 05 Jul 2019 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEyJOO8kYpWKc8QSO4ONNsoAI/4yuJeK2ThjsKjv10k=;
        b=DRDlErc+0kXzUdgaWp/ZaB5wi4aw2JvkIenojy2RYxniLxqdRdE7OhHk0OKezKjMk7
         mIzCmiFXicrLQFXrtAAX6Unu/lcDVUEBUYzcgoeRMca058CIp+veHiSR+0gEpAbVKtdA
         pbiHoscgX80CZp1rxPQNTLcgrMO+R9VxPtTu41FBuWk+MaLsV1cBZ5xS2tJookUbOABF
         VXJN6mCyQCDTPR37XXptcuKGQs7k5BORHje6PuZLnEzbIrVo+JciviDWdwF2vPVwqHNo
         Qr5FiOL24R528bv7CD14UXtyeraMCivrT2FwgeBjOZ9PFta4+ELpHCfCfl8l6i+vP6oa
         f9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEyJOO8kYpWKc8QSO4ONNsoAI/4yuJeK2ThjsKjv10k=;
        b=Yk9F1BJiEZ5DXaCNboeHtXhPuH/LRTsKlqcPVcakW6CKCjtJu020XshfWsw8NUEQIh
         ZDrKxpWX+ZA1i7agnwb7HEJMIxXSIowK/KLzdKhRvSDOanA5dhOWlNy/eKhxtjF9BfLt
         kCTwCWW4bajXV4TmlN9E/Fh97dl0AyzQDHXT8Uqbwayod6jTVZY7+7w/kWqqji32WJJa
         mlQRTKncti21e2AIsBu/I+r37iNHcDfKLghY1g55gMXCqofyzAcGZg9w4nPtnxTt262E
         sTpNMuYgomGr8Y5qwgniCZdBcG5G2yKrBEoTLB8SzZ7I4JtzcoE/1+QEfbgNx90IBiOi
         JYIw==
X-Gm-Message-State: APjAAAVvIbxEvAwU3ieOc7lFbdKZ+jFqy1KYXJ7BXHXHeH4/ZrP54CF6
        zBBD4uvvJ19o4ZvbTRdSvYs7Cc8vWYvuxM7ds1DRCAW9MFE=
X-Google-Smtp-Source: APXvYqwWNOMyja5vtXudK/+kFDlFUKXSubGT1Aa9J+3NDl4NBx2ur1SfoYASTVZgHZ/Y44Dtc7FNDsRtfKOClAQi8e0=
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr2152456ljb.211.1562332253406;
 Fri, 05 Jul 2019 06:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
 <20190624140731.24080-1-TheSven73@gmail.com> <20190705124646.GD2911@vkoul-mobl>
 <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com>
In-Reply-To: <CAGngYiW2+sBv1WqB8+csb=mZm2owziJ5wWcWLNPy7=m72ppypw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Jul 2019 10:10:44 -0300
Message-ID: <CAOMZO5AeA2PryHHNqxfhTYjJd-QZrm++ctjuuiTzpGC4UuxZ3A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error path
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 10:09 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> You are of course right, I was looking at the wrong if.
>
> Apologies for the confusion, I did try to look at what you
> changed, but your git repo listed in MAINTAINERS appears
> unresponsive for me?

Works fine here:
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git/commit/?h=fixes&id=2b8066c3deb9140fdf258417a51479b2aeaa7622
