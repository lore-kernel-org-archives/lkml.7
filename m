Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D56C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7422133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctEgaZ/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCHNPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:15:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36813 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfCHNPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:15:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id 197so4343950lfz.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 05:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uZMqNKssawoG7Wcg8qolgPtZ3pIACxsWPBW4IABvLiU=;
        b=ctEgaZ/hLnCi++2JsZeUD7UpNtqdCbQzey9wLyy+9OuWoZUQqto9lOS2zxhdw5FIMo
         0sOzF4LoH+0YcS2v34TrwI8VtxnO88RRaDbTFDIIo85XQirtb7JgHu/DWHokojsA/+Ej
         HY3PEouoC8jjVB+YaOeOjBwYbMkqNVoSCepvVxT3OCmshyuhCCAP0WsvcZbTjV66sQop
         30fwdq1iTvmePTZoVfxh9MFjv1Si82RiN00H0/2ULCHKNrhW6ScVKzXcR+qtwnAR+U8C
         +0ZsI4kYgjfMUIV7P0xi1kWIbk3SC8adukkhtDfmgQeOD8XScq0RSpIQfxlj0FFx/0B0
         EXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uZMqNKssawoG7Wcg8qolgPtZ3pIACxsWPBW4IABvLiU=;
        b=VhfRsGeLeBBfR88VD2781rWniSrK8AsYFXm9OrwjvHX5gPCxBbVHHgRh4823oFOAEW
         iayen/31olgE1l8Btq3I5JFfUL86kJrSLVsFhdCbyziE/VQqo8FzaNtEaJqZ8JiRpHQE
         IM8Qds7J0+jCvks3O0Mfj966hLGiC4KNXA9IEqxLhAgJ8vtSNy9IkzCPyZAD2CkzHtOT
         y4/wIC5NhL9ggHebQ3WWm6rb+Li2jcFduJVAzekZkvvbyo6x9D1kjbhCqifXod/2SaM9
         BX3HZ/w/VY/7DEez4llonB/bCUEfH0SVgnmMCcZVAL8yDHs1Gato/OY+JMxEPYsOGsBM
         oYGA==
X-Gm-Message-State: APjAAAXfXgWwXKanicuSd2nfA/1WUQw2MXuD+7xrQuqCsr5NzkzIvqJ3
        IKPisLFHK8fOG03iD2w03R3DdVgq+XR3EIXzCeQscA==
X-Google-Smtp-Source: APXvYqyL47OaXzKwZh0+lVn2AflJiOzQqiq8tuF7RRsxjrdMrWapiJ3vFUQACoieCyMvt1Ebv99p48Mfa7RLD/1tXmQ=
X-Received: by 2002:ac2:4304:: with SMTP id l4mr5876212lfh.168.1552050933303;
 Fri, 08 Mar 2019 05:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20190307125251.724-1-marek.behun@nic.cz> <20190307125251.724-2-marek.behun@nic.cz>
In-Reply-To: <20190307125251.724-2-marek.behun@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 14:15:21 +0100
Message-ID: <CACRpkdb+mR_=tC89AS6XzuB0STb4-H-DHhf+yM8K33V809A60g@mail.gmail.com>
Subject: Re: [PATCH v4 armsoc/drivers/bus+gpio 1/5] bus: Add support for
 Moxtet bus
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:53 PM Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:

> On the Turris Mox router different modules can be connected to the main
> CPU board: currently a module with a SFP cage, a module with MiniPCIe
> connector, a PCIe pass-through MiniPCIe connector module, a 4-port
> switch module, an 8-port switch module, and a 4-port USB3 module.
>
> For example:
>   [CPU]-[PCIe-pass-through]-[PCIe]-[8-port switch]-[8-port switch]-[SFP]
>
> Each of this modules has an input and output shift register, and these
> are connected via SPI to the CPU board.
>
> Via SPI we are able to discover which modules are connected, in which
> order, and we can also read some information about the modules (eg.
> their interrupt status), and configure them.
> From each module 8 bits can be read (of which low 4 bits identify the
> module) and 8 bits can be written.
>
> For example from the module with a SFP cage we can read the LOS,
> TX-FAULT and MOD-DEF0 signals, while we can write TX-DISABLE and
> RATE-SELECT signals.
>
> This driver creates a new bus type, called "moxtet". For each Mox module
> it finds via SPI, it creates a new device on the moxtet bus so that
> drivers can be written for them.
>
> It also implements a virtual interrupt controller for the modules which
> send their interrupt status over the SPI shift register. These modules
> do this in addition to sending their interrupt status via the shared
> interrupt line. When the shared interrupt is triggered, we read from the
> shift register and handle IRQs for all devices which are in interrupt.
>
> The topology of how Mox modules are connected can then be read by
> listing /sys/bus/moxtet/devices.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
