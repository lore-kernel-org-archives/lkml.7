Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D72CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE7A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oaXpskJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbfJ2O6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:58:30 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33843 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389800AbfJ2O6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:58:30 -0400
Received: by mail-vs1-f67.google.com with SMTP id f8so2788324vsg.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjB+ZpmO3twByAPR+4L+mHm+DrtDlohe88jo1dKnnjc=;
        b=oaXpskJCNt4XXGtwMjTYcVHqnsYcgfy+b60L4FecmVgfx2bvqI3yhshilu7EhsJGED
         HVdSB0Mv5TcTKihKo/g4eEfeVwotJc2pI/ADqKHZEUoEExQ8N64ZUrSpvrgw7sbAwcUo
         G8C1XTdibyo5hC2gTMCccdjPP6Z7mxoeFR5bZbqRMZsoVWGGmDx8HQchm2K6hW0QYpRv
         HRjGUXBFVueW3Q+RJJFP0NnoifQLM3IFNuHcGmbETxhTmNvuBTS6uCiEZGdBLtOEo9uU
         6qxbkxwqypztHkWqNz0CPNUGK4ythXELpQL7YDWxZ7XSIYBgmIgmz8a8hl717594vq9q
         f0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjB+ZpmO3twByAPR+4L+mHm+DrtDlohe88jo1dKnnjc=;
        b=INaKV0DYYwI21YhiPXxDR7MAGNymkp1vrthhcPaHnNqPOmcT67uaZeexAsTb+ykxsM
         rgTb0bghoeUQlYfj23OSKSCk3rfOcNfRBANOqQTb4fXzVvpyWqY5zOQAqjJnKP/0LqSG
         QhrcWdKqg0pDFNLGjgOqNXOX9twqMBGou2knz6fvnVl3kBtbqRQaZqGIB2Ph/s05Sy8D
         Xsbhl1gvBfnFbio91RFrbWi/WsmzWn/DYq9yI5RfiyHcoxZ+pafBMv35bO5NnIT5DQ//
         1rMBPQnXKzwe0XnSM3o13jynTzgrfS82pgKoyyRzc3ARJTzF0h+mtsbu1JPb2vAjyd+1
         Do4g==
X-Gm-Message-State: APjAAAX3PQSPf61RItG0fe+oAFyfs3ZvJ04SgQFJT8bW/l+TJfNsymzF
        HcmUXP6IDG4fgd/LjmMzhwtyAeb3/anaDaVP/0YcGA==
X-Google-Smtp-Source: APXvYqzaI791KOXBIBsCJiL8FxnvMrHuQCjh4l15hmm8Lf0ZRw6g5PMTkXCt8PXFzSZIcrNtpyFpJt2Gtasg9XBc6NE=
X-Received: by 2002:a67:7944:: with SMTP id u65mr2109606vsc.10.1572361109404;
 Tue, 29 Oct 2019 07:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191024202703.8017-1-chris.packham@alliedtelesis.co.nz> <20191024202703.8017-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20191024202703.8017-3-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Oct 2019 15:58:17 +0100
Message-ID: <CACRpkdaD=VMvUuWfwn+aa=G9rKC+=eiRVk85ghhDWXWshKQRaw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: Add xgs-iproc driver
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:27 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> This driver supports the Chip Common A GPIO controller present on a
> number of Broadcom switch ASICs with integrated SoCs. The controller is
> similar to the pinctrl-nsp-gpio and pinctrl-iproc-gpio blocks but
> different enough that a separate driver is required.
>
> This has been ported from Broadcom's XLDK 5.0.3 retaining only the CCA
> support (pinctrl-iproc-gpio covers CCB).
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v4:
>     - rename the config option to GPIO_BCM_XGS_IPROC and place alphabetically
>     - sort #includes alphabetically

Patch applied, great work on this patch, it's very lean and clean now!

Got a minor thing I wanna look at, will send a patch on top if I find it
useful.

Yours,
Linus Walleij
