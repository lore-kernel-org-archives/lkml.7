Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C72EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BE8206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsw9Nmnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfHZLRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:17:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38649 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbfHZLQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:16:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id c12so600398lfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 04:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoFNGyhD/IpzgrNu/s4nyMOqx8vjiMZXotZwnxN0fmQ=;
        b=zsw9Nmnuox1dtcDek+VxNObd5JtV9AetPOXXNqU5QQAGc/yFDb721tTak0xA/y8yjr
         xanBopG8k/irYaRWOGZhFV2Czdtd8AClacur10EiFlexX0Ctwvd06HjML60yPoh7+f5m
         vywc5WoZKgTSX9lnv9kmRrWjoi/0ro0ift3DHfj5xDcNXiIqmoIQr5Ybyd280tQ+ZOsc
         kU8A44nndrz7I64UTBZVKNTb5R13C+0YjVX/KeMaUMevL0DpP7nv9DQokfIQLddQSRpn
         wcQbb7W1H5gnosf0fdBGQezB8WjDmAv8bl+x6LPG1WO4iwmwMin1I+fLwqWicY38+x1w
         6PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoFNGyhD/IpzgrNu/s4nyMOqx8vjiMZXotZwnxN0fmQ=;
        b=px0Odlk4Y07gAEgEEiuKUXCuFZJY20lhgs/0CnwPMwFhYeRam4WNkHbMY8fChnbblV
         tsZTrn/mnWwMABWrUQXV2CpTknKvSdupT9O0ibVj56ig3+JgaBqzYxTgheGct0UCZlwT
         KbNuDom/0N5yU0sofIC5yx+doLpMF/eG3IiWlc1BnLWBSBscOGUEWPHW4pc1CKuQ1qR9
         5Gw52wcE04RMfVy7PShCv1kgf8v0AkeqFvLrmNhzTGfVI8dyNUDYx5LT07ee9EjxjVMZ
         b7ecLZqPoVnrmWTnFszJF+A/nEWyvPyV9ZlQTjm4kP4GOvOvCkART3AMZRv0UJg/4Vsa
         GerA==
X-Gm-Message-State: APjAAAWWH9SPPHwtJLjbV3xiBqH14ITstOmFuckNVs7ZY3o7D9KkiNJX
        SMtUuiYlF5ICzhnTXgDI/+2Nc1aCw4g/9ag+mA4I4w==
X-Google-Smtp-Source: APXvYqwq+n3IWbnz++AwYjY5hi9PwQS3DsryoTO85Roujdt6TlsqwVJGaCILrK7a/BuelN2HGE61Fz7GYYwHWJZ3XhQ=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr10463633lfy.141.1566818213972;
 Mon, 26 Aug 2019 04:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190826210252.20ca44ba@canb.auug.org.au>
In-Reply-To: <20190826210252.20ca44ba@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 26 Aug 2019 13:16:42 +0200
Message-ID: <CACRpkdbfe+az-Cgymd0Y+-m1MqvdSNb-H1XO0923cQ7RwEWanA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the gpio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 1:03 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Today's linux-next merge of the pinctrl tree got a conflict in:
>
>   drivers/pinctrl/bcm/pinctrl-bcm2835.c
>
> between commit:
>
>   82357f82ec69 ("pinctrl: bcm2835: Pass irqchip when adding gpiochip")
>
> from the gpio tree and commit:
>
>   e38a9a437fb9 ("pinctrl: bcm2835: Add support for BCM2711 pull-up functionality")
>
> from the pinctrl tree.

Ah that's so unnecessary. I will take the patch out of the GPIO
tree and put it into the pinctrl tree instead, thanks for noticing!

Yours,
Linus Walleij
