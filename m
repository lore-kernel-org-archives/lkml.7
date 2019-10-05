Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E8C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B84222C8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2jT+U/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfJEQho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:37:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44722 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfJEQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:37:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so9484408ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prTkz2BDct+kznOCTl84BP6+isxcds/VL5wpAYcwHBY=;
        b=m2jT+U/AjYzHW1iLL25RrSATBB+XM5O+wb9pHkyxDDzOz+5wGDsqcWYu+xHIj20FMA
         Xwu2HpckrIcTSmbFz4sWXa/wECnqJsrKouRHo8gp5QslS74mYPCyeObXJ6VxItdD/YOC
         ce/yz+2TEzQmEUTxeWuakUD29l/+b5pbv0n+t/YNdn7lWrpgzfmUjaLRamPvaA81a1Zs
         bTJLBgiswBGT+nqqJsALx6ClmKePzLHjFXqbmXRXKl4a6OgkzLIBLODmJg58g4XgC6Sg
         0fJZ8c+uj0/bGFwpeORcThh4OgIe4OKl4jO0bbkLdQx7LlUw15JmDX9Am5AL/OoEzK8b
         kTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prTkz2BDct+kznOCTl84BP6+isxcds/VL5wpAYcwHBY=;
        b=b90iBhbD51SngosTco5x2YWzEb0r+OjirPasSejdttmvx/hEuSGwYI1/QahXV78Zt1
         th2sso3+55eSxpvH0z9ZnClRmkx3KBJr1YN5ei+nED4uoziRW1Z0LMPdH/itU27Ei4DD
         ZImC8GeejolLc89KCjY1DfHs5Z9B+WDOrIQuOZ01vG3vCB1Ox509IEoT6hqETdemxXqj
         u74mjj6DX1pGivsofVpJpPMHGKk8C8ONk4HrUCNGdfTLTM9W4zKtFTJSZZWn/Jfs9poT
         FgWEdlgnxlyvvJFO/ilmmwEDmc7XuXeM8sO6FMSEiRevall/6PnSZ8zx0ShZ4NwiN02B
         E3Ag==
X-Gm-Message-State: APjAAAXHkCbKPwsALvNW30Si/6Vsba0xyGh2UgmhtG0kOEbquYmM46tC
        uG8SMRrOcfMzXQCYCS4lcne+7jXWNAgHg0L/GdUCXKzhcnM=
X-Google-Smtp-Source: APXvYqxZDMfqx8V17O+f48DGUFf1jTMmQs1PnbGuYwpAD58xGCuDybqkY6PymiQ5pg31cLHibQqXMFRqO2iNX6kIrBM=
X-Received: by 2002:a2e:6344:: with SMTP id x65mr12909835ljb.59.1570293461231;
 Sat, 05 Oct 2019 09:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191003000310.17099-1-chris.packham@alliedtelesis.co.nz> <20191003000310.17099-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20191003000310.17099-3-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 18:37:29 +0200
Message-ID: <CACRpkdYuJgjLEbYVA-cVxyy6v-L8Hnf2kmZt3S72nFQnrrzMmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: iproc: use unique name for irq chip
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Li Jin <li.jin@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 2:03 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> Use the dev_name(dev) for the irqc->name so that we get unique names
> when we have multiple instances of this driver.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Patch applied.

Yours,
Linus Walleij
