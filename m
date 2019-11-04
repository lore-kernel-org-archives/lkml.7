Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B7CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5720F20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zc1uRzF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfKDPUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:20:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32968 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfKDPUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:20:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id y127so12543601lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWIcS6Kmcinpk4nazH38gksGZeb2V5O9XJjjx6H21Q8=;
        b=zc1uRzF40CpT6LkCRwwck/CCCxwcxTrBQVaJv5/aHXhXLsGWCoT60D3wxJkb0QrznY
         K54Xuuex7dbG1qBAFgp1gf4crcrXjrajNMsPHoTCOpaH93oqP2l6NpmAe128gLDaXXLg
         yzaGFREMiBKw0T8NTU9AjwlQsv9MiITfUUicI6ryR/otQbP3royH+MiBCg0UxfLbMhxc
         mzYGabnkXYbzgX0uXlqdxdijf/dy79voiwy9F/VF5G0eUCumIdOAuWdfHZRo91IoiFXH
         yIUgxMzrthfkDeLoaFN8V+/OWHmE0LrSLCmL5fxIATQWB40ZPkfE/h/vUMZK/ORTKvJx
         LAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWIcS6Kmcinpk4nazH38gksGZeb2V5O9XJjjx6H21Q8=;
        b=ataqCgIm6safw+j/Gq4p4ZDG1eHgpLm1P2UJh/gy3vb7ucWFHIoTzhwbGoAsekgW9Q
         NyaQpZo6jNQb+0Z9sqFmhD+XvdTLY1HCwuxVkmFuDBijGMDtPjkuKJzaRBkak2GnD6pO
         ZlvKy1r91LouBFjUz70q9DIQmpkyUYxtBH3w2V7w8e7lco4SAWY573tWTcnxqbgUDZHc
         mJ/wIUELP9/tlKaLXhV3R4A+jdrFFrrv1QDXo2pjlKx9q9AYG9mvmex/sLP5aalTLN0z
         PQEAR8MH7CrR+zDIDl8G4S+gwRtUhD1Pr8zU5E+ybcRPXWo+bpAqEaqtvhQco4Pn6t8x
         xjjg==
X-Gm-Message-State: APjAAAUHgw4oEr2FNyXSuNVsVtUbOk2WCU5HuNK7HAqfqsN8hOjjl8L7
        HAeU3nAbOBxd9xWkNIGPJ/SyzyrYBUJLw4a7pQkIpw==
X-Google-Smtp-Source: APXvYqwPjUaJnzHm1yNiOffbukbBDzPd9LLjWB9u5Xvz7aYxG7tWRntIx7qmsDoGrfBOfmcGRICRRmKGUue7Gnrqs2g=
X-Received: by 2002:a19:ca13:: with SMTP id a19mr16886127lfg.133.1572880829843;
 Mon, 04 Nov 2019 07:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20191104001819.2300-1-chris.packham@alliedtelesis.co.nz> <20191104001819.2300-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20191104001819.2300-2-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:20:17 +0100
Message-ID: <CACRpkdYnUbNJtLcLtZXcL8s_Cq64Q85pyy484J4ZvobAODLOSA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pinctrl: bcm: nsp: use gpiolib infrastructure for interrupts
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 1:18 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> Use more of the gpiolib infrastructure for handling interrupts. The
> root interrupt still needs to be handled manually as it is shared with
> other peripherals on the SoC.
>
> This will allow multiple instances of this driver to be supported and
> will clean up gracefully on failure thanks to the device managed APIs.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>
> Notes:
>     Changes in v3:
>     - retain old irqchip name for ABI compatilbilty
>     - add revew from Florian
>     Changes in v2:
>     - none

Patch applied.

Yours,
Linus Walleij
