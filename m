Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B27C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1F120718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CB5Yu2xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKNMyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:54:08 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34880 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfKNMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:54:07 -0500
Received: by mail-ua1-f66.google.com with SMTP id s14so1829089uad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 04:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TabhCeemnbt5YWJd9CPxReqJBi1D8pdx95Mgt8aSEw=;
        b=CB5Yu2xuaym93+UTMULc25a86wS48QqpxftBXsTLQdXzTUA0toqFuXQyvSaBG1ePNW
         BoPd/uQG44ly2FV0t2Vxpg3zksylWpO/0dVJyu46UIvYM9aOoyzbocACIM1QxzaNDsj6
         eDkqhqLy6my9dbZRpzQieGFrFS4vkno4wSRePgCV7+QoDzx+TC8J0sDIipQUz6Avo2zq
         XvA/wZ5ALcek7yD+OMsBbr/0EEEjOaP8vGkeq6dz9TrRxu8kVzcuzPN7pKLSWCG6LvSV
         ktnYHh0pbFCizUl7ZUEV5JSGOJzbCB+Ru1WZ8Fe4ZWNsjLMJLhsB1rIoGBKvokNKP0bU
         ++NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TabhCeemnbt5YWJd9CPxReqJBi1D8pdx95Mgt8aSEw=;
        b=efYkVylSUy5wZf3fJfgoPb9uFvg1tuHGJ/3v+IJH4zXNgh31OF8V7ahp61fWa9VZyn
         rzmnuTAgbi4ay/452+VKaC7i36Ou9qQ8ZwSrJg1ntKNvMNCM7y4+HQG6MB7vXrYHhMuU
         ZloRprvMoJuBLCC4QeGDT4yu91jPv70eED/OfLc7A/D7ibT57li7cPovWcC+ULeOWYOy
         4n6w2H5vOYf/zaMTimuUU0HKYO5WzTswkhCqJ91oqUIYNFm7sLt7j5Ydhai9+BVsbedd
         u6ozZAue1nSrbrzR1GTLXrY80xRpZAKpTWUDm3/QrZ7BXAsQ3jkwcquv5ltYGnP+OBAi
         /BQg==
X-Gm-Message-State: APjAAAU2syZsKy2Vdqq5OyjeoRPnDFB1/wDKY3SS8v1QbJdCuQtyVlt9
        e0I4yMC4oxV9olPYr2FBNNlCN4kzKZu5UVckk0Q//g==
X-Google-Smtp-Source: APXvYqwA+J0UCOgnwqppP3NKFyifvH6MtwSxKN//hr4/ukqNE2SPBmLZyMZVnkJC9I1HKis7De+7tL7O3dYz+TSI3W4=
X-Received: by 2002:ab0:3399:: with SMTP id y25mr5316646uap.100.1573736046067;
 Thu, 14 Nov 2019 04:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20191113093616.32474-1-peter.ujfalusi@ti.com>
In-Reply-To: <20191113093616.32474-1-peter.ujfalusi@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 13:53:30 +0100
Message-ID: <CAPDyKFp15ZMq1f_xwrPSRbhU4M4SXhRzigA9-QMNBGSZj-YtJA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mms: Use dma_request_chan() directly for channel request
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        vkoul@kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 at 10:35, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Hi,
>
> I'm going through the tree to remove dma_request_slave_channel_reason() as it
> is just:
> #define dma_request_slave_channel_reason(dev, name) \
>         dma_request_chan(dev, name)
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   mmc: atmel-mci: Use dma_request_chan() directly for channel request
>   mmc: moxart: Use dma_request_chan() directly for channel request
>
>  drivers/mmc/host/atmel-mci.c  | 3 +--
>  drivers/mmc/host/moxart-mmc.c | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
