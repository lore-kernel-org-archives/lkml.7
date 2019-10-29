Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA2CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3503E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hwng/1iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389615AbfJ2OwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:52:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43780 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389398AbfJ2OwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:52:01 -0400
Received: by mail-vs1-f65.google.com with SMTP id s130so5033159vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AghPO3C3rEgGBPotZ+vICco1DWQsd2uHdndQrS4Mhmg=;
        b=Hwng/1iREMu58SnENh22U3wjGobxllv5Tqdl4SLxKt2rJHJMiSBnFDHk0tk8PRXMfc
         Mlmj3c4mAJ+7d58g5EbhSontzBbJAUktNUENdEfVlLgpoFhjxBt+oRDVCNMZLh78ImpF
         5/1Mu84pLONjy3utBV6gpZ1tNFmoUgr4QV6/NshuMd+VqPjHdERr52EmJwCzO9lVP9DD
         XV7l8eSunjesHvuWBwX9Xyk00bdIjSaD1mP7kdDLOqE/0Ffk01zex7aFEn8amOJZTYD3
         Pl85KuEPuIhkiasQ1yQuSw8WFIVc8uI3/QnKLBZk/hZRhXOrRGAnwcJfaBTrb+3IDB07
         JWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AghPO3C3rEgGBPotZ+vICco1DWQsd2uHdndQrS4Mhmg=;
        b=Sr3+LNALuoeW/CNYrMw7TpiZvbxsG38SvKC9F+cKQPk7PxRske48cIgdQiSL8Lahow
         UA5NQ7k7N9NpY0ZUapEAaBkvgF62huty/nb558s1uROqlkssb8A0QwWdYZ7hqhzN1FfR
         C7Spruv2nS50OrfanmI+ObhCAL/qTq46FdO7xwXcXcJh0RSV3n+dgxsFCPwa7GK5QOYD
         IZswiQp7n/bbb17ubEZha8U39wbQjnmADvqUO51G/xuzoyLmi+qdu5SM3PnUsBMN3uQi
         qTX8jv9e1at/OoWVUw0uPvHze7gzAcDxAqfYi7kWs/8/D0mEBB2U0UxzDH733ZxrjVhP
         Z6cg==
X-Gm-Message-State: APjAAAWiwarW162KL0+bdzAVa5mPiHZurv/3ZtzHvRyTePrpUAy5fwvK
        QXj+uZ1sfhgMky/kNlXiKkJAD9J3iVfe6fLnAvrNNA==
X-Google-Smtp-Source: APXvYqxy+qA6VE5Nq1a9sMm7sQY0Vmiq6oTH38qQ4sCv5Md8fk8HW1K0XuZUl3bbruZa1JoQJbbOkNNLqDYASp6pmRE=
X-Received: by 2002:a05:6102:2436:: with SMTP id l22mr1897257vsi.93.1572360718925;
 Tue, 29 Oct 2019 07:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191028200555.27524-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20191028200555.27524-1-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Oct 2019 15:51:47 +0100
Message-ID: <CACRpkdbJhXxAXTBnTUxj7AkOBv1wBphCD6bJ5Vta4FT78x=--w@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: gpio: brcm: Add bindings for xgs-iproc
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 9:06 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> This GPIO controller is present on a number of Broadcom switch ASICs
> with integrated SoCs. It is similar to the nsp-gpio and iproc-gpio
> blocks but different enough to require a separate driver.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>
> Notes:
>     Changes in v5:
>     - correct $id line following rename
>     - add reviewed-by from Rob

Patch applied.

Yours,
Linus Walleij
